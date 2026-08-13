## ⚙️ Quick Start for ruvomain-installer script

### Ruvomain-installer (Pure Bash Installer)
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

- **Paste your personnal `.apk` file `./ruvomain-installer/Apps`**

- **Navigate:**
```bash
cd ./Ruvomain-Protocole/ruvomain-installer/
```

- **Execute:**
```bash
chmod +x ruvomain-installer.sh && ./ruvomain-installer.sh
```

### 📱 For Termux users
- **Grant Storage Access:**
```bash
termux-setup-storage
```
 (Accept the permission prompt)

- **Deploy:** Follow the same steps as the [Linux](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-for-linux-users) deployment above.

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
4. **Paste your personnal `.apk` file `./ruvomain-installer/Apps`**

5. **Verify device connection:**
```bash
adb devices
```
*(If "unauthorized", check your phonescreen and tap "Always allow")*

6. **Execute:**
```bash
cd ./Ruvomain-Protocole/Ruvomain-installer/
```
```bash
./ruvomain-installer.sh
```

**Finalize:** Reboot the device.
