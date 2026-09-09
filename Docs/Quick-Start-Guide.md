## ⚙️ Quick Start
**Disconnect Samsung account before using tier 2 and 3 in script and for more privacy.**

### Universal Ruvomain ADB App-Manager (URAAM)

**1. Enable USB Debugging on your Android device:**

<details>
<summary>Configuration</summary>

>>Settings > About Phone > Tap "Build Number" 7 times
>
>>Settings > Developer Options > Enable "USB Debugging"
>
>>Connect your Android device to your PC via USB
</details>

OR

**2. Use Wireless Debugging:**

<details>
<summary>Configuration</summary>

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

- On your terminal
>
>>Select "wireless ADB Setup" in Dashboard Menu when you execute URAAM and follow instrutions.
>>>
> Wireless ADB Setup [Screenshot](/assets/wireless.jpg) (on Termux)
>
Or manually:
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

*Note: `<PORT>` for pairing is differentfrom the connection `<PORT>` on Android 11+.*

*- If adb connection fails, ensure your PC and Android device are on the same Wi-Fi network.*

*- If the pairing code is rejected, turn off Wireless Debugging and turn it back on to refresh the token.*
</details>

### 🐧 For Linux & WSL users:
1. **Prerequisites:**

- `git` for clone repo
<details>
 <summary>Git installation:</summary>

>>Debian, Ubuntu, WSL
```bash
sudo apt install git -y
```
>>Arch based
```bash
sudo pacman -S --no-confirm git
```
>>Fedora based
```bash
sudo dnf install -y git
```
</details>

***Note:** `adb` and `jq` (The script will attempt an android-tools/jq auto-installation if missing).*

2. **Deployment:**

<details>
<summary><b></b>Execution:</b></summary>

- **Clone the repo:**
  
```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocol.git
```

Folder layout:
* Place debloat configurations in `./Configs/debloat/` *(Canta JSON supported)*.
* Place APKs to install in `./Apps/`.
* Backups and restoration targets reside in `./Configs/backup-restore/`.
```bash
make -C ./Ruvomain-Protocol
```
Or run directly in **Bash**:
```bash
cd ./Ruvomain-Protocol
```

```bash
chmod +x ruvomain.sh && ./ruvomain.sh
```
</details>

### 📱 For Termux users (The script detect if you use with root, Shizuku Rish or wireless ADB)

<details>
<summary><b></b>Execution:</b></summary>

**Install git:**
```bash
pkg install git
```
*`adb` and `jq` (The script will attempt an android-tools/jq auto-installation if missing).*

**Clone the repo:**
```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocol.git
```

Folder layout:
* Place debloat configurations in `./Configs/debloat/` *(Canta JSON supported)*.
* Place APKs to install in `./Apps/`.
* Backups and restoration targets reside in `./Configs/backup-restore/`.
**Execute Universal ADB App-Manager (URAAM) dashboard:**

```bash
make -C ./Ruvomain-Protocol
```
Or run directly in **Bash**:
```bash
cd ./Ruvomain-Protocol
chmod +x ruvomain.sh && ./ruvomain.sh
```

***Note :***

*- Make sure you run these commands from the directory where you cloned the repository. If you are in your Termux home folder, the command above is correct.*

*- If `adb` fails, run `adb kill-server && adb start-server` and ensure your device appears in `adb devices`.*

</details>

### 🍎 For MacOS users:

<details>
<summary><b></b>Execution:</b></summary>
 
Install [Homebrew](https://brew.sh/) if you haven't already.

**Prerequisites:**
```bash
brew install git
```
*`adb` and `jq` (The script will attempt an android-tools/jq auto-installation if missing).*

**Clone the repository:**

```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocol.git
```

*(If "unauthorized", check your phonescreen and tap "Always allow")*

4.
Folder layout:
* Place debloat configurations in `./Configs/debloat/` *(Canta JSON supported)*.
* Place APKs to install in `./Apps/`.
* Backups and restoration targets reside in `./Configs/backup-restore/`.

5. **Execute Universal ADB App-Manager (URAAM) dashboard:**

```bash
make -C ./Ruvomain-Protocol
```
Or run directly in **Bash**:
```bash
cd ./Ruvomain-Protocol
```
```bash
chmod +x ./ruvomain.sh && ruvomain.sh
```

</details>

**Finalize:** Reboot the device.
