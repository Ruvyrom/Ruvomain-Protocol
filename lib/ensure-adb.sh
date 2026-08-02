#!/usr/bin/env bash

ensure_adb() {
    if command -v adb &>/dev/null; then
        return 0
    fi

    printf "${RED}[!] ADB not found.${NC}\n"
    printf "${GREEN}[+] Attempting auto-installation...${NC}\n"
    if [ -d "/data/data/com.termux" ]; then
        pkg install -y android-tools
    elif command -v apt-get &>/dev/null; then
        sudo apt-get update && sudo apt-get install -y android-tools-adb
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm android-tools
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y android-tools
    else
        printf "${RED}[!] ERROR: No supported package manager found to install ADB. Please install ADB manually.${NC}\n" >&2
        return 1
    fi
}
