#!/usr/bin/env bash

init_logs() {
local base_dir="${REPO_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
local log_dir="${1:-$base_dir/ruvomain-debloat/logs}"

mkdir -p "$log_dir"

find "$log_dir" -name "ruvomain-debloat-*.log" -type f -mtime +30 -delete 2>/dev/null

LOGFILE="$log_dir"/ruvomain-debloat-$(date +%Y%m%d_%H%M%S).log"

exec > >(tee -a "$LOGFILE") 2>&1
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
init_logs
fi
