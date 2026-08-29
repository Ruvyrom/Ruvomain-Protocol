#!/usr/bin/env bash

final(){
local JSON_FILE="$1"

if [[ ! -f "$JSON_FILE" ]]; then
printf "${RED}[!] Configuration file not found: %s${NC}\n" "$JSON_FILE"
return 1
fi

# ADB connection verification
if ! adb devices | grep -q "device$"; then
printf "${RED}[!] No device detected via ADB.${NC}\n"
return 1
fi

printf"${CYAN}[+] Processing: %s${NC}\n" "$JSON_FILE"

local SUCCESS=0
local FAILED=0

# JSON reading via jq without mapfile
while read -r pkg; do
[[ -z "$pkg" ]] && continue

printf "${CYAN}Uninstalling: %s ... ${NC}" "$pkg"
if $EXEC "$pkg" >/dev/null 2>&1; then
printf "${GREEN}[OK]${NC}\n"
((SUCCESS++))
else
printf"${RED}[FAILED]${NC}\n"
((FAILED++))
fi
done < <(jq -r '.apps[]' "$JSON_FILE")

# Report
printf "\n${CYAN}--- Final Report ---${NC}\n"
printf "Successfully removed: %d\n" "$SUCCESS"
printf "Errors: %d\n" "$FAILED"
printf "${CYAN}--------------------${NC}\n"

# Reboot option
read -r -p "Reboot device? (y/n): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
adb reboot
fi
}

# --- Main Entry ---
if [[ -z "$1" ]]; then
printf "Usage: %s <config.json>\n" "$0"
else
final "$1"
fi
