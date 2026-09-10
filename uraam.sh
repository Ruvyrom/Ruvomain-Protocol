#!/usr/bin/env bash
#
# URAAM - Universal Ruvomain ADB App-Manager v4.2.0 - All-in-One Edition
#
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
SOURCE="$(readlink "$SOURCE")"
[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
cd "$SCRIPT_DIR" || exit 1
REPO_DIR="$SCRIPT_DIR"
CONFIGS_DIR="$REPO_DIR/Configs/debloat"
BACKUPS_DIR="$REPO_DIR/Configs/backup-restore"
APP_DIR="$REPO_DIR/Apps"
LOGD_DIR="$REPO_DIR/Logs/debloat"
LOGB_DIR="$REPO_DIR/Logs/backup"
LOGR_DIR="$REPO_DIR/Logs/restore"
REPO_URL="https://github.com/Ruvyrom/Uraam"
BRANCH="main"

if [ -z "$INSTALL_DIR" ]; then
INSTALL_DIR="$HOME/Uraam"
fi

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
echo -e "\n${BLUE}[Termux Mode: Shizuku/rish detected]${NC}"
elif [ "$(id -u)" -eq 0 ] || command -v su >/dev/null 2>&1; then
EXEC="su -c"
echo -e "\n${BLUE}[Termux Mode: Root/su detected]${NC}"
elif command -v adb >/dev/null 2>&1; then
EXEC="adb shell"
echo -e "\n${BLUE}[Local ADB detected]${NC}"
else
EXEC=""
echo -e "\n${BLUE}[Termux Mode detected (Stand-alone)]${NC}"
fi
else
EXEC="adb shell"
echo -e "\n${BLUE}[Remote Linux/ADB Mode detected]${NC}"
fi
export EXEC

show_logo() {
echo -e "${CYAN}"
cat << 'EOF'
::| ::|::::::\ ::::\  ::::\ ::::::|
::|_::|::|,::|::|,::|::|,::|:::"::|
`:::::|::| ::\::| ::|::| ::|::| ::|
EOF
echo -e "${NC}"
}

init_logs() {
mkdir -p "$LOGD_DIR"

find "$LOGD_DIR" -name "uraam-debloat-*.log" -type f -mtime +30 -delete 2>/dev/null

LOGFILE="$LOGD_DIR/uraam-debloat-$(date +%Y%m%d_%H%M%S).log"

exec> >(tee -a "$LOGFILE") 2>&1
}

init_logs_backup() {
mkdir -p "$LOGB_DIR"

find "$LOGB_DIR" -name "uraam-backup-*.log" -type f -mtime +30 -delete 2>/dev/null

LOGFILE="$LOGB_DIR/uraam-backup-$(date +%Y%m%d_%H%M%S).log"

exec> >(tee -a "$LOGFILE") 2>&1
}

init_logs_restore() {
mkdir -p "$LOGR_DIR"

find "$LOGR_DIR" -name "uraam-restore-*.log" -type f -mtime +30 -delete 2>/dev/null

LOGFILE="$LOGR_DIR/uraam-restore-$(date +%Y%m%d_%H%M%S).log"

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
sleep 1
read -rp "Press [Enter] to return to main menu..."
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

printf "${RED}[!] JQ is not detected on your system.${NC}\n"
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
read -rp "Press [Enter] to return to main menu..."
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
echo -e "\n${BLUE}--------------------------------------------------------${NC}"
echo -e "\n${CYAN}CRITICAL STEP: Wireless Debugging.${NC}"
echo -e "\n${CYAN}1. Go to Settings > Developer Options.${NC}"
echo -e "\n${CYAN}2. Tap on 'Wireless debugging' (the text itself).${NC}"
echo -e "\n${CYAN}3. Select 'Pair device with pairing code'.${NC}"
echo -e "\n${BLUE}--------------------------------------------------------${NC}"
echo ""

read -rp "Do you need to PAIR first? (y/N): " need_pair

case "$need_pair" in
y|Y)
echo -e "\n--- STEP 1: PAIRING ---"
echo -e "\n${CYAN}Check the pairing popup dialog${NC}"
echo -e "${CYAN}for IP:Port and the 6-digit code.${NC}"
read -rp "Enter PAIRING host:port (e.g., 127.0.0.1:37123): " pair_host
read -rp "Enter 6-digit PAIRING CODE: " pair_code

if [ -n "$pair_host" ] && [ -n "$pair_code" ]; then
echo -e "\n${GREEN}[*] Pairing with $pair_host...${NC}"
adb pair "$pair_host" "$pair_code"
else
echo -e "\n${RED}[!] Pairing aborted: host or code cannot be empty.${NC}"
fi
;;
esac

echo -e "\n--- STEP 2: CONNECTION ---"
echo -e "\n${CYAN}Look at the main Wireless Debugging screen${NC}" 
echo -e "${CYAN}for the CONNECTION port.${NC}"

read -rp "Enter CONNECTION host:port (e.g., 127.0.0.1:41235): " conn_host

if [ -n "$conn_host" ]; then
echo -e "\n[*] Connecting to $conn_host..."
adb connect "$conn_host"

sleep 1
if adb devices | grep -q "$conn_host.*device"; then
echo -e "\n${GREEN}[✓] Successfully connected via Wireless ADB!${NC}"
else
echo -e "\n${RED}[!] Connection failed.${NC}"
echo -e "Check IP/Port and make sure screen is on."
fi
else
echo -e "\n${RED}[!] Connection aborted: host empty.${NC}"
fi

sleep 1
read -rp "Press Enter to return to main menu..."
return 1
}

check_adb() {
if ! command -v adb &> /dev/null; then
echo -e "\n${RED}[ERROR]${NC} ADB is not installed or not found in PATH."
return 1
fi

if ! adb devices | grep -q "device$"; then
echo -e "\n${RED}[ERROR]${NC} No device detected via ADB."
return 1
fi
return 0
}

uraam_debloat() {
clear
show_logo
echo -e "${BLUE}==========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | DEBLOATER${NC}"
echo -e "${BLUE}==========================================${NC}"
echo -e "\n${CYAN}Place debloat configurations in ./Configs/debloat/${NC}"
echo -e "${CYAN}(Canta JSON, UAD lists & raw packages supported).${NC}"
echo -e "${BLUE}------------------------------------------${NC}"

init_logs 2>/dev/null || true

ensure_adb || exit 1
ensure_jq || exit 1

check_adb || {
read -rp "Press Enter to return to main menu..."
return 1
}

shopt -s nullglob
local files=("$CONFIGS_DIR"/*.json)
shopt -u nullglob

if [ ${#files[@]} -eq 0 ]; then
echo -e "\n${RED}No .json files found in $CONFIGS_DIR${NC}"
sleep 1
read -rp "Press Enter to return to main menu..."
return 1
fi

local display_names=()
for f in "${files[@]}"; do
display_names+=("$(basename "$f")")
done

echo -e "\n${BLUE}----------------------------------------${NC}"
echo -e "\nConfiguration files found:"
echo -e "\n${BLUE}----------------------------------------${NC}"


PS3="Select the file number (1-${#files[@]}): "
select short_name in "${display_names[@]}"; do
if [ -n "$short_name" ]; then
file="${files[$((REPLY-1))]}"
echo -e "\nSelected file: ${GREEN}${short_name}${NC}"
break
else
echo -e "\n${RED}Invalid selection, please try again.${NC}"
fi
done

mapfile -t PACKAGES < <(jq -r '
  def extract:
    if type == "string" and test("^[a-zA-Z][a-zA-Z0-9_]*(\\.[a-zA-Z][a-zA-Z0-9_]*)+$") then
      .
    elif type == "object" then
      (.packageName // .package // empty)
    elif type == "array" then
      .[] | extract
    else
      empty
    end;

  if .apps then .apps[] | extract
  elif .packages then .packages[] | extract
  elif type == "array" then .[] | extract
  else extract
  end
' "$file" 2>/dev/null | sort -u)

if [ ${#PACKAGES[@]} -eq 0 ]; then
echo -e "\n${RED}No packages found. Verify the JSON format.${NC}"
sleep 1
read -rp "Press Enter to return to main menu"
return 1
fi

echo -e "\n${BLUE}Fetching installed packages from device...${NC}"
local INSTALLED_PKGS
INSTALLED_PKGS=$($EXEC pm list packages -u 2>/dev/null | tr -d '\r' | cut -d: -f2)


echo -e "\n${BLUE}Starting debloating of ${#PACKAGES[@]} packages...${NC}"

local SUCCESS=0
local SKIPPED=0
local FAILED=0

for pkg in "${PACKAGES[@]}"; do
[ -z "$pkg" ] && continue
echo -n "Checking $pkg: "

if ! echo "$INSTALLED_PKGS" | grep -qx "$pkg"; then
echo -e "\n${YELLOW}Skipped (not installed)${NC}"
((SKIPPED++))
continue
fi

if $EXEC pm uninstall -k --user 0 "$pkg">/dev/null 2>&1; then
echo -e "\n${GREEN}Success (removed)${NC}"
((SUCCESS++))
else
echo -e "\n${RED}Failed${NC}"
((FAILED++))
fi
done

echo -e "\n${BLUE}----------------------------------------${NC}"
echo -e "Summary: ${GREEN}$SUCCESS removed${NC}, ${YELLOW}$SKIPPED skipped${NC}, ${RED}$FAILED failed${NC}."
echo -e "\n${BLUE}----------------------------------------${NC}"
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
echo -e "${CYAN}Backups targets reside in ./Configs/backup-restore/"
echo -e "${BLUE}---------------------------------------------${NC}"

init_logs_backup 2>/dev/null || true

ensure_adb || exit 1
ensure_jq || exit 1

echo -e "\n${BLUE}----------------------------------------${NC}"
check_adb || {
return 1
}
echo -e "\n${BLUE}----------------------------------------${NC}"

mkdir -p "$BACKUPS_DIR"
local output_file="$BACKUPS_DIR/backup_$(date +%Y%m%d_%H%M%S).json"

echo -e "\n${RED}--- Warning ---${NC}"
echo -e "\n${CYAN}You are about to create backup.*json in /Configs/backuo-restore.${NC}"
read -p "Are you sure you want to proceed? (y/N): " confirm

if [[ $confirm != "y" && $confirm != "Y" ]]; then
echo "\nOperation cancelled."
sleep 1
read -rp "Press Enter to return to main menu"
return 1
fi

echo -e "\n${BLUE}----------------------------------------${NC}"
echo -e "${CYAN}\n--- Generating snapshot: $output_file---${NC}"
echo -e "\n${BLUE}----------------------------------------${NC}"

$EXEC pm list packages -u 2>/dev/null \
| tr -d '\r' \
| sed 's/^package://' \
| jq -R 'select(test("^[a-zA-Z][a-zA-Z0-9_]*(\\.[a-zA-Z][a-zA-Z0-9_]*)+$"))' \
| jq -s --arg date "$(date +%Y%m%d)" '{
name: ("Uraam_Snapshot_Auto_" + $date),
description: "Automatic backup generated by URAAM",
author: "User",
version: "2.0",
apps: [.[] | {packageName: .}]
}' > "$output_file"

if [ ! -s "$output_file" ] || [ "$(jq '.apps | length' "$output_file" 2>/dev/null || echo 0)" -eq 0 ]; then
rm -f "$output_file"
echo -e "\n${RED}[!] Error:${NC} Unable to retrieve package list. Check ADB connection."
read -rp "Press Enter to return to main menu"
return 1
fi

echo -e "\n${GREEN}[✓] Backup list successfully generated in Configs/backup-restore!${NC}"
sleep 1
read -rp "Press Enter to return to main menu"
return 0
}

uraam_installer() {
clear
show_logo
echo -e "${BLUE}==========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | INSTALLER${NC}"
echo -e "${BLUE}==========================================${NC}"
echo -e "\n${CYAN}Place APKs to install in ./Apps/ before starting.${NC}"
echo -e "\n${BLUE}----------------------------------------${NC}"

ensure_adb || exit 1

check_adb || {
read -rp "Press Enter to return tomain menu..."
return 1
}

if [ ! -d "$APP_DIR" ]; then
echo -e "\n${RED}[ERROR]${NC}Directory $APP_DIR not found."
sleep 1
read -rp "Press Enter to return to main menu"
return 1
fi

shopt -s nullglob
local apks=("$APP_DIR"/*.apk)
shopt -u nullglob

if [ ${#apks[@]} -eq 0 ];then
echo -e "\n${RED}[ERROR]${NC} No APK files found in $APP_DIR."
sleep 1
read -rp "Press Enter to return to main menu"
return 1
fi

echo -e "\n${GREEN}[INFO]${NC} Deploying ${#apks[@]} package(s)..."

local ok=0
local fail=0
for apk in "${apks[@]}"; do
echo -n "Installing: $(basename "$apk") ... "
if $EXEC pminstall -r -g "$apk" >/dev/null 2>&1; then
echo -e"${GREEN}✓ Success${NC}"
((ok++))
else
echo -e "${RED}✗ Failed${NC}"
((fail++))
fi
done

echo -e "\n${BLUE}----------------------------------------${NC}"
echo -e "Summary: ${GREEN}$ok installed${NC}, ${RED}$fail failed${NC}."
echo -e "${BLUE}----------------------------------------${NC}\n"
sleep 1
read -rp "Press Enter to return to main menu"
return 0
}

uraam_restore() {
clear
show_logo
echo -e "${BLUE}=========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | RESTORER${NC}"
echo -e "${BLUE}=========================================${NC}"
echo -e "\n${CYAN}Restoration targets reside in ./Configs/backup-restore/${NC}"
echo -e "\n${BLUE}---------------------------------------${NC}"

init_logs_restore 2>/dev/null || true

ensure_adb || exit 1
ensure_jq || exit 1

echo -e "\n${BLUE}---------------------------------------${NC}"
check_adb || {
read -rp "Press Enter to return tomain menu..."
return 1
}
echo -e "\n${BLUE}---------------------------------------${NC}"

shopt -s nullglob
local files=("$BACKUPS_DIR"/*.json)
shopt -u nullglob

local display_names=()
for f in "${files[@]}"; do
display_names+=("$(basename "$f")")
done

echo -e "\n${BLUE}---------------------------------------${NC}"
echo -e "\nConfiguration files found:"
echo -e "\n${BLUE}---------------------------------------${NC}"

PS3="Select the file number (1-${#files[@]}): "
select short_name in "${display_names[@]}"; do
if [ -n "$short_name" ]; then
file="${files[$((REPLY-1))]}"
echo -e "\nSelected file: ${GREEN}${short_name}${NC}"
break
else
echo -e "\n${RED}Invalid selection, please try again.${NC}"
read -rp "Press Enter to return to main menu"
return 1
fi
done

mapfile -t PACKAGES < <(jq -r '
  def extract:
    if type == "string" and test("^[a-zA-Z][a-zA-Z0-9_]*(\\.[a-zA-Z][a-zA-Z0-9_]*)+$") then
      .
    elif type == "object" then
      (.packageName // .package // empty)
    elif type == "array" then
      .[] | extract
    else
      empty
    end;

  if .apps then .apps[] | extract
  elif .packages then .packages[] | extract
  elif type == "array" then .[] | extract
  else extract
  end
' "$file" 2>/dev/null | sort -u)

if [ ${#PACKAGES[@]} -eq 0 ]; then
echo -e "\n${RED}No packages found. Verify the JSON format.${NC}"
sleep 1
read -rp "Press Enter to return to main menu"
return 1
fi

echo -e "\n${BLUE}Starting restoration of ${#PACKAGES[@]} packages...${NC}"

local SUCCESS=0
local FAILED=0

for pkg in "${PACKAGES[@]}"; do
[ -z "$pkg" ] && continue
echo -n "Restoring $pkg: "

if $EXEC pm install-existing --user 0 "$pkg" >/dev/null 2>&1; then
echo -e "\n${GREEN}Success${NC}"
((SUCCESS++))
else
echo -e "\n${RED}Failed (already present or not found)${NC}"
((FAILED++))
fi
done

echo -e "\n${BLUE}----------------------------------------${NC}"
echo -e "\nSummary: ${GREEN}$SUCCESS restored${NC}, ${RED}$FAILED failed/skipped${NC}."
echo -e "\n${BLUE}----------------------------------------${NC}"
sleep 1
read -rp "Press Enter to return to main menu"
return 0
}

view_dlogs() {
clear
if compgen -G "$LOGD_DIR/*.log" >/dev/null; then
if command -v less >/dev/null 2>&1; then
echo -e "${GREEN}[*] Viewing logs (Press 'q' to quit, ':n' for next file)...${NC}"
sleep 1
less -R "$LOGD_DIR"/*.log
elif command -v nano >/dev/null 2>&1; then
echo-e "${YELLOW}[!] 'less' not found. Opening with nano in view-mode...${NC}"
sleep 1
nano -v "$LOGD_DIR"/*.log
else
echo -e "\n${YELLOW}[!] Displaying raw logs:${NC}\n"
cat "$LOGD_DIR"/*.log
echo -e "\n${CYAN}Press [Enter] to return to the menu...${NC}"
read -r
fi
else
echo -e "\n${RED}[X] No log files found in $LOGD_DIR${NC}"
sleep 2
fi
}

view_blogs() {
clear
if compgen -G "$LOGB_DIR/*.log" >/dev/null; then
if command -v less >/dev/null 2>&1; then
echo -e "${GREEN}[*] Viewing logs (Press 'q' to quit, ':n' for next file)...${NC}"
sleep 1
less -R "$LOGB_DIR"/*.log
elif command -v nano >/dev/null 2>&1; then
echo -e "${YELLOW}[!] 'less' not found. Opening with nano in view-mode...${NC}"
sleep1
nano -v "$LOGB_DIR"/*.log
else
echo -e "\n${YELLOW}[!] Displaying raw logs:${NC}\n"
cat "$LOGB_DIR"/*.log
echo -e "\nPress [Enter] to return to the menu..."
read -r
fi
else
echo -e "\n${RED}[X] No log files found in $LOGB_DIR${NC}"
sleep 2
fi
}

view_rlogs() {
clear
if compgen -G "$LOGR_DIR/*.log" >/dev/null; then
if command -v less >/dev/null 2>&1; then
echo -e "${GREEN}[*] Viewing logs (Press 'q' to quit, ':n' for next file)...${NC}"
sleep 1
less -R "$LOGR_DIR"/*.log
elif command -v nano >/dev/null 2>&1; then
echo -e "${YELLOW}[!] 'less' not found. Opening with nano in view-mode...${NC}"
sleep1
nano -v "$LOGR_DIR"/*.log
else
echo -e "\n${YELLOW}[!] Displaying raw logs:${NC}\n"
cat "$LOGR_DIR"/*.log
echo -e "\nPress [Enter] to return to the menu... "
read -r
fi
else
echo -e "\n${RED}[X] No log files found in $LOGR_DIR${NC}"
sleep 2
fi
}

vl_menu() {
clear
show_logo
echo -e "${BLUE}==========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | VIEW LOGS${NC}"
echo -e "${BLUE}==========================================${NC}"

echo -e "\n [1] View Debloat Logs"
echo -e " [2] View Restore Logs"
echo -e " [3] View Backup Logs"
echo -e " [4] Return to Dashboard"
echo -e " [5] Exit\n"
read -rp "Enter choice: " choice
case "$choice" in

1) view_dlogs;;
2) view_rlogs ;;
3) view_blogs ;;
4) return 0 ;;
5)
echo -e "\nGoodbye!"
clear
exit 0
;;
*)
echo -e "\nInvalide option, please try again."
sleep 1
;;
esac
}

update_uraam() {
echo -e "${BLUE}========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | UPDATER${NC}"
echo -e "${BLUE}========================================${NC}"
printf "${CYAN}[*] Updating existing installation...${NC}\n"
git fetch --all --prune >/dev/null 2>&1

if git reset --hard "origin/$BRANCH">/dev/null 2>&1; then
printf "${GREEN}[✓] Core repository updated successfully.${NC}\n"
else
printf "${RED}[X] Git reset failed. Check repository branch status.${NC}\n"
exit1
fi

if [ -f "$INSTALL_DIR/uraam.sh" ]; then
chmod +x "$INSTALL_DIR/uraam.sh"
find "$INSTALL_DIR" -type f -name "*.sh" -exec chmod +x {} +
sleep 1 
read -rp "press Enter to restarting URAAM with new changes..." 
rm -rf "$INSTALL_DIR/assets" "$INSTALL_DIR/installer.sh"
exec "$0" "$@"
else
printf "${RED}[X] Critical error: uraam.sh was not found in ${INSTALL_DIR}.${NC}\n"
sleep 1
read -rp "Press Enter to return to main menu"
clear
return 0
fi
}

check_device() {
local brand model android_ver
brand=$(adb shell getprop ro.product.manufacturer2>/dev/null | tr -d '\r')
model=$(adb shell getprop ro.product.model 2>/dev/null | tr -d '\r')
android_ver=$(adb shell getprop ro.build.version.release 2>/dev/null | tr -d '\r')

brand="${brand:-Unknown}"
model="${model:-Unknown}"
android_ver="${android_ver:-Unknown}"

if [[ "$model" == "Unknown" && "$brand" == "Unknown" ]]; then
CURRENT_MODEL="UnknownDevice"
else
CURRENT_MODEL="${brand^} ${model} (Android ${android_ver})"
fi
}

if [ -d "/data/data/com.termux" ] && command -v termux-setup-storage >/dev/null 2>&1; then
echo -e "\n${CYAN}[*] Requesting storage access (please confirm the popup)...${NC}"
termux-setup-storage
fi

while true; do
clear
show_logo
echo -e "${BLUE}==========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | DASHBOARD${NC}"
echo -e "${BLUE}==========================================${NC}"
echo -e "${CYAN}Folder layout instructions before starting:${NC}"
echo -e "${CYAN}\nPlace debloat configurations in ./Configs/debloat/ (Canta JSON supported).${NC}"
echo -e "${CYAN}\nPlace APKs to install in ./Apps/.${NC}"
echo -e "${CYAN}\nBackups and restoration targets reside in ./Configs/backup-restore/${NC}"
echo -e "${BLUE}==========================================${NC}"
check_device
ensure_adb || exit 1
ensure_jq || exit 1
check_adb
echo -e "${BLUE}==========================================${NC}"

echo -e "\n ${CYAN}[d]${NC} Debloat ${YELLOW}(Remove Bloatware)${NC}"
echo -e " ${CYAN}[i]${NC} Install ${YELLOW}(Batch APK Install)${NC}"
echo -e " ${CYAN}[b]${NC} Backup ${YELLOW}(Export Apps List)${NC}"
echo -e " ${CYAN}[r]${NC} Restore ${YELLOW}(Revert/Reinstall Apps)${NC}"
echo -e " ${CYAN}[w]${NC} Wireless ADB Setup ${YELLOW}(Pair & Connect)${NC}"
echo -e " ${CYAN}[u]${NC} Update Uraam ${YELLOW}(Search/install update from repo)${NC}"
echo -e " ${CYAN}[v]${NC} View Logs ${YELLOW}(Open & read logs)${NC}"
echo -e " ${RED}[e]${NC} Exit\n"

read -rp "Enter choice: " choice
case "$choice" in

d) uraam_debloat ;;
i) uraam_installer ;;
b) uraam_backup ;;
r) uraam_restore ;;
w) wireless_adb ;;
u) update_uraam ;;
v) vl_menu ;;
e)
echo -e "${CYAN}Goodbye!${NC}"
clear
exit 0
;;
*)
echo -e "${RED}Invalide option, please try again.${NC}"
sleep 1
;;
esac
done
