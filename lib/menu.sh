#!/usr/bin/env bash

menu() {
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
}
