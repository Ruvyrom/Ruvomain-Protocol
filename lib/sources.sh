#!/usr/bin/env bash

sources() {
# --- Dynamic Path Resolution ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
STYLE_DIR="$REPO_DIR/lib/styles.sh"
ENSURE_DIR="$REPO_DIR/lib/ensure-adb.sh"
LOGS_DIR="$REPO_DIR/lib/logs.sh"
LOGO_DIR="$REPO_DIR/lib/logo.sh"
INJECTION_DIR="$REPO_DIR/lib/injection.sh"
VISITOR_DIR="$REPO_DIR/lib/visitor.sh"
MODEL_DIR="$REPO_DIR/lib/model.sh"
ENV_DIR="$REPO_DIR/lib/env.sh"
MENU_DIR="$REPO_DIR/lib/menu.sh"

# --- Sources ---
chmod +x "$STYLE_DIR"
chmod +x "$ENSURE_DIR"
chmod +x "$LOGS_DIR"
chmod +x "$LOGO_DIR"
chmod +x "$INJECTION_DIR"
chmod +x "$VISITOR_DIR"
chmod +x "$MODEL_DIR"
chmod +x "$ENV_DIR"
chmod +x "$MENU_DIR"
source "$STYLE_DIR"
source "$ENSURE_DIR"
source "$LOGS_DIR"
source "$LOGO_DIR"
source "$INJECTION_DIR"
source "$VISITOR_DIR"
source "$MODEL_DIR"
source "$ENV_DIR"
source "$MENU_DIR"
} 
