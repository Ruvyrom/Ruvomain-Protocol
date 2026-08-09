#!/usr/bin/env bash

jsonwalk_json=
jsonwalk_pos=0
jsonwalk_visitor=

jsonwalk::_emit() {
    if [[ -n $jsonwalk_visitor ]]; then
        "$jsonwalk_visitor" "$@"
    else
        printf '%s' "$1"
        shift

        for arg in "$@"; do
            printf '\t%s' "$arg"
        done

        printf '\n'
    fi
}

jsonwalk::_peek() {
    REPLY=${jsonwalk_json:jsonwalk_pos:1}
}

jsonwalk::_next_char() {
    ((jsonwalk_pos++))
}

jsonwalk::_skip_ws() {
    while :; do
        jsonwalk::_peek

        case "$REPLY" in
            ' '|$'\t'|$'\r'|$'\n')
                jsonwalk::_next_char
                ;;
            *)
                return
                ;;
        esac
    done
}

jsonwalk::_parse_hex_quad() {
    jsonwalk_last_hex=${jsonwalk_json:jsonwalk_pos:4}

    if [[ ! $jsonwalk_last_hex =~ ^[0-9a-fA-F]{4}$ ]]; then
        echo "Invalid unicode escape at $jsonwalk_pos" >&2
        return 1
    fi

    jsonwalk_pos=$((jsonwalk_pos + 4))
}

jsonwalk::_append_codepoint() {
    local codepoint=$1
    local encoded

    printf -v encoded '%08x' "$codepoint"
    printf -v jsonwalk_last_char '%b' "\\U$encoded"
}

jsonwalk::_parse_unicode_escape() {
    local high low low_prefix

    jsonwalk::_next_char
    jsonwalk::_parse_hex_quad || return $?
    high=$((16#$jsonwalk_last_hex))

    if (( high >= 0xD800 && high <= 0xDBFF )); then
        low_prefix=${jsonwalk_json:jsonwalk_pos:2}

        if [[ $low_prefix != '\u' ]]; then
            echo "Invalid unicode escape at $jsonwalk_pos" >&2
            return 1
        fi

        jsonwalk_pos=$((jsonwalk_pos + 2))
        jsonwalk::_parse_hex_quad || return $?
        low=$((16#$jsonwalk_last_hex))

        if (( low < 0xDC00 || low > 0xDFFF )); then
            echo "Invalid unicode escape at $jsonwalk_pos" >&2
            return 1
        fi

        jsonwalk::_append_codepoint $((0x10000 + ((high - 0xD800) << 10) + (low - 0xDC00)))
        return
    fi

    if (( high >= 0xDC00 && high <= 0xDFFF )); then
        echo "Invalid unicode escape at $jsonwalk_pos" >&2
        return 1
    fi

    jsonwalk::_append_codepoint "$high"
}

jsonwalk::_parse_string() {
    local c char_code content_start

    jsonwalk::_peek

    if [[ $REPLY != '"' ]]; then
        echo "Expected string at $jsonwalk_pos" >&2
        return 1
    fi

    jsonwalk::_next_char   # skip opening "
    content_start=$jsonwalk_pos

    while :; do
        jsonwalk::_peek
        c=$REPLY

        case "$c" in
            '"')
                jsonwalk_last_string=${jsonwalk_json:content_start:jsonwalk_pos-content_start}
                jsonwalk::_next_char
                return
                ;;

            \\)
                jsonwalk::_next_char
                jsonwalk::_peek
                c=$REPLY

                case "$c" in
                    '"'|\\|'/'|b|f|n|r|t)
                        jsonwalk::_next_char
                        ;;
                    u)
                        jsonwalk::_parse_unicode_escape || return $?
                        continue
                        ;;
                    *)
                        echo "Invalid string escape at $jsonwalk_pos" >&2
                        return 1
                        ;;
                esac
                ;;

            '')
                echo "Unterminated string at $jsonwalk_pos" >&2
                return 1
                ;;

            *)
                LC_CTYPE=C printf -v char_code '%d' "'$c"

                if (( char_code < 0x20 )); then
                    echo "Unescaped control character at $jsonwalk_pos" >&2
                    return 1
                fi

                jsonwalk::_next_char
                ;;
        esac
    done
}

jsonwalk::_parse_string_decoded() {
    local out="" c char_code

    jsonwalk::_peek

    if [[ $REPLY != '"' ]]; then
        echo "Expected string at $jsonwalk_pos" >&2
        return 1
    fi

    jsonwalk::_next_char   # skip opening "

    while :; do
        jsonwalk::_peek
        c=$REPLY

        case "$c" in
            '"')
                jsonwalk::_next_char
                jsonwalk_last_string="$out"
                return
                ;;

            \\)
                jsonwalk::_next_char
                jsonwalk::_peek
                c=$REPLY

                case "$c" in
                    '"'|\\|'/')
                        out+="$c"
                        ;;
                    b)
                        out+=$'\b'
                        ;;
                    f)
                        out+=$'\f'
                        ;;
                    n)
                        out+=$'\n'
                        ;;
                    r)
                        out+=$'\r'
                        ;;
                    t)
                        out+=$'\t'
                        ;;
                    u)
                        jsonwalk::_parse_unicode_escape || return $?
                        out+="$jsonwalk_last_char"
                        continue
                        ;;
                    *)
                        echo "Invalid string escape at $jsonwalk_pos" >&2
                        return 1
                        ;;
                esac

                jsonwalk::_next_char
                ;;

            '')
                echo "Unterminated string at $jsonwalk_pos" >&2
                return 1
                ;;

            *)
                LC_CTYPE=C printf -v char_code '%d' "'$c"

                if (( char_code < 0x20 )); then
                    echo "Unescaped control character at $jsonwalk_pos" >&2
                    return 1
                fi

                out+="$c"
                jsonwalk::_next_char
                ;;
        esac
    done
}

