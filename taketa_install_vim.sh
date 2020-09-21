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
#sudo apt install -y neovim neomutt
sudo apt install -y python-dev python-pip python3-dev python3-pip
sudo apt install -y exuberant-ctags
sudo apt install -y xclip
sudo apt install -y ripgrep
#sudo pip2 install --user pynvim
#sudo pip3 install --user pynvim
#sudo export DISPLAY=:0
sudo pip install --upgrade --no-cache-dir pip
sudo pip install --no-cache-dir setuptools
sudo pip install --user --upgrade --no-cache-dir pynvim
sudo pip2 install --user --upgrade --no-cache-dir pynvim
sudo pip3 install --user --upgrade --no-cache-dir pynvim
sudo pip3 --no-cache-dir install -I neovim
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

# ripgrep (NB: install the latest one by manually changing version number
#curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
#dpkg -i ripgrep_0.10.0_amd64.deb && rm ripgrep_0.10.0_amd64.deb

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

#
# Setup configulation files
# /home/$USERNAME/.config/nvim/init.vim
#

# Create init.vim (empty file)
NOW=$(date '+%F_%H:%M:%S')
INI=/home/${USER}/.config/nvim/init.vim

echo ${INI}

if [ -e ${INI} ]; then

  mv ${INI} ${INI}_till${NOW}

else

  mkdir -p /home/${USER}/.config/nvim

fi	

chmod -R 777 /home/${USER}/.config/

ln -s $PWD/init.vim ${INI} 
#ln -s /home/${USER}/vim/init.vim ${INI} 

#
# Neomutt mailer
#
#mkdir -p /home/${USER}/.config/neomutt/
#ln -s /home/${USER}/vim/neomuttrc /home/${USER}/.config/neomutt/neomuttrc

#
# CSV filetype
#
cat <<EOF >> /home/${USER}/.config/nvim/filetype.vim
if exists("did_load_csvfiletype")                                            
  finish
endif
let did_load_csvfiletype=1

augroup filetypedetect
  au! BufRead,BufNewFile *.csv,*.dat  setfiletype csv
augroup END
EOF

#
# Github
#https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

# DEPRECATED
#cat <<EOF > /home/${USER}/.netrc
#machine github.com
#login tkdhss111
#password ********* 
#EOF
#
#chmod -R 777 /home/${USER}/.netrc

#git config --global user.name "tkdhss111"
#git config --global user.email "tkdhss111@gmail.com"
#git config --global web.browser "ff"
#git config --global browser.ff.cmd "open -a Firefox.app"

#
# ssh-agent
#
apt install ssh-askpass -y
#apt install git-gui -y

#ssh-keygen -t rsa -b 4096 -C "tkdhss111@gmail.com"
#stop
#eval "$(ssh-agent -s)" # Start the ssh-agent in the background
#ssh-add ~/.ssh/id_rsa  # Add your SSH private key to the ssh-agent.
#ssh-add -l # Check if the key has been added
#xclip -sel clip < ~/.ssh/id_rsa.pub
#ssh -T git@github.com
## Test
#git push
## If you are asked ID and PW, ssh login does not work properly
## Try the following solutions (adding .git afer the repo name):
## git config remote.origin.url
## git remote set-url origin git@github.com:tkdhss111/[リポジトリ].git
## DO NOT USE : git clone https... 
## BUT USE WHEN SSH: git clone git@github.com:tkdhss111/[リポジトリ].git
cat <<'EOF'>>~/.profile
# ssh-agent
eval `ssh-agent`
ssh-add -t 1w ~/.ssh/id_rsa

# keymap
setxkbmap us -option MYKEYMAP:keymap

EOF

cat <<'EOF'>>~/.bashrc
# ssh-agent
if [ -z "$(pgrep ssh-agent)" ]; then
   rm -rf /tmp/ssh-*
   eval $(ssh-agent -s) > /dev/null
else
   export SSH_AGENT_PID=$(pgrep ssh-agent)
   export SSH_AUTH_SOCK=$(find /tmp/ssh-* -name agent.*)
fi
EOF

#
# Fortran syntax highlighting
#
mkdir -p ~/.vim/after/ftplugin
cat <<EOF> ~/.vim/after/ftplugin/fortran.vim
" \file fortran.vim
if exists("b:did_ftplugin_fortran") | finish | endif
let b:did_ftplugin_fortran = 1

let s:ext = expand("%:e")
let b:fortran_free_source=1

" let fortran_more_precise=1 " より高精度な構文ハイライト。時間がかかる
" let b:fortran_have_tabs=1 " プログラム内でタブ文字を使う

"" 折りたたみ設定
let b:fortran_fold=1 " プログラム、サブルーチン、関数などで折りたたみを定義
let b:fortran_fold_conditionals=1 " doループ、ifブロックなどで折りたたみを定義
let b:fortran_fold_multilinecomments=1 " 3行以上のコメントに折りたたみを定義

"" インデント設定
let b:fortran_do_enddo=1 " do-endoブロックをインデント
" let b:fortran_indent_less=1 " プログラム単位でのインデントを無効化
EOF

#sudo chmod -R 777 /home/${USER}/.config/nvim
