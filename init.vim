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

"
" File Encoding and Formats
"
set encoding=utf-8
set fileencodings=utf-8,cp932 " 文字コードをUTF-8，Shift-JISの順に試す
set fileformats=unix,dos,mac

lang en_US.UTF-8

"
" Font
" For windows, write the followings in ginit.vim
"C:\Users\hss\AppData\Local\nvim\ginit.vim
"Guifont! MyricaM\ M:h14
"set guifont=MyricaM\ M:h14

" Windows only:
if s:is_win
  let g:python2_host_prog='C:\Python27'
  let g:python3_host_prog='~\AppData\Local\Programs\Python\Python310\python.exe'
  set makeprg=make\ -f\ makefile.win
endif

"
" Get back to the last edited line when file is opened.
"
:autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


"
" Move to the beginning and end of the line
"
noremap <C-h> ^
noremap <C-l> $
noremap <C-j> 20j
noremap <C-k> 20k
"noremap <C-j> <C-f>
"noremap <C-k> <C-b>
noremap <Space> i

" *** Japanese input instruction by tkdhss
" Mozc settings - General - keymap style - Kotoeri
" Add new entry in:
" ===================================================
" Mozc keymap editor
" ===================================================
" Mode           Key        Command
" ---------------------------------------------------
" Direct input   Ctrl Space Activate IME
" Direct input   Escape     Cancel and deactivate IME
" Precomposition Escape     Cancel and deactivate IME 
" Composition    Escape     Cancel and deactivate IME 
" Conversion     Escape     Cancel and deactivate IME 
" ===================================================
" Use gnome-tweek to swap Capslock and Ctrl

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
nnoremap <F9> :sp<CR>
nnoremap <F12> :sp<CR>:resize 3<CR>:terminal<CR>i 
nnoremap <F2> :NeoDebug <CR> file ~/gdb/fortran_debug <CR>

if s:is_win
  nnoremap <F1> :w <CR> :AsyncRun make -f makefile.win clean<CR>
  nnoremap <F3> :w <CR> :AsyncRun make -f makefile.win debug<CR>
  nnoremap <F6> :w <CR> :AsyncRun make -f makefile.win release<CR>
  nnoremap <F4> :w <CR> :AsyncRun make -f makefile.win test<CR>
  nnoremap <F5> :w <CR> :AsyncRun make -f makefile.win run<CR>
else
  nnoremap <F1> :w <CR> :AsyncRun make clean<CR>
  nnoremap <F3> :w <CR> :AsyncRun make debug<CR>
  nnoremap <F6> :w <CR> :AsyncRun make release<CR>
  nnoremap <F4> :w <CR> :AsyncRun make test<CR>
  nnoremap <F5> :w <CR> :AsyncRun make run<CR>
  nnoremap <F7> :w <CR> :AsyncRun make showquizho<CR>
  nnoremap <F8> :w <CR> :AsyncRun make showlecho<CR>
endif

"
" Clipboard
"
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction

function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

vnoremap <silent> y y:call ClipboardYank()<CR>
vnoremap <silent> d d:call ClipboardYank()<CR>
nnoremap <silent> p :call ClipboardPaste()<CR>p
onoremap <silent> y y:call ClipboardYank()<CR>
onoremap <silent> d d:call ClipboardYank()<CR>

"
" Useful set commands
"
set number         " 行番号表示
set autochdir      " カレントディレクリに自動設定
set smartindent    " インデント自動挿入
set shiftwidth=2   " smartindentの空白数
set softtabstop=0  " タブで挿入する空白数
set tabstop=2
set clipboard+=unnamedplus    " Vimの無名レジスタとクリップボードを連携
set colorcolumn=74            " 指定するカラムに赤い縦線を表示
set cursorline
set showmatch
set expandtab
set smarttab
set shiftround
"set ignorecase
"set smartcase
set wrapscan
set incsearch
set inccommand=split
"set noswapfile
set viminfo='10
"set background=dark
"set relativenumber
"set autoindent
"set termguicolors

" 挿入モードからEscでノーマルモードにするとき，
" 少し時間がかかる場合に設定
set ttimeoutlen=50

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"
" Plugin Manager
"
Plugin 'VundleVim/Vundle.vim'

"
" Time Stamp
"
Plugin 'vim-scripts/autodate.vim' 

" N.B. commas does not work
let autodate_keyword_pre  = '\c@date '
let autodate_keyword_post = '\.'
let autodate_format       = '%F'
"let autodate_start_line   = -1
let autodate_lines        = 1000
"let autodate_format       = '%0m %d, %Y'
"let autodate_format       = '%F %Ex %x %X %B %Om %d, %Y'

"
" Auto Completion (deoplete and denite)
"

Plugin 'Shougo/deoplete.nvim'
Plugin 'Shougo/denite.nvim'
let g:deoplete#enable_at_startup = 1

