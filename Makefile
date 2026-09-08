# Ruvomain-Protocol - Universal ADB App Manager
# Usage:
#   make          (run the dashboard)
#   make clean    (run clean logs)
#   make bclean   (run clean backup)
#   make help     (run command help)
#
# For Ruvomain-debloat, place your personal or Canta JSON lists in ./Configs
#
# For Ruvomain-installer, place your APK files in ./ruvomain-installer/Apps
#
# For Ruvomain-restore, use your backup created with ruvomain-backup.sh or place your own backup .json file or Canta .json file list in ./ruvomain-backup/backups
#
# Ruvomain-backup places your backup .json file in /ruvomain-backup/backups

.PHONY: all dashboard termux debloat backup restore install clean bclean help

# Default action: run the dashboard
all: dashboard

dashboard:
@chmod +x ./ruvomain.sh
./ruvomain.sh

clean:
@echo "Cleaning up temporary files..."
-rm -f ./Logs/debloat/*.log
-rm -f ./Logs/backup/*.log
-rm -f ./Logs/restore/*.log

bclean:
@echo "Cleaning up backup JSON files..."
-rm -f ./Configs/backup-restore/*.json

help:
@echo "Ruvomain-Protocol available commands:"
@echo "  make         - Runs the dashboard"
@echo "  make clean   - Runs clean logs"
@echo "  make bclean  - Runs clean backup
