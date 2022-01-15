
" Last Updated:2019-07-24 23:09:50
" by H. Takeda, Ph.D.

"
" Japanese entry setup instruction for Windows OS
"
" See URL: http://sifue.hatenablog.com/entry/20120411/1334161078 
" Go to Google Japanese (Windows) or iBus(linux) input 
" and right click 'A' icon in the task bar of windows
" Then select 'property' and press key selection 'Kotorie' 
" and next 'Henshu' botton of 'ippan' tab
" Go to the bottom 'Henshu' botton and add entry, then press all six entries
" with Escape and 'Nolify IME after cancellation' by 'triple' clicking cells.

" Install python2 and 3 using the commands: choco install python2, python3
" and set the following path before dein is used.

" Define OS variable
let s:is_win = has('win32') || has('win64')
let s:is_mac = !s:is_win && (has('mac') || has('macunix') || has('gui_macvim')
            \ || system('uname') =~? '^darwin')
let s:is_linux = !s:is_win && !s:is_mac

let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'

" Windows only:
if s:is_win
  let g:python2_host_prog='C:\Python27'
  let g:python3_host_prog='C:\Python38'
elseif s:is_mac
"pip3 uninstall neovim
"pip3 uninstall pynvim
"pip3 install pynvim
endif

"
" Get back to the last edited line when file is opened.
"
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

silent !setxkbmap -option "ctrl:nocaps"

"
" Move to the beginning and end of the line
"
noremap <C-h> ^
noremap <C-l> $
noremap <C-j> 20j
noremap <C-k> 20k
noremap <Space> i

"
" Move line up and down with alt + j and k
"
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
 
"
" Get back to normal mode from insert mode by typing 'jj' or 'kk' or 'hh'
"
"inoremap <silent> jj <ESC>

"
" Return from terminal by ESC
"
tnoremap <silent> <ESC> <C-\><C-n>

"
" Change directory to current directory by typing C-c
"
nnoremap <C-c> :cd %:p:h<CR>:pwd<CR>

"
" Change window by typing 'Ctrl-hjkl'
"
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l

"
" Change yanked strings to a word under the cursol
"
nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> cy   ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cy   c<C-r>0<ESC>:let@/=@1<CR>:noh<CR>

"
" Set F9 to make run
"
:nnoremap <F1> :make clean<CR>
:nnoremap <F2> :NeoDebug <CR> file ~/gdb/fortran_debug <CR>
:nnoremap <F3> :make debug<CR>
:nnoremap <F6> :make release<CR>
:nnoremap <F4> :make test<CR>
:nnoremap <F5> :make run<CR>
:nnoremap <F9> :sp<CR>
:nnoremap <F11> :vsp<CR>:terminal<CR>i 
:nnoremap <F12> :sp<CR>:terminal<CR>i 

"
" Useful set commands
"
set autochdir
set number
set cursorline
set showmatch
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab
set smarttab
set shiftround
"set ignorecase
"set smartcase
set wrapscan
set incsearch
set inccommand=split
set noswapfile
set clipboard+=unnamedplus
set background=dark
set viminfo='10
"set relativenumber
"set autoindent
"set termguicolors

"
" Shougo's dein
"
if &compatible

  set nocompatible

endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Latex
set runtimepath+=~/latex/ftplugin/tex_quickrun.vim

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
  " (Python) 
  "
  call dein#add('deoplete-plugins/deoplete-jedi')

  "
  " Cmake syntax
  "
  call dein#add('pboettch/vim-cmake-syntax')

  "
  " ALE --Asynchronous Lint Engine-- 
  "
  call dein#add('dense-analysis/ale')

  "
  " vim-syntastic 
  "
  "call dein#add('vim-syntastic/syntastic')

  "
  " Previm
  "
  call dein#add('tyru/open-browser.vim')
  call dein#add('kannokanno/previm')

  "
  " Neodebug
  "
  call dein#add('cpiger/NeoDebug')

  "
  " Latex (vimtex and vim - quickrun)
  "
  call dein#add('lervag/vimtex')
  call dein#add('thinca/vim-quickrun')

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
  "call dein#add('szw/vim-tags')
  call dein#add('soramugi/auto-ctags.vim')

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
" ALE for Fortran linting
"
let g:ale_fortran_gcc_use_free_form = 1
let g:ale_fortran_gcc_executable ='gfortran'
let g:ale_fortran_gcc_options ='-Wall -Wextra -cpp'

"
" Previm
"
let g:previm_open_cmd = ''
let g:previm_enable_realtime = 1

"
" Openbrowser
"
" N.B. @ mark conflicts with macro run
"
"nmap @ <Nop>
"nmap @g <Plug>(openbrowser-search)
"nmap <C-@> <Plug>(openbrowser-smart-search)
"nnoremap @a :<C-u>execute 'OpenBrowserSearch -alc' expand('<cWORD>')<CR>
"nnoremap @d :<C-u>execute 'OpenBrowserSearch -dev' expand('<cWORD>')<CR>
"let g:openbrowser_search_engines = {
"    \ 'alc': 'http://eow.alc.co.jp/{query}/UTF-8/',
"    \ 'dev': 'https://dev.classmethod.jp/?s={query}',
"    \ }

