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
modules=(""$t" ""$r2""$i"/"$r1""$i".sh" ""$r2""$d"/"$r1""$d".sh" ""$r2""$b"/"$r1""$b".sh" ""$r2""$r3"/"$r1""$r3".sh")

for mod in "${modules[@]}"; do
if [ -f "$mod" ]; then
chmod +x "$mod"
fi
done
}
