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
- **Clone the repo:** `git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git`

- **(Optional) [import](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/README.md) your personnal configuration file (for s24+ or other Android devices) or Modify** ruvomain_tier*_stable.json in `/Configs/S24+`

- **Navigate:** `cd ./Ruvomain-Protocole/ruvomain-pdb/`

- **Execute:**
`chmod +x ruvomain.sh && ./ruvomain.sh`

### 📱 For Termux users
- **Grant Storage Access:** `termux-setup-storage` (Accept the permission prompt)

- **Deploy:** Follow the same steps as the [Linux](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-for-linux-users) deployment above.

### 🍎 For MacOS users:
1. Install [Homebrew](https://brew.sh/) if you haven't already.

2. **Install ADB:**
`brew install git android-platform-tools`

3. **Clone the protocol:**
`git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git`
`cd Ruvomain-Protocole/ruvomain-pdb`

4. **Verify device connection:**
`adb devices`
*(If "unauthorized", check your phonescreen and tap "Always allow")*

5. **(Optional) [import](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/README.md) your personnal configuration file (for s24+ or other Android devices) or Modify** ruvomain_tier*_stable.json in `/Configs/S24+`

6. **Execute:**
`cd ./Ruvomain-Protocole/ADB-Termux/devices/S24+`
`./ruvomain.sh`

**Finalize:** Reboot the device.
