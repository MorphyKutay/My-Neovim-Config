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

if ! command -v unzip &> /dev/null; then
    echo "Error: unzip command not found" >&2
    exit 1
fi

if ! command -v go &> /dev/null; then
    echo "Error: go command not found" >&2
    exit 1
fi

#echo "--- Nerd Font kurulu mu? ---"; 
fc-list 2>/dev/null | grep -iE "nerd|symbols" | head

#echo "--- sonuç ---"
if fc-list 2>/dev/null | grep -qi nerd; then
    continue
else 
    echo "Nerd Font is Not Found"
    #echo "Do you Want install Nerd Font"
    read -p "Do want install Nerd Font [y/n]: " nerdfont
    if [[ "$nerdfont" == "y" ]];then
        mkdir -p ~/.local/share/fonts/
        cd /tmp
        wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
        unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNerdFont

        fc-cache -fv
    else
        exit 1
    fi
fi

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
