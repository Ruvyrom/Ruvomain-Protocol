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

# Define the options
options=(
"Installer (Manage Initial Setup)"
"Debloat (System Optimization)"
"Backup (Snapshot Data)"
"Restore (Revert/Install Apps)"
"Exit"
)

PS3="Select a module to execute (1-5): "
select opt in "${options[@]}"; do
case $opt in
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
*) echo -e "${RED}Invalid option. Please choose 1-5.${NC}";;
esac
done
