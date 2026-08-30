### URAAM : Universal ADB Ruvomain Apps-Manager - Ruvomain-backup.sh

This script backup your uninstalled apps list in a JSON file for execute later for debloat or restore via ruvomain-debloat, ruvomain-restore or Canta.
It put `backup_*.json` in `./ruvomain-backup/backups` Ruvomain Protocol directory

You can execute it directly:
```bash
make backup -C ./Ruvomain-Protocol
```
**Requirements: (Script auto-install these if missing)**
*`adb` (Android Debug Bridge)
* `jq`