if !has('nvim')
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif

"
" Database Tool(vim-dadbod, ui and completion)
"
Plugin 'tpope/vim-dadbod'
Plugin 'kristijanhusak/vim-dadbod-ui'
Plugin 'kristijanhusak/vim-dadbod-completion'

augroup sql
  autocmd!
  "autocmd FileType sql let g:auto_save = 0
  autocmd FileType dbout setlocal nofoldenable
augroup END

let g:dbs = [
      \{"name":"sqlite", "url":"sqlite://var/www/stats.dip.jp/admin/fortran-www.db"},
      \{"name":"admin", "url":"mysql://admin@stats.dip.jp:3306/admin"},
      \{"name":"test", "url":"mysql://hss@stats.dip.jp:3306/test"},
      \{"name":"ba", "url":"mysql://tiu@stats.dip.jp:3306/ba"}
      \]
let g:db_ui_show_database_icon = 1
let g:db_ui_default_query = 'select * from "{table}" limit 10'
let g:db_ui_table_helpers = {
\   'mysql': {
\     'Desc': 'DESC {table}',
\     'Show Create Table': 'SHOW CREATE TABLE {table}',
\     'Show Full Columns From': 'SHOW FULL COLUMNS FROM {table}',
\     'Select Count(*)': 'SELECT COUNT(*) FROM {table}'
\   }
\ }

"
" Ashyncrun 
"
Plugin 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 5

"
" R
"
Plugin 'jalvesaq/Nvim-R'
Plugin 'gaalcaras/ncm-R'
Plugin 'ncm2/ncm2'
Plugin 'sirver/UltiSnips'
Plugin 'ncm2/ncm2-ultisnips'

"
" Python
"
Plugin 'deoplete-plugins/deoplete-jedi'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
Plugin 'jalvesaq/vimcmdline'
augroup py
  autocmd!
  "autocmd BufRead,BufNewFile *.py :execute "normal \\s"<CR>
  autocmd BufRead,BufNewFile *.py :nnoremap <F5> :execute "normal \\f"<CR>
  autocmd BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
  "autocmd! FileType tex nnoremap <ESC> <ESC> <ESC>
  autocmd BufNewFile,BufRead *.py let python_highlight_all=1
  syntax on
augroup END

"
" Linter
"

