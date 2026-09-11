#!/usr/bin/env bash
# ==============================================================================
# URAAM - Universal Ruvyrom Android ADB Manager
# Remote Installer & Updater Script
# ==============================================================================

set -e

REPO_URL="https://github.com/Ruvyrom/Uraam"
BRANCH="main"

if [ -z "$INSTALL_DIR" ]; then
INSTALL_DIR="$HOME/Uraam"
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

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

show_logo() {
echo -e "${CYAN}"
cat << 'EOF'
::| ::|::::::\ ::::\  ::::\ ::::::|
::|_::|::|,::|::|,::|::|,::|:::"::|
`:::::|::| ::\::| ::|::| ::|::| ::|
EOF
echo -e "${NC}"
}

clear
show_logo
echo -e "${BLUE}==========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | INSTALLER${NC}"
echo -e "${BLUE}==========================================${NC}"
printf "${CYAN}WELCOME TO URAAM INSTALLER!${NC}\n"
printf "${CYAN)}This installer will:${NC}\n" 
printf "${CYAN}Download Uraam from the official repository;${NC}\n"
printf "${CYAN}Auto-install git if missing (with confirmation);${NC}\n"
printf "${CYAN}Setup files into ~/Uraam${NC}\n"
printf "${CYAN}Expose 'uraam' command in PATH(/usr/local/bin or ~/.local/${NC}\n"
read -p "Do you want to start the installation of URAAM? (y/n) : " choice

case "$choice" in
y|Y)
clear
printf "${CYAN}[*] Checking prerequisites...${NC}\n"

if ! command -v git >/dev/null 2>&1;then
printf "${YELLOW}[!] Git is missing. Attempting automatic installation...${NC}\n"
if command -v pkg >/dev/null 2>&1; then
pkg update -y && pkg install git -y
elif command -v apt >/dev/null 2>&1; then
sudo apt update -y && sudo apt install git -y
elif command -v pacman >/dev/null2>&1; then
sudo pacman -S --noconfirm git
elif command -v dnf >/dev/null 2>&1; then
sudo dnf install -y git
elif command -v brew >/dev/null 2>&1; then
brew install git
else
printf "${RED}[X] Package manager not found. Please install git manually.${NC}\n"
sleep 1
read -rp "Press [Enter] to exit..."
exit 1
fi
fi

printf "${GREEN}[✓] Git is ready.${NC}\n"

INSTALL_DIR="${INSTALL_DIR:-$HOME/Uraam}"

if [ -d "$INSTALL_DIR/.git" ]; then
printf "${CYAN}[*] Updating existing installation...${NC}\n"
cd "$INSTALL_DIR"

git fetch --all --prune >/dev/null 2>&1

if git reset --hard "origin/$BRANCH">/dev/null 2>&1; then
printf "${GREEN}[✓] Core repository updated successfully.${NC}\n"
else
printf "${RED}[X] Git reset failed. Check repository branch status.${NC}\n"
exit1
fi
else
printf "${CYAN}[*] Performing initial clone to: ${INSTALL_DIR}...${NC}\n"
mkdir -p "$(dirname "$INSTALL_DIR")"
if git clone --depth 1 -b "$BRANCH" "$REPO_URL" "$INSTALL_DIR"; then
printf "${GREEN}[✓] Repository cloned successfully.${NC}\n"
cd "$INSTALL_DIR"
else
printf "${RED}[X] Failed to clone repository. Check your connection.${NC}\n"
exit 1
fi
fi

if [ -f "$INSTALL_DIR/uraam.sh" ]; then
chmod +x "$INSTALL_DIR/uraam.sh"

find "$INSTALL_DIR" -type f -name "*.sh" -exec chmod +x {} +
else
printf "${RED}[X] Critical error: uraam.sh was not found in ${INSTALL_DIR}.${NC}\n"
exit 1
fi
;;

n|N)
printf "${YELLOW}[-] Installation aborted by user.${NC}\n"
read -rp "Press [Enter] to exit..."
exit 0
;;

*)
printf "${RED}[!] Invalid choice. Installation canceled.${NC}\n"
read -rp "Press[Enter] to exit..."
exit 1
;;
esac

printf "${CYAN}[*] Configuring system command alias (uraam)...${NC}\n"

if [ -n "$PREFIX" ] && [ -d "$PREFIX/bin" ]; then
TARGET_BIN="$PREFIX/bin"
target
perm
cleanup
printf "${GREEN}[✓] Symlink installed in Termux: ${TARGET_BIN}/uraam${NC}\n"
printf "${YELLOW}[!] Type 'uraam' to use URAAM.${NC}\n"

elif [ -w "/usr/local/bin" ]; then
TARGET_BIN="/usr/local/bin"
target
perm
cleanup
printf "${GREEN}[✓] Global symlink installed: ${TARGET_BIN}/uraam${NC}\n"
printf "${YELLOW}[!] Type 'uraam' to use URAAM.${NC}\n"

elif command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null; then
TARGET_BIN="/usr/local/bin"
sudo ln -sf "$INSTALL_DIR/uraam.sh" "$TARGET_BIN/uraam"
perm
cleanup
printf "${GREEN}[✓] Global symlink installed via sudo: ${TARGET_BIN}/uraam${NC}\n"
printf "${YELLOW}[!] Type 'uraam' to use URAAM.${NC}\n"

else
TARGET_BIN="$HOME/.local/bin"
target
perm
cleanup
printf "${GREEN}[✓] User symlink installed: ${TARGET_BIN}/uraam${NC}\n"
printf "${YELLOW}[!] Type 'uraam' to use URAAM.${NC}\n"

case ":$PATH:" in
*":$TARGET_BIN:"*) ;;
*)

SHELL_RC="$HOME/.bashrc"
[ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ] && SHELL_RC="$HOME/.zshrc"

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_RC"2>/dev/null; then
printf '\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$SHELL_RC"
printf "${YELLOW}[!] Added ~/.local/bin to PATH in ${SHELL_RC}.${NC}\n"
cleanup
printf "${YELLOW}[!] Run 'source %s' or open a new terminal to use 'uraam'.${NC}\n" "$SHELL_RC"
fi
;;
esac
fi
