#!/usr/bin/env bash

ensure_jq() {
# 1. Verify if ADBis installed
if command -v jq >/dev/null; then
printf "${GREEN}[✓] JQ is already installed and ready to use.${NC}\n"
return 0
fi

# 2. If not found, ask for confirmation
printf "${RED}[!] jq is not detected onyour system.${NC}\n"
read -p "Do you want to install jq now? (y/n) : " choice

case "$choice" in
y|Y)
printf "${GREEN}[+] Attemptingautomatic installation...${NC}\n"
# 3. Existing installation logic
if command -v apt-get >/dev/null; then
"$3" apt-get update && "$3" apt-get install -y jq
elif command -v pacman >/dev/null; then
"$3" pacman -S --noconfirm jq
elif command -v dnf >/dev/null; then
"$3" dnf install -y jq
else
printf"${RED}[!] Package manager not supported. Please install jq manually.${NC}\n" >&2
return1
fi
;;
*)
printf "${YELLOW}[-] Installation cancelled. jq is required for the project to work properly.${NC}\n"
return 1
;;
esac
}
