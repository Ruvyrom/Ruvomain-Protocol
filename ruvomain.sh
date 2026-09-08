#!/usr/bin/env bash
#
# RUVOMAIN-PROTOCOL (URAAM) - All-in-One Edition
#
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$SCRIPT_DIR"
CONFIGS_DIR="$REPO_DIR/Configs/debloat"
BACKUPS_DIR="$REPO_DIR/Configs/backup-restore"
APP_DIR="$REPO_DIR/Apps"
LOGD_DIR="$REPO_DIR/Logs/debloat"
LOGB_DIR="$REPO_DIR/Logs/backup"
LOGR_DIR="$REPO_DIR/Logs/restore"

BLUE='\033[0;34m'
BOLD='\033[1m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[1;31m'
WHITE='\033[0;37m'
YELLOW='\033[0;33m'
NC='\033[0m'

if [ -d "/data/data/com.termux" ]; then
if command -v rish >/dev/null 2>&1; then
EXEC="rish -c"
echo -e "${BLUE}[Termux Mode: Shizuku/rish detected]${NC}"
elif [ "$(id -u)" -eq 0 ] || command -v su >/dev/null 2>&1; then
EXEC="su -c"
echo -e "${BLUE}[Termux Mode: Root/su detected]${NC}"
elif command -v adb >/dev/null 2>&1; then
EXEC="adb shell"
echo -e "${BLUE}[Local ADB detected]${NC}"
else
EXEC=""
echo -e "${BLUE}[Termux Mode detected (Stand-alone)]${NC}"
fi
else
EXEC="adb shell"
echo -e "${BLUE}[Remote Linux/ADB Mode detected]${NC}"
fi
export EXEC

show_logo() {
echo -e "${CYAN}"
cat << 'EOF'
    ____                                    _     
   / __ \__  ___   ______  ____ ___  ____ _(_)___ 
  / /_/ / / / / | / / __ \/ __ `__ \/ __ `/ / __ \
 / _, _/ /_/ /| |/ / /_/ / / / / / / /_/ / / / / /
/_/ |_|\__,_/ |___/\____/_/ /_/ /_/\__,_/_/_/ /_/ 
   / __ \_________  / /_____  _________  / /__    
  / /_/ / ___/ __ \/ __/ __ \/ ___/ __ \/ / _ \   
 / ____/ /  / /_/ / /_/ /_/ / /__/ /_/ / /  __/   
/_/   /_/   \____/\__/\____/\___/\____/_/\___/    
EOF
echo -e "${NC}"
}

init_logs() {
mkdir -p "$LOGD_DIR"

find "$LOGD_DIR" -name "ruvomain-debloat-*.log" -type f -mtime +30 -delete 2>/dev/null

LOGFILE="$LOGD_DIR/ruvomain-debloat-$(date +%Y%m%d_%H%M%S).log"

exec> >(tee -a "$LOGFILE") 2>&1
}

init_logs_backup() {

mkdir -p "$LOGB_DIR"

find "$LOGB_DIR" -name "ruvomain-backup-*.log" -type f -mtime +30 -delete 2>/dev/null

LOGFILE="$LOGB_DIR/ruvomain-backup-$(date +%Y%m%d_%H%M%S).log"

exec> >(tee -a "$LOGFILE") 2>&1
}

init_logs_restore() {

mkdir -p "$LOGR_DIR"

find "$LOGR_DIR" -name "ruvomain-restore-*.log" -type f -mtime +30 -delete 2>/dev/null

LOGFILE="$LOGR_DIR/ruvomain-restore-$(date +%Y%m%d_%H%M%S).log"

exec> >(tee -a "$LOGFILE") 2>&1
}


