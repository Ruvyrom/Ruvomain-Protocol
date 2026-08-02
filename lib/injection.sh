#!/usr/bin/env bash

injection() {
LIB_PATH="$REPO_DIR/lib/json-walk.sh"
if [ ! -f "$LIB_PATH" ]; then
    printf "${RED}[!] CRITICAL: %s not found. Infrastructure integrity compromised.\n${NC} " "$LIB_PATH" >&2
    exit 1
fi
source "$LIB_PATH"

if [[ ! -x "$LIB_PATH" ]]; then
    chmod +x "$LIB_PATH"
fi
} 
