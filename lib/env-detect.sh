#!/usr/bin/env bash

env_detect() {
if [ -d "/data/data/com.termux" ]; then
EXEC=""
echo -e "${BLUE}[Local Termux Mode detected]${NC}"
else
EXEC="adb shell"
echo-e "${BLUE}[Remote Linux/ADB Mode detected]${NC}"
fi
} 

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
env_detect
fi
