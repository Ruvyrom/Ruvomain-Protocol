#!/usr/bin/env bash

ensure_adb() {
    if command -v "$2" &>/dev/null; then
        return 0
    fi

    printf "${RED}[!] ADB not found.${NC}\n"
    printf "${GREEN}[+] Attempting auto-installation...${NC}\n"
    if command -v apt-get &>/dev/null; then
        "$3" apt-get update && "$3" apt-get install -y "$2"
    elif command -v pacman &>/dev/null; then
        "$3" pacman -S --noconfirm "$1"
    elif command -v dnf &>/dev/null; then
        "$3" dnf install -y "$1"
    else
        printf "${RED}[!] ERROR: No supported package manager found to install ADB. Please install ADB manually.${NC}\n" >&2
        return 1
    fi
}
