#!/usr/bin/env bash

configurations() {
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
} 
