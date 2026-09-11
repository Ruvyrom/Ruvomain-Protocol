## ⚙️ Quick Start

**Disconnect Samsung account before using tier 2 and 3 in script and for more privacy and toavoid account sync loops.**

### Universal Ruvomain ADB App-Manager (URAAM)

**1-USB option** ***Enable USB Debugging on your device:***

* Settings > About phone > Tap "Build Number" 7 times

* Settings > Developer Options > Enable "USB Debugging"

* Connect your device to your PC via USB

or

**2-Wireless option** ***Use wireless ADB setup assistant option in Dashboard.***
* Execute script and choose option ***[5] Wireless ADB Setup***
* Follow instructions.

or

**3-Shizuku option** ***(For Termux via Shizuku & Rish):***
* Start [Shizuku](https://shizuku.rikka.app/).
* Export the Shizuku shell (`rish`) into Termux environment.
* URAAM will execute elevated package commands directly on-device.

*Note:*
* *- If adb connection fails, ensure your PC and Android device are on the same Wi-Fi network.*
* *- If the pairing code is rejected, turn off Wireless Debugging and turn it back on to refresh the token.*

---
### For 🐧Linux, 📱Termux, WSL:
### Direct execution
**1-Line Installation**

* Auto-install with confirmation on **Termux, Linux, macOS, WSL**:
```bash
bash <(command -v curl >/dev/null && curl -fsSL https://raw.githubusercontent.com/Ruvyrom/Uraam/main/installer.sh || wget -qO- https://raw.githubusercontent.com/Ruvyrom/Uraam/main/installer.sh)
```

DEB installation for Debian with uraam-debian_*.deb**
```bash
curl -LO https://github.com/Ruvyrom/Uraam/releases/download/v4.2.0/uraam-termux_4.2.0_all.deb 
sudo dpkg -i install ./uraam-debian_4.2.0_all.deb
```

**DEB installation fo installation with uraam-termux_*.deb**
```bash
curl -LO https://github.com/Ruvyrom/Uraam/releases/download/v4.2.0/uraam-termux_4.2.0_all.deb 
pkg install ./uraam-termux_4.2.0_all.deb
```

> * **Note :**
>> * *The installer auto-install GIT after confirm and takes care of cloning the repository.*
>> * *URAAM auto-install ADB and JQ if necessary.*
>> * *DEB package install dependencies*
### Usage Anywhere

Once installed, simply run the global command from any directory:
```bash
uraam
```

### 📁 File Layout (`~/.Uraam/`)
| Folder | Purpose|
| :--- | :--- |
| `Configs/debloat/` | Place debloat lists here(*Canta JSON supported*) |
| `Apps/` | Place APKs to batch-install |
| `Configs/backup-restore/` | Exported application lists & restore points |

## Other installation method
<details>
<sumary>Prerequisites:</sumary>

- `git` for clone repo

Git installation:

>>Termux
```bash
pkg install git
```
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


<details>
<summary><b></b>Execution:</b></summary>

- **Clone the repo:**
  
```bash
git clone https://github.com/Ruvyrom/Uraam.git
```

Folder layout:
* Place debloat configurations in `./Configs/debloat/` *(Canta JSON supported)*.
* Place APKs to install in `./Apps/`.
* Backups and restoration targets reside in `./Configs/backup-restore/`.

```bash
make -C ./Uraam
```
Or run directly in **Bash**:
```bash
cd ./Uraam
```

```bash
chmod +x uraam.sh && ./uraam.sh
```
</details>
</details>

***Note :***

*- Make sure you run these commands from the directory where you cloned the repository. If you are in your Termux home folder, the command above is correct.*

*- If `adb` fails, run `adb kill-server && adb start-server` and ensure your device appears in `adb devices`.*

</details>

### 🍎 For MacOS users:

Install [Homebrew](https://brew.sh/) if you haven't already.

**Prerequisites:**
```bash
brew install git android-tools jq
```
**Follow the same quick start than [Linux, Termux...](https://github.com/Ruvyrom/Ruvomain-Protocol/blob/main/Docs/Quick-Start-Guide.md#for-linux-termux-wsl)**
