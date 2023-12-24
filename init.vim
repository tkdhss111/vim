"年末調整への対応・完了 Last Updated:2019-07-24 23:09:50
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

" Define OS variable
let s:is_win = has('win32') || has('win64')
let s:is_mac = !s:is_win && (has('mac') || has('macunix') || has('gui_macvim')
            \ || system('uname') =~? '^darwin')
let s:is_linux = !s:is_win && !s:is_mac

if s:is_linux
  let g:python_host_prog='/usr/bin/python2'
  let g:python3_host_prog='/usr/bin/python3'
endif

if s:is_win
  " N.B.
  " Install pynvim from the master, or import imp error will occur.
  " pip install git+https://github.com/neovim/pynvim.git
  "let g:python3_host_prog='C:\Users\tkdhs\AppData\Local\Programs\Python\Python312\python.exe'
endif

if s:is_mac
  let g:python3_host_prog='/usr/local/bin/python3'
endif

" 編集後の自動init.vimのリロード
"autocmd! bufwritepost $MYVIMRC source %

"========================================================================
" 文字コードとファイルフォーマット
"
set encoding=utf-8
set fileencodings=utf-8,cp932 " 文字コードをUTF-8，Shift-JISの順に試す
set fileformats=unix,dos,mac
lang en_US.UTF-8

"========================================================================
" フォント
"
" For windows, write the followings in ginit.vim
"C:\Users\hss\AppData\Local\nvim\ginit.vim
"Guifont! MyricaM\ M:h14
"set guifont=MyricaM\ M:h14

if s:is_win
  " In MSYS2 MING64 console
  " $ pacman -S make
  " $ where make
  " Set path in environment variable in Windows
  "set makeprg=make\ -f\ makefile.win
endif

" インサートモードでCtrl+dをDeleteにアサイン
inoremap <C-d> <Del>

" インサートモードでCtrl+fをBackspaceにアサイン
inoremap <C-f> <Backspace>

" インサートモードで移動できるようにする。
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

"
" Get back to the last edited line when file is opened.
"
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

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
"
nnoremap <F12> :sp<CR>:resize 3<CR>:terminal<CR>i

"
" makeの非同期実行のキーマップ
"
"if s:is_win
"  nnoremap <F1> :w <CR> :AsyncRun make -f makefile.win clean<CR>
"  nnoremap <F2> :NeoDebug <CR> file ~/gdb/fortran_debug <CR>
"  nnoremap <F3> :w <CR> :AsyncRun make -f makefile.win debug<CR>
"  nnoremap <F6> :w <CR> :AsyncRun make -f makefile.win release<CR>
"  nnoremap <F4> :w <CR> :AsyncRun make -f makefile.win test<CR>
"  nnoremap <F5> :w <CR> :AsyncRun make -f makefile.win run<CR>
"else
  nnoremap <F1> :w <CR> :AsyncRun make clean<CR>
  nnoremap <F3> :w <CR> :AsyncRun make debug<CR>
  nnoremap <F6> :w <CR> :make -j release<CR>
  "nnoremap <F6> :w <CR> :AsyncRun make release<CR>
  nnoremap <F4> :w <CR> :AsyncRun make test<CR>
  nnoremap <F5> :w <CR> :AsyncRun make run<CR>
"endif

"
" Universal Ctags
"
"tagsではなく./tagsと指定すると、
"カレントディレクトリではなく開いているファイルのディレクトリから
"tagsファイルを探してくれる
";$HOMEとすることで、
"ホームディレクトリまで遡ってtagsファイルを探してくれる
"set tags=./tags;$HOME
set tags=./tags;~
nnoremap <F8> :w <CR> :!touch tags<CR>
      \ :!ctags --recurse=yes --tag-relative=yes --sort=yes
      \ -f tags
      \ --exclude=build
      \ --exclude=old
      \ --exclude=bak
      \ --exclude=.git
      \ --exclude=archive<CR>

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
set noswapfile
set viminfo='10
"set background=dark
"set relativenumber
"set autoindent
"set termguicolors

