#!/usr/bin/env bash
# Ruvomain ADB-Termux backup script (Pure Bash / Zero-Dependency)
# You can backup your user uninstalled file in JSON list.
# Version 1.0.0 (Refactored for Ruvomain Protocol - Surgical Minimalism)
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
init_logs-backup
show_logo
ensure_adb || exit 1

# --- Execution
generate_snapshot


