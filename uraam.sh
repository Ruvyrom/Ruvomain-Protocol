#!/usr/bin/env bash
#
# URAAM - Universal Ruvomain ADB App-Manager v4.2.0
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

if [[ "$REPO_DIR" == /usr/* ]]; then
USER_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/uraam"
USER_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/uraam"
else
USER_DATA_DIR="$REPO_DIR"
USER_CONFIG_DIR="$REPO_DIR/Configs"
fi

APP_DIR="$REPO_DIR/Apps"
CONFIGS_DIR="$REPO_DIR/Configs/debloat"
BACKUPS_DIR="$USER_DATA_DIR/Configs/backup-restore"
LOGB_DIR="$REPO_DIR/logs/backup"
LOGD_DIR="$REPO_DIR/logs/debloat"
LOGR_DIR="$REPO_DIR/logs/restore"
USER_DEBLOAT_DIR="$USER_CONFIG_DIR/debloat"
USER_BACKUPS_DIR="$USER_DATA_DIR/Configs/backup-restore"
LOGD_DIR="$USER_DATA_DIR/Logs/debloat"
LOGB_DIR="$USER_DATA_DIR/Logs/backup"
LOGR_DIR="$USER_DATA_DIR/Logs/restore"

mkdir -p "$USER_DEBLOAT_DIR" "$BACKUPS_DIR" "$LOGD_DIR" "$LOGB_DIR" "$LOGR_DIR"

REPO_URL="https://github.com/Ruvyrom/Uraam"
BRANCH="main"

if [ -z "$INSTALL_DIR" ]; then
INSTALL_DIR="$HOME/Uraam"
fi

BLUE='\033[0;34m'
BOLD='\033[1m'
CYAN='\033[0;36m'
PURPLE='\e[0;35m'
GREEN='\033[0;32m'
RED='\033[1;31m'
WHITE='\033[0;37m'
YELLOW='\033[0;33m'
NC='\033[0m'

show_logo() {
clear
echo -e "${PURPLE}"
cat << 'EOF'
::| ::|::::::\ ::::\  ::::\ ::::::|
::|_::|::|,::|::|,::|::|,::|:::"::|
`:::::|::| ::\::| ::|::| ::|::| ::|
EOF
echo -e "${NC}"
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
printf "%b\n" "${GREEN}[+] Attempting automatic installation...${NC}"

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
printf "%b\n" "${RED}[!] Package manager not supported. Please install JQ manually.${NC}" >&2
read -rp "Press [Enter] to return to main menu..."
return 1
fi
;;
*)
printf "%b\n" "${YELLOW}[-] Installation cancelled. JQ is required for the project to work properly.${NC}"
return 1
;;
esac
}

device_brand() {
devices=$(adb devices | grep -v "List of devices" | grep "device$" || true)
brand=$("$EXEC" getprop ro.product.manufacturer 2>/dev/null || echo "Unknown manufacturer")
model=$("$EXEC" getprop ro.product.model 2>/dev/null || echo "Unknown model")
android_ver=$("$EXEC" getprop ro.build.version.release 2>/dev/null || 2>/dev/null)
tbrand=$(getprop ro.product.manufacturer 2>/dev/null || echo "Unknown manufacturer")
tmodel=$(getprop ro.product.model 2>/dev/null || echo "Unknown model")
tandroid_ver=$(getprop ro.build.version.release 2>/dev/null || 2>/dev/null)

CURRENT_MODEL="${brand^} ${model} (Android ${android_ver})"
CURRENT_TMODEL="${tbrand^} ${tmodel} (Android ${tandroid_ver})"
}


detect_execution_backend() {
EXEC=""
EXEC_TYPE=""
device_brand

printf "%b\n" "${CYAN}[*] Detecting execution backend...${NC}"

if [ "$(id -u)" -eq 0 ] || command -v su >/dev/null 2>&1 && su -c "id" >/dev/null 2>&1; then
EXEC="su -c"
EXEC_TYPE="ROOT"
ensure_jq || exit 1
printf "%b\n" "$CURRENTT_MODEL" 
printf "%b\n" "$CURRENT_MODEL"
printf "%b\n" "${GREEN}[✓]Execution backend: ROOT (su)${NC}"
return 0
fi

if command -v rish >/dev/null 2>&1 && echo "exit" | rish >/dev/null 2>&1; then
EXEC="rish -c"
EXEC_TYPE="SHIZUKU"
ensure_jq || exit 1
printf "%b\n" "$CURRENTT_MODEL" 
printf "%b\n" "$CURRENT_MODEL"
printf "%b\n" "${GREEN}[✓] Execution backend: SHIZUKU (Rish)${NC}"
return 0
fi

if command -v adb >/dev/null 2>&1; then
local connected
connected=$(adb devices 2>/dev/null | grep -v "List of devices" | grep "device$" | head -n 1)
if [ -n "$connected" ]; then
EXEC="adb shell"
EXEC_TYPE="ADB"
ensure_adb || exit 1
ensure_jq || exit 1
printf "%b\n" "$CURRENTT_MODEL" 
printf "%b\n" "$CURRENT_MODEL"
printf "%b\n" "${GREEN}[✓] Execution backend: ADB(Connected)${NC}\n"
return 0
fi
fi

printf "%b\n" "${PURPLE}[HOST]${NC} $CURRENT_TMODEL"
printf "%b\n" "${RED}[ERROR]${NC} No device or execution method detected."
printf "%b\n" "${YELLOW}[!] Make sure:${NC}"
printf "%b\n" "  1. USB Debugging or Wireless Debugging is enabled."
printf "%b\n" "  2. You authorized this device in the popup prompt."
printf "%b\n" "  3. If on Termux, use 'Wireless ADB setup' in Dashboard or configure Shizuku (rish)."
printf "%b\n" "${BLUE}--------------------------------------------------------${NC}"
printf "%b\n" "Press [Enter] to continue..." 
read -rp ""
return 1
}

check_adb() {
local brand model android_ver tbrand tmodel tandroid_ver devices
device_brand

if [ -z "$devices" ]; then
printf "%b\n" "${PURPLE}[HOST]${NC} $CURRENT_TMODEL"
printf "%b\n" "${RED}[ERROR]${NC}No device detected via ADB."
printf "%b\n" "${YELLOW}[!] Make sure:${NC}"
printf "%b\n" "1. USB Debugging or Wireless Debugging is enabled."
printf "%b\n" "  2. You authorized this device in the popup prompt."
printf "%b\n" "  3. If on Termux, use 'Wireless ADB setup' in Dashboard or Shizuku."
read -rp "Press [Enter] to return to main menu..."
return 1
fi
return 0

printf "%b\n" "${RED}[ERROR] No execution environment detected!${NC}"
printf "%b\n" "${YELLOW}[!] Make sure one of the following is active:${NC}"
printf "%b\n" "• Root access granted to Termux"
printf "%b\n" "  • Shizuku running with 'rish' configured"
printf "%b\n" "  • ADB connected ('adb devices')\n"
printf "%b\n" "${BLUE}--------------------------------------------------------${NC}"
printf "%b\n" "Press [Enter] to return..."
read -rp ""
return 1
}

check_adb_menu() {
local brand model android_ver tbrand tmodel tandroid_ver
device_brand

if ! command -v adb &> /dev/null; then
echo -e "${PURPLE}[HOST]${NC} $CURRENT_TMODEL"
echo -e "${RED}[ERROR]${NC} ADB is not installed or not found in PATH."
return 1
fi

if ! adb devices | grep -q "device$"; then
echo -e "${PURPLE}[Host]${NC} $CURRENT_TMODEL"
echo -e "${RED}[ERROR]${NC} No device detected via ADB."
else
echo -e "${PURPLE}[Host]${NC} $CURRENT_TMODEL"
printf "%b\n" "${PURPLE}[Target]${NC} $CURRENT_MODEL"
return 1
fi
return 0
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

wireless_adb(){
show_logo
printf "%b\n" "${BLUE}===================================================${NC}"
printf "%b\n" "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | WIRELESS ADB SETUP${NC}"
printf "%b\n" "${BLUE}===================================================${NC}"
printf "%b\n" ""
ensure_adb
printf "%b\n" "\n${BLUE}--------------------------------------------------------${NC}"
printf "%b\n" "\n${CYAN}CRITICAL STEP: Wireless Debugging.${NC}"
printf "%b\n" "\n${CYAN}1. Go to Settings > Developer Options.${NC}"
printf "%b\n" "\n${CYAN}2. Tap on 'Wireless debugging' (the text itself).${NC}"
printf "%b\n" "\n${CYAN}3. Select 'Pair device with pairing code'.${NC}"
printf "%b\n" "\n${BLUE}--------------------------------------------------------${NC}"
printf "%b\n" ""

printf "%b\n" "Do you need to PAIR first (y/N)" 
read -rp " " need_pair

case "$need_pair" in
y|Y)
printf "%b\n" "\n--- STEP 1: PAIRING ---"
printf "%b\n" "\n${CYAN}Check the pairing popup dialog${NC}"
printf "%b\n" "${CYAN}for IP:Port and the 6-digit code.${NC}"
read -rp "Enter PAIRING host:port or just PORT: " pair_input
if [[ "$pair_input" =~ ^[0-9]+$ ]]; then
pair_host="127.0.0.1:$pair_input"
else
pair_host="$pair_input"
fi

read -rp "Enter 6-digit PAIRING CODE: " pair_code

if [ "$need_pair" = "y" ] || [ "$need_pair" = "Y" ]; then
if [ -z "$pair_host" ] || [ -z "$pair_code" ]; then
printf "%b\n" "\n[!] Pairing aborted: host or code cannot be empty."
printf "%b\n" "\n${BLUE}--------------------------------------------------------${NC}"
printf "%b\n" "Press Enter to return to main menu..."
read -rp ""
return 1
fi
adb pair "$pair_host" "$pair_code"
else
printf "%b\n" "\n${RED}[!] Pairing aborted: host or code cannot be empty.${NC}"
fi
;;
esac

printf "%b\n" "\n--- STEP 2: CONNECTION ---"
printf "%b\n" "\n${CYAN}Look at the main Wireless Debugging screen${NC}" 
printf "%b\n" "${CYAN}for the CONNECTION port.${NC}"

read -rp "Enter CONNECTION host:port or just PORT: " conn_host
if [[ "$conn_input" =~ ^[0-9]+$ ]]; then
conn_host="127.0.0.1:$conn_input"
else
conn_host="$pair_input"
fi

if [ -n "$conn_host" ]; then
printf "%b\n" "\n[*] Connecting to $conn_host..."
adb connect "$conn_host"

sleep 1
if adb devices | grep -q "$conn_host.*device"; then
printf "%b\n" "\n${GREEN}[✓] Successfully connected via Wireless ADB!${NC}"
else
printf "%b\n" "\n${RED}[!] Connection failed.${NC}"
printf "%b\n" "Check IP/Port and make sure screen is on."
fi
else
echo -e "\n${RED}[!] Connection aborted: host empty.${NC}"
fi

printf "%b\n" "\n${BLUE}--------------------------------------------------------${NC}"
printf "%b\n" "Press Enter to return to main menu..."
read -rp ""
return 1
}

uraam_debloat() {
show_logo
echo -e "${BLUE}==========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | DEBLOATER${NC}"
echo -e "${BLUE}==========================================${NC}"
echo -e "\n${CYAN}Place debloat configurations in ./Configs/debloat/${NC}"
echo -e "${CYAN}(Canta JSON, UAD lists & raw packages supported).${NC}"
echo -e "${BLUE}------------------------------------------${NC}"

detect_execution_backend || return 1

printf "%b\n" "[*] Fetching installed packages..."
local installed_packages
installed_packages=$($EXEC pm list packages 2>/dev/null | sed 's/^package://' | tr -d '\r')

if [ -z "$installed_packages" ]; then
printf "%b\n" "${RED}[ERROR] Failed to fetch packages from device.${NC}"
read -rp "Press [Enter] to return..."
return 1
fi

local files=()

shopt -s nullglob
files+=("$CONFIGS_DIR"/*.json)
if [ "$USER_DEBLOAT_DIR" != "$CONFIGS_DIR" ]; then
files+=("$USER_DEBLOAT_DIR"/*.json)
fi
shopt -u nullglob

if [ "$USER_DEBLOAT_DIR" != "$CONFIGS_DIR" ]; then
for f in "$USER_DEBLOAT_DIR"/*.json; do
[ -e "$f" ] && files+=("$f")
done
fi

if [ ${#files[@]} -eq 0 ]; then
echo -e "\n${RED}No .json files found in $CONFIGS_DIR${NC}"
read -rp "Press Enter to return to main menu..."
return 1
fi

printf "%b\n" "${CYAN}--------------------------------------------${NC}"
printf "%b\n" "Configuration files found:"
printf "%b\n" "${CYAN}--------------------------------------------${NC}"

local display_names=()
for f in "${files[@]}"; do
display_names+=("$(basename "$f")")
done

PS3="Select the file number (1-${#files[@]}): "
select short_name in "${display_names[@]}"; do
if [ -n "$short_name" ]; then
file="${files[$((REPLY-1))]}"
printf "%b\n" "${CYAN}--------------------------------------------${NC}"
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

printf "\n%b" "${YELLOW}[?] You are about to debloat your device... do you want continue? [y/N]: ${NC}"
read -r confirm
if [[ ! "$confirm" =~ ^[yY]$ ]]; then
printf "%b\n" "Update canceled."
return 0
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

ubackup() {
local output_dir="$BACKUPS_DIR"
mkdir -p "output_dir"
local date_str
date_str="$(date +%Y%m%d_%H%M%S)"
local output_file="$output_dir/Uraam_Restoration_List_${date_str}.json"

echo -e "\n${BLUE}----------------------------------------${NC}"
echo -e "${CYAN}\n--- Generating snapshot: $output_file---${NC}"
echo -e "\n${BLUE}----------------------------------------${NC}"

local all_pkgs
all_pkgs=$(eval "$EXEC \"pm list packages -u --user 0\"" 2>/dev/null | tr-d '\r' | sed 's/^package://' | sort)

local active_pkgs
active_pkgs=$(eval "$EXEC \"pm list packages --user 0\"" 2>/dev/null | tr -d '\r' | sed 's/^package://' | sort)


if [ -z "$all_pkgs" ]; then
printf "\n%b\n" "${RED}[!] Error:${NC} Unableto communicate with package manager."
read -rp "Press [Enter] to return to main menu"
return 1
fi

comm -23 <(echo "$all_pkgs") <(echo "$active_pkgs") \
| jq -R -s --arg date "$date_str" '
[ split("\n")[] | select(test("^[a-zA-Z][a-zA-Z0-9_]*(\\.[a-zA-Z][a-zA-Z0-9_]*)+$")) | {packageName: .} ] as $apps
| {
name: ("Uraam_Restore_List_" + $date),
description: "List of debloated packages pending restoration",
author: "URAAM",
version: "4.2.0",
apps: $apps
}' > "$output_file"

local count
count=$(jq '.apps | length' "$output_file" 2>/dev/null || echo 0)

if [ "$count" -eq 0 ]; then
rm -f"$output_file"
printf "\n%b\n" "${YELLOW}[i] No debloatedpackages found on this device.${NC}"
printf "%b\n" "All system packages are currently installed."
read -rp "Press [Enter] to return to main menu"
return 0
fi

printf "\n%b\n" "${GREEN}[✓] Successfully identified ${count} debloated packages!${NC}"
printf "%b\n" "${BLUE}[i] Restoration file saved to: ${output_file}${NC}"
read -rp "Press[Enter] to return to main menu"
return 0
}

ruvomain_backup() {
show_logo
echo -e "${BLUE}===============================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | BACKUP CREATOR${NC}"
echo -e "${BLUE}===============================================${NC}"
echo -e "${CYAN}Backups targets reside in ./Configs/backup-restore/"
echo -e "${BLUE}-----------------------------------------------${NC}"

detect_execution_backend || return 1

echo -e "\n${RED}--- Warning ---${NC}"
echo -e "\n${CYAN}You are about to create backup.*json in /Configs/backuo-restore.${NC}"
read -p "Are you sure you want to proceed? (y/N): " confirm

if [[ ! "$confirm" =~ ^[yY]$ ]]; then
echo "\nOperation cancelled."
sleep 1
read -rp "Press Enter to return to main menu"
return 1
else
ubackup
fi
}

uraam_installer() {
clear
show_logo
echo -e "${BLUE}==========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | INSTALLER${NC}"
echo -e "${BLUE}==========================================${NC}"
echo -e "\n${CYAN}Place APKs to install in ./Apps/ before starting.${NC}"
echo -e "\n${BLUE}----------------------------------------${NC}"

detect_execution_backend || return 1

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
show_logo
echo -e "${BLUE}=========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | RESTORER${NC}"
echo -e "${BLUE}=========================================${NC}"
echo -e "\n${CYAN}Restoration targets reside in ./Configs/backup-restore/${NC}"
echo -e "\n${BLUE}---------------------------------------${NC}"

detect_execution_backend || return 1

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
show_logo
echo -e "${BLUE}========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | UPDATER${NC}"
echo -e "${BLUE}========================================${NC}"
printf "\n%b" "${YELLOW}[?] You are about to update URAAM. Do you want to download and install it? [y/N]: ${NC}"
read -r confirm
if [[ ! "$confirm" =~ ^[yY]$ ]]; then
printf "%b\n" "Update canceled."
return 0
fi
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
read -rp "press Enter to restart URAAM with new changes..." 
rm -rf "$INSTALL_DIR/assets" "$INSTALL_DIR/installer.sh"
clear
exec "$0" "$@"
else
printf "${RED}[X] Critical error: uraam.sh was not found in ${INSTALL_DIR}.${NC}\n"
sleep 1
read -rp "Press Enter to return to main menu"
return 0
fi
}

is_installed_via_deb() {
if [ -n "$PREFIX" ] && [[ "$PREFIX" == *com.termux* ]]; then
return 1
fi

if command -v dpkg-query >/dev/null 2>&1; then
local pkg_status
pkg_status=$(dpkg-query -W -f='${Status}' uraam 2>/dev/null)
if [[ "$pkg_status" == *"install ok installed"* ]]; then
return 0
fi
fi

return 1
}

check_and_update() {
if ! is_installed_via_deb; then
update_uraam
return $?
fi

printf "%b\n" "${CYAN}[*] Debian .deb installation detected.${NC}"
printf "%b\n" "${CYAN}[*] Checking for updates on GitHub...${NC}"

local release_json
release_json=$(curl -s "$REPO_URL/releases/latest")

local latest_tag
latest_tag=$(echo "$release_json" | jq -r '.tag_name // empty' | tr -d '\r')

if [ -z "$latest_tag" ]; then
printf "%b\n" "${RED}[!] Error: Unable to fetch release info from GitHub.${NC}"
return 1
fi

local remote_ver="${latest_tag#v}"

local local_ver
local_ver=$(dpkg-query -W -f='${Version}' uraam 2>/dev/null | tr -d '\r')
local_ver="${local_ver#v}"

printf "%b\n" "Current version :${BLUE}${local_ver}${NC}"
printf "%b\n" "Latest version  : ${GREEN}${remote_ver}${NC}"

if [ "$local_ver" = "$remote_ver" ]; then
printf "\n%b\n" "${GREEN}[✓] URAAM is already up to date!${NC}"
read -rp "Press [Enter] to return to menu..."
return 0
fi

local deb_url
deb_url=$(echo "$release_json" | jq -r '.assets[] | select(.name | endswith(".deb")) | .browser_download_url' | head -n1)

if [ -z "$deb_url" ] ||[ "$deb_url" = "null" ]; then
printf "\n%b\n" "${RED}[!] New version found (${latest_tag}),but no .deb asset is available.${NC}"
read -rp "Press [Enter] to return to menu..."
return 1
fi

printf "\n%b" "${YELLOW}[?] A new update is available. Do you want to download and install it? [y/N]: ${NC}"
read -r confirm
if [[ ! "$confirm" =~ ^[yY]$ ]]; then
printf "%b\n" "Update canceled."
return 0
fi

local tmp_deb="/tmp/uraam_update.deb"

printf "\n%b\n" "${CYAN}[*] Downloading: ${deb_url}${NC}"
if ! curl -L --progress-bar -o "$tmp_deb" "$deb_url"; then
printf "%b\n" "${RED}[!] Download failed.${NC}"
rm -f "$tmp_deb"
return 1
fi

printf "\n%b\n" "${CYAN}[*] Installing package (sudo required)...${NC}"
if sudo dpkg -i "$tmp_deb"; then
sudo apt-get install -f -y >/dev/null 2>&1
rm -f "$tmp_deb"
printf "\n%b\n" "${GREEN}[✓] URAAM successfully updated to ${latest_tag}!${NC}"
printf "%b\n" "${YELLOW}[!] Please restart URAAM to apply changes.${NC}"
exit0
else
printf "\n%b\n" "${RED}[!] Installation failed.${NC}"
rm -f "$tmp_deb"
return 1
fi
}

if [ -d "/data/data/com.termux" ] && command -v termux-setup-storage >/dev/null 2>&1; then
if [ ! -d "$HOME/storage/shared" ]; then
echo -e "\n${CYAN}[*] Requesting storage access (please confirm the popup)...${NC}"
termux-setup-storage
sleep 1
fi
fi

while true; do
show_logo
echo -e "${BLUE}==========================================${NC}"
echo -e "${CYAN}URAAM RUVOMAIN ADB APP-MANAGER | DASHBOARD${NC}"
echo -e "${BLUE}==========================================${NC}"
echo -e "${CYAN}Folder layout instructions before starting:${NC}"
echo -e "${CYAN}\nPlace debloat configurations in ./Configs/debloat/ (Canta JSON supported).${NC}"
echo -e "${CYAN}\nPlace APKs to install in ./Apps/.${NC}"
echo -e "${CYAN}\nBackups and restoration targets reside in ./Configs/backup-restore/${NC}"
echo -e "${BLUE}==========================================${NC}"
ensure_adb || exit 1
ensure_jq || exit 1
check_adb_menu
echo -e "${BLUE}==========================================${NC}"

echo -e "\n ${CYAN}[d]${NC} Debloat ${YELLOW}(Remove Bloatware)${NC}"
echo -e " ${CYAN}[i]${NC} Install ${YELLOW}(Batch APK Install)${NC}"
echo -e " ${CYAN}[b]${NC} Backup ${YELLOW}(Export Apps List)${NC}"
echo -e " ${CYAN}[r]${NC} Restore ${YELLOW}(Revert/Reinstall Apps)${NC}"
echo -e " ${CYAN}[w]${NC} Wireless ADB Setup ${YELLOW}(Pair & Connect)${NC}"
echo -e " ${CYAN}[u]${NC} Update Uraam ${YELLOW}(Search/install update from repo)${NC}"
echo -e " ${CYAN}[v]${NC} View Logs ${YELLOW}(Open & read logs)${NC}"
echo -e " ${RED}[e]${NC} Exit\n"

printf "%b\n" "${BLUE}--------------------------------------------${NC}"
printf "%b\n" "Enter your choice:"

read -rp "" choice
case "$choice" in

d) uraam_debloat ;;
i) uraam_installer ;;
b) uraam_backup ;;
r) uraam_restore ;;
w) wireless_adb ;;
u) check_and_update ;;
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
