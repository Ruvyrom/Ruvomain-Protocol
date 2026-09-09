#!/usr/bin/env bash
set -e

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[1;31m'
NC='\033[0m'

INSTALL_DIR="$HOME/.Ruvomain-Protocol"
REPO_URL="https://github.com/Ruvyrom/Ruvomain-Protocol.git"

printf "${CYAN}[*] Installing URAAM...${NC}\n"

if ! command -v git >/dev/null 2>&1; then
printf "${RED}[!] GIT is required for installation.${NC}\n"
read -p "Do you want to install GIT now? (y/n): " choice < /dev/tty

case "$choice" in
y|Y)
printf "${CYAN}[+] Installing git...${NC}\n"
if command -v pkg >/dev/null 2>&1; then
pkg install -y git
elif command -v apt-get >/dev/null 2>&1; then
sudo apt-get update && sudo apt-get install -y git
elif command -v pacman >/dev/null2>&1; then
sudo pacman -S --noconfirm git
elif command -v dnf >/dev/null 2>&1; then
sudo dnf install -y git
else
printf "${RED}[!] Package manager not supported. Please install git manually.${NC}\n" >&2
exit 1
fi
;;
*)
printf "${RED}[*] Installation aborted.${NC}\n"
exit 1
;;
esac
else
printf "${GREEN}[✓] GIT is ready.${NC}\n"
fi

if [ -d "$INSTALL_DIR/.git" ]; then
printf "${CYAN}[*] Updating existing installation...${NC}\n"
git -C "$INSTALL_DIR" pull --quiet
else
printf "${CYAN}[*] Downloading full environment...${NC}\n"
git clone --depth=1 "$REPO_URL" "$INSTALL_DIR"
fi

chmod +x "$INSTALL_DIR/ruvomain.sh"

BIN_DIR=""
if[ -n "$PREFIX" ] && [ -d "$PREFIX/bin" ]; then
BIN_DIR="$PREFIX/bin"
elif [ -d "/usr/local/bin" ] && [ -w "/usr/local/bin" ];then
BIN_DIR="/usr/local/bin"
else
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
fi

if [ -n "$BIN_DIR" ]; then
ln -sf "$INSTALL_DIR/ruvomain.sh" "$BIN_DIR/uraam"
printf "${GREEN}[✓] Command 'uraam' created in ${BIN_DIR}${NC}\n"
fi

printf "${GREEN}[+] Done! Launching URAAM...${NC}\n"
cd "$INSTALL_DIR"
./ruvomain.sh