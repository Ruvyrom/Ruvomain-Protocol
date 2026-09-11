#!/usr/bin/env bash
# ==============================================================================
# URAAM - Universal Ruvyrom Android ADB Manager
# Remote Installer & Updater Script
# ==============================================================================

set -e

show_logo() {
echo -e "${PURPLE}"
cat << 'EOF'
::| ::|::::::\ ::::\  ::::\ ::::::|
::|_::|::|,::|::|,::|::|,::|:::"::|
`:::::|::| ::\::| ::|::| ::|::| ::|
EOF
echo -e "${NC}"
}

BLUE='\033[0;34m'
BOLD='\033[1m'
CYAN='\033[0;36m'
PURPLE='\e[0;35m'
GREEN='\033[0;32m'
RED='\033[1;31m'
WHITE='\033[0;37m'
YELLOW='\033[0;33m'
NC='\033[0m'

INSTALL_DIR="${INSTALL_DIR:-$HOME/Uraam}"
REPO_URL="https://github.com/Ruvyrom/Uraam"
BRANCH="${BRANCH:-main}"

clear
if command -v show_logo >/dev/null 2>&1; then
show_logo
fi

cleanup() {
printf "${CYAN}[*] Cleaning up...${NC}\n"
rm -rf "$INSTALL_DIR/assets" "$INSTALL_DIR/installer.sh"
}

target() {
mkdir -p "$TARGET_BIN"
ln -sf "$INSTALL_DIR/uraam.sh" "$TARGET_BIN/uraam"
}

perm() {
chmod +x "$TARGET_BIN/uraam"
}

show_logo
echo -e "${BLUE}==========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | INSTALLER${NC}"
echo -e "${BLUE}==========================================${NC}"
printf "%b\n" "${CYAN}WELCOME TO URAAM INSTALLER!${NC}"
printf "%b\n" "${CYAN}--------------------------------------------${NC}"
printf "%b\n" "${CYAN}This installer will:${NC}"
printf "%b\n" "${WHITE} • Download URAAM from official repo${NC}"
printf "%b\n" "${WHITE} • Auto-install git if missing${NC}"
printf "%b\n" "${WHITE} • Setup files into ~/Uraam${NC}"
printf "%b\n" "${WHITE} • Expose 'uraam' command in PATH${NC}"
printf "%b\n" "${WHITE}--------------------------------------------${NC}"

read -p "Do you want to start the installation of URAAM? (y/n) : " choice

case "$choice" in
y|Y)
clear
printf "${CYAN}[*] Checking prerequisites...${NC}\n"

if ! command -v git >/dev/null 2>&1; then
printf "${YELLOW}[!] Git is missing. Attempting automatic installation...${NC}\n"
if command -v pkg >/dev/null 2>&1; then
pkg update -y && pkg install git -y
elif command -v apt >/dev/null 2>&1; then
sudo apt update && sudo apt install -y git
elif command -v pacman >/dev/null 2>&1; then
sudo pacman -Sy --noconfirm git
elif command -v dnf >/dev/null 2>&1; then
sudo dnf install -y git
elif command -v brew >/dev/null 2>&1; then
brew install git
else
printf "${RED}[X] Package manager not found. Please install git manually.${NC}\n"
read -rp "Press [Enter] to exit..."
exit 1
fi
fi
printf "${GREEN}[✓] Git is ready.${NC}\n"

if [ -d "$INSTALL_DIR/.git" ]; then
printf "${CYAN}[*] Updating existing installation...${NC}\n"
cd "$INSTALL_DIR" || exit 1
git fetch --all --prune >/dev/null 2>&1
if git reset --hard "origin/$BRANCH" >/dev/null 2>&1; then
printf "${GREEN}[✓] Core repository updated successfully.${NC}\n"
else
printf "${RED}[X] Git reset failed. Check repository branch status.${NC}\n"
read -rp "Press [Enter] to exit..."
exit 1
fi
else
printf "${CYAN}[*] Performing initial clone to: ${INSTALL_DIR}...${NC}\n"
mkdir -p "$(dirname "$INSTALL_DIR")"

git clone --depth 1 -b "$BRANCH" --progress "$REPO_URL" "$INSTALL_DIR" 2>&1 | while IFS= read -r line; do
if [[ "$line" =~ Receiving\ objects:[[:space:]]*([0-9]+)% ]]; then
percent="${BASH_REMATCH[1]}"
completed=$(( percent / 5 ))
remaining=$((20 - completed ))
bar_done=$(printf "%${completed}s" | tr ' ' '#')
bar_empty=$(printf"%${remaining}s" | tr ' ' '-')
printf "\r${CYAN}[${bar_done}${bar_empty}] ${percent}%%${NC}"
fi
done

if [ -d "$INSTALL_DIR/.git" ]; then
printf "\r${GREEN}[####################] 100%%${NC}\n"
printf "${GREEN}[✓] Repository cloned successfully.${NC}\n"
cd "$INSTALL_DIR" || exit 1
else
printf "\n${RED}[X] Failed to clone repository. Check your connection.${NC}\n"
read -rp "Press [Enter] to exit..."
exit 1
fi
fi

if [ -f "$INSTALL_DIR/uraam.sh" ]; then
chmod +x "$INSTALL_DIR/uraam.sh"
find "$INSTALL_DIR" -type f -name "*.sh" -exec chmod +x {} +
else
printf "${RED}[X] Critical error: uraam.sh was not found in ${INSTALL_DIR}.${NC}\n"
read -rp "Press [Enter] toexit..."
exit 1
fi

BIN_DIR=""
if [ -n "$PREFIX" ] && [ -d "$PREFIX/bin" ]; then
BIN_DIR="$PREFIX/bin"
elif [ -w "/usr/local/bin" ]; then
BIN_DIR="/usr/local/bin"
else
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
fi

ln -sf "$INSTALL_DIR/uraam.sh" "$BIN_DIR/uraam"
chmod+x "$BIN_DIR/uraam"
printf "${GREEN}[✓] Command 'uraam' linked to %s${NC}\n" "$BIN_DIR"

printf "\n${GREEN}==========================================${NC}\n"
printf "${GREEN}URAAM has been successfully installed!${NC}\n"
printf "${GREEN}Run 'uraam' to start.${NC}\n"
printf "${GREEN}==========================================${NC}\n"
;;

n|N)
printf "${YELLOW}[-] Installation aborted by user.${NC}\n"
exit0
;;

*)
printf "${RED}[!] Invalid choice. Installation canceled.${NC}\n"
exit 1
;;
esac
