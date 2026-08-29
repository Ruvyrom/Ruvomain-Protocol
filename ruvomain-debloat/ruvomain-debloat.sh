#!/usr/bin/env bash
# Ruvomain ADB-Termux Debloater script ( Bash/JQ )
# You can apply your own json debloat list file. Use or place your *.json file in ./Configs and select it in menu.
# Version 5.0.0 (Refactored for Ruvomain Protocol - Surgical Minimalism)
# Created by Ruvyrom
set -euo pipefail

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

init_logs
env_detect
show_logo

echo -e "${BLUE}=== Ruvomain-Protocol: Package Debloater ===${NC}"

ensure-adb
ensure-jq
debloat
final

echo -e "${GREEN}=== Operation finished===${NC}"
