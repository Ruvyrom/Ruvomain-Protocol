#!/usr/bin/env bash
# Ruvomain ADB-Termux Debloater (Pure Bash / Zero-Dependency)
# Version 3.0.0 (Refactored for Ruvomain Protocol - Surgical Minimalism)
# Created by Ruvyrom
set -euo pipefail

# --- Dynamic Path Resolution ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# --- Library Injection ---
LIB_PATH="$REPO_DIR/lib/json-walk.sh"
if [ ! -f "$LIB_PATH" ]; then
    printf "${RED}[!] CRITICAL: %s not found. Infrastructure integrity compromised.\n${NC} " "$LIB_PATH" >&2
    exit 1
fi
source "$LIB_PATH"

if [[ ! -x "$LIB_PATH" ]]; then
    chmod +x "$LIB_PATH"
fi

# --- Styles ---
source "$REPO_DIR/lib/styles.sh"

show_logo() {
    cat <<- "EOF"
    ____                                    _     
   / __ \__  ___   ______  ____ ___  ____ _(_)___ 
  / /_/ / / / / | / / __ \/ __ `__ \/ __ `/ / __ \
 / _, _/ /_/ /| |/ / /_/ / / / / / / /_/ / / / / /
/_/ |_|\__,_/ |___/\____/_/ /_/ /_/\__,_/_/_/ /_/ 
   / __ \_________  / /_____  _________  / /__    
  / /_/ / ___/ __ \/ __/ __ \/ ___/ __ \/ / _ \   
 / ____/ /  / /_/ / /_/ /_/ / /__/ /_/ / /  __/   
/_/   /_/   \____/\__/\____/\___/\____/_/\___/    
EOF
}

ensure_adb() {
    if command -v adb &>/dev/null; then
        return 0
    fi

    printf "${RED}[!] ADB not found.${NC}\n"
    printf "${GREEN}[+] Attempting auto-installation...${NC}\n"
    if [ -d "/data/data/com.termux" ]; then
        pkg install -y android-tools
    elif command -v apt-get &>/dev/null; then
        sudo apt-get update && sudo apt-get install -y android-tools-adb
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm android-tools
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y android-tools
    else
        printf "${RED}[!] ERROR: No supported package manager found to install ADB. Please install ADB manually.${NC}\n" >&2
        return 1
    fi
}

show_logo
printf "${CYAN}${BOLD}Ruvomain-PBD | Pure Bash Debloater${NC}\n"
printf "%s\n" "------------------------------------------"
CURRENT_MODEL=$(getprop ro.product.model 2>/dev/null || adb shell getprop ro.product.model 2>/dev/null || echo "Unknown")
printf "Device detected: ${BOLD}%s${NC}\n" "${CURRENT_MODEL}"
printf "%s\n" "------------------------------------------"

ensure_adb

# --- Infrastructure Helpers (Visitors) ---
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

# --- Environment Setup ---
if [ -d "/data/data/com.termux" ] || [ -f "/system/bin/pm" ]; then
    EXEC="pm uninstall -k --user 0"
else
    EXEC="adb shell pm uninstall -k --user 0"
fi

# --- Menu Logic ---
select_import_from_folder() {
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

# --- Configuration ---
CONFIG_DIR="$REPO_DIR/Configs/S24+"
FILE_T1="$CONFIG_DIR/ruvomain_tier1_stable.json"
FILE_T2="$CONFIG_DIR/ruvomain_tier2_stable.json"
FILE_T3="$CONFIG_DIR/ruvomain_tier3_stable.json"

printf "%s\n" "========================================"
printf "%s\n" "   RUVOMAIN PROTOCOL - DEPLOYMENT      "
printf "%s\n" "========================================"
printf "1) Apply Tier 1 (Safe)\n"
printf "2) Apply Tier 2 (Balanced)\n"
printf "3) Apply Tier 3 (Extreme)\n"
printf "4) Load external JSON from /Imports\n"
printf "%s\n" "----------------------------------------"
read -r -p "Your choice (1-4): " choice

case $choice in
    1) JSON_FILE=$FILE_T1; TIER="Tier 1 (Safe)" ;;
    2) JSON_FILE=$FILE_T2; TIER="Tier 2 (Balanced)" ;;
    3) JSON_FILE=$FILE_T3; TIER="Tier 3 (Extreme)" ;;
    4)
        if ! select_import_from_folder; then
            printf "Operation cancelled. Returning to main menu...\n"
            exit 1
        fi
        TIER="External Configuration ($JSON_FILE)"
        ;;
    *)
        printf "Invalid option. Exiting.\n"
        exit 1
        ;;
esac

# --- Final Execution ---
printf "[+] Deploying configuration: %s\n" "$JSON_FILE"

SUCCESS_COUNT=0
FAILED_COUNT=0

get_packages "$JSON_FILE"

if [[ "$(get_json_val "$JSON_FILE" "apps")" == "N/A" ]]; then
    printf "[!] CRITICAL: Invalid Ruvomain file (missing 'apps' key).\n" >&2
    exit 1
fi

for pkg in "${PACKAGES[@]}"; do
    printf "Processing: %s ... " "$pkg"

    if $EXEC "$pkg" > /dev/null 2>&1; then
        printf "[OK]\n"
        ((SUCCESS_COUNT++))
    else
        printf "[FAILED]\n"
        ((FAILED_COUNT++))
    fi
done

printf "%s\n" "========================================"
printf "Report:\n"
printf "  Packages removed: %d\n" "$SUCCESS_COUNT"
printf "  Failures: %d\n" "$FAILED_COUNT"
printf "\n"
printf "%s\n" "========================================"
printf "Operation finished. Sovereignty restored.\n"
