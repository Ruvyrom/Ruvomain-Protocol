### URAAM : Universal ADB Ruvomain Apps-Manager - Ruvomain-debloat.sh

This script debloat unwanted apps or bloatware with JSON file apps list or your backup json file from Canta.
It uses `*.json` files in `./Configs` Ruvomain Protocol directory.
Put before execute script or use and select a `*.json` or Canta backup .json file (in ./Configs) and the script debloat listed apps.

---
**1. Enable USB Debugging on your phone:**

<details>
<summary>Configuration</summary>

>>Settings > About Phone > Tap "Build Number" 7 times
>
>>Settings > Developer Options > Enable "USB Debugging"
>
>>Connect your phone to your PC via USB
</details>

OR

**2. Use Wireless Debuging:**

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

- On your PC in your terminal (WSL/Linux/Mac):
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
</details>

You can execute it directly:

```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocol.git
make debloat -C ./Ruvomain-Protocol
```

**Requirements: (Script auto-install these if missing)**

*`adb` (Android Debug Bridge)
* `jq`
