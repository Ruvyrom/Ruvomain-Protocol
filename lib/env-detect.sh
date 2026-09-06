#!/usr/bin/env bash

env_detect() {
if [ -d "/data/data/com.termux" ]; then
if command -v rish >/dev/null 2>&1; then
EXEC="rish -c"
echo -e "${BLUE}[Termux Mode: Shizuku/rish detected]${NC}"
elif [ "$(id -u)" -eq 0 ] || command -v su >/dev/null 2>&1; then
EXEC="su -c"
echo -e "${BLUE}[Termux Mode: Root/su detected]${NC}"
elif command -v adb >/dev/null 2>&1; then
EXEC="adb shell"
echo -e "${BLUE}[Termux Mode: Local ADB detected]${NC}"
else
EXEC=""
echo -e "${BLUE}[Termux Mode detected (Stand-alone)]${NC}"
fi
else
EXEC="adb shell"
echo -e "${BLUE}[Remote Linux/ADB Mode detected]${NC}"
fi
export EXEC
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
env_detect
fi
