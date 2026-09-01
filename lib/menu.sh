#!/usr/bin/env bash

menu() {
echo "--- System's health ---"
$EXEC dumpsys battery | grep "level"
$EXEC dumpsys cpuinfo | head -n 1

options=(
"Termux Setup (Semi auto Termux setup)"
"Installer (APK installation)"
"Debloat (System Optimization)"
"Backup (Snapshot Data)"
"Restore (Revert/Install Apps)"
"View Logs"
"Exit"
)

PS3="Select a module to execute (1-7): "
select opt in "${options[@]}"; do
case $opt in
"Termux Setup (Semi auto Termux setuo)")
clear
$REPO_DIR/termux-setup.sh
;;
"Installer (APK installation)")
clear
$REPO_DIR/ruvomain-installer/ruvomain-installer.sh
;;
"Debloat (System Optimization)")
$REPO_DIR/ruvomain-debloat/ruvomain-debloat.sh
;;
"Backup (Snapshot Data)")
clear
$REPO_DIR/ruvomain-backup/ruvomain-backup.sh
;;
"Restore (Revert/Reinstall Apps)")
clear
$REPO_DIR/ruvomain-restore/ruvomain-restore.sh
;;
"View Logs")
clear
vl_menu
;;
"Exit")
echo "Exiting protocol..."
exit 0
;;
*) echo -e "${RED}Invalid option. Please choose 1-6.${NC}";;
esac
done
}
