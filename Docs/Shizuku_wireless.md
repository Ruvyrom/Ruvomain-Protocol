# ⚡ Quick Guide: One-Click Wireless ADB & Shizuku Setup

Get rid of cables! With this guide, you only need to connect your phone witha USB cable **once**. The script will automatically start **Shizuku**, switch **ADB** to wireless mode, find your device's IP, and connect to it over Wi-Fi.

Once completed, you can **unplug the cable** and use tools like **URAAM** or **Canta** completely wirelessly.

---

## 📋 Prerequisites

1. **On your phone:**
- **Developer Options** enabled:
- Go to `Settings` > `About phone` > Tap **Build number** $7$ times.
- Go to `Developer Options` and enable **USB Debugging**.
- Make sure **Shizuku** is installed from [GitHub](https://github.com/RikkaApps/Shizuku/releases) or Google Play.
- Your phone and your computer must be connected to the **same Wi-Fi network**.

2. **On your computer:**
- `adb` installed and accessible in your terminal/command line.

---

## 🚀 Setup Instructions (Step-by-Step)

### Step 1: Connect via USB
Plug your Android device into your computer using a USB cable. If prompted on your phone's screen, tap **"Always allow from this computer"** and select **Allow**.

### Step 2: Run the Wireless ADB Shizuku Setup
Run URAAM, select "Wireless ADB Setup in Dashboard", in menu select "Wireless ADB + Shizuku" 

### Step 3: Unplug the Cable!🎉
Once you see:✅ Wireless ADB setup complete! You can now unplug your cable.Disconnect the USB cable. You are now fully connected over Wi-Fi!

---

## 🛠️ How It Works Underthe Hood

The script automatically executes the following actions:
1. **Starts Shizuku:** Wakes up theShizuku background service without requiring root permissions.
2. **Enables TCP/IP Mode:** Tells the AndroidADB daemon to listen on port `5555`.
3. **Detects Device IP:** Reads your phone's local network IP address dynamically.
4. **Initiates Wireless Link:** Pairs your terminal session directly over the local network via `adb connect<device-ip>:5555`.

---

## 💡 Good to Know & Reconnection

- **Do I need to do this every time?**
**No!** As long as your phone stays powered on,Shizuku and wireless ADB will remain active.
- **What happens if I reboot my phone?**
Android disables temporary debug ports and background daemon services on system reboot for security reasons. If your phone restarts:
1. Plug it back invia USB.
2. Run the script once again.
3. Unplug and enjoy wireless access again!
- **Lost connection while phone is still on?**
If your Wi-Fi disconnects momentarily, you don't need the cable again. Simply run: adb connect <YOUR_PHONE_IP>:5555
