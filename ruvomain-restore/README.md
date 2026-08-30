### URAAM : Universal ADB Ruvomain Apps-Manager - Ruvomain-restore.sh

This script restore your uninstalled apps list in a JSON file.
For use it, you can use your `backup_*.json` file created with ruvomain-backup or you should put a `*.json` file with this [Shema](https://github.com/Ruvyrom/Ruvomain-Protocol/blob/main/Docs/structure-example.json) (json file can be Canta backup file) in `./ruvomain-backup/backups` Ruvomain Protocol directory, before execute the script.
It reinstalls apps from json list.

You can execute it directly:
```bash
make restore -C ./Ruvomain-Protocol
```
**Requirements: (Script auto-install these if missing)**
*`adb` (Android Debug Bridge)
* `jq`
