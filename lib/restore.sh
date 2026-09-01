#!/usr/bin/env bash

restore() {
# ---File List ---
# Create an array with all .json files
# Verify if the directory contains any .json files
files=("$BACKUPS_DIR"/*.json)
if [ ! -e "${files[0]}" ]; then
echo -e "${RED}No .json files found in $BACKUPS_DIR${NC}"
exit 1
fi

echo "Configuration files found:"
echo "-----------------------------------"

# Interactive menu
PS3="Selectthe file number (1-${#files[@]}): "
select file in "${files[@]}"; do
if [ -f "$file" ]; then
echo -e "\nSelected file: ${GREEN}$(basename "$file")${NC}"
break
else
echo -e "${RED}Invalid selection, please try again.${NC}"
fi
done

# --- Restoration ---

# Extract packages
mapfile -t PACKAGES < <(jq -r '.apps[].packageName' "$file" 2>/dev/null)

if [ ${#PACKAGES[@]} -eq 0 ];then
echo -e "${RED}No packages found. Verify the JSON format.${NC}"
exit1
fi

echo -e "${BLUE}Starting restoration of ${#PACKAGES[@]} packages...${NC}"

for pkg in "${PACKAGES[@]}"; do
echo -n "Restoring $pkg: "

# Execute command
if $EXEC pm install-existing --user 0 "$pkg" > /dev/null 2>&1; then
echo -e "${GREEN}Success${NC}"
else
echo -e "${RED}Failed (already present or not found)${NC}"
fi
done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
restore()
fi
