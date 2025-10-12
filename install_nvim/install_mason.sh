#!/usr/bin/env bash
set -e

# =====================================================
# Install or update mason.nvim for Neovim
# Compatible with Linux and macOS
# =====================================================

# GitHub repo URL
REPO_URL="https://github.com/williamboman/mason.nvim.git"

# Detect Neovim data directory
NVIM_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
PACK_DIR="$NVIM_DATA_DIR/site/pack/packer/start"

# Create directory if it doesn't exist
mkdir -p "$PACK_DIR"

# Target plugin path
PLUGIN_DIR="$PACK_DIR/mason.nvim"

echo "📦 Installing or updating mason.nvim..."

if [ -d "$PLUGIN_DIR/.git" ]; then
    echo "🔄 Updating existing mason.nvim installation..."
    git -C "$PLUGIN_DIR" pull --ff-only
else
    echo "⬇️  Cloning mason.nvim repository..."
    git clone --depth 1 "$REPO_URL" "$PLUGIN_DIR"
fi

# Optional: Install dependencies if 'mason' command is missing
if ! command -v nvim >/dev/null 2>&1; then
    echo "⚠️  Neovim not found. Please install Neovim first:"
    echo "    https://github.com/neovim/neovim/wiki/Installing-Neovim"
    exit 1
fi

# Verify installation
if nvim --headless "+helptags ALL" +qall >/dev/null 2>&1; then
    echo "✅ mason.nvim successfully installed or updated!"
else
    echo "⚠️  mason.nvim installed, but help tags could not be generated."
fi
