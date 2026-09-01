#!/usr/bin/env bash

view_logs(){
if ls $REPO_DIR/ruvomain-debloat/logs/ruvomain-debloat*.log >/dev/null 2>&1; then
if ls $REPO_DIR/ruvomain-backup/logs/*.log >/dev/null 2>&1; then
if ls $REPO_DIR/ruvomain-restore/logs/*.log >/dev/null 2>&1; then

if command -v nano >/dev/null 2>&1; then
echo -e "${GREEN}Opening logs with nano...${NC}"
nano "$REPO_DIR/logs/"*.log

elif command -v less >/dev/null 2>&1; then
echo -e"${YELLOW}Nano not found. Using less...${NC}"
cat "$REPO_DIR/logs/"*.log| less

else
echo -e "${YELLOW}Nano and less not found. Dumping to screen:${NC}"
cat "$REPO_DIR/ruvomain-debloat/logs/"*.log
fi

else
echo -e "${RED}No log files found in $REPO_DIR/ruvomain-debloat/logs/${NC}"
sleep 2
fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
view-logs()
fi
