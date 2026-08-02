#!/usr/bin/env bash

env() {
if [ -d "/data/data/com.termux" ] || [ -f "/system/bin/pm" ]; then
    EXEC="pm uninstall -k --user 0"
else
    EXEC="adb shell pm uninstall -k --user 0"
fi
} 