" 挿入モードからEscでノーマルモードにするとき，
" 少し時間がかかる場合に設定
set ttimeoutlen=50

"
" Turn off paste mode when leaving insert
"
"autocmd InsertLeave * set nopaste

" ToDo: not working
"autocmd BufNewFile *.sh put = '#!/usr/bin/bash'

"------------------------------------------------------------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() " *** プラグインインパッケージはここから下に書く。***

"========================================================================
" Plugin Manager
"
Plugin 'VundleVim/Vundle.vim'


"========================================================================
" Grammar Checker
"
Plugin 'rhysd/vim-grammarous'

let g:grammarous#enable_spell_check=1
let g:grammarous#use_vim_spelllang=1

" Workround for level setting
let g:grammarous#jar_url = 'https://www.languagetool.org/download/LanguageTool-5.9.zip'

Plugin 'gianarb/coc-grammarly'

"========================================================================
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

"========================================================================
" Auto Completion (deoplete and denite)
"

Plugin 'Shougo/deoplete.nvim'
Plugin 'Shougo/denite.nvim'
let g:deoplete#enable_at_startup = 1

if !has('nvim')
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif

"========================================================================
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

"========================================================================
" Ashyncrun
"
Plugin 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 5

"========================================================================
" R
"
Plugin 'hrsh7th/nvim-cmp'
Plugin 'jalvesaq/Nvim-R'
Plugin 'jalvesaq/cmp-nvim-r'
Plugin 'gaalcaras/ncm-R'
Plugin 'ncm2/ncm2'
Plugin 'sirver/UltiSnips'
Plugin 'ncm2/ncm2-ultisnips'

" remapping the basic :: send line
"nnoremap , <Plug>RDSendLine
nmap , <Plug>RDSendLine

" remapping selection :: send multiple lines
"vnoremap , <Plug>RDSendSelection
vmap , <Plug>RDSendSelection

" remapping selection :: send multiple lines + echo lines
"vnoremap ,e <Plug>RESendSelection
vmap ,e <Plug>RESendSelection

"
" settings :: Nvim-R plugin
"
"https://github.com/jamespeapen/Nvim-R/wiki/options
" N.B. 初回nvmcomのコンパイル時に.Rprofileを読み込みコンパイルエラーとなる場合は，
" Documents/.Rprofileをリネームしてからコンパイルする。コンパイル完了後元のファイル名に戻す。
" 以下のパス設定はコンパイルに必要
" C:\Users\%USERNAME%\AppData\Local\R\win-library\*.*\nvimcomにRパッケージライブラリーが追加される。
if s:is_win
  let R_path = 'C:\rtools43\x86_64-w64-mingw32.static.posix\bin;C:\rtools43\usr\bin;C:\Program Files\R\R-4.3.2\bin\x64'
  "let R_path = 'C:\Program Files\R\R-4.3.2\bin\x64'
endif
let R_args = ['--no-save', '--quiet']
let R_start_libs = 'base,stats,graphics,grDevices,utils,methods'
let Rout_more_colors = 1
let R_hi_fun_paren = 1

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

let R_openhtml = 1

"========================================================================
" Python
"
Plugin 'deoplete-plugins/deoplete-jedi'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
Plugin 'jalvesaq/vimcmdline'
augroup py
  autocmd!
  "autocmd filetype python nnoremap <F5> :!python %:p<CR>
  autocmd filetype python nnoremap <F5> :QuickRun python<CR>
  autocmd filetype python vnoremap <F5> :QuickRun python<CR>
  autocmd filetype python nnoremap <C-Enter> :execute 'python' getline('.')<CR>
  "autocmd filetype python nnoremap <C-Enter> :execute 'python' getline('.')<CR> /^.<CR>

  "autocmd BufRead,BufNewFile *.py :execute "normal \\s"<CR>
  "autocmd BufRead,BufNewFile *.py :nnoremap <F5> :execute "normal \\f"<CR>
  "
  autocmd BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
  autocmd BufNewFile,BufRead *.py let python_highlight_all=1
  syntax on

