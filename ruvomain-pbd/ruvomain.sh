#!/usr/bin/env bash
# Ruvomain ADB-Termux Debloater (Pure Bash / Zero-Dependency)
# Version 4.0.0 (Refactored for Ruvomain Protocol - Surgical Minimalism)
# Created by Ruvyrom
set -euo pipefail

# --- Dynamic Path Resolution and sources---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCES_DIR="$REPO_DIR/lib/sources.sh"
chmod +x "$SOURCES_DIR"
source "$SOURCES_DIR"
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
