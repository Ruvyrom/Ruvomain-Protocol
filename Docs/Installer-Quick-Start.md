## ⚙️ Quick Start for ruvomain-installer script

*Pro-Tip: Keep your APK folder clean.The installer will process every file found in `./ruvomain-installer/Apps`. Keep only the necessary versions to maintain your system efficiency.*

### Ruvomain-installer (Pure Bash Installer)
Local, offline-capable usage.

Enable USB Debugging on your Android device: 
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
git clone https://github.com/Ruvyrom/Ruvomain-Protocol.git
```

- **Place your personnal `.apk` file `./ruvomain-installer/Apps`**

3. **Execute:**
```bash
make install -C ./Ruvomain-Protocol
```

### 📱 For Termux users

**1. Semi-Automatic setup execution** (Install adb, pair & connect):

**Setup:**
```bash
pkg install git
```
```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocol.git
cd ./Ruvomain-Protocol/ruvomain-installer/
chmod +x termux-setup.sh && ./termux-setup.sh
```
- **Place** your multiple apk files to ./ruvomain-installer/Apps

**Execute** installer script:
```bash
chmod +x ruvomain-installer.sh && ./ruvomain-installer.sh
```
***Note :** Make sure you run these commands from the directory where you cloned the repository. If you are in your Termux home folder, the command above is correct.

If `adb` fails, run `adb kill-server && adb start-server` and ensure your device appearsin `adb devices`.*

**2. Manual execution:**
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
git clone https://github.com/Ruvyrom/Ruvomain-Protocol.git
```

- **Place** your multiple apk files to ./ruvomain-installer/Apps

- **Execute:**
```bash
cd ./Ruvomain-Protocol/ruvomain-installer/
chmod +x ruvomain-installer.sh && ./ruvomain-installer.sh
```

***Note:***
*- If `adb` fails, run `adb kill-server && adb start-server` and ensure your device appearsin `adb devices`.*
*- Make sure you run these commands from the directory where you cloned the repository. If you are in your Termux home* folder, the command above is correct.*

No Root or Shizuku required. Your Ruvomain Protocol communicates directly via local ADB socket.

### 🍎 For MacOS users:
1. Install [Homebrew](https://brew.sh/) if you haven't already.

2. **Install ADB:**
```bash
brew install git android-platform-tools
```

3. **Clone the protocol:**
```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocol.git
```
4. **Paste your personnal `.apk` file `./ruvomain-installer/Apps`**

5. **Verify device connection:**
```bash
adb devices
```
*(If "unauthorized", check your phonescreen and tap "Always allow")*

6. **Execute:**
```bash
cd ./Ruvomain-Protocol/Ruvomain-installer/
```
```bash
./ruvomain-installer.sh
```

**Finalize:** Reboot the device.