augroup END

"========================================================================
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
let g:ale_lacheck_executable = 'chktex'
let g:ale_tex_chktex_options = "-n 1 36"

" From https://lyz-code.github.io/blue-book/linux/vim/vim_plugins/#ale
let g:ale_sign_error                  = '✘'
let g:ale_sign_warning                = '⚠'
highlight ALEErrorSign ctermbg        =NONE ctermfg=red
highlight ALEWarningSign ctermbg      =NONE ctermfg=yellow
let g:ale_linters_explicit            = 1
let g:ale_lint_on_text_changed        = 'normal'
" let g:ale_lint_on_text_changed        = 'never'
let g:ale_lint_on_enter               = 1
let g:ale_lint_on_save                = 0
let g:ale_fix_on_save                 = 0
"
"Make symlink to /usr/bin/

" create .chktexrc file in home dir to suppress warnings
" https://raw.githubusercontent.com/overleaf/chktex/master/chktexrc
"\  'tex': ['chktex', 'lacheck', 'proselint'],
let g:ale_linters = {
\  'make': ['checkmake'],
\  'tex': ['chktex', 'proselint'],
\  'r': ['lintr', 'styler'],
\  'sh': ['shellcheck'],
\  'vim': ['vimls', 'vint'],
\  'markdown': ['markdownlint', 'writegood', 'alex', 'proselint'],
\  'json': ['jsonlint'],
\  'python': ['flake8', 'mypy', 'pylint', 'alex'],
\  'yaml': ['yamllint', 'alex'],
\   '*': ['alex', 'writegood'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'json': ['jq'],
\   'python': ['isort'],
\   'terraform': ['terraform'],
\}

" Linter for makefile
"autocmd FileType make :nnoremap <F5> :! checkmake makefile<CR>

"========================================================================
" Latex (vimtex and vim - quickrun)
"
Plugin 'lervag/vimtex'
Plugin 'thinca/vim-quickrun'
set runtimepath+=~/latex/ftplugin/tex_quickrun.vim

" Install neovim-remote with the command: pip3 install neovim-remote
" use the followings: nvr --remote-silent +%l '%f' for SumatraPDF inverse search
"
" DEPRECATED in favor of the above
" Inverse search for SumatraPDF in Windows
" N.B. Do not forget to change username!
"cmd /c for /F %i in ('type C:\Users\hss\AppData\Local\Temp\vimtexserver.txt') do nvr --servername %i -c 'normal! zzzv' +'%l' '%f'
"function! s:write_server_name() abort
"  let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/vimtexserver.txt'
"  call writefile([v:servername], nvim_server_file)
"endfunction

" Place this at the header of latex file like !$bash
" %! TeX program = lualatex
" Or edit ~/.latexmkrc
"
let g:vimtex_compiler_latexmk = {
      \ 'build_dir': 'build',
      \ 'background': 1,
      \ 'continuous': 1,
      \ 'options': [
      \    '-pdflatex=lualatex',
      \    '-recorder',
      \    '-shell-escape',
      \    '-verbose',
      \    '-file-line-error',
      \    '-halt-on-error',
      \    '-synctex=-1',
      \    '-interaction=nonstopmode',
      \],
      \}
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_enabled = 2
let g:vimtex_quickfix_autoclose_after_keystrokes = 2
let g:vimtex_quickfix_open_on_warning = 0

let g:vimtex_quickfix_ignore_filters = [
        \ 'Underfull',
        \ 'Overfull',
      \]
" Disable overfull/underfull \hbox and all package warnings
"augroup filetype
augroup tex
  autocmd!
  autocmd BufRead,BufNewFile *.tex set filetype=tex
  "autocmd FileType tex :execute "normal \\ll"
  "autocmd BufRead,BufNewFile lec.tex :VimtexView %:p:h/debug/lecsol-handout.pdf
  "autocmd BufRead,BufNewFile lec.tex :AsyncRun ../../tex/hss_auto/auto
  "autocmd BufRead,BufNewFile quiz.tex :VimtexView %:p:h/debug/quizsol-handout.pdf

  "
  autocmd FileType tex :inoremap <D-h> <Left>
  autocmd FileType tex :inoremap <D-l> <Right>

  if s:is_linux
    " 既存のパス.にLaTeXのパスを追加
    :let $PATH .= ':/usr/local/texlive/2022/bin/x86_64-linux'

    autocmd FileType tex :nnoremap <F4> :w <CR> :AsyncRun make test<CR> :VimtexView %:p:h/debug/quizsol-handout.pdf<CR>
    "autocmd FileType tex :nnoremap <F4> :w <CR> :AsyncRun make test LINE=:echo line('.')<CR> :VimtexView %:p:h/debug/quizsol-handout.pdf<CR>
    autocmd FileType tex :nnoremap <F5> :w <CR> :AsyncRun make run<CR> :VimtexView %:p:h/debug/lecsol-handout.pdf<CR>
  endif

  if s:is_win
    "autocmd FileType tex :nnoremap <F4> :w <CR> :AsyncRun make -f makefile.win test<CR> :VimtexView %:p:h/debug/quizsol-handout.pdf<CR>
    autocmd FileType tex :nnoremap <F4> :w <CR> :AsyncRun make test<CR> :VimtexView %:p:h/debug/quizsol-handout.pdf<CR>
    "autocmd FileType tex :nnoremap <F5> :w <CR> :AsyncRun make -f makefile.win run<CR> :VimtexView %:p:h/debug/lecsol-handout.pdf<CR>
    autocmd FileType tex :nnoremap <F5> :w <CR> :AsyncRun make run<CR> :VimtexView %:p:h/debug/lecsol-handout.pdf<CR>
  endif

  if s:is_mac
    autocmd FileType tex :nnoremap <F2> :w <CR> :AsyncRun make test<CR> :VimtexView %:p:h/debug/quizsol-handout.pdf<CR>
    autocmd FileType tex :nnoremap <F3> :w <CR> :AsyncRun make run<CR> :VimtexView %:p:h/debug/lecsol-handout.pdf<CR>
  endif

  " Escを押し間違えてTabを押しても良いようにTabをEscに割当
  autocmd FileType tex :inoremap <Tab> <Esc>

  "autocmd FileType tex :nnoremap <C-p> :make default<CR>
  "autocmd FileType tex :nnoremap <F9> :sp<CR>:resize 2<CR>:terminal<CR>i auto<CR>

  " N.B. makefileで直にコンパイルしてるので逆順検索は使えない。
  " Vimtexの機能（latexmkを使っている）<leader>lvでコンパイルするできるかも。
  if s:is_win
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    "let g:vimtex_view_general_viewer = 'okular'
    "let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
    "autocmd FileType tex call s:write_server_name()
  endif

  if s:is_linux
    let g:vimtex_compiler_progname = 'nvr'
    " ToDo: get zathura to work!
    "let g:vimtex_view_method = 'zathura'
    "let g:vimtex_view_general_viewer = 'zathura'
    "let g:vimtex_view_general_options = '-x \"nvr +%{line} %{input}\" --synctex-forward=@line:0:@tex @pdf'
    let g:vimtex_view_general_viewer = 'okular'
    let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
  endif

  if s:is_mac
    let g:vimtex_view_general_viewer = 'open -a skim'
    let g:vimtex_view_skim_sync = 1
    let g:vimtex_view_skim_activate = 1
  endif

augroup END

"========================================================================
" Bibtexcite
"
"Plugin 'ferdinandyb/bibtexcite.vim'

"========================================================================
" Debagger (sakhnik/nvim-gdb)
"
Plugin 'sakhnik/nvim-gdb'
Plugin 'cpiger/NeoDebug'
set mouse=a
"let g:termdebug_wide = 163

"========================================================================
" Markdown Viewer
"
Plugin 'iamcco/markdown-preview.nvim'
let g:mkdp_auto_start = 1

"========================================================================
" CSV Viewer
"
Plugin 'chrisbra/csv.vim'

augroup csv
  autocmd!
  autocmd BufRead,BufNewFile *.csv set filetype=csv

  " 自動整列が繰り返し実行されるため自動保存を解除
  "autocmd FileType csv let g:auto_save = 0

  " スクロールしてもヘッダーが見えるように画面分割
  autocmd FileType csv nnoremap <F5> :CSVHeaderToggle<CR>

augroup END

let g:csv_delim=','
let g:csv_hiHeader = 'Pmenu'
let g:no_csv_maps = 1 " キーマップを解除しないと<S-j>が使えなくなる。
let g:csv_autocmd_arrange	= 0 " 自動整列
let g:csv_autocmd_arrange_size = 256*256 " 整列時間節約のため1MB分に限定
let g:csv_highlight_column = 'y' " カラムを黄色でハイライト

"========================================================================
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

"========================================================================
" Document Auto-Save
"
Plugin 'vim-scripts/vim-auto-save'

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_in_insert_mode = 1
let g:auto_save_no_updatetime = 0
let g:auto_save_postsave_hook = 'call SaveBackupFile()'
" 分単位でバックアップファイルを作成する。
function! SaveBackupFile()
  let EXT = expand("%:e")
  if EXT == ''
    let fname = expand("%:r")."_".strftime("%Y-%m-%d_%H%M")
  else
    let fname = expand("%:r")."_".strftime("%Y-%m-%d_%H%M") . ".".expand("%:e")
  endif
  silent execute ":!mkdir bak"
  silent execute ":%w! ./bak/" . fname
  "echo "Saved backup file: ./bak/" . fname
endfunction
"========================================================================
" Word Alignment
"
Plugin 'junegunn/vim-easy-align'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Align Fortran :: symbols
vnoremap <F2> :s/=/<equal>/ge<CR> :'<,'>s/::/=/g<CR> :'<,'>EasyAlign =<CR> :'<,'>s/=/::/g<CR> :'<,'>s/<equal>/=/ge<CR>

"========================================================================
" Tags
"
"Plugin 'soramugi/auto-ctags.vim'
"
"set tags=./tags;,tags;
"let g:auto_ctags_tags_name = 'tags'
"let g:auto_ctags = 0
""let g:auto_ctags_filetype_mode = 1
"let g:auto_ctags_set_tags_option = 1
"let g:auto_ctags_warn_once = 1
"let g:auto_ctags_tags_args = [
"      \'--exclude=build',
"      \'--exclude=old',
"      \'--exclude=bak',
"      \'--exclude=archive',
"      \'--exclude=.git',
"      \'--languages=TeX',
"      \'--tag-relative=yes',
"      \'--recurse=yes',
"      \'--sort=yes',
"      \'pwd']

"========================================================================
" File Manager
"
" Install Nerd-Font first as follows:
" brew tap homebrew/cask-fonts
" brew install font-hack-nerd-font
" Terminal manual setting - Font: Hack Nerd Font
"
" NERDTree settings (Ctrl+n to open NERDTree)
"
Plugin 'preservim/nerdtree'
Plugin 'ryanoasis/vim-devicons'
"Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
"https://ja.stackoverflow.com/questions/29595/vim%E8%B5%B7%E5%8B%95%E3%81%AE%E9%9A%9B-w18-invalid-character-in-group-name-%E3%81%8C%E5%87%BA%E5%8A%9B%E3%81%95%E3%82%8C%E3%82%8B

nnoremap <silent><C-n> :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeQuitOnOpen=1
let NERDTreeShowBookmarks = 1
let g:NERDTreeDirArrows = 1

" DEPRECATED: default path is homepath of windows
"if s:is_win
  "let g:NERDTreeBookmarksFile = '$HOME/.NERDTreeBookmarks'
"endif

if s:is_mac
  let g:NERDTreeBookmarksFile = '/Users/hss/.NERDTreeBookmarks'
endif

if s:is_linux
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

"========================================================================
" その他諸々のプラグイン
"

" Enhanced Multi-File Search
Plugin 'wincent/ferret'
"echo ferret#get_default_arguments('rg')
let g:FerretExecutableArguments = {
  \   'rg': '--vimgrep --no-heading --no-config --max-columns 4096 --glob=!tags --glob=!bak --glob=!old --glob=!build --glob=!archive --glob=!*.html'
  \ }

" sudo.vim
Plugin 'vim-scripts/sudo.vim'
" 保存時にsudo権限で無理やり保存
cnoremap w! w !sudo tee > /dev/null %<CR> :e!<CR>

" Smartchr
Plugin 'kana/vim-smartchr'

" Cmake Syntax Highlighting
Plugin 'pboettch/vim-cmake-syntax'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'

" Parenthesis completion (pear-tree)
"Plugin 'tmsvg/pear-tree'

call vundle#end() " *** プラグインインパッケージはここから上に書く。***

filetype plugin on
filetype plugin indent on

" 画面配色スキームはプラグインマネジャーの後(vundle#end()の後)で宣言する。
colorscheme PaperColor

"========================================================================
" 日本語入力（IME）設定
"
" 文書作成時に挿入モードに移ると自動でIMEを起動する設定で，
" 日本語で長い文書を作成するときに便利。
" Escを１回押すと英語入力，もう一度押すと標準モードになる。
"
"【事前準備】
" 1. 仮想キーボードxvkbdのコマンドラインでのキー送信機能を利用して
"    IMEを起動/停止するので予めインストールしておく。
"   （xvkbdはX Window（Linux）向けのアプリでMS-Windows版は無いようである）
"
" 2. Mozc SetupのKeymapでKotoeriのキーマップを次のようにカスタマイズしておく。
"    こうすることでControl+SpaceでIMEを起動，EscapeでIMEを停止することができる。
"   （竹田は全角/半角キーをEscにしているのでこのようにカスタマイズ）
"
"      「Activate IME」       →  Ctrl Space
"      「Deactivate IME」全て →  Escpape

"       Mozc settings - General - keymap style - Kotoeri
"       ===================================================
"       Mozc keymap editor
"       ===================================================
"       Mode           Key        Command
"       ---------------------------------------------------
"       Direct input   Ctrl Space Activate IME
"       Precomposition Escape     Deactivate IME
"       Composition    Escape     Deactivate IME
"       Conversion     Escape     Deactivate IME
"       ===================================================
"       Use gnome-tweek to swap Capslock and Ctrl
"
"【注意事項】
" 挿入モードでIME起動中のときにEscを押すとvimコマンドより先に
" IMEのIMEDeactivateが起動しIMEが停止し英語入力になる。
" 当初Esc１回で標準モードに移るようにしようと考えたが難しかった。
" LaTeXの文書作成では英語 ↔ 日本語の切り替えが頻繁であるため，
" むしろこのままの方が良い。
"
" 拡張子がtex, txt, mdのときにIMEを自動で起動させる。
" ファイルの種類を増やしたいときは，カンマでスペースなしで区切り追加すること。

"if s:is_linux
"  autocmd InsertEnter *.tex,*.txt,*.md
"        \ call system('xvkbd -text "\[Control]\[space]" >/dev/null 2>&1')
"endif

"function QfMakeConv()
"    let qflist = getqflist()
"    for i in qflist
"        let i.text = iconv(i.text, "cp936", "utf-8")
"    endfor
"    call setqflist(qflist)
"  endfunction
"
"au QuickfixCmdPost make call QfMakeConv()
