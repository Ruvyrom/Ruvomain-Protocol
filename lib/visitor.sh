#!/usr/bin/env bash

visitor() {
get_json_val() {
    local file="$1"
    local target_key="$2"
    local found="N/A"

    visitor() {
        if [[ "$1" == "key" && "$2" == "$target_key" ]]; then
            STATE="capture"
        elif [[ "$STATE" == "capture" && "$1" == "string" ]]; then
            found="$2"
            STATE="done"
        fi
    }
    STATE="idle"
    json_walk "$(<"$file")" visitor
    printf "%s\n" "$found"
}

get_packages() {
    local file="$1"
    PACKAGES=()

    pkg_visitor() {
        if [[ "$1" == "key" && "$2" == "packageName" ]]; then
            STATE="capturing"
        elif [[ "$STATE" == "capturing" && "$1" == "string" ]]; then
            PACKAGES+=("$2")
            STATE="idle"
        fi
    }
    STATE="idle"
    json_walk "$(<"$file")" pkg_visitor
}
