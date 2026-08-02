#!/usr/bin/env bash
# Ruvomain ADB-Termux Debloater (Pure Bash / Zero-Dependency)
# Version 3.0.0 (Refactored for Ruvomain Protocol - Surgical Minimalism)
# Created by Ruvyrom
set -euo pipefail

# --- Dynamic Path Resolution and sources---
SOURCES_DIR="$REPO_DIR/lib/sources.sh"
chmod +x "$SOURCES_DIR"
source "$SOURCES_DIR"
sources

# --- Initialization ---
init_logs
ensure_adb || exit 1
show_logo
model
env

# --- Modules Execution ---
injection
visitor

# --- Menu & Configurations ---
display_main_menu

# --- Configuration ---
CONFIG_DIR="$REPO_DIR/Configs/S24+"
FILE_T1="$CONFIG_DIR/ruvomain_tier1_stable.json"
FILE_T2="$CONFIG_DIR/ruvomain_tier2_stable.json"
FILE_T3="$CONFIG_DIR/ruvomain_tier3_stable.json"

printf "%s\n" "${CYAN}========================================${NC}\n"
printf "%s\n" "   ${CYAN}RUVOMAIN PROTOCOL - DEPLOYMENT${NC}      "
printf "%s\n" "${CYAN}========================================${NC}\n"
printf "1) ${GREEN}Apply Tier 1 (Safe)${NC}\n"
printf "2) ${YELLOW}Apply Tier 2 (Balanced)${NC}\n"
printf "3) ${RED}Apply Tier 3 (Extreme)${NC}\n"
printf "4) ${BLUE}Load external JSON from /Imports${NC}\n"
printf "%s\n" "----------------------------------------"
read -r -p "${CYAN}Your choice (1-4): ${NC}" choice
printf "\n" 

case $choice in
    1) JSON_FILE=$FILE_T1; TIER="${GREEN}Tier 1 (Safe)${NC}" ;;
    2) JSON_FILE=$FILE_T2; TIER="${YELLOW}Tier 2 (Balanced)${NC}" ;;
    3) JSON_FILE=$FILE_T3; TIER="${RED}Tier 3 (Extreme)${NC}" ;;
    4)
        if ! select_import_from_folder; then
            printf "${RED}Operation cancelled. Returning to main menu...${NC}\n"
            exit 1
        fi
        TIER="${BLUE}External Configuration${NC} ($JSON_FILE)"
        ;;
    *)
        printf "${RED}Invalid option. Exiting.${NC}\n"
        exit 1
        ;;
esac

# --- Final Execution ---
printf "${GREEN}[+] Deploying configuration: %s${NC}\n" "$JSON_FILE"

SUCCESS_COUNT=0
FAILED_COUNT=0

get_packages "$JSON_FILE"

if [[ "$(get_json_val "$JSON_FILE" "apps")" == "N/A" ]]; then
    printf "${RED}[!] CRITICAL: Invalid Ruvomain file (missing 'apps' key).${NC}\n" >&2
    exit 1
fi

for pkg in "${PACKAGES[@]}"; do
    printf "${BLUE}Processing: %s ... ${NC}" "$pkg"

    if $EXEC "$pkg" > /dev/null 2>&1; then
        printf "${GREEN}[OK]${NC}\n"
        ((SUCCESS_COUNT++))
    else
        printf "${RED}[FAILED]${NC}\n"
        ((FAILED_COUNT++))
    fi
done

printf "%s\n" "${CYAN}========================================${NC}\n"
printf "${CYAN}Report:${NC}\n"
printf "  ${CYAN}Packages removed:${NC} %d\n" "$SUCCESS_COUNT"
printf "  ${CYAN}Failures: %d${NC}\n" "$FAILED_COUNT"
printf "\n"
printf "%s\n" "${CYAN}========================================${NC}\n"
printf "${GREEN}Operation finished. Sovereignty restored.${NC}\n"

printf "${WHITE}Rebooting device...${NC}\n"
read -r -p "${CYAN}Do you want to reboot your device? (y/n): ${NC}\n" reboot_choice
if [[ "$reboot_choice" =~ ^[Yy]$ ]]; then
    adb reboot
    printf "${GREEN}Reboot command sent to device.${NC}\n"
else
    printf "${YELLOW}Reboot skipped.${NC}"
fi
