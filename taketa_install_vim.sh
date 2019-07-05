#=====================================================
# Vim installation script
#
#
# Created by: Hisashi Takeda, Ph.D. 2019-01-26
#=====================================================

USER=eric

#
# Need to purge regular vim installed as default to prevent
# root from using .vimrc
#
apt --purge remove vim

#
# Vim installation
#
apt install software-properties-common
add-apt-repository ppa:neovim-ppa/stable
add-apt-repository ppa:x4121/ripgrep
apt update
apt upgrade -y
apt install -y neovim
apt install -y python-dev python-pip python3-dev python3-pip
apt install -y exuberant-ctags
apt install -y xclip
apt install -y ripgrep
#pip2 install --user pynvim
#pip3 install --user pynvim
pip install --upgrade --no-cache-dir pip
pip install --no-cache-dir setuptools
pip install --user --upgrade --no-cache-dir pynvim
pip2 install --user --upgrade --no-cache-dir pynvim
pip3 install --user --upgrade --no-cache-dir pynvim
pip3 --no-cache-dir install -I neovim
which nvim
nvim -v | grep 'NVIM v'
echo 'alias vim=nvim # added by: '${USER} >> /home/${USER}/.profile
echo 'export TERM=xterm-256color # added by: '${USER} >> /home/${USER}/.profile

#
# Add-in packages installation
#

# ripgrep (NB: install the latest one by manually changing version number
#curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
#dpkg -i ripgrep_0.10.0_amd64.deb && rm ripgrep_0.10.0_amd64.deb

# repeat.vim
mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start
git clone https://tpope.io/vim/repeat.git

# surround.vim
mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start
git clone https://tpope.io/vim/surround.git
vim -u NONE -c "helptags surround/doc" -c q

# speeddating.vim
mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start
git clone https://tpope.io/vim/speeddating.git
vim -u NONE -c "helptags speeddating/doc" -c q

# NERDtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
echo 'map <C-n> :NERDTreeToggle<CR>' >> ${INI}

# Shougo's dein (Vim/Neovim plugin manager)
apt install curl -y
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein
chmod -R 777 ~/.cache/dein

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

cp init.vim ${INI} 

chmod -R 777 /home/${USER}/.config/nvim

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
# Github (manual edit the password)
#
cat <<EOF >> /home/${USER}/.netrc
machine github.com
login tkdhss111
password ********* 
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
