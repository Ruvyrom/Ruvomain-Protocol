# Ruvomain-Protocol - Universal ADB App Manager
# Usage:
#   make          (run the dashboard)
#   make termux   (run Termux setup)
#   make debloat  (run debloat script)
#   make backup   (run backup script)
#   make restore  (run restore script)
#   make install  (run install script)
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
@chmod +x ./dashboard.sh
./dashboard.sh

debloat:
@chmod +x ./ruvomain-debloat/ruvomain-debloat.sh
./ruvomain-debloat/ruvomain-debloat.sh

backup:
@chmod +x ./ruvomain-backup/ruvomain-backup.sh
./ruvomain-backup.sh

restore:
@chmod +x ./ruvomain-restore/ruvomain-restore.sh
./ruvomain-restore/ruvomain-restore.sh

install:
@chmod +x ./ruvomain-installer/ruvomain-installer.sh
./ruvomain-installer/ruvomain-installer.sh

termux:
@chmod +x ./termux-setup.sh
./termux-setup.sh

clean:
@echo "Cleaning up temporary files..."
-rm -f ./ruvomain-debloat/logs/*.log
-rm -f ./ruvomain-restore/logs/*.log
-rm -f ./ruvomain-backup/logs/*.log

bclean:
@echo "Cleaning up backup JSON files..."
-rm -f ./ruvomain-backup/backups/*.json

help:
@echo "Ruvomain-Protocol available commands:"
@echo "  make         - Runs the dashboard"
@echo "  make termux  - Runs Termux setup"
@echo "  make debloat - Runs the debloat module"
@echo "  make backup  - Runs the backup module"
@echo "  make restore - Runs the restore module"
@echo "  make install - Runs the installer module"
@echo "  make clean   - Runs clean logs"
@echo "  make bclean  - Runs clean backup