ensure_adb() {
if command -v adb >/dev/null; then
printf "${GREEN}[✓] ADB is already installed and ready to use.${NC}\n"
return 0
fi

printf "${RED}[!] ADB is not detected on your system.${NC}\n"
read -p "Do you want to install ADB now? (y/n) : " choice

case "$choice" in
y|Y)
printf "${GREEN}[+] Attempting automatic installation...${NC}\n"
# 3. Existing installation logic
if command -v pkg >/dev/null; then
pkg install -y android-tools
elif command -v apt-get >/dev/null; then
sudo apt-get update && sudo apt-get install -y adb
elif command -v pacman >/dev/null; then
sudo pacman -S --noconfirm android-tools
elif command -v dnf >/dev/null; then
sudo dnf install -y android-tools
elif command -v brew >/dev/null; then
brew install android-platform-tools
else
printf "${RED}[!] Package manager not supported. Please install ADB manually.${NC}\n" >&2
return 1
fi
;;
*)
printf "${YELLOW}[-] Installation cancelled. ADB is required for the project to work properly.${NC}\n"
return 1
;;
esac
}

ensure_jq() {
if command -v jq >/dev/null; then
printf "${GREEN}[✓] JQ is already installed and ready to use.${NC}\n"
return 0
fi

printf "${RED}[!] JQ is not detected onyour system.${NC}\n"
read -p "Do you want to install JQ now? (y/n) : " choice

case "$choice" in
y|Y)
printf "${GREEN}[+] Attempting automatic installation...${NC}\n"
# 3. Existing installation logic
if command -v pkg >/dev/null; then
pkg install -y jq
elif command -v apt-get >/dev/null; then
sudo apt-get update && sudo apt-get install -y jq
elif command -v pacman >/dev/null; then
sudo pacman -S --noconfirm jq
elif command -v dnf >/dev/null; then
sudo dnf install -y jq
elif command -v brew >/dev/null; then
brew install jq
else
printf "${RED}[!] Package manager not supported. Please install JQ manually.${NC}\n" >&2
return 1
fi
;;
*)
printf "${YELLOW}[-] Installation cancelled. JQ is required for the project to work properly.${NC}\n"
return 1
;;
esac
}

wireless_adb(){
clear
show_logo
echo -e "${BLUE}===================================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | WIRELESS ADB SETUP${NC}"
echo -e "${BLUE}===================================================${NC}"
echo ""
ensure_adb
echo "--------------------------------------------------------"
echo "CRITICAL STEP: Wireless Debugging"
echo "1. Go to Settings > Developer Options."
echo "2. Tap on 'Wireless debugging' (the text itself)."
echo "3. Select 'Pair device with pairing code'."
echo "--------------------------------------------------------"
echo "\n"

read -rp "Do you need to PAIR first? (y/N): " need_pair

if [[ "$need_pair" =~ ^[yY]$ ]]; then
echo -e "\n--- STEP 1: PAIRING ---"
echo "Check the pairing popup dialog for IP:Port and the 6-digit code."
read -rp "Enter PAIRING host:port (e.g., 127.0.0.1:37123): " pair_host
read -rp "Enter 6-digit PAIRING CODE: " pair_code

if [ -n "$pair_host" ] && [ -n "$pair_code" ]; then
echo -e "\n[*] Pairing with $pair_host..."
adb pair "$pair_host" "$pair_code"
else
echo -e "\n\e[1;31m[!] Pairing aborted: host or code cannot be empty.\e[0m"
fi
fi

echo -e "\n--- STEP 2: CONNECTION ---"
echo "Look at the main Wireless Debugging screen for the CONNECTION port."
read -rp "Enter CONNECTION host:port (e.g., 127.0.0.1:41235): " conn_host

if [ -n "$conn_host" ]; then
echo -e "\n[*] Connecting to $conn_host..."
adb connect "$conn_host"

sleep 1
if adb devices | grep -q "$conn_host.*device"; then
echo -e "\n${GREEN}[✓] Successfully connected via Wireless ADB!${NC}"
else
echo -e "\n${RED}[!] Connection failed. Check IP/Port and make sure screen is on.${NC}"
fi
else
echo -e "\n${RED}[!] Connection aborted: host empty.${NC}"
fi

echo ""
read -rp "Press Enter to return to main menu..."
}

check_adb() {
# ADB binary check
if ! command -v adb &> /dev/null; then
echo -e "${RED}[ERROR]${NC} ADB is not installed or notfound in PATH."
return 1
fi

# Device connection check
if [ -z "$(adb devices -l | grep 'device$')" ]; then
echo -e "${RED}[ERROR]${NC} No device detected via ADB."
return 1
fi
}

