#!/usr/bin/env bash
# Universal Ruvomain ADB Apps-Manager (URAAM) - Control Center
# Surgical access to your protocol modules
# Version: v3.0.0

# --- Dynamic Path Resolution and sources---
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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
echo -e " URAAM RUVOMAIN ADB APP-MANAGER | CONTROL CENTER"
echo -e "==========================================${NC}"
echo -e "before use a script:"
echo -e "For Ruvomain-debloat, place your personal or Canta JSON lists in ./Configs"
echo -e "For Ruvomain-installer, place your APK files in ./ruvomain-installer/Apps"
echo -e "For Ruvomain-restore, use your backup created with ruvomain-backup.sh or place your own backup .json file or Canta .json file list in ./ruvomain-backup/backups"
echo -e "Ruvomain-backup places your backup .json file in /ruvomain-backup/backups"


ensure-adb || exit 1
ensure-jq || exit 1
autoperm
menu
