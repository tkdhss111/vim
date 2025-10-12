#!/bin/bash

# Script to install the latest version of pynvim for Neovim

set -e

echo "🔍 Checking for Python 3..."
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 not found. Installing..."
    sudo apt update
    sudo apt install -y python3
fi

echo "📦 Checking for pip3..."
if ! command -v pip3 &> /dev/null; then
    echo "❌ pip3 not found. Installing..."
    sudo apt install -y python3-pip
fi

echo "🐍 Ensuring pip and setuptools are up to date..."
pip3 install --user --upgrade pip setuptools wheel

echo "📦 Installing/Upgrading pynvim for user Python environment..."
pip3 install --user --upgrade pynvim

echo "✅ pynvim installed successfully!"

echo "🔁 Checking Neovim Python integration..."
if command -v nvim &> /dev/null; then
    echo "📦 Installed Python plugins for Neovim:"
    nvim --headless +'echo has("python3") ? "✅ Python3 support is available" : "❌ Python3 support is missing"' +qa
else
    echo "⚠️ Neovim not found. Skipping Neovim check."
fi

echo "🎉 Done!"
