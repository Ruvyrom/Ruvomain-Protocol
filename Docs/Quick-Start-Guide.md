## ⚙️ Quick Start
**Disconnect Samsung account before using tier 2 and 3 in script and for more privacy.**

### Ruvomain-PBD (Pure Bash Debloater)
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
  
- `adb` (The script will attempt an android-tools auto-installation if missing).

2. **Deployment:**
- **Clone the repo:**
```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git
```

- **(Optional) [import](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/README.md) your personnal or Canta .json restoration list (all Android devices) or Modify** ruvomain_tier*_stable.json in `/Configs/S24+`

- **Navigate:**
```bash
cd ./Ruvomain-Protocole/ruvomain-pdb/
```

- **Execute:**
```bash
chmod +x ruvomain.sh && ./ruvomain.sh
```

### 📱 For Termux users (Wireless)
**Grant Storage Access:**
```bash
termux-setup-storage
```
 (Accept the permission prompt)

**Deploy:**

- ```bash
  pkg install android-tools git -y
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
- **(Optional) [import](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/README.md) your personnal or Canta .json restoration list (all Android devices) or Modify** ruvomain_tier*_stable.json in `/Configs/S24+`

- **Navigate:**
```bash
cd ./Ruvomain-Protocole/ruvomain-pdb/
```
***Note :** Makesure you run these commands from the directory where you cloned the repository. If you are in your Termux home folder, thecommand above is correct.*

- **Execute:**
```bash
chmod +x ruvomain.sh && ./ruvomain.sh
```
***Note:** If `adb` fails, run `adb kill-server && adb start-server` and ensure your device appearsin `adb devices`.*

No Root or Shizuku required. Your Ruvomain Protocol communicates directly via local ADB socket.

### 🍎 For MacOS users:
1. Install [Homebrew](https://brew.sh/) if you haven't already.

2. **Install ADB:**
```bash
brew install git android-platform-tools
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

5. **(Optional) [import](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/README.md) your personnal or Canta .json restoration list (all Android devices) or Modify** ruvomain_tier*_stable.json in `/Configs/S24+`

6. **Execute:**
```bash
cd ./Ruvomain-Protocole/Ruvomain-pdb/
```
```bash
./ruvomain.sh
```

**Finalize:** Reboot the device.
