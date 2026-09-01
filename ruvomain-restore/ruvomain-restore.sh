#!/usr/bin/env bash
# Ruvomain ADB-Termux Restorer script ( Bash/JQ )
# You can apply your own json debloat list file. Use or place your *.json file in ./ruvomain-backup/backups and select it in menu.
# Version 2.0.0 (Refactored for Ruvomain Protocol - Surgical Minimalism)
# Created by Ruvyrom (https://github.com/Ruvyrom/Ruvomain-Protocol)
set -euo pipefail

# --- Dynamic Path Resolution and sources---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCES_DIR="$REPO_DIR/lib/sources.sh"
if [ -f "$SOURCES_DIR" ]; then
chmod +x "$SOURCES_DIR"
source "$SOURCES_DIR"
else
echo "Error: Could not find $SOURCES_DIR"
exit 1
fi
sources

show_logo
init_logs-restore
env_detect
ensure_adb
ensure_jq

echo -e "${BLUE}=== Ruvomain-Protocol: Package Restoration ===${NC}"

restore
