#!/usr/bin/env bash

init_logs() {
mkdir -p $REPO_DIR/ruvomain-debloat/logs

find "$REPO_DIR/ruvomain-debloat/logs" -name "ruvomain-debloat-*.log" -type f -mtime +30 -delete 2>/dev/null

LOGFILE="$REPO_DIR/ruvomain-debloat/logs/ruvomain-debloat-$(date +%Y%m%d_%H%M%S).log"

exec > >(tee -a "$LOGFILE") 2>&1
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
init_logs()
fi
