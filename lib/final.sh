#!/usr/bin/env bash

final() {
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
} 
