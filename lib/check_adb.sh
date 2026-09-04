#!/usr/bin/env bash

check_adb() {
echo -e "${GREEN}[INFO]${NC} Initializing APK deployment..."

# 1. ADB binary check
if ! command -v adb &> /dev/null; then
echo -e "${RED}[ERROR]${NC} ADB is not installed or notfound in PATH."
exit 1
fi

# 2. Device connection check
if [ -z "$(adb devices -l | grep 'device$')" ]; then
echo -e "${RED}[ERROR]${NC} No device detected via ADB."
exit 1
fi

# 3. Directory check
if [ ! -d "$APP_DIR" ]; then
echo -e "${RED}[ERROR]${NC}Directory $APP_DIR not found."
exit 1
fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
check_adb
fi
