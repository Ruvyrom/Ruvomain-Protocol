#!/usr/bin/env bash

init_logs_backup() {
local script_dir
script_dir=$(dirname "${BASH_SOURCE[0]}")

local default_base
default_base=$(cd "$script_dir/.." && pwd)

local base_dir="${REPO_DIR:-$default_base}"
local log_dir="${1:-$base_dir/ruvomain-backup/logs}"

mkdir -p "$log_dir"

find "$log_dir" -name "ruvomain-backup-*.log" -type f -mtime +30 -delete 2>/dev/null

LOGFILE="$log_dir/ruvomain-backup-$(date +%Y%m%d_%H%M%S).log"

exec> >(tee -a "$LOGFILE") 2>&1
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
init_logs_backup
fi
