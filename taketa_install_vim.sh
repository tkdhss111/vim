#=====================================================
# Vim installation script
#
# (Instruction)
# Install with username (-u USER)
# sudo -u USER sh ./taketa_vim_installer.sh
#
# Created by: Hisashi Takeda, Ph.D. 2019-01-26
#=====================================================

USER=eric

#
# Vim installation
#
apt install software-properties-common
#add-apt-repository ppa:neovim-ppa/unstable
apt update -y
apt install python-dev python-pip python3 python3-dev python3-pip
pip3 install --user pynvim
pip3 install --user --upgrade pynvim
pip3 install neovim
which nvim
nvim -v | grep 'NVIM v'
echo 'alias vim=nvim # added by: '${USER} >> /home/${USER}/.bashrc

#
# Add-in packages installation
#

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
touch ${INI}

# Move line up and down with alt + j and k
cat <<EOF >> ${INI}
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
EOF

# Get back to normal mode from insert mode by typing 'jj' and :w
echo "inoremap <silent> jj <ESC>:<C-u>w<CR>" >>${INI}

# Change window by typing 'Ctrl-hjkl'
cat <<EOF >> ${INI}
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
EOF

# Useful set commands
cat <<EOF >> ${INI}
set number
set relativenumber
set cursorline
set showmatch
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab
set smarttab
set shiftround
set ignorecase
set smartcase
set wrapscan
set incsearch
set inccommand=split
EOF

# Shougo's dein
cat <<EOF >> ${INI}
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/denite.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

" taketa begin -------------------------------------------
  "
  " vim-easy-align
  "
  call dein#add('junegunn/vim-easy-align')
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
  nmap <F2> gaip*<Right>,

  "
  " vim theme
  "
  call dein#add('jdkanani/vim-material-theme')
  call dein#add('jacoborus/tender.vim')
  "call dein#add('tomasr/colors/molokai.vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  syntax enable
  set termguicolors
  set background=dark
  "colorscheme tender 
  let g:airline_theme = 'simple'
  let g:airline#extensions#tabline#enabled = 1
  "let g:molokai_original = 1
  "let g:rehash256 = 1
  call dein#remote_plugins()
" taketa ends --------------------------------------------

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" Use deoplete.
let g:deoplete#enable_at_startup = 1
EOF

#
# Vim editor process (Manual installation)
#

# dein
# :call dein#install()
# :checkhealth
