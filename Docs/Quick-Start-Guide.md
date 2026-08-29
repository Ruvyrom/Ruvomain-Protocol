## ⚙️ Quick Start
**Disconnect Samsung account before using tier 2 and 3 in script and for more privacy.**

### Universal Ruvomain ADB Apps-Manager (URAAM)

**1. Enable USB Debugging on your phone:**
>
>>Settings > About Phone > Tap "Build Number" 7 times
>
>>Settings > Developer Options > Enable "USB Debugging"
>
>>Connect your phone to your PC via USB

or

**2. Use Wireless Debuging:**

- On your phone:
>>Settings > About Phone > Tap "Build Number" 7 times
>
>>Settings > Developer Options > Enable "Wireless Debugging"
>
>>Click the text "Wireless debugging" (not the button) to open the menu
>
>>Click on "Pair device with a QR code" or "Pair with a pairing code"
>
>>Note down the IP address, the port, and the pairing code.

- On your PC in your terminal:
>
>>Use `adb pair` and `adb connect` in your terminal to link your ADB client to the system server.
>
>>**Pair the terminal (it will ask you for the code).**
>
```bash
adb pair <IP>:<PORT>
```
>>**Connect the terminal**
>
```bash
adb connect <IP>:<PORT>
```

*Note:*
*- If adb connection fails, ensure your PC and Phone are on the same Wi-Fi network.*
*- If the pairing code is rejected, turn off Wireless Debugging and turn it back on to refresh the token.*

### 🐧 For Linux users:
1. **Prerequisites:**

- `git` for clone repo. 

- `adb` and `jq` (The script will attempt an android-tools/jq auto-installation if missing).

2. **Deployment:**
- **Clone the repo:**
```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git
```

- For Ruvomain-debloat, place your personal or Canta JSON lists in ./Configs
- For Ruvomain-installer, place your `APK` files in ./ruvomain-installer/Apps 
- For Ruvomain-restore, place your own backup .json file or Canta .json file list in ./ruvomain-backup/backups
- Ruvomain-backup places your backup .json file in /ruvomain-backup/backups

- **Navigate:**
```bash
cd ./Ruvomain-Protocole
```

- **Execute Universal ADB Apps-Manager (URAAM) dashboard:**
```bash
chmod +x dashboard.sh && ./dashboard.sh
```

### 📱 For Termux users (Wireless)

**1. Semi-Automatic setup execution** (Install adb, pair & connect):

**Setup:**
```bash
pkg install git
```
```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git
cd ./Ruvomain-Protocole
chmod +x termux-setup.sh && ./termux-setup.sh
```

- For Ruvomain-debloat, place your personal or Canta JSON lists in ./Configs
- For Ruvomain-installer, place your `APK` files in ./ruvomain-installer/Apps 
- For Ruvomain-restore, place your own backup .json file or Canta .json file list in ./ruvomain-backup/backups
- Ruvomain-backup places your backup .json file in /ruvomain-backup/backups

**Execute Universal ADB Apps-Manager (URAAM) dashboard:**
```bash
chmod +x dashboard.sh && ./dashboard.sh
```
***Note :** Make sure you run these commands from the directory where you cloned the repository. If you are in your Termux home folder, the command above is correct.*

*If `adb` fails, run `adb kill-server && adb start-server` and ensure your device appears in `adb devices`.*

No Root or Shizuku required. Your Ruvomain Protocol communicates directly via local ADB socket.

**2. Manual execution:**
**Grant Storage Access:**
```bash
termux-setup-storage
```
 (Accept the permission prompt)

**Deploy:**

- ```bash
  pkg install android-tools jq git -y
  ```
- Enable "Wireless Debugging" in Developer Options.

- Click the text "Wireless debugging" (not the button) to open the menu

- Click on "Pair device with a QR code" or "Pair with a pairing code"

- Note down the IP address, the port, and the pairing code.

- Use `adb pair` and `adb connect` within Termux to link your local ADB client to the system server.

>>**Pair the terminal (it will ask you for the code).**
>
```bash
adb pair <IP>:<PORT>
```
>>**Connect the terminal**
>
```bash
adb connect <IP>:<PORT>
```
- **Clone the repo:**
```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git
```

- For Ruvomain-debloat, place your personal or Canta JSON lists in ./Configs
- For Ruvomain-installer, place your `APK` files in ./ruvomain-installer/Apps 
- For Ruvomain-restore, place your own backup .json file or Canta .json file list in ./ruvomain-backup/backups
- Ruvomain-backup places your backup .json file in /ruvomain-backup/backups

- **Navigate:**
```bash
cd ./Ruvomain-Protocole
```
***Note :** Make sure you run these commands from the directory where you cloned the repository. If you are in your Termux home folder, the command above is correct.*

- **Execute Universal ADB Apps-Manager (URAAM) dashboard:**
```bash
chmod +x dashboard.sh && ./dashboard.sh
```
***Note:** If `adb` fails, run `adb kill-server && adb start-server` and ensure your device appearsin `adb devices`.*

No Root or Shizuku required. Your Ruvomain Protocol communicates directly via local ADB socket.

### 🍎 For MacOS users:
1. Install [Homebrew](https://brew.sh/) if you haven't already.

2. **Install ADB:**
```bash
brew install git android-platform-tools jq
```

3. **Clone the protocol:**
```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git
```

4. **Verify device connection:**
```bash
adb devices
```
*(If "unauthorized", check your phonescreen and tap "Always allow")*

5.
- For Ruvomain-debloat, place your personal or Canta JSON lists in ./Configs
- For Ruvomain-installer, place your `APK` files in ./ruvomain-installer/Apps 
- For Ruvomain-restore, place your own backup .json file or Canta .json file list in ./ruvomain-backup/backups
- Ruvomain-backup places your backup .json file in /ruvomain-backup/backups

6. **Execute Universal ADB Apps-Manager (URAAM) dashboard:**
```bash
cd ./Ruvomain-Protocole
```
```bash
chmod +x ./dashboard.sh && dashboard.sh
```

**Finalize:** Reboot the device.
