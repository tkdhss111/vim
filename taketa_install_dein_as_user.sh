#========================================================
# Shougo's dein (Vim/Neovim plugin manager) Installer
#
# Run this script as user (non administrative) privilege
#
# @date 2020-07-24. 
#========================================================

# Shougo's dein (Vim/Neovim plugin manager)
sudo apt install curl -y
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein
