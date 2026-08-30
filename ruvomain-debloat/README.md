### URAAM : Universal ADB Ruvomain Apps-Manager - Ruvomain-debloat.sh

This script debloat unwanted apps or bloatware with JSON file apps list or your backup json file from Canta.
It uses `*.json` files in `./Configs` Ruvomain Protocol directory.
Put before execute script or use and select a `*.json` or Canta backup .json file (in ./Configs) and the script debloat listed apps.

You can execute it directly:
```bash
make debloat -C ./Ruvomain-Protocol
```
**Requirements: (Script auto-install these if missing)**

*`adb` (Android Debug Bridge)
* `jq`
