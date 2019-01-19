"dein Scripts-----------------------------
if &compatible
set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=/home/eric/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('/home/eric/.cache/dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
  
" takeda ============================================================
set number
set cursorline
set showmatch
set autoindent
set smartindent
set shiftwidth=2
set expandtab
set tabstop=2

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

"call dein#add('chrisbra/csv.vim')
call dein#add('junegunn/vim-easy-align')
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nmap <F2> gaip*<Right>,

call dein#add('Shougo/deoplete.nvim')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif
let g:deoplete#enable_at_startup = 1  
" takeda ============================================================

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

"If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
