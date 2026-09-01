#!/usr/bin/env bash

view_logs_generic() {
local target_dir="$1"
local log_pattern="$2"

if ls "$REPO_DIR/$target_dir/logs/$log_pattern"*.log >/dev/null 2>&1; then
if command -v nano >/dev/null 2>&1; then
echo -e "${GREEN}Openinglogs with nano...${NC}"
nano "$REPO_DIR/$target_dir/logs/$log_pattern"*.log
elif command -v less >/dev/null 2>&1; then
echo -e "${YELLOW}Nanonot found. Using less...${NC}"
cat "$REPO_DIR/$target_dir/logs/$log_pattern"*.log | less
else
echo -e "${YELLOW}Using cat (no nano/less found):${NC}"
cat "$REPO_DIR/$target_dir/logs/$log_pattern"*.log
fi
else
echo -e "${RED}No log files found in $target_dir/logs/${NC}"
sleep 2
fi
}

view_dlogs() { view_logs_generic "ruvomain-debloat" "ruvomain-debloat"; }
view_blogs() { view_logs_generic "ruvomain-backup" "ruvomain-backup"; }
view_rlogs() { view_logs_generic "ruvomain-restore" "ruvomain-restore"; }

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
view_logs_generic()
fi
