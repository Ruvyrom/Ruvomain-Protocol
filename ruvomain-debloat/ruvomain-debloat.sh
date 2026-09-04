#!/usr/bin/env bash
# Ruvomain ADB-Termux Debloater script ( Bash/JQ )
# You can apply your own json debloat list file. Use or place your *.json file in ./Configs and select it in menu.
# Version 5.0.0 (Refactored for Ruvomain Protocol - Surgical Minimalism)
# Created by Ruvyrom {https://github.com/Ruvyrom/Ruvomain-Protocol)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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

show_logo
init_logs
env_detect

echo -e "${BLUE}=== Ruvomain-Protocol: Package Debloater ===${NC}"

ensure_adb || exit 1
ensure_jq || exit 1
debloat

echo "--------------------------------------------------"
echo "Operation completed successfully."
echo "If URAAM has been useful to you, a star on GitHub is"
echo "the best way to support the project:"
echo "https://github.com/Ruvyrom/Ruvomain-Protocol"
echo "--------------------------------------------------"
