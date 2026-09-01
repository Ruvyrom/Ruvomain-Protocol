#!/usr/bin/env bash
# Ruvomain ADB-Termux Installer (Pure Bash / Zero-Dependency)
# Install your multiple own apk via adb. Place your apk files in ./ruvomain-installer/Apps folder.
# Version 1.0.0 (Refactored for Ruvomain Protocol - Surgical Minimalism)
# Created by Ruvyrom
set -euo pipefail

# --- Dynamic Path Resolution and sources ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
APP_DIR="./Apps"
SOURCES_DIR="$REPO_DIR/lib/sources.sh"
if [ -f "$SOURCES_DIR" ]; then
chmod +x "$SOURCES_DIR"
source "$SOURCES_DIR"
else
echo "Error: Could not find $SOURCES_DIR"
exit 1
fi
sources

# --- Initialization ---
show_logo
init_logs
ensure_adb
check_adb

## --- Installation ---
installer

echo "--------------------------------------------------"
echo "Operation completed successfully."
echo "If URAAM has been useful to you, a star on GitHub is"
echo "the best way to support the project:"
echo "https://github.com/Ruvyrom/Ruvomain-Protocol"
echo "--------------------------------------------------"
