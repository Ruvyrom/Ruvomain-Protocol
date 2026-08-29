#!/usr/bin/env bash
# Ruvomain-Protocol Control Center
# Surgical access to your protocol modules

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

clear
echo -e "${BLUE}=========================================="
echo -e "   RUVOMAIN-PROTOCOL | CONTROL CENTER"
echo -e "==========================================${NC}"
show_logo
# --- Auto-fix Permissions (Targeted) ---
modules=("ruvomain-installer" "ruvomain-debloat" "ruvomain-backup" "ruvomain-restore")

for mod in "${modules[@]}"; do
if [ -d "$mod" ]; then
chmod +x "$mod"/*.sh
fi
done

chmod +x ./termux-setup.sh

# Define the options
options=(
"Termux Setup (Setup Termux before scripts exexution)"
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
./termux-setup.sh
break
;;
"Installer (Manage Initial Setup)")
./ruvomain-installer/ruvomain-installer.sh
break
;;
"Debloat (System Optimization)")
./ruvomain-debloat/ruvomain-debloat.sh
break
;;
"Backup (Snapshot Data)")
./ruvomain-backup/ruvomain-backup.sh
break
;;
"Restore (Revert/Reinstall Apps)")
./ruvomain-restore/ruvomain-restore.sh
break
;;
"Exit")
echo "Exiting protocol..."
exit 0
;;
*) echo -e "${RED}Invalid option. Please choose 1-6.${NC}";;
esac
done
