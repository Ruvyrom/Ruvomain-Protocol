#!/usr/bin/env bash

autoperm() {
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$(dirname "$(readlink -f"$0")")")"
SOURCES_DIR="$REPO_DIR/lib/sources.sh"
if [ -z "$SOURCES_LOADED" ]; then
chmod +x "$SOURCES_DIR"
source "$SOURCES_DIR"
else
echo "Error: Could not find $SOURCES_DIR"
exit 1
fi
sources
export SOURCES_LOADED=1

# --- Auto-fix Permissions (Targeted) ---
modules=(
"$REPO_DIR/termux-setup.sh"
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

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
autoperm
fi