"
" Latex (vimtex and vim - quickrun)
" Install neovim-remote with the command: pip3 install neovim-remote
" use the followings: nvr --remote-silent %f -c %l for SumatraPDF inverse search
if (has('win32') || has('win64') || has('win32unix'))
  let g:vimtex_view_general_viewer = 'C:/02_Tools/PDF/SumatraPDF/SumatraPDF'
  let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
else
  let g:vimtex_compiler_progname = 'nvr'
  let g:vimtex_view_general_viewer = 'okular'
  let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
  "let g:latex_view_general_viewer = 'zathura'
  "let g:vimtex_view_method = 'zathura'
  "let g:vimtex_view_general_options = '--synctex-forward @line:1:@tex @pdf'
  "Add the following to your ~/.config/zathura/zathurarc:
  "set synctex true
  "set synctex-editor-command "nvr --remote-silent +%{line} %{input}"
endif

"let g:tex_flavor = 'latex'
let g:tex_flavor = 'ptex2pdf'
"let g:tex_flavor = 'ptex2pdf -l -ot "-syctex=-1 -interaction=nonstopmode -recorder"'
let g:vimtex_compiler_latexmk = {'build_dir': 'build'}
" Disable overfull/underfull \hbox and all package warnings
augroup filetype
  autocmd!
  " tex file (I always use latex)
  autocmd BufRead,BufNewFile *.tex set filetype=tex
augroup END

"
" NeoDebug
"
set mouse=a
"let g:termdebug_wide = 163

"
" Smartchr
"
"inoremap <expr> = smartchr#loop(' = ', '=', ' == ')
"inoremap <expr> + smartchr#loop(' + ', '+')
"inoremap <expr> - smartchr#loop(' - ', '-', '--')
"inoremap <expr> , smartchr#loop(', ', ',', '')

"
" autodate.vim
" N.B. commas does not work
" Hisashi Takeda Ph.D. []
"let autodate_keyword_pre  = '\cHisashi Takeda Ph.D. ['
let autodate_keyword_pre  = '\c@date '
let autodate_keyword_post = '\.'
let autodate_format       = '%F'
"let autodate_start_line   = -1
let autodate_lines        = 1000
"let autodate_format       = '%0m %d, %Y'
"let autodate_format       = '%F %Ex %x %X %B %Om %d, %Y'

"
" vim-auto-save
"
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification
let g:auto_save_in_insert_mode = 0
" This will run :TagsGenerate after each save
"let g:auto_save_postsave_hook = 'TagsGenerate'
let g:auto_save_no_updatetime = 1

"
" vim-easy-align
"

" Start interactive EasyAlign in visual mode (e.g. vipga)
xnoremap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnoremap ga <Plug>(EasyAlign)

" Align Fortran :: symbols
vnoremap <F2> :s/=/<equal>/ge<CR> :'<,'>s/::/=/g<CR> :'<,'>EasyAlign =<CR> :'<,'>s/=/::/g<CR> :'<,'>s/<equal>/=/ge<CR>

"
" R plugins
"

" remapping the basic :: send line
"nnoremap , <Plug>RDSendLine
nmap , <Plug>RDSendLine

" remapping selection :: send multiple lines
"vnoremap , <Plug>RDSendSelection
vmap , <Plug>RDSendSelection

" remapping selection :: send multiple lines + echo lines
"vnoremap ,e <Plug>RESendSelection
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

"N.B. set full path to bookmarksfile instead of using ~ as home dir
"Auto open bookmarks is slow for some reason
let g:NERDTreeBookmarksFile = '.NERDTreeBookmarks' 
let NERDTreeShowBookmarks=1

"
" Turn off paste mode when leaving insert
"
autocmd InsertLeave * set nopaste

"
" Clipboard
"
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

"
" ctags
"
set tags=./tags;,tags;
let g:auto_ctags = 1
"let g:auto_ctags_directory_list = ['.git']
let g:auto_ctags_tags_name = 'tags'
"let g:auto_ctags_tags_args = ['--tag-relative=yes', '--recurse=yes', '--sort=yes', 'pwd']
let g:auto_ctags_filetype_mode = 1
let g:auto_ctags_set_tags_option = 1
let g:auto_ctags_warn_once = 1
"set exrc
"set secure
"let g:vim_tags_main_file = 'tags'
"let g:vim_tags_auto_generate = 1
let g:vim_tags_project_tags_command = 'ctags -R --exclude=.git --exclude=archives --exclude=old --exclude=build --fields=+l --tag-relative --languages=Fortran `pwd` 2>/dev/null'
"let g:vim_tags_project_tags_command = 'ctags -R --exclude=.git --exclude=archives --exclude=old --exclude=build --fields=+l --tag-relative -f ~/1_Projects/tags --languages=Fortran `pwd` 2>/dev/null'

" 保存時にsudo権限で無理やり保存
cnoremap w! w !sudo tee > /dev/null %<CR> :e!<CR>
