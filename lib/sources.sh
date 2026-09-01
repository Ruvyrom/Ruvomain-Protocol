#!/usr/bin/env bash

sources() {
#Variable
"android-tools"="$1"; 
"adb"="$2";
"sudo"="$3";
"ruvomain-"="$r1";
"./ruvomain-"="$r2";
"./termux-setup.sh"="$t";
"installer"="$i";
"debloat"="$d";
"backup"="$b";
"restore"="$r3";
"$REPO_DIR/ruvomain-backup/logs"="$bl";

# --- Dynamic Path Resolution ---
STYLE_DIR="$REPO_DIR/lib/styles.sh"
ENSURE_DIR="$REPO_DIR/lib/ensure-adb.sh"
ENSUREJQ_DIR="$REPO_DIR/lib/ensure-jq.sh"
LOGS_DIR="$REPO_DIR/lib/logs.sh"
LOGO_DIR="$REPO_DIR/lib/logo.sh"
MODEL_DIR="$REPO_DIR/lib/model.sh"
ENV_DIR="$REPO_DIR/lib/env-detect.sh"
MENU_DIR="$REPO_DIR/lib/menu.sh"
CONFIGS_DIR="$REPO_DIR/lib/logs-backup.sh"
BACKUPS_DIR="$REPO_DIR/Configs"
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
MODULES_DIR=("$STYLE_DIR" "$ENSURE_DIR" "$ENSUREJQ_DIR" "$LOGS_DIR" "$LOGO_DIR" "$MODEL_DIR" "$ENV_DIR" "$MENU_DIR" "$FINAL_DIR" "$CHECK_DIR" "$INSTALLER_DIR" "$BACKUP_DIR" "$LOGSBACKUP_DIR" "$LOGSRESTORE_DIR" "$DEBLOAT_DIR" "$RESTORE_DIR" "$AUTOP_DIR")

for mod in "${MODULES_DIR[@]}"; do
[ -f "$mod" ] && chmod +x "$mod" && source "$mod"
done
} 
