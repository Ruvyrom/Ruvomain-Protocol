#!/usr/bin/env bash

ensure_adb() {
# 1. Verify if ADB is installed
if command -v "$2" >/dev/null; then
printf "${GREEN}[✓] ADB is already installed and ready to use.${NC}\n"
return 0
fi

# 2. If not found, ask for confirmation
printf "${RED}[!] ADB is not detected on your system.${NC}\n"
read -p "Do you want to install ADB now? (y/n) : " choice

case "$choice" in
y|Y)
printf "${GREEN}[+] Attempting automatic installation...${NC}\n"
# 3. Existing installation logic
if command -v apt-get >/dev/null; then
"$3" apt-get update && "$3" apt-get install -y "$2"
elif command -v pacman >/dev/null; then
"$3" pacman -S --noconfirm "$1"
elif command -v dnf >/dev/null; then
"$3" dnf install -y "$1"
else
printf "${RED}[!] Package manager not supported. Please install ADB manually.${NC}\n" >&2
return1
fi
;;
*)
printf "${YELLOW}[-] Installation cancelled. ADB is required for the project to workproperly.${NC}\n"
return 1
;;
esac
}
