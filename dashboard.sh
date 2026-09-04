#!/usr/bin/env bash
# Universal Ruvomain ADB Apps-Manager (URAAM) - Control Center
# Surgical access to your protocol modules
# Version: v3.0.0

# --- Dynamic Path Resolution and sources---
REPO_DIR="$(dirname "$SCRIPT_DIR")"
SOURCES_DIR="$REPO_DIR/lib/sources.sh"

if [ -f "$SOURCES_DIR" ]; then
chmod +x "$SOURCES_DIR"
source "$SOURCES_DIR"
sources
else
echo "Error: Could not find $SOURCES_DIR"
exit 1
fi

clear
show_logo
echo -e "${BLUE}=========================================="
echo -e "   RUVOMAIN-PROTOCOL | CONTROL CENTER"
echo -e "==========================================${NC}"

ensure-adb || exit 1
ensure-jq || exit 1
autoperm
menu
