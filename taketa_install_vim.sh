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
touch ${INI}
chmod -R 777 /home/${USER}/.config/nvim

# Move line up and down with alt + j and k
cat <<EOF >> ${INI}
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
EOF

# Get back to normal mode from insert mode by typing 'jj' or 'kk' or 'hh'
echo "inoremap <silent> jj <ESC>" >>${INI}
echo "inoremap <silent> kk <ESC>" >>${INI}
echo "inoremap <silent> hh <ESC>" >>${INI}

# Return from terminal by ESC
echo "tnoremap <silent> <ESC> <C-\><C-n>" >>${INI}

# Change directory to current directory by typing C-c
echo "nnoremap <C-c> :cd %:p:h<CR>:pwd<CR>" >>${INI}

# Change window by typing 'Ctrl-hjkl'
cat <<EOF >> ${INI}
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
EOF

# Change yanked strings to a word under the cursol
cat <<EOF >> ${INI}
nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> cy   ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cy   c<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
EOF

#
# Set F9 to make run
#
cat <<EOF >> ${INI}
:nmap <F9> :w<CR> :make<CR> :make run<CR>
:nmap <F8> :w<CR> :make<CR> :make debugrun<CR>
EOF

# Useful set commands
cat <<EOF >> ${INI}
set number
set relativenumber
set cursorline
set showmatch
"set autoindent
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
set noswapfile
set clipboard+=unnamedplus
"set termguicolors
set background=dark
set viminfo='10
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
  " mesonic
  "
  call dein#add('igankevich/mesonic')

  "
  " vim-tags
  "
  call dein#add('szw/vim-tags')

  "
  " CSV 
  "
  call dein#add('chrisbra/csv.vim')

  "
  " vim-auto-save
  "
  call dein#add('vim-scripts/vim-auto-save')
  
  "
  " vim-easy-align
  "
  call dein#add('junegunn/vim-easy-align')

  "
  " Enhanced multi-file search for Vim
  "
  call dein#add('wincent/ferret')

  "
  " NERDTree
  "
  call dein#add('scrooloose/nerdtree')

  "
  " vim theme
  "
  call dein#add('jdkanani/vim-material-theme')
  call dein#add('jacoborus/tender.vim')
  "call dein#add('tomasr/colors/molokai.vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  
  "
  " R plugins
  "
  call dein#add('jalvesaq/Nvim-R')
  call dein#add('gaalcaras/ncm-R')
  call dein#add('ncm2/ncm2')
  call dein#add('sirver/UltiSnips')
  call dein#add('ncm2/ncm2-ultisnips')

" taketa ends --------------------------------------------

  call dein#remote_plugins()
  call dein#end()
  call dein#save_state()

endif

"
" MESON 
"
" If there's a `meson.build` file, use meson for linting.
autocmd FileType c call ConsiderMesonForLinting()
function ConsiderMesonForLinting()
    if filereadable('meson.build')
        let g:syntastic_c_checkers = ['meson']
    endif
endfunction

"
" vim-auto-save
"
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification

"
" vim-easy-align
"

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Align Fortran :: symbols
vmap <F2> :s/=/<equal>/ge<CR> :'<,'>s/::/=/g<CR> :'<,'>EasyAlign =<CR> :'<,'>s/=/::/g<CR> :'<,'>s/<equal>/=/ge<CR>

"
" R plugins
"

" remapping the basic :: send line
nmap , <Plug>RDSendLine

" remapping selection :: send multiple lines
vmap , <Plug>RDSendSelection

" remapping selection :: send multiple lines + echo lines
vmap ,e <Plug>RESendSelection

" settings :: Nvim-R plugin
" R output is highlighted with current colorscheme
let g:rout_follow_colorscheme = 1

" R commands in R output are highlighted
let g:Rout_more_colors = 1

"
" vim theme
"
syntax enable
"colorscheme tender 
let g:airline_theme = 'simple'
let g:airline#extensions#tabline#enabled = 1
"let g:molokai_original = 1
"let g:rehash256 = 1

filetype plugin indent on
syntax enable

" Use deoplete.
let g:deoplete#enable_at_startup = 1

"
" NERDTree settings (Ctrl+n to open NERDTree)
"
nnoremap <silent><C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" NERDTress File highlighting
"function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
" exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
" exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
"endfunction
"call NERDTreeHighlightFile('f90',  'yellow',  'none', 'yellow',  '#151515')
"call NERDTreeHighlightFile('mod',  'blue',    'none', '#3366FF', '#151515')
"call NERDTreeHighlightFile('chp',  'yellow',  'none', 'yellow',  '#151515')
"call NERDTreeHighlightFile('o',    'yellow',  'none', 'yellow',  '#151515')
"call NERDTreeHighlightFile('a',    'yellow',  'none', 'yellow',  '#151515')
"call NERDTreeHighlightFile('csv',  'yellow',  'none', 'yellow',  '#151515')
"call NERDTreeHighlightFile('html', 'yellow',  'none', 'yellow',  '#151515')
"call NERDTreeHighlightFile('styl', 'cyan',    'none', 'cyan',    '#151515')
"call NERDTreeHighlightFile('css',  'cyan',    'none', 'cyan',    '#151515')
"call NERDTreeHighlightFile('txt',  'Red',     'none', 'red',     '#151515')
"call NERDTreeHighlightFile('js',   'Red',     'none', '#ffa500', '#151515')
"call NERDTreeHighlightFile('db',   'Magenta', 'none', '#ff00ff', '#151515')
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable  = '+'
let g:NERDTreeDirArrowCollapsible = '▼'
EOF

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
# Turn off paste mode when leaving insert
#
cat <<EOF >>${INI}
autocmd InsertLeave * set nopaste
EOF

cat <<EOF >>${INI}
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction
vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
nnoremap <silent> p :call ClipboardPaste()<cr>p
onoremap <silent> y y:call ClipboardYank()<cr>
onoremap <silent> d d:call ClipboardYank()<cr>
EOF

#
# ctags settings
#
cat <<EOF >>${INI}
let g:vim_tags_auto_generate = 1
let g:vim_tags_project_tags_command = 'ctags -R --fields=+l --tag-relative -f ~/1_Projects/tags --languages=Fortran ~/1_Projects 2>/dev/null'
EOF

#
# Vim editor process (Manual installation)
#

# reboot 
# :call dein#install()
# :call dein#update()
# :checkhealth
# If there is no tags information -> :TagsGenerate!