jsonwalk::_parse_number() {
    local rest=${jsonwalk_json:jsonwalk_pos}

    if [[ $rest =~ ^-?(0|[1-9][0-9]*)(\.[0-9]+)?([eE][+-]?[0-9]+)? ]]; then
        jsonwalk_last_number=${BASH_REMATCH[0]}
        jsonwalk_pos=$((jsonwalk_pos + ${#jsonwalk_last_number}))
        return
    fi

    echo "JSON parse error near position $jsonwalk_pos" >&2
    return 1
}

jsonwalk::_parse_literal() {
    local literal=$1
    local event=$2
    local value=${3-}

    if [[ ${jsonwalk_json:jsonwalk_pos:${#literal}} != "$literal" ]]; then
        echo "JSON parse error near position $jsonwalk_pos" >&2
        return 1
    fi

    jsonwalk_pos=$((jsonwalk_pos + ${#literal}))

    if [[ $# -ge 3 ]]; then
        jsonwalk::_emit "$event" "$value"
    else
        jsonwalk::_emit "$event"
    fi
}

jsonwalk::_parse_value() {
    jsonwalk::_skip_ws

    jsonwalk::_peek

    case "$REPLY" in
        '{')
            jsonwalk::_parse_object
            ;;

        '[')
            jsonwalk::_parse_array
            ;;

        '"')
            jsonwalk::_parse_string || return $?
            jsonwalk::_emit string "$jsonwalk_last_string" || return $?
            ;;

        t)
            jsonwalk::_parse_literal true boolean true || return $?
            ;;

        f)
            jsonwalk::_parse_literal false boolean false || return $?
            ;;

        n)
            jsonwalk::_parse_literal null null || return $?
            ;;

        *)
            jsonwalk::_parse_number || return $?
            jsonwalk::_emit number "$jsonwalk_last_number" || return $?
            ;;
    esac
}

jsonwalk::_parse_array() {
    jsonwalk::_emit start_array || return $?

    jsonwalk::_next_char
    jsonwalk::_skip_ws
    jsonwalk::_peek

    if [[ $REPLY == ']' ]]; then
        jsonwalk::_next_char
        jsonwalk::_emit end_array || return $?
        return
    fi

    while :; do
        jsonwalk::_parse_value || return $?

        jsonwalk::_skip_ws
        jsonwalk::_peek

        case "$REPLY" in
            ',')
                jsonwalk::_next_char
                ;;
            ']')
                jsonwalk::_next_char
                jsonwalk::_emit end_array || return $?
                return
                ;;
            *)
                echo "JSON parse error near position $jsonwalk_pos" >&2
                return 1
                ;;
        esac
    done
}

jsonwalk::_parse_object() {
    jsonwalk::_emit start_object || return $?

    jsonwalk::_next_char
    jsonwalk::_skip_ws
    jsonwalk::_peek

    if [[ $REPLY == '}' ]]; then
        jsonwalk::_next_char
        jsonwalk::_emit end_object || return $?
        return
    fi

    while :; do
        local key

        jsonwalk::_peek

        [[ $REPLY == '"' ]] || {
            echo "Expected string key at $jsonwalk_pos" >&2
            return 1
        }

        jsonwalk::_parse_string || return $?
        key="$jsonwalk_last_string"
        jsonwalk::_emit key "$key" || return $?

        jsonwalk::_skip_ws
        jsonwalk::_peek

        [[ $REPLY == ':' ]] || {
            echo "Expected ':' at $jsonwalk_pos" >&2
            return 1
        }

        jsonwalk::_next_char

        jsonwalk::_parse_value || return $?

        jsonwalk::_skip_ws
        jsonwalk::_peek

        case "$REPLY" in
            ',')
                jsonwalk::_next_char
                jsonwalk::_skip_ws
                ;;
            '}')
                jsonwalk::_next_char
                jsonwalk::_emit end_object || return $?
                return
                ;;
            *)
                echo "JSON parse error near position $jsonwalk_pos" >&2
                return 1
                ;;
        esac
    done
}

json_walk() {
    jsonwalk_json=$1
    jsonwalk_pos=0
    jsonwalk_visitor=${2-}

    jsonwalk::_parse_value || return $?
    jsonwalk::_skip_ws
    jsonwalk::_peek

    if [[ -n $REPLY ]]; then
        echo "JSON parse error near position $jsonwalk_pos" >&2
        return 1
    fi
}

json_walk_decode_string() {
    local jsonwalk_json jsonwalk_pos jsonwalk_visitor jsonwalk_last_string
    local jsonwalk_last_char jsonwalk_last_hex

    jsonwalk_json="\"$1\""
    jsonwalk_pos=0
    jsonwalk_visitor=

    jsonwalk::_parse_string_decoded || return $?
    jsonwalk::_peek

    if [[ -n $REPLY ]]; then
        echo "Invalid string content near position $jsonwalk_pos" >&2
        return 1
    fi

    REPLY=$jsonwalk_last_string
    printf '%s' "$REPLY"
}

jsonwalk_main() {
    local json=$1
    local visitor=${2-}

    if [[ -z $json ]]; then
        echo "usage: jsonwalk '<json>' [visitor]" >&2
        exit 1
    fi

    json_walk "$json" "$visitor"
}

# Run main only if script executed, not sourced
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    jsonwalk_main "$@"
fi
