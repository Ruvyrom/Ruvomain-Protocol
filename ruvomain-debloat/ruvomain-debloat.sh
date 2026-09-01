#!/usr/bin/env bash
# Ruvomain ADB-Termux Debloater script ( Bash/JQ )
# You can apply your own json debloat list file. Use or place your *.json file in ./Configs and select it in menu.
# Version 5.0.0 (Refactored for Ruvomain Protocol - Surgical Minimalism)
# Created by Ruvyrom {https://github.com/Ruvyrom/Ruvomain-Protocol)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$(dirname "$(readlink -f"$0")")")"
SOURCES_DIR="$REPO_DIR/lib/sources.sh"
if [ -z "$SOURCES_LOADED" ]; then
chmod +x "$SOURCES_DIR"
source "$SOURCES_DIR"
else
echo "Error: Could not find $SOURCES_DIR"
exit 1
sources
export SOURCES_LOADED=1
fi

show_logo
init_logs
env_detect

echo -e "${BLUE}=== Ruvomain-Protocol: Package Debloater ===${NC}"

ensure_adb || exit 1
ensure_jq || exit 1
debloat
final

echo -e "${GREEN}=== Operation finished===${NC}"
