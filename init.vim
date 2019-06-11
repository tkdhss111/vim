" Last Updated:2019-06-11 16:15:29. 
" by H. Takeda,  Ph.D.

:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>
inoremap <silent> hh <ESC>
tnoremap <silent> <ESC> <C-\><C-n>
nnoremap <C-c> :cd %:p:h<CR>:pwd<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> cy   ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cy   c<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
:nmap <F1> :q<CR>
:nmap <F3> :make debug<CR>
:nmap <F6> :make release<CR>
:nmap <F4> :make clean_debug<CR> :make debugrun<CR>
:nmap <F5> :make clean_release<CR> :make run<CR>
set autochdir
set number
"set relativenumber
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
  " vim-fugitive and vim-rhubarb
  "
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rhubarb')

  "
  " sudo.vim
  "
  call dein#add('vim-scripts/sudo.vim')

  "
  " Smartchr
  "
  call dein#add('kana/vim-smartchr')
  inoremap <expr> = smartchr#loop(' = ', '=', ' == ')
  inoremap <expr> , smartchr#loop(', ', ',')

  "
  " autodate.vim
  "
  call dein#add('vim-scripts/autodate.vim') 

  "
  " sakhnik/nvim-gdb
  "
  call dein#add('sakhnik/nvim-gdb')

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
" autodate.vim
"
let autodate_keyword_pre  = '\cLast Updated:'
let autodate_keyword_post = '\.'
let autodate_format       = '%Y-%m-%d %H:%M:%S'

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
let NERDTreeQuitOnOpen=1
nnoremap <silent><C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" NERDTress File highlighting
"function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
" exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
" exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'0'
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
autocmd InsertLeave * set nopaste
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
let g:vim_tags_auto_generate = 1
let g:vim_tags_project_tags_command = 'ctags -R --fields=+l --tag-relative -f ~/1_Projects/tags --languages=Fortran ~/1_Projects 2>/dev/null'
