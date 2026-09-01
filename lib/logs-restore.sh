#!/usr/bin/env bash

init_logs-restore() {
mkdir -p "$REPO_DIR/ruvomain-restore/logs"

find "$REPO_DIR/ruvomain-restore/logs" -name "ruvomain-restore-*.log" -type f -mtime +30 -delete 2>/dev/null

LOGFILE="$1"/ruvomain-restore-$(date +%Y%m%d_%H%M%S).log"

exec > >(tee -a "$LOGFILE") 2>&1
}
