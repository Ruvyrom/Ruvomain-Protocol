#!/usr/bin/env bash

jq="$1"; 
sudo="$2";

ensure_jq() {
    if command -v "$1" &>/dev/null; then
        return 0
    fi

    printf "${RED}[!] ADB not found.${NC}\n"
    printf "${GREEN}[+] Attempting auto-installation...${NC}\n"
    if [ -d "/data/data/com.termux" ]; then
        pkg install -y "$1"
    elif command -v apt-get &>/dev/null; then
        "$2" apt-get update && sudo apt-get install -y "$1"
    elif command -v pacman &>/dev/null; then
        "$2" pacman -S --noconfirm "$1"
    elif command -v dnf &>/dev/null; then
        "$2" dnf install -y "$1"
    else
        printf "${RED}[!] ERROR: No supported package manager found to install JQ. Please install JQ manually.${NC}\n" >&2
        return 1
    fi
}