ruvomain_debloat() {
clear
show_logo
echo -e "${BLUE}==========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | DEBLOATER${NC}"
echo -e "${BLUE}==========================================${NC}"

echo -e "${RED}Before finalizing execution, place your personal Canta JSON lists or use one of the files located in /Configs/debloat via the selection menu.${NC}"

init_logs 2>/dev/null || true

ensure_adb || exit 1
ensure_jq || exit 1
check_adb
sleep 1

shopt -s nullglob
local files=("$CONFIGS_DIR"/*.json)
shopt -u nullglob

if [ ${#files[@]} -eq 0 ]; then
echo -e "${RED}No .json files found in $CONFIGS_DIR${NC}"
return 1
fi

local display_names=()
for f in "${files[@]}"; do
display_names+=("$(basename "$f")")
done

echo "Configuration files found:"
echo "----------------------------------------"

# Interactive menu
PS3="Select the file number (1-${#files[@]}): "
select short_name in "${display_names[@]}"; do
if [ -n "$short_name" ]; then
file="${files[$((REPLY-1))]}"
echo -e "\nSelected file: ${GREEN}${short_name}${NC}"
break
else
echo -e "${RED}Invalid selection, please try again.${NC}"
fi
done

mapfile -t PACKAGES < <(jq -r 'if type=="array" then .[] elif .apps then .apps[].packageName // .apps[] else empty end' "$file" 2>/dev/null)

if [ ${#PACKAGES[@]} -eq 0 ]; then
echo -e "${RED}No packages found. Verify the JSON format.${NC}"
return 1
fi

echo -e "${BLUE}Fetching installed packages from device...${NC}"
local INSTALLED_PKGS
INSTALLED_PKGS=$($EXEC pm list packages -u 2>/dev/null | tr -d '\r' | cut -d: -f2)


echo -e "${BLUE}Starting debloating of ${#PACKAGES[@]} packages...${NC}"

local SUCCESS=0
local SKIPPED=0
local FAILED=0

for pkg in "${PACKAGES[@]}"; do
[ -z "$pkg" ] && continue
echo -n "Checking $pkg: "

if ! echo "$INSTALLED_PKGS" | grep -qx "$pkg"; then
echo -e "${YELLOW}Skipped (not installed)${NC}"
((SKIPPED++))
continue
fi

if $EXEC pm uninstall -k --user 0 "$pkg">/dev/null 2>&1; then
echo -e "${GREEN}Success (removed)${NC}"
((SUCCESS++))
else
echo -e "${RED}Failed${NC}"
((FAILED++))
fi
done

echo "----------------------------------------"
echo -e "Summary: ${GREEN}$SUCCESS removed${NC}, ${YELLOW}$SKIPPED skipped${NC}, ${RED}$FAILED failed${NC}."
sleep 1
read -rp "Press Enter to return to main menu"
return 0
}

ruvomain_backup() {
clear
show_logo
echo -e "${BLUE}===============================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | BACKUP CREATOR${NC}"
echo -e "${BLUE}===============================================${NC}"

init_logs_backup 2>/dev/null || true

check_adb

mkdir -p "$BACKUPS_DIR"
local output_file="$BACKUPS_DIR/backup_$(date +%Y%m%d_%H%M%S).json"

echo -e "--- Warning ---"
echo -e "You are about to create backup.*json."
read -p "Are you sure you want to proceed? (y/N): " confirm

if [[ $confirm != "y" && $confirm != "Y" ]]; then
echo "Operation cancelled."
exit 0
fi

echo -e "--- Generating snapshot: $output_file---"

{
echo "{"
echo '  "name": "Ruvomain_Snapshot_Auto_'$(date +%Y%m%d)'",'
echo '  "description": "Automatic backup generated by Ruvomain-Protocol",'
echo '  "author": "User",'
echo '  "version": "2.0",'
echo '  "apps":['
} > "$output_file"

# 'pm list packages -u' displays: package:com.example.app
local packages
packages=$($EXEC pm list packages -u | sed 's/package://g' | tr -d '\r' | grep -v '^$' | sort) || { echo "Error: Failed to retrieve package list."; return 1; }

if [[ -z "$packages" ]]; then
echo "[!] Error: Unable to retrieve the list of packages. Check ADB."
return 0
fi

local pkg_array=($packages)
local total=${#pkg_array[@]}
local count=0

for pkg in "${pkg_array[@]}"; do
count=$((count + 1))

echo '.   {' >> "$output_file"
echo '      "packageName": "'$pkg'"' >> "$output_file"

# Managing the comma for JSON
if [ "$count" -lt "$total" ]; then
echo '    },' >> "$output_file"
else
echo '    }' >> "$output_file"
fi
done

# Closing the JSON
echo '  ]' >> "$output_file"
echo '}' >> "$output_file"

echo -e "Your uninstalled apps list created to /Config/backup-restore."
sleep 1
read -rp "Press Enter to return to main menu"
return 0
}

ruvomain_installer() {
clear
show_logo
echo -e "${BLUE}==========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | INSTALLER${NC}"
echo -e "${BLUE}==========================================${NC}"

check_adb

echo -e "Check Apps Dir"
if [ ! -d "$APP_DIR" ]; then
echo -e "${RED}[ERROR]${NC}Directory $APP_DIR not found."
return 1
fi

echo -e "${GREEN}[INFO]${NC} Deploying packages..."

for apk in "$APP_DIR"/*.apk; do
if [ -f "$apk" ]; then
echo -e "Installing: $(basename "$apk")"

# -r: Replace existing application
# -g: Grant all runtime permissions (minimizes interaction)
if adb install -r -g "$apk" >/dev/null 2>&1; then
echo -e "${GREEN}✓${NC} Successfully installed."
else
echo -e "${RED}✗${NC} Installation failed."
fi
fi
done
sleep 1
read -rp "Press Enter to return to main menu"
return 0
}

ruvomain_restore() {
clear
show_logo
echo -e "${BLUE}=========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | RESTORER${NC}"
echo -e "${BLUE}=========================================${NC}"

init_logs_restore 2>/dev/null || true

shopt -s nullglob
local files=("$BACKUPS_DIR"/*.json)
shopt -u nullglob

local display_names=()
for f in "${files[@]}"; do
display_names+=("$(basename "$f")")
done

echo -e "Configuration files found:"
echo -e "----------------------------------------"

PS3="Select the file number (1-${#files[@]}): "
select short_name in "${display_names[@]}"; do
if [ -n "$short_name" ]; then
file="${files[$((REPLY-1))]}"
echo -e "\nSelected file: ${GREEN}${short_name}${NC}"
break
else
echo -e "${RED}Invalid selection, please try again.${NC}"
fi
done

mapfile -t PACKAGES < <(jq -r 'if type=="array" then .[] elif .apps then.apps[].packageName // .apps[] else empty end' "$file" 2>/dev/null)

if [ ${#PACKAGES[@]} -eq 0 ]; then
echo -e "${RED}No packages found. Verify the JSON format.${NC}"
read -rp "Press Enter to return to main menu"
return 1
fi

echo -e "${BLUE}Starting restoration of ${#PACKAGES[@]} packages...${NC}"

local SUCCESS=0
local FAILED=0

for pkg in "${PACKAGES[@]}"; do
[ -z "$pkg" ] && continue
echo -n "Restoring $pkg: "

if $EXEC pm install-existing --user 0 "$pkg" >/dev/null 2>&1; then
echo -e "${GREEN}Success${NC}"
((SUCCESS++))
else
echo -e "${RED}Failed (already present or not found)${NC}"
((FAILED++))
fi
done

echo "----------------------------------------"
echo -e "Summary: ${GREEN}$SUCCESS restored${NC}, ${RED}$FAILED failed/skipped${NC}."
sleep 1
read -rp "Press Enter to return to main menu"
return 0
}

view_dlogs() {
if ls $LOGD_DIR/*.log >/dev/null 2>&1; then
if command -v nano >/dev/null 2>&1; then
echo -e "${GREEN}Opening logs with nano...${NC}"
nano $LOGD_DIR/*.log
elif command -v less >/dev/null 2>&1; then
echo -e "${YELLOW}Nano not found. Using less...${NC}"
cat $LOGD_DIR/*.log | less
else
echo -e "${YELLOW}Using cat (no nano/less found):${NC}"
cat $LOGD_DIR/*.log
fi
else
echo -e "${RED}No log files found in $LOGD_DIR${NC}"
sleep 2
fi
}

view_blogs() { 
if ls $LOGB_DIR/*.log >/dev/null 2>&1; then
if command -v nano >/dev/null 2>&1; then
echo -e "${GREEN}Opening logs with nano...${NC}"
nano $LOGB_DIR/*.log
elif command -v less >/dev/null 2>&1; then
echo -e "${YELLOW}Nano not found. Using less...${NC}"
cat $LOGB_DIR/*.log | less
else
echo -e "${YELLOW}Using cat (no nano/less found):${NC}"
cat $LOGB_DIR/*.log
fi
else
echo -e "${RED}No log files found in $LOGB_DIR${NC}"
sleep 2
fi
}

view_rlogs() {
if ls $LOGR_DIR/*.log >/dev/null 2>&1; then
if command -v nano >/dev/null 2>&1; then
echo -e "${GREEN}Opening logs with nano...${NC}"
nano $LOGR_DIR/*.log
elif command -v less >/dev/null 2>&1; then
echo -e "${YELLOW}Nano not found. Using less...${NC}"
cat $LOGR_DIR/*.log | less
else
echo -e "${YELLOW}Using cat (no nano/less found):${NC}"
cat $LOGR_DIR/*.log
fi
else
echo -e "${RED}No log files found in $LOGD_DIR${NC}"
sleep 2
fi
}

vl_menu() {
clear
show_logo
echo -e "${BLUE}=========================================="
echo -e "URAAM RUVOMAIN ADB APP-MANAGER | View Logs"
echo -e "==========================================${NC}"

echo -e "\n [1] View Debloat Logs"
echo -e " [2] View Restore Logs"
echo -e " [3] View Backup Logs"
echo -e " [4] Return to Dashboard"
echo -e " [5] Exit\n"

read -rp "Enter choice: " choice
case "$choice" in

1) clear && view_dlogs;;
2) clear && view_rlogs ;;
3) clear && view_blogs ;;
4) return 0 ;;
5)
echo "Goodbye!"
clear
exit 0
;;
*)
echo "Invalide option, please try again."
sleep 1
;;
esac
}

if [ -d "/data/data/com.termux" ] && command -v termux-setup-storage >/dev/null 2>&1; then
echo "[*] Requesting storage access (please confirm the popup)..."
termux-setup-storage
fi

while true; do
clear
show_logo

echo -e "Instructions before starting:"
echo -e "For Ruvomain-debloat, place your personal or Canta JSON lists in /Configs/debloat"
echo -e "For Ruvomain-installer, place your APK files in /Apps"
echo -e "For Ruvomain-restore, use your backup created with ruvomain-backup or place your own backup .json file or Canta .json file list in /Configs/backup-restore"
echo -e "Ruvomain-backup places your backup .json file in /Configs/backup-restore"

ensure_adb || exit 1
ensure_jq || exit 1
check_adb

echo -e "\n [1] Debloat (Remove Bloatware)"
echo -e " [2] Install (Batch APK Install)"
echo -e " [3] Backup (Export Apps List)"
echo -e " [4] Restore (Revert/Reinstall Apps)"
echo -e " [5] Wireless ADB Setup (Pair & Connect)"
echo -e " [6] View Logs"
echo -e " [7] Exit\n"

read -rp "Enter choice: " choice
case "$choice" in

1) ruvomain_debloat ;;
2) ruvomain_installer ;;
3) ruvomain_backup ;;
4) ruvomain_restore ;;
5) wireless_adb ;;
6) vl_menu ;;
7)
echo "Goodbye!"
clear
exit 0
;;
*)
echo "Invalide option, please try again."
sleep 1
;;
esac
done
