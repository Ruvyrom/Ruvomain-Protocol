#!/usr/bin/env bash

autoperm() {
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
SOURCES_DIR="$REPO_DIR/lib/sources.sh"

# --- Auto-fix Permissions (Targeted) ---
modules=(
"$REPO_DIR/wireless_adb-setup.sh"
"$REPO_DIR/ruvomain-installer/ruvomain-installer.sh"
"$REPO_DIR/ruvomain-debloat/ruvomain-debloat.sh"
"$REPO_DIR/ruvomain-backup/ruvomain-backup.sh"
"$REPO_DIR/ruvomain-restore/ruvomain-restore.sh"
)

for mod in "${modules[@]}"; do
if [ -f "$mod" ]; then
chmod +x "$mod"
printf "${GREEN}[✓] Permissions applied: %s${NC}\n" "$(basename "$mod")"
else
printf "[!] Error : Module %s not found.\n" "$mod" >&2
fi
done
} 

if[ "${BASH_SOURCE[0]}" = "$0" ]; then
if [ -f "$SOURCES_DIR" ]; then
source "$SOURCES_DIR"
sources
fi
autoperm
fi
