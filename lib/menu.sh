#!/usr/bin/env bash

display_main_menu() {
    local import_dir="$REPO_DIR/Configs/Imports"
    if [ ! -d "$import_dir" ]; then
        printf "${RED}[!] Folder not found: %s${NC}\n" "$import_dir" >&2
        return 1
    fi
    local files=("$import_dir"/*.json)
    if [ ! -e "${files[0]}" ]; then
        printf "${RED}[!] No configs found in %s\n${NC}" "$import_dir" >&2
        return 1
    fi

    select opt in "${files[@]}" "Return to main menu"; do
        if [[ "$opt" == "Return to main menu" ]]; then return 1; fi
        if [ -f "$opt" ]; then
            JSON_FILE="$opt"
            printf "%s\n" "--- Configuration Details ---"
            printf "Name: %s\n" "$(get_json_val "$opt" "name")"
            printf "Version: %s\n" "$(get_json_val "$opt" "version")"
            read -r -p "Apply? (y/N): " confirm
            [[ "$confirm" == [yY] ]] && return 0 || return 1
        fi
    done
}
