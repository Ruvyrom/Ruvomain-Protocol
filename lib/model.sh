#!/usr/bin/env bash

model() {
printf "${CYAN}${BOLD}Ruvomain-PBD | Pure Bash Debloater${NC}\n"
printf "%s\n" "${CYAN}------------------------------------------${NC}\n"
CURRENT_MODEL=$(getprop ro.product.model 2>/dev/null || adb shell getprop ro.product.model 2>/dev/null || echo "Unknown")
printf "${GREEN}Device detected:${NC}\n ${BOLD}%s${NC}\n" "${CURRENT_MODEL}"
printf "%s\n" "${CYAN}------------------------------------------${NC}\n"
} 
