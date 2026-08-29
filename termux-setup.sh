#!/data/data/com.termux/files/usr/bin/bash

# --- Ruvomain Protocol - Termux Setup Script ---

echo "[*] Initializing environment..."

# 1. Installing dependencies
echo "[*] Installing required tools (android-tools)..."
pkg update -y

if ! command -v adb &> /dev/null; then
echo "[!] ADB not found, installing..."
pkg install android-tools -y
fi

if ! command -v jq &> /dev/null; then
echo "[!] ADB not found, installing..."
pkg install jq -y
fi

# 2. Granting storage access
echo "[*] Requesting storage access (please confirm thepopup)..."
termux-setup-storage

# 3. Guidance for Wireless Debugging
echo "--------------------------------------------------------"
echo "CRITICAL STEP: Wireless Debugging"
echo "1. Go to Settings > Developer Options."
echo "2.Tap on 'Wireless debugging' (the text itself)."
echo "3. Select 'Pair device with pairing code'."
echo "--------------------------------------------------------"

# 4. Interactive Pairing and Connection
read -p "[?] Enter IP addressand port for PAIRING (e.g., 192.168.1.5:41234): " pair_target
adb pair $pair_target

echo "[*] Now, use the connection port displayed in the Wireless debugging menu."
read -p "[?] Enter IP address and port for CONNECTION (e.g., 192.168.1.5:33456): " connect_target
adb connect $connect_target

#5. Status check
if adb devices | grep -q "device$"; then
echo "[+] SUCCESS: Device connected successfully."
echo "[+] Ruvomain-Protocol environment is ready."
else
echo "[!] ERROR: Connection failed. Please check your IP/Port and try again."
fi
