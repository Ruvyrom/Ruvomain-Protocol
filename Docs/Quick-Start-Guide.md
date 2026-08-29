## ⚙️ Quick Start
**Disconnect Samsung account before using tier 2 and 3 in script and for more privacy.**

### Ruvomain ADB App-Manager (RAAM)
Local, offline-capable usage.

Enable USB Debugging on your phone: 
>
>Settings > About Phone > Tap "Build Number" 7 times
>
>Settings > Developer Options > Enable "USB Debugging"
>
>Connect your phone to your PC via USB

### 🐧 For Linux users:
1. **Prerequisites:**

- `git` for clone repo. 

- `adb` and `jq` (The script will attempt an android-tools/jq auto-installation if missing).

2. **Deployment:**
- **Clone the repo:**
```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git
```

- **[import](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/README.md) your personnal or Canta .json restoration list (all Android devices) or Modify** ruvomain_tier*_stable.json in `/Configs/S24+`

- **Navigate:**
```bash
cd ./Ruvomain-Protocole
```

- **Execute ADB App-Manager dashboard:**
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
- **[import](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/README.md) your personnal or Canta .json restoration list (all Android devices) or Modify** *.json in `/Configs`

**Execute** ADB App-Manager dashboard:
```bash
chmod +x dashboard.sh && ./dashboard.sh
```
***Note :** Make sure you run these commands from the directory where you cloned the repository. If you are in your Termux home folder, the command above is correct.*

*If `adb` fails, run `adb kill-server && adb start-server` and ensure your device appearsin `adb devices`.*

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

>**Pair the terminal (it will ask you for the code).**
>
>adb pair
```bash
adb pair <IP>:<PORT>
```
>**Connect the terminal**
>
>adb connect
```bash
adb connect <IP>:<PORT>
```
- **Clone the repo:**
```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git
```
- **[import](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/README.md) your personnal or Canta .json restoration list (all Android devices) or Modify** ruvomain_tier*_stable.json in `/Configs/S24+`

- **Navigate:**
```bash
cd ./Ruvomain-Protocole
```
***Note :** Make sure you run these commands from the directory where you cloned the repository. If you are in your Termux home folder, the command above is correct.*

- **Execute ADB App-Manager dashboard:**
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

5. **(Optionak) [import](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/README.md) your personnal or Canta .json restoration list (all Android devices)  in `/Configs`

6. **Execute ADB App-Manager dashboard:**
```bash
cd ./Ruvomain-Protocole
```
```bash
chmod +x ./dashboard.sh && dashboard.sh
```

**Finalize:** Reboot the device.
