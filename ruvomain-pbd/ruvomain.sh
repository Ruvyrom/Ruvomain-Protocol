#!/usr/bin/env bash
# Ruvomain ADB-Termux Debloater (Pure Bash / Zero-Dependency)
# You can apply tiers list for S24+ or use your own json debloat list file. Place your *.json file in ./Configs/Import and select it via option 4.
# Version 4.0.0 (Refactored for Ruvomain Protocol - Surgical Minimalism)
# Created by Ruvyrom
set -euo pipefail

# --- Dynamic Path Resolution and sources ---
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

# --- Initialization ---
init_logs
ensure_adb || exit 1
show_logo
model
env

# --- Modules Execution ---
injection
visitor

# --- Menu & Configurations ---
display_main_menu
configurations
final
