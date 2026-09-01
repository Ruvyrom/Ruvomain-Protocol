#!/usr/bin/env bash

ensure_adb() {
# 1. Verify if ADB is installed
if command -v adb >/dev/null; then
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
sudo apt-get update && sudo apt-get install -y adb
elif command -v pacman >/dev/null; then
sudo pacman -S --noconfirm android-tools
elif command -v dnf >/dev/null; then
sudo dnf install -y android-tools
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
