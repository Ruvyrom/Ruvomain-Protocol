#!/usr/bin/env bash
# Universal Ruvomain ADB Apps-Manager (URAAM) - Control Center
# Surgical access to your protocol modules
# Version: v2.0.0

# --- Dynamic Path Resolution and sources---
REPO_DIR="$(cd "./Ruvomain-Protocol" && pwd)"
SOURCES_DIR="$REPO_DIR/lib/sources.sh"
if [ -f "$SOURCES_DIR" ]; then
chmod +x "$SOURCES_DIR"
source "$SOURCES_DIR"
else
echo "Error: Could not find $SOURCES_DIR"
exit 1
fi
sources

clear
echo -e "${BLUE}=========================================="
echo -e "   RUVOMAIN-PROTOCOL | CONTROL CENTER"
echo -e "==========================================${NC}"
show_logo

autoperm
menu
