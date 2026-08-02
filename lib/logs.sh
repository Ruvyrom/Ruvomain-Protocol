#!/usr/bin/env bash

init_logs() {
mkdir -p "$REPO_DIR/logs"

find "$REPO_DIR/logs" -name "ruvomain-*.log" -type f -mtime +30 -delete 2>/dev/null

LOGFILE="$REPO_DIR/logs/ruvomain-$(date +%Y%m%d_%H%M%S).log"

exec > >(tee -a "$LOGFILE") 2>&1
}
