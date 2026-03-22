#!/bin/bash
# My-Neovim-Config installation script
# Creates ~/.config/nvim directory and init.lua if they don't exist

set -e

CONFIG_DIR="$HOME/.config/nvim"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INIT_SRC="$SCRIPT_DIR/init.lua"
INIT_DEST="$CONFIG_DIR/init.lua"

echo "My-Neovim-Config Installation"
echo "============================="

# Create config directory (if it doesn't exist)
if [ ! -d "$CONFIG_DIR" ]; then
    echo "Creating: $CONFIG_DIR"
    mkdir -p "$CONFIG_DIR"
else
    echo "Directory exists: $CONFIG_DIR"
fi

# Backup init.lua (if it exists)
if [ -f "$INIT_DEST" ]; then
    BACKUP="$INIT_DEST.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Backing up: $INIT_DEST -> $BACKUP"
    cp "$INIT_DEST" "$BACKUP"
fi

# Copy init.lua
echo "Copying: $INIT_SRC -> $INIT_DEST"
cp "$INIT_SRC" "$INIT_DEST"

echo ""
echo "Installation complete!"
echo "Open Neovim and run :Lazy sync to install plugins."
