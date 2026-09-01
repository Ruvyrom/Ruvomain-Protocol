#!/usr/bin/env bash

menu() {
clear
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
$REPO_DIR/termux-setup.sh
;;
"Installer (APK installation)")
$REPO_DIR/ruvomain-installer/ruvomain-installer.sh
;;
"Debloat (System Optimization)")
$REPO_DIR/ruvomain-debloat/ruvomain-debloat.sh
;;
"Backup (Snapshot Data)")
$REPO_DIR/ruvomain-backup/ruvomain-backup.sh
;;
"Restore (Revert/Reinstall Apps)")
$REPO_DIR/ruvomain-restore/ruvomain-restore.sh
;;
"Exit")
echo "Exiting protocol..."
exit 0
;;
*) echo -e "${RED}Invalid option. Please choose 1-6.${NC}";;
esac
done
}
