#!/usr/bin/env bash

debloat() {
# --- File List ---
# Enable nullglob to avoid literal wildcard if no file matches
shopt -s nullglob
local files=("$CONFIGS_DIR"/*.json)
shopt -u nullglob

if [ ${#files[@]} -eq 0 ]; then
echo -e "${RED}No .json files found in $CONFIGS_DIR${NC}"
exit 1
fi

echo "Configuration files found:"
echo "----------------------------------------"

# Interactive menu
PS3="Select the file number (1-${#files[@]}): "
select file in "${files[@]}"; do
if [ -n "$file" ] && [ -f "$file" ]; then
echo -e "\nSelected file: ${GREEN}$(basename "$file")${NC}"
break
else
echo -e "${RED}Invalid selection, please try again.${NC}"
fi
done

# --- Debloating ---
#Extract packages (compatible with Canta schema & simple arrays)
mapfile -t PACKAGES < <(jq-r 'if type=="array" then .[] elif .apps then .apps[].packageName // .apps[]else empty end' "$file" 2>/dev/null)

if [ ${#PACKAGES[@]} -eq0 ]; then
echo -e "${RED}No packages found. Verify the JSON format.${NC}"
exit 1
fi

echo -e "${BLUE}Starting debloating of ${#PACKAGES[@]} packages...${NC}"

local SUCCESS=0
local FAILED=0

for pkg in "${PACKAGES[@]}"; do
[ -z "$pkg" ] && continue
echo -n "Debloating $pkg: "

# Execute command properly
if $EXEC pm uninstall -k --user 0 "$pkg" >/dev/null 2>&1; then
echo -e "${GREEN}Success${NC}"
((SUCCESS++))
else
echo -e "${RED}Failed (already uninstalled or not found)${NC}"
((FAILED++))
fi
done

echo "----------------------------------------"
echo -e "Summary: ${GREEN}$SUCCESS removed${NC}, ${RED}$FAILED failed/skipped${NC}."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
debloat
fi
