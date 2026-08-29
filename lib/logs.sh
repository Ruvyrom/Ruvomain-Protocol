#!/usr/bin/env bash

"$REPO_DIR/ruvomain-debloat/logs"="$1";

init_logs() {
mkdir -p "$1"

find "$1" -name "ruvomain-debloat-*.log" -type f -mtime +30 -delete 2>/dev/null

LOGFILE="$1"/ruvomain-debloat-$(date +%Y%m%d_%H%M%S).log"

exec > >(tee -a "$LOGFILE") 2>&1
}
