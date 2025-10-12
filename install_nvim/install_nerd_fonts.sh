#!/usr/bin/env bash
set -e

# ============================================================
# 🧠 Install Nerd Fonts system-wide for Neovim / Terminal
# Works on Ubuntu — Run with: sudo sh ./install_nerd_fonts.sh
# ============================================================

# Fonts to install (edit or pass as args)
FONTS=("$@")
if [ ${#FONTS[@]} -eq 0 ]; then
  FONTS=("FiraCode" "JetBrainsMono" "Hack")
fi

# System-wide font directory
FONT_DIR="/usr/share/fonts/nerd-fonts"

echo "🧩 Installing Nerd Fonts: ${FONTS[*]}"
echo "📁 Target directory: $FONT_DIR"

# ------------------------------------------------------------
# Step 1: Ensure dependencies
# ------------------------------------------------------------
for pkg in curl unzip; do
  if ! command -v "$pkg" >/dev/null 2>&1; then
    echo "🔧 Installing dependency: $pkg"
    apt update && apt install -y "$pkg"
  fi
done

mkdir -p "$FONT_DIR"

# ------------------------------------------------------------
# Step 2: Fetch the latest Nerd Fonts release info
# ------------------------------------------------------------
LATEST_URL="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"
echo "🌐 Fetching latest Nerd Fonts release info..."
RELEASE_DATA=$(curl -s "$LATEST_URL")

# ------------------------------------------------------------
# Step 3: Install each font
# ------------------------------------------------------------
for FONT_NAME in "${FONTS[@]}"; do
  echo ""
  echo "➡️  Processing font: $FONT_NAME"

  ZIP_URL=$(echo "$RELEASE_DATA" | grep "browser_download_url" | grep "$FONT_NAME" | grep ".zip" | cut -d '"' -f 4 | head -n 1)

  if [ -z "$ZIP_URL" ]; then
    echo "❌ Could not find a Nerd Font named '$FONT_NAME'."
    echo "   → See available fonts: https://www.nerdfonts.com/font-downloads"
    continue
  fi

  TMP_DIR=$(mktemp -d)
  cd "$TMP_DIR"

  echo "⬇️  Downloading $FONT_NAME Nerd Font..."
  curl -L -o "${FONT_NAME}.zip" "$ZIP_URL"

  echo "📂 Extracting fonts to $FONT_DIR ..."
  unzip -oq "${FONT_NAME}.zip" -d "$FONT_DIR"

  cd /
  rm -rf "$TMP_DIR"

  echo "✅ Installed: $FONT_NAME Nerd Font"
done

# ------------------------------------------------------------
# Step 4: Refresh font cache
# ------------------------------------------------------------
if command -v fc-cache >/dev/null 2>&1; then
  echo ""
  echo "🔄 Refreshing system font cache..."
  fc-cache -fv >/dev/null
else
  echo "⚠️  'fc-cache' not found. Install it via 'sudo apt install fontconfig'."
fi

# ------------------------------------------------------------
# Step 5: Completion message
# ------------------------------------------------------------
echo ""
echo "🎉 All done!"
echo "💡 You can now set your terminal or Neovim font to:"
for FONT_NAME in "${FONTS[@]}"; do
  echo "   → ${FONT_NAME} Nerd Font"
done
echo ""
echo "To verify installation:"
echo "   fc-list | grep 'Nerd Font'"
