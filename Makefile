# Ruvomain-Protocol - Universal ADB App Manager
# Usage:
#   make(run the dashboard)
#   make update   (run update to latest)
#   make clean(run clean logs)
#   make bclean   (run clean backup)
#   make help     (run command help)

.PHONY: all dashboard update clean bclean help

# Default action: run the dashboard
all: dashboard

dashboard:
@chmod +x ./ruvomain.sh
@./ruvomain.sh

update:
@if [ -f "./update.sh" ]; then \
chmod +x ./update.sh && ./update.sh; \
elif [ -d ".git" ]; then \
echo "Updating via git...";\
git pull --quiet && echo "Updated successfully."; \
else \
echo "Update script orgit repo not found."; \
fi

clean:
@echo "Cleaning up temporary logs..."
@-rm -f ./Logs/debloat/*.log 2>/dev/null
@-rm -f ./Logs/backup/*.log 2>/dev/null
@-rm -f ./Logs/restore/*.log 2>/dev/null
@echo "[✓] Logs cleaned."

bclean:
@echo "Cleaning up backup JSON files..."
@-rm-f ./Configs/backup-restore/*.json 2>/dev/null
@echo "[✓] Backups cleaned."

help:
@echo "Ruvomain-Protocol available commands:"
@echo "make         - Runs the dashboard"
@echo "  make update  - Updates to the latest version"
@echo "  makeclean   - Cleans debloat/backup/restore logs"
@echo "  make bclean  - Cleans JSONbackups"
@echo "  make help    - Displays this help menu"
