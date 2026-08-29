#!/usr/bin/env bash

envb() {
if [ -d "/data/data/com.termux" ] || [ -f "/system/bin/pm" ]; then
    EXEC="pm install-existing --user0"
else
    EXEC="adb shell pm install-existing --user0"
fi
} 
