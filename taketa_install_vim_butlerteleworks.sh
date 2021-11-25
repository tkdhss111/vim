#=====================================================
# Vim installation script
#
# Run this script as user (non administrative) privilege
#
# Created by: Hisashi Takeda, Ph.D. 2019-01-26
#=====================================================

USER=ubuntu

#
# Need to purge regular vim installed as default to prevent
# root from using .vimrc
#
sudo apt --purge remove vim

#
# Vim installation
#
sudo apt install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo add-apt-repository ppa:x4121/ripgrep
sudo apt update
sudo apt upgrade -y
sudo apt install neovim -y
sudo apt install -y python-dev python-pip python3-dev python3-pip
sudo apt install -y exuberant-ctags
sudo apt install -y xclip
sudo apt install -y ripgrep
sudo pip install --upgrade --no-cache-dir pip
sudo pip install --no-cache-dir setuptools
sudo pip install --user --upgrade --no-cache-dir pynvim
sudo pip2 install --user --upgrade --no-cache-dir pynvim
sudo pip3 install --user --upgrade --no-cache-dir pynvim
sudo pip3 --no-cache-dir install -I neovim
suod apt install msgpack
which nvim
nvim -v | grep 'NVIM v'
echo 'alias vim=nvim             # added by: '${USER} >> /home/${USER}/.profile
echo 'export TERM=xterm-256color # added by: '${USER} >> /home/${USER}/.profile

# Shougo's dein (Vim/Neovim plugin manager)
sudo apt install curl -y
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein

#
# Add-in packages installation
#

mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start

# repeat.vim
git clone https://tpope.io/vim/repeat.git

# surround.vim
git clone https://tpope.io/vim/surround.git
vim -u NONE -c "helptags surround/doc" -c q

# speeddating.vim
git clone https://tpope.io/vim/speeddating.git
vim -u NONE -c "helptags speeddating/doc" -c q

# NERDtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
echo 'map <C-n> :NERDTreeToggle<CR>' >> ${INI}

# Create init.vim (empty file)
NOW=$(date '+%F_%H:%M:%S')
INI=/home/${USER}/.config/nvim/init.vim

echo ${INI}

if [ -e ${INI} ]; then

  mv ${INI} ${INI}_till${NOW}

else

  mkdir -p /home/${USER}/.config/nvim

fi	

ln -s $PWD/init.vim ${INI} 
