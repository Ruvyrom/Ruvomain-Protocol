#!/usr/bin/env bash

REPO_DIR="${REPO_DIR:-$(dirname "$(readlink -f "$0")")}"

sources() {
# --- Dynamic Path Resolution ---
STYLE_DIR="$REPO_DIR/lib/styles.sh"
ENSURE_DIR="$REPO_DIR/lib/ensure-adb.sh"
ENSUREJQ_DIR="$REPO_DIR/lib/ensure-jq.sh"
LOGS_DIR="$REPO_DIR/lib/logs.sh"
LOGO_DIR="$REPO_DIR/lib/logo.sh"
MODEL_DIR="$REPO_DIR/lib/model.sh"
ENV_DIR="$REPO_DIR/lib/env-detect.sh"
MENU_DIR="$REPO_DIR/lib/menu.sh"
CONFIGS_DIR="$REPO_DIR/Configs"
BACKUPS_DIR="$REPO_DIR/ruvomain-backup/backups"
FINAL_DIR="$REPO_DIR/lib/final.sh"
CHECK_DIR="$REPO_DIR/lib/check_adb.sh"
INSTALLER_DIR="$REPO_DIR/lib/installer.sh"
BACKUP_DIR="$REPO_DIR/lib/backup.sh"
LOGSBACKUP_DIR="$REPO_DIR/lib/logs-backup.sh"
LOGSRESTORE_DIR="$REPO_DIR/lib/logs-restore.sh"
BACKUPS_DIR="$(dirname "$0")/../ruvomain-backup/backups"
DEBLOAT_DIR="$REPO_DIR/lib/debloat.sh"
RESTORE_DIR="$REPO_DIR/lib/restore.sh"
AUTOP_DIR="$REPO_DIR/lib/autoperm.sh"

# --- Sources & Execution Permissions ---
MODULES_DIR=(
"$STYLE_DIR"
"$ENSURE_DIR"
"$ENSUREJQ_DIR"
"$LOGS_DIR"
"$LOGO_DIR"
"$MODEL_DIR"
"$ENV_DIR"
"$MENU_DIR"
"$FINAL_DIR"
"$CHECK_DIR"
"$INSTALLER_DIR"
"$BACKUP_DIR"
"$LOGSBACKUP_DIR"
"$LOGSRESTORE_DIR"
"$DEBLOAT_DIR"
"$RESTORE_DIR"
"$AUTOP_DIR"
)

for mod in "${MODULES[@]}"; do
if [[ -f "$mod" ]]; then
chmod +x "$mod"
source "$mod"
else
printf "[!] Error : Module %s not found.\n" "$mod" >&2
fi
done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
sources()
fi
