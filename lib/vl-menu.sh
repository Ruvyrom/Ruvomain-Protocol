#!/usr/bin/env bash

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

vl_menu() {
clear
echo "Select log type you want see"
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
clear
menu
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
