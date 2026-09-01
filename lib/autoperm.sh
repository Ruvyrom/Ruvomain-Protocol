#!/usr/bin/env bash

autoperm() {
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

# --- Auto-fix Permissions (Targeted) ---
modules=("
"${./termux-setup.sh}"
"${./ruvomain-installer/ruvomain-installer.sh}"
"${./ruvomain-debloat/ruvomain-debloat.sh"
"${./ruvomain-backup/ruvomain-backup.sh}"
"${./ruvomain-restore/ruvomain-restore.sh"
)

for mod in "${modules[@]}"; do
if [ -f "$mod" ]; then
chmod +x "$mod"
else
printf "[!] Error : Module %s not found.\n" "$mod" >&2
fi
done
}
