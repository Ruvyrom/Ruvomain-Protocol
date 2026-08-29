#!/usr/bin/env bash

debloat() {
# ---File List ---
# Create an array with all .json files
# Verify if the directory contains any .json files
files=("$CONFIGS_DIR"/*.json)
if [ ! -e "${files[0]}" ]; then
echo -e "${RED}No .json files found in $CONFIGS_DIR${NC}"
exit 1
fi

echo "Configuration files found:"
echo "-----------------------------------"

# Interactive menu
PS3="Select the file number (1-${#files[@]}): "
select file in "${files[@]}"; do
if [ -f "$file" ]; then
echo -e "\nSelected file: ${GREEN}$(basename "$file")${NC}"
break
else
echo -e "${RED}Invalid selection, please try again.${NC}"
fi
done

# --- Debloating ---

# Extract packages
mapfile -t PACKAGES < <(jq -r '.apps[].packageName' "$file" 2>/dev/null)

if [ ${#PACKAGES[@]} -eq 0 ];then
echo -e "${RED}No packages found. Verify the JSON format.${NC}"
exit1
fi

echo -e "${BLUE}Starting debloating of ${#PACKAGES[@]} packages...${NC}"

for pkg in "${PACKAGES[@]}"; do
echo -n "Debloating $pkg: "

# Execute command
if $EXEC "pm uninstall -k --user 0" "$pkg" > /dev/null 2>&1; then
echo -e "${GREEN}Success${NC}"
else
echo -e "${RED}Failed (already uninstall or not found)${NC}"
fi
done

echo -e "${GREEN}=== Operation finished===${NC}"
