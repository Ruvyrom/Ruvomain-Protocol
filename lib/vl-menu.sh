#!/usr/bin/env bash

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
*) echo -e "${RED}Invalid option. Please choose 1-6.${NC}";;
esac
done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
vl_menu()
fi
