#!/usr/bin/env bash

REPO_DIR="$(dirname "$(dirname "$(readlink -f"$0")")")"
SOURCES_DIR="$REPO_DIR/lib/sources.sh"
if [ -z "$SOURCES_LOADED" ]; then
chmod +x "$SOURCES_DIR"
source "$SOURCES_DIR"
else
echo "Error: Could not find $SOURCES_DIR"
exit 1
sources
export SOURCES_LOADED=1
fi

vl_menu() {
clear
echo "--- Santé du Système ---"
adbshell dumpsys battery | grep "level"
adb shell dumpsys cpuinfo | head -n 1

options=(
"Debloat Logs"
"Restore Logs"
"Backup Logs"
"Return to Dashboard"
"Exit"
)

PS3="Select a module to execute (1-5): "
select opt in "${options[@]}"; do
case $opt in
"Debloat Logs")
clear
view_dlogs
;;
"Restore Logs")
clear
view_rlogs
;;
"Backup Logs")
clear
view_blogs
;;
"Return to Dashboard")
break
;;
"Exit")
echo "Exiting protocol..."
exit 0
;;
*) echo -e "${RED}Invalid option. Please choose 1-5.${NC}";;
esac
done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
vl_menu()
fi
