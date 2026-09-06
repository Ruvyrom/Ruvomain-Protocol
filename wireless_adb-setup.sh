#!/usr/bin/env bash

# --- Ruvomain Protocol - Termux Setup Script ---
# version: v3.0.0

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
SOURCES_DIR="$REPO_DIR/lib/sources.sh"

if [ -f "$SOURCES_DIR" ]; then
chmod +x "$SOURCES_DIR"
source "$SOURCES_DIR"
sources
else
echo "Error: Could not find $SOURCES_DIR"
exit 1
fi

#Granting storage access
echo "[*] Requesting storage access (please confirm the popup)..."
if [ -d "/data/data/com.termux" ] && command -v termux-setup-storage >/dev/null 2>&1; then
termux-setup-storage
fi

#Guidance for Wireless Debugging
echo "--------------------------------------------------------"
echo "CRITICAL STEP: Wireless Debugging"
echo "1. Go to Settings > Developer Options."
echo "2. Tap on 'Wireless debugging' (the text itself)."
echo "3. Select 'Pair device with pairing code'."
echo "--------------------------------------------------------"

#Interactive Pairing and Connection
read -p "[?] Enter IP address and port for PAIRING (e.g., 192.168.1.5:41234): " pair_target
adb pair $pair_target

echo "[*] Now, use the connection port displayed in the Wireless debugging menu."
read -p "[?] Enter IP address and port for CONNECTION (e.g., 192.168.1.5:33456): " connect_target
adb connect $connect_target

#Status check
if adb devices | grep -E -q "[[:space:]]+device$"; then
echo "[+] SUCCESS: Device connected successfully."
echo "[+] Ruvomain-Protocol environment is ready."
else
echo "[!] ERROR: Connection failed. Please check your IP/Port and try again."
fi
