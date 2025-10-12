#!/usr/bin/env bash
set -e

# =====================================================
# Install LuaRocks for Neovim / Lua environment
# Works on Ubuntu, Debian, Fedora, Arch, and macOS
# =====================================================

LUAROCKS_VERSION="3.11.1"
LUAROCKS_URL="https://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz"

echo "📦 Installing LuaRocks ${LUAROCKS_VERSION}..."

# -----------------------------------------------------
# Step 1: Install dependencies
# -----------------------------------------------------
if command -v apt >/dev/null 2>&1; then
    echo "🔧 Installing dependencies via apt..."
    sudo apt update -y
    sudo apt install -y build-essential unzip git curl libreadline-dev lua5.4 liblua5.4-dev
elif command -v dnf >/dev/null 2>&1; then
    echo "🔧 Installing dependencies via dnf..."
    sudo dnf install -y make gcc unzip git readline-devel lua lua-devel
elif command -v pacman >/dev/null 2>&1; then
    echo "🔧 Installing dependencies via pacman..."
    sudo pacman -Sy --needed base-devel lua
elif command -v brew >/dev/null 2>&1; then
    echo "🔧 Installing dependencies via Homebrew..."
    brew install lua
else
    echo "❌ Unsupported package manager. Please install dependencies manually."
    exit 1
fi

# -----------------------------------------------------
# Step 2: Download and extract LuaRocks
# -----------------------------------------------------
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"
echo "⬇️  Downloading LuaRocks..."
curl -fsSL "$LUAROCKS_URL" -o luarocks.tar.gz
tar xzf luarocks.tar.gz
cd "luarocks-${LUAROCKS_VERSION}"

# -----------------------------------------------------
# Step 3: Configure & build
# -----------------------------------------------------
LUA_VERSION=$(lua -v 2>&1 | grep -oE '[0-9]+\.[0-9]+' | head -n1)
PREFIX="/usr/local"

echo "🧠 Detected Lua version: ${LUA_VERSION}"
echo "⚙️  Configuring build for prefix: ${PREFIX}"

./configure \
  --with-lua-include="/usr/include/lua${LUA_VERSION}" \
  --prefix="${PREFIX}"

make -j"$(nproc)"
sudo make install

# -----------------------------------------------------
# Step 4: Verify
# -----------------------------------------------------
if command -v luarocks >/dev/null 2>&1; then
    echo "✅ LuaRocks successfully installed!"
    luarocks --version
else
    echo "❌ Installation failed. Please check the logs."
    exit 1
fi

# -----------------------------------------------------
# Step 5 (Optional): Integrate with Neovim
# -----------------------------------------------------
echo "🔗 To use LuaRocks with Neovim, add this to your init.lua:"
echo ""
echo 'package.path = package.path .. ";" .. os.getenv("HOME") .. "/.luarocks/share/lua/5.4/?.lua"'
echo 'package.cpath = package.cpath .. ";" .. os.getenv("HOME") .. "/.luarocks/lib/lua/5.4/?.so"'
echo ""
echo "🎉 Done!"