"" DEPRECATED in favor of ALE
"Plugin 'vim-syntastic/syntastic'
"
"" LatexのALEによる構文エラーチェックのときに抑制したい注意表示を記入
"let g:syntastic_quiet_messages = { "regex": [
"        \ '\mpossible unwanted space at "{"',
"        \ 'SOME OTHER SYNTASTIC MESSAGE TO BE QUIET',
"        \ ] }

Plugin 'dense-analysis/ale'

" エラー箇所をハイライト
let g:ale_set_highlights = 1

" Fortran
let g:ale_fortran_gcc_use_free_form = 1
let g:ale_fortran_gcc_executable ='gfortran'
let g:ale_fortran_gcc_options ='-Wall -Wextra -cpp'

" LaTeX linter choices: chktex(default) or lacheck
"let g:ale_lacheck_executable = 'lacheck'

"
" Cmake Syntax Highlighting
"
Plugin 'pboettch/vim-cmake-syntax'

"
" Markdown Viewer
"
Plugin 'iamcco/markdown-preview.nvim'
let g:mkdp_auto_start = 1

"
" Latex
"
Plugin 'lervag/vimtex'
Plugin 'thinca/vim-quickrun'
set runtimepath+=~/latex/ftplugin/tex_quickrun.vim

"
" Git
"
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'

"
" sudo.vim
"
Plugin 'vim-scripts/sudo.vim'

"
" Smartchr
"
Plugin 'kana/vim-smartchr'

"
" Debagger (sakhnik/nvim-gdb)
"
Plugin 'sakhnik/nvim-gdb'
Plugin 'cpiger/NeoDebug'
set mouse=a
"let g:termdebug_wide = 163

"
" Tags
"
Plugin 'soramugi/auto-ctags.vim'

"
" CSV Viewer
"
Plugin 'chrisbra/csv.vim'

augroup csv
  autocmd!
  autocmd BufRead,BufNewFile *.csv set filetype=csv

  " 自動整列が繰り返し実行されるため自動保存を解除
  autocmd FileType csv let g:auto_save = 0

  " スクロールしてもヘッダーが見えるように画面分割
  autocmd FileType csv nnoremap <F5> :CSVHeaderToggle<CR> 
augroup END

let g:csv_hiHeader = 'Pmenu'
let g:no_csv_maps = 1 " キーマップを解除しないと<S-j>が使えなくなる。
let g:csv_autocmd_arrange	= 1 " 自動整列
let g:csv_autocmd_arrange_size = 1024*1024 " 整列時間節約のため1MB分に限定
let g:csv_start = 1 " 時間短縮のため，この行から
let g:csv_end = 100 " この行までを分析しデリミタを決定
let g:csv_highlight_column = 'y' " カラムを黄色でハイライト
filetype plugin on

"
" Theme
"
Plugin 'NLKNguyen/papercolor-theme'
set t_Co=256
set background=light

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

let g:airline_theme = 'papercolor'

" ヘッダーバー(tabline)を表示
let g:airline#extensions#tabline#enabled = 1

" csv.vimと連携しフッターバーにカラム名とカラム番号/全カラム数を表示
let g:airline#extensions#csv#enabled = 1
let g:airline#extensions#csv#column_display = 'Name'

" ALEによるリント
let g:airline#extensions#ale#enabled = 1

syntax enable

"
" Document Auto-Save
"
Plugin 'vim-scripts/vim-auto-save'

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_in_insert_mode = 1
let g:auto_save_no_updatetime = 0
" Run Ctags command after each save
"let g:auto_save_postsave_hook = 'Ctags'

"
" Word Alignment
"
Plugin 'junegunn/vim-easy-align'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Align Fortran :: symbols
vnoremap <F2> :s/=/<equal>/ge<CR> :'<,'>s/::/=/g<CR> :'<,'>EasyAlign =<CR> :'<,'>s/=/::/g<CR> :'<,'>s/<equal>/=/ge<CR>

"
" Enhanced Multi-File Search
"
Plugin 'wincent/ferret'

"
" File Manager
"
Plugin 'preservim/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'ryanoasis/vim-devicons'

call vundle#end()
filetype plugin indent on

" Declare colorscheme after plugin manager
colorscheme PaperColor

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

" Inverse search for SumatraPDF in Windows
"cmd /c for /F %i in ('type C:\Users\hss\AppData\Local\Temp\vimtexserver.txt') do nvr --servername %i -c 'normal! zzzv' +'%l' '%f'
function! s:write_server_name() abort
  let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/vimtexserver.txt'
  call writefile([v:servername], nvim_server_file)
endfunction

" Edit .latexmkrc
"
"$latex = 'lualatex -interaction=nonstopmode -synctex=-1 -recorder %O %S';
"
let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {'build_dir': 'build'}
" Disable overfull/underfull \hbox and all package warnings
"augroup filetype
augroup tex
  autocmd!
  autocmd BufRead,BufNewFile *.tex set filetype=tex
  "autocmd FileType tex :execute "normal \\ll"
  autocmd FileType tex :nnoremap <C-p> :make default<CR>
  autocmd FileType tex :nnoremap <F9> :sp<CR>:resize 2<CR>:terminal<CR>i auto<CR>
  autocmd FileType tex let g:auto_save = 0
  if (has('win32') || has('win64') || has('win32unix'))
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    autocmd FileType tex call s:write_server_name()
  else
    let g:vimtex_compiler_progname = 'nvr'
    let g:vimtex_view_general_viewer = 'okular'
    let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
  endif
augroup END

"===================================================================
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
let r_syntax_folding = 0
let R_auto_start = 1

augroup r
  autocmd!
  " Run entire sourve by 'Ctrl+a' by hss
  autocmd FileType r nnoremap <F5> :execute "normal \\aa"<Cr>
augroup END

augroup rmd
  autocmd!
  autocmd BufRead,BufNewFile *.Rmd nnoremap <F4> :execute "normal \\kh"<Cr>
augroup END

"" Use markdown-preview instead of using Nvim-R function
"let R_openhtml = 0

"
" Turn off paste mode when leaving insert
"
autocmd InsertLeave * set nopaste

"
" ctags
"
set tags=./tags;,tags;
let g:auto_ctags = 0
"let g:auto_ctags_directory_list = ['.git']
let g:auto_ctags_tags_name = 'tags'
"let g:auto_ctags_tags_args = ['--tag-relative=yes', '--recurse=yes', '--sort=yes', 'pwd']
"let g:auto_ctags_filetype_mode = 1
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

"
" NERDTree settings (Ctrl+n to open NERDTree)
"
nnoremap <silent><C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrows = 1
let NERDTreeShowBookmarks = 1
if s:is_win
  let g:NERDTreeBookmarksFile = 'C:/Users/hss/.NERDTreeBookmarks' 
else
  let g:NERDTreeBookmarksFile = '/home/hss/.NERDTreeBookmarks' 
endif

" change the default dictionary mappings for file extension matches
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tex'] = 'TEX'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['exe'] = 'EXE'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['f90'] = 'F90'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['csv'] = 'CSV'
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['tex'] = s:yellow
let g:NERDTreeExtensionHighlightColor['exe'] = s:lightGreen
let g:NERDTreeExtensionHighlightColor['f90'] = s:blue
let g:NERDTreeExtensionHighlightColor['csv'] = s:beige

" ToDo: not working
"autocmd BufNewFile *.sh put = '#!/usr/bin/bash'

