#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
SOURCES_DIR="$REPO_DIR/lib/sources.sh"

vl_menu() {
clear
echo "--- System'shealth ---"
$EXEC dumpsys battery | grep "level"
$EXEC shell dumpsys cpuinfo | head -n 1

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
*) echo-e "${RED}Invalid option. Please choose 1-5.${NC}" ;;
esac
done
}

if[ "${BASH_SOURCE[0]}" = "$0" ]; then
if [ -f "$SOURCES_DIR" ]; then
source "$SOURCES_DIR"
sources
fi
vl_menu
fi
