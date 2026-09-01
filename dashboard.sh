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

# --- Auto-fix Permissions (Targeted) ---
modules=(""$t" "$r2""$i"/"$r1""$i".sh" "$r2""$d"/"$r1""$d".sh" ""$r2""$b"/"$r1""$b".sh" ""$r2""$r3"/"$r1""$r3".sh")

for mod in "${modules[@]}"; do
if [ -f "$mod" ]; then
chmod +x "$mod"
fi
done

# Define the options
options=(
"Termux Setup (Semi-auto Termux setup)"
"Installer (APK installation)"
"Debloat (System Optimization)"
"Backup (Snapshot Data)"
"Restore (Revert/Install Apps)"
"Exit"
)

PS3="Select a module to execute (1-6): "
select opt in "${options[@]}"; do
case $opt in
"Termux Setup (Setup Termux before scripts exexution)")
"$t"
;;
"Installer (Manage Initial Setup)")
"$r2""$i"/"$r1""$i".sh
;;
"Debloat (System Optimization)")
"$r2""$d"/"$r1""$d".sh
;;
"Backup (Snapshot Data)")
"$r2""$b"/"$r1""$b".sh
;;
"Restore (Revert/Reinstall Apps)")
$r2""$r3"/"$r1""$r3".sh
;;
"Exit")
echo "Exiting protocol..."
exit 0
;;
*) echo -e "${RED}Invalid option. Please choose 1-6.${NC}";;
esac
done
