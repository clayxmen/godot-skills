#!/usr/bin/env bash
# Universal One-Liner Installer for Godot Skills Suite (Linux / macOS)
# Usage:
#   ./install.sh                     # Init current project
#   ./install.sh --target /path/to   # Init target project
#   ./install.sh --global            # Install globally for all projects

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLI_SCRIPT="$SCRIPT_DIR/tools/godot_skills_cli.py"

echo -e "\n\033[1;36m🎮 ==========================================================="
echo -e "   GODOT SKILLS SUITE (GODOT 4.3+) - UNIVERSAL INSTALLER"
echo -e "===========================================================\033[0m\n"

PYTHON_BIN=""
if command -v python3 &>/dev/null; then
    PYTHON_BIN="python3"
elif command -v python &>/dev/null; then
    PYTHON_BIN="python"
fi

if [ -z "$PYTHON_BIN" ]; then
    echo -e "\033[1;31m[!] Python 3 is required to run the installer. Please install python3.\033[0m"
    exit 1
fi

"$PYTHON_BIN" "$CLI_SCRIPT" "$@"

echo -e "\033[1;32m✨ Installation completed successfully!\033[0m\n"
