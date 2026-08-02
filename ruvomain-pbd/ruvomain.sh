#!/usr/bin/env bash
# Ruvomain ADB-Termux Debloater (Pure Bash / Zero-Dependency)
# Version 3.0.0 (Refactored for Ruvomain Protocol - Surgical Minimalism)
# Created by Ruvyrom
set -euo pipefail

# --- Dynamic Path Resolution and sources---
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
