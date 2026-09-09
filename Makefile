# Ruvomain-Protocol - Universal ADB App Manager
# Usage:
#   make          (run the dashboard)
#   make update   (run update to lastest)
#   make clean    (run clean logs)
#   make bclean   (run clean backup)
#   make help     (run command help)
#
#Folder layout:
#
#Place debloat configurations in ./Configs/debloat/ (Canta JSON supported).
#
#Place APKs to install in ./Apps/.
#
#Backups and restoration targets reside in ./Configs/backup-restore/.

.PHONY: all dashboard update clean bclean help

# Default action: run the dashboard
all: dashboard

dashboard:
@chmod +x ./ruvomain.sh
./ruvomain.sh

update:
@chmod +x ./update.sh

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
