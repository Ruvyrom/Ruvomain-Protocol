#!/usr/bin/env bash

check_adb() {
# ADB binary check
if ! command -v adb &> /dev/null; then
echo -e "${RED}[ERROR]${NC} ADB is not installed or notfound in PATH."
return 1
fi

# Device connection check
if [ -z "$(adb devices -l | grep 'device$')" ]; then
echo -e "${RED}[ERROR]${NC} No device detected via ADB."
return 1
fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
check_adb
fi
