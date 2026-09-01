#!/usr/bin/env bash

installer() {
# Installation process
echo-e "${GREEN}[INFO]${NC} Deploying packages..."

for apk in "$APP_DIR"/*.apk; do
if [ -f "$apk" ]; then
echo -e "Installing: $(basename "$apk")"

# -r: Replace existing application
# -g: Grant all runtime permissions (minimizes interaction)
adb install -r -g "$apk" | grep -v "Success"

if[ $? -eq 0 ]; then
echo -e "${GREEN}✓${NC} Successfully installed."
else
echo -e "${RED}✗${NC} Installation failed."
fi
fi
done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
installer()
fi
