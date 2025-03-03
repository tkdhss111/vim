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

" Set the latest Python here, DO NOT UPGRADE Ubuntu default Python in /bin
if s:is_linux
  "let g:python3_host_prog='/usr/local/bin/python3.12'
  let g:python3_host_prog='/opt/python/3.12.1/bin/python3'

  " Default shell is sh, which can not use 'source' commmand.
  set makeprg=make\ SHELL=/bin/bash
endif

if s:is_win
  " N.B.
  " Install pynvim from the master, or import imp error will occur.
  " pip install git+https://github.com/neovim/pynvim.git
  "let g:python3_host_prog='C:\Users\tkdhs\AppData\Local\Programs\Python\Python312\python.exe'
  let g:python3_host_prog='C:\Python312\python'
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

" インサートモードでCtrl+lをDeleteにアサイン
inoremap <C-l> <Del>

" インサートモードでCtrl+hをBackspaceにアサイン
inoremap <C-h> <Backspace>

" インサートモードで左右移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
"inoremap <C-h> <Left> DEPRECATED: use muhenkan key
"inoremap <C-l> <Right> DEPRECATED: use henkan key

"
" Get back to the last edited line when file is opened.
"
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"
" Move to the beginning and end of the line
"
noremap <C-g> ^
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

let basename = expand('%:t:r')

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
"
"  nnoremap <F1> :w <CR> :AsyncRun make clean<CR>
"  nnoremap <F3> :w <CR> :AsyncRun make debug<CR>
"  nnoremap <F6> :w <CR> :make -j release<CR>
"  nnoremap <F6> :w <CR> :AsyncRun make release<CR>
"  nnoremap <F4> :w <CR> :AsyncRun make test<CR>
"  nnoremap <F5> :w <CR> :AsyncRun make run<CR>
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
"set colorcolumn=101           " 指定するカラムに赤い縦線を表示
"set cursorline
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
"set nocompatible
"filetype off
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin() " *** プラグインインパッケージはここから下に書く。***
call plug#begin('~/.vim/plugins/') " *** プラグインインパッケージはここから下に書く。***

"========================================================================
" Plugin Manager
"
"Plug 'VundleVim/Vundle.vim'

"========================================================================
" Grammar Checker
"
Plug 'rhysd/vim-grammarous'

let g:grammarous#enable_spell_check=1
let g:grammarous#use_vim_spelllang=1

" Workround for level setting
let g:grammarous#jar_url = 'https://www.languagetool.org/download/LanguageTool-5.9.zip'

Plug 'gianarb/coc-grammarly'

"========================================================================
" Time Stamp
"
Plug 'vim-scripts/autodate.vim'

" N.B. commas does not work
let autodate_keyword_pre  = '\c@date '
let autodate_keyword_post = '\.'
let autodate_format       = '%F'
"let autodate_start_line   = -1
let autodate_lines        = 1000
"let autodate_format       = '%0m %d, %Y'
"let autodate_format       = '%F %Ex %x %X %B %Om %d, %Y'

"========================================================================
" Github Copilot
"
Plug 'github/copilot.vim'

"========================================================================
" Auto Completion (deoplete and denite)
"
Plug 'roxma/vim-hug-neovim-rpc'

"========================================================================
" Parentheses
"
Plug 'tpope/vim-surround'

"========================================================================
" Database Tool(vim-dadbod, ui and completion)
"
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'

augroup sql
  autocmd!
  autocmd FileType sql let g:auto_save = 0
  autocmd FileType dbout setlocal nofoldenable
augroup END
let g:dbs = [
      \{"name":"load", "url":"sqlite:/mnt/DATA/load/load.db"},
      \{"name":"admin", "url":"mysql://admin@stats.dip.jp:3306/admin"},
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
let g:db_ui_auto_execute_table_helpers = 1

"========================================================================
" Ashyncrun
"
Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 10

"========================================================================
" R
"
Plug 'jalvesaq/Nvim-R'
Plug 'jalvesaq/cmp-nvim-r'
Plug 'gaalcaras/ncm-R'
Plug 'ncm2/ncm2'
Plug 'sirver/UltiSnips'
Plug 'ncm2/ncm2-ultisnips'
Plug 'hrsh7th/nvim-cmp'
Plug 'tree-sitter/tree-sitter' "sudo npm install -g tree-sitter-cli
Plug 'nvim-treesitter/nvim-treesitter'
"Plug 'R-nvim/cmp-r'
"Plug 'R-nvim/R.nvim'

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
  let R_path = 'C:\rtools43\x86_64-w64-mingw32.static.posix\bin;C:\rtools43\usr\bin;C:\Program Files\R\R-4.4.0\bin\x64'
  "let R_path = 'C:\Program Files\R\R-4.3.2\bin\x64'
endif
let R_args = ['--no-save', '--quiet']
let R_start_libs = 'base,stats,graphics,grDevices,utils,methods'
let Rout_more_colors = 1
let R_hi_fun_paren = 1
let R_pdfviewer = 'okular'
" R output is highlighted with current colorscheme
let g:rout_follow_colorscheme = 1

" R commands in R output are highlighted
let g:Rout_more_colors = 1
let r_syntax_folding = 0
let R_auto_start = 0

augroup r
  autocmd!
  autocmd FileType r nnoremap <F5> :execute "normal \\aa"<Cr>
  autocmd FileType r let g:lsp_diagnostics_enabled = 0
  autocmd FileType R let g:lsp_diagnostics_enabled = 0
  autocmd FileType Rmd let g:lsp_diagnostics_enabled = 0
augroup END

augroup rmd
  autocmd!
  autocmd BufRead,BufNewFile *.Rmd nnoremap <F4> :execute "normal \\kh"<Cr>
augroup END

let R_openhtml = 1

"========================================================================
" Debugger
"
"Plug 'puremourning/vimspector'
"
"" Neovim does not have winber capability
"let g:vimspector_enable_winbar=0
"
"let g:vimspector_sidebar_width = 20
"let g:vimspector_bottombar_height = 5
"let g:vimspector_code_minwidth = 90
"let g:vimspector_terminal_maxwidth = 100
"let g:vimspector_terminal_minwidth = 20
"
""let g:vimspector_enable_mappings = 'HUMAN'
"
"augroup python
"  autocmd!
"  autocmd FileType py :nonremap <F5> <Plug>VimspectorContinue
"  autocmd FileType py :nonremap <F9> <Plug>VimspectorToggleBreakpoint
"  autocmd FileType py :nonremap <F4> <Plug>VimspectorRestart
"  autocmd FileType py :nonremap <F3> <Plug>VimspectorStop
"  autocmd FileType py :nonremap <Leader><F8> <Plug>VimspectorRunToCursor
"  autocmd FileType py :nonremap <F10> <Plug>VimspectorStepOver
"  autocmd FileType py :nonremap <F11> <Plug>VimspectorStepInto
"  autocmd FileType py :nonremap <F12> <Plug>VimspectorStepOut
"augroup END

"":nmap <F5> <Plug>VimspectorContinue
"":nmap <F9> <Plug>VimspectorToggleBreakpoint
"":nmap <F4> <Plug>VimspectorRestart
"":nmap <F3> <Plug>VimspectorStop
"":nmap <Leader><F8> <Plug>VimspectorRunToCursor
"":nmap <F10> <Plug>VimspectorStepOver
"":nmap <F11> <Plug>VimspectorStepInto
"":nmap <F12> <Plug>VimspectorStepOut
"
"" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)
"
"" for normal mode - the word under the cursor
"nmap <Leader>di <Plug>VimspectorBalloonEval
"" for visual mode, the visually selected text
"xmap <Leader>di <Plug>VimspectorBalloonEval
"
"" Use F9 to toggle break point
"nmap <Leader>db <Plug>VimspectorBreakpoints
"
"nmap <LocalLeader><F11> <Plug>VimspectorUpFrame
"nmap <LocalLeader><F12> <Plug>VimspectorDownFrame
"nmap <LocalLeader>B     <Plug>VimspectorBreakpoints
"nmap <LocalLeader>D     <Plug>VimspectorDisassemble

"========================================================================
" Auto Completion 
"
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"========================================================================
" Language Server Protocol (LSP)
"
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-lsp-icons'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

"let g:lsp_log_file = 'lsp.log'
"let g:lsp_log_verbose = 1

highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green

if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

if executable('fortls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'fortls',
        \ 'cmd': {server_info->['fortls']},
        \ 'allowlist': ['fortran'],
        \ })
endif

let g:lsp_settings = {
\   'pylsp-all': {
\     'workspace_config': {
\       'pylsp': {
\         'plugins': {
\           'pycodestyle': {
\             'ignore': ["E221", "E501"]
\           }
\         }
\       }
\     }
\   },
\}

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
   " nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

" URL: https://mattn.kaoriya.net/software/vim/20191231213507.htm
augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
"let g:lsp_document_highlight_enabled = 0
"let g:lsp_diagnostics_echo_cursor = 1
"let g:lsp_diagnostics_enabled = 0
"let g:asyncomplete_auto_popup = 1
"let g:asyncomplete_auto_completeopt = 0
"let g:asyncomplete_popup_delay = 500
"let g:lsp_text_edit_enabled = 1
"========================================================================
" Python
"
"Plug 'deoplete-plugins/deoplete-jedi'
"Plug 'vim-scripts/indentpython.vim'
"Plug 'nvie/vim-flake8'

Plug 'jalvesaq/vimcmdline'

augroup python
  autocmd!
  autocmd BufRead,BufNewFile *.py set filetype=python
  let cmdline_follow_colorscheme = 1
  let cmdline_vsplit = 0
  let cmdline_term_height = 15
  let cmdline_term_width = 90
  let cmdline_app = {}
  let cmdline_app['python'] = 'python3'
  let cmdline_map_send = ','
augroup END

"========================================================================
" Fortran
"

augroup fortran
  autocmd!
  autocmd BufRead,BufNewFile *.f90 set filetype=fortran
  autocmd BufRead,BufNewFile *.f90 set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab conceallevel=1
  "autocmd BufRead,BufNewFile *.f90 syntax match FortranConceal '%' conceal cchar=%
  autocmd BufRead,BufNewFile *.f90 syntax match FortranConceal '%' conceal cchar=.
  "autocmd BufRead,BufNewFile *.f90 syntax match FortranConceal '%' conceal cchar=→
  "autocmd BufRead,BufNewFile *.f90 syntax match FortranConceal '%' conceal cchar=∙
  autocmd BufRead,BufNewFile *.f90 hi! link Conceal Operator
  autocmd BufRead,BufNewFile *.f90 setlocal conceallevel=1
  autocmd BufRead,BufNewFile *.f90 setlocal concealcursor=n
  autocmd FileType fortran let g:lsp_diagnostics_enabled = 1
  autocmd FileType fortran inoremap ,, %
  autocmd FileType fortran nnoremap <F1> :AsyncStop<CR> :cclose<CR> 
  autocmd FileType fortran nnoremap <F3> :w<CR> :AsyncRun make debug<CR>
  "autocmd FileType fortran nnoremap <F4> :w<CR> :AsyncRun make test<CR>
  autocmd FileType fortran nnoremap <F4> :w<CR> :make test<CR>
  autocmd FileType fortran nnoremap <F5> :w<CR> :AsyncRun make run<CR>
  autocmd FileType fortran nnoremap <F6> :w<CR> :AsyncRun make relwithdebinfo<CR>
  "nnoremap <F12> :sp<CR>:resize 10<CR>:terminal<CR>i gdb-oneapi --quiet<CR>
  "nnoremap <F12> :vsp<CR>:terminal<CR>i gdb-oneapi --quiet<CR>
  "nnoremap <F12> :vsp<CR>:terminal<CR>i
  nnoremap <F12> :sp<CR>:terminal<CR>

  let g:lsp_diagnostics_echo_cursor = 1
  let g:lsp_diagnostics_enabled = 1
  let g:asyncomplete_auto_popup = 1
  let g:asyncomplete_auto_completeopt = 1
  let g:asyncomplete_popup_delay = 500
  let g:lsp_text_edit_enabled = 1
augroup END

"========================================================================
" Latex (vimtex and vim - quickrun)
"
Plug 'lervag/vimtex'
Plug 'thinca/vim-quickrun'
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
      \    '-synctex=1',
      \    '-interaction=nonstopmode',
      \    '-output-directory="build"',
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
  "autocmd BufRead,BufNewFile quiz.tex :VimtexView %:p:h/debug/quizsol-handout.pdf
  "autocmd BufRead,BufNewFile lec.tex :AsyncRun ../../tex/hss_auto/auto

  "
  autocmd FileType tex :inoremap <D-h> <Left>
  autocmd FileType tex :inoremap <D-l> <Right>

  if s:is_linux
    " 既存のパス.にLaTeXのパスを追加
    :let $PATH .= ':/usr/local/texlive/2024/bin/x86_64-linux'
    autocmd FileType tex :nnoremap <F3> :w <CR> :AsyncRun make test<CR>
    "autocmd FileType tex :nnoremap <F4> :w <CR> :AsyncRun make test LINE=:echo line('.')<CR> :VimtexView %:p:h/debug/quizsol-handout.pdf<CR>
    autocmd FileType tex :nnoremap <F4> :w <CR> :AsyncRun make run<CR>
    autocmd FileType tex :nnoremap <F5> :w <CR> :AsyncRun make -j release<CR>
    autocmd FileType tex :nnoremap <F8> :VimtexView %:p:h/debug/quizsol-handout.pdf<CR>
    autocmd FileType tex :nnoremap <F9> :VimtexView %:p:h/debug/lecsol-handout.pdf<CR>
  endif

  if s:is_win
    "autocmd FileType tex :nnoremap <F4> :w <CR> :AsyncRun make -f makefile.win test<CR> :VimtexView %:p:h/debug/quizsol-handout.pdf<CR>
    autocmd FileType tex :nnoremap <F4> :w <CR> :AsyncRun make test<CR> :VimtexView %:p:h/debug/quizsol-handout.pdf<CR>
    "autocmd FileType tex :nnoremap <F5> :w <CR> :AsyncRun make -f makefile.win run<CR> :VimtexView %:p:h/debug/lecsol-handout.pdf<CR>
    autocmd FileType tex :nnoremap <F5> :w <CR> :AsyncRun make run<CR> :VimtexView %:p:h/debug/lecsol-handout.pdf<CR>
    autocmd FileType tex :nnoremap <F6> :w <CR> :AsyncRun make -j release<CR>
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
    let g:vimtex_compiler_progname = 'nvr'
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

  let g:auto_save = 1
  let g:auto_save_silent = 1
  let g:auto_save_in_insert_mode = 1

augroup END

"========================================================================
" Bibtexcite
"
"Plug 'ferdinandyb/bibtexcite.vim'

"========================================================================
" Debagger (sakhnik/nvim-gdb)
"
Plug 'sakhnik/nvim-gdb'
Plug 'cpiger/NeoDebug'
set mouse=a
"let g:termdebug_wide = 163

"========================================================================
" Markdown Viewer
"
  Plug 'quarto-dev/quarto-nvim'
  Plug 'jmbuhr/otter.nvim'
  Plug 'neovim/nvim-lspconfig'

"========================================================================
" Markdown Viewer
"

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
let g:mkdp_auto_start = 0
"let g:mkdp_combine_preview_auto_refresh = 1

autocmd BufRead,BufNewFile *.qmd set filetype=qmd

" Escを押し間違えてTabを押しても良いようにTabとEscを交換
"autocmd FileType Rmd :inoremap <Tab> <Esc>
"autocmd FileType Rmd :inoremap <Esc> <Tab>
"autocmd FileType qmd :inoremap <Tab> <Esc>
"autocmd FileType qmd :inoremap <Esc> <Tab>
"autocmd FileType md :inoremap <Tab> <Esc>
"autocmd FileType md :inoremap <Esc> <Tab>
"autocmd FileType txt :inoremap <Tab> <Esc>
"autocmd FileType txt :inoremap <Esc> <Tab>
"autocmd FileType vim :inoremap <Tab> <Esc>
"autocmd FileType vim :inoremap <Esc> <Tab>

function OpenMarkdownPreview (url)
  execute "silent ! brave --new-window " . a:url
endfunction
let g:mkdp_browserfunc = 'OpenMarkdownPreview'

" Windows
Plug 'previm/previm'
Plug 'tyru/open-browser.vim'

augroup md
  autocmd!
  autocmd BufRead,BufNewFile *.md set spell 
augroup END

augroup Rmd
  autocmd!
  autocmd BufRead,BufNewFile *.Rmd set spell 
augroup END

augroup qmd
  autocmd!
  "autocmd BufRead,BufNewFile *.qmd let g:auto_save = 1
  autocmd BufRead,BufNewFile *.qmd :QuartoPreview
  autocmd BufRead,BufNewFile *.qmd nnoremap <F4> :QuartoUpdatePreview<CR>
augroup END

"========================================================================
" CSV Viewer
"
Plug 'chrisbra/csv.vim'

augroup csv
  autocmd!
  autocmd BufRead,BufNewFile *.csv set filetype
  "autocmd BufRead,BufWritePost *.csv :%ArrangeColumn
  "autocmd BufWritePre *.csv :%UnArrangeColumn=csv

  " 自動整列が繰り返し実行されるため自動保存を解除
  "autocmd FileType csv let g:auto_save = 0

  " スクロールしてもヘッダーが見えるように画面分割
  autocmd FileType csv nnoremap <F8> :CSVHeaderToggle<CR>
augroup END

let g:csv_delim=','
let g:csv_start = 1
let g:csv_end = 100
let g:csv_hiHeader = 'Pmenu'
let g:no_csv_maps = 1 " キーマップを解除しないと<S-j>が使えなくなる。
let g:csv_autocmd_arrange	= 0 " 自動整列
"let g:csv_autocmd_arrange_size = 1024*1024 " 整列時間節約のため1MB分に限定
"let g:csv_highlight_column = 'y' " カラムを黄色でハイライト

" Escを押し間違えてTabを押しても良いようにTabをEscに割当
autocmd FileType csv :inoremap <Tab> <Esc>

"========================================================================
" Theme
"
Plug 'NLKNguyen/papercolor-theme'
set t_Co=256
set background=light

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
Plug 'vim-scripts/vim-auto-save'

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_in_insert_mode = 1
let g:auto_save_no_updatetime = 0
let g:auto_save_postsave_hook = 'call SaveBackupFile()'
" 分単位でバックアップファイルを作成する。
function! SaveBackupFile()
  let EXT = expand("%:e")
  if EXT == ''
    let fname = strftime("%Y-%m-%d_%H%M")
  else
    let fname = strftime("%Y-%m-%d_%H%M") . ".".expand("%:e")
  endif
  if s:is_linux
    let dname = "~/.local/share/Trash/files/VIM_BAKUP_FILES/" . expand("%:r") . '/'
  else
    let dname = 'C:\Users\tkdhs\Downloads\VIM_BAKUP_FILES\' . expand("%:r") . '\'
  endif
    silent execute ':!mkdir "' . dname . '"'
    silent execute ':!cp % "' . dname . fname . '"'
  "echo 'Saved backup file: "' . dname . fname . '"'
endfunction
"========================================================================
" Word Alignment
"
Plug 'junegunn/vim-easy-align'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Align Fortran :: symbols
vnoremap <F2> :s/=/<equal>/ge<CR> :'<,'>s/::/=/g<CR> :'<,'>EasyAlign =<CR> :'<,'>s/=/::/g<CR> :'<,'>s/<equal>/=/ge<CR>

"========================================================================
" Tags
"
"Plug 'soramugi/auto-ctags.vim'
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
Plug 'preservim/nerdtree'
"Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"https://ja.stackoverflow.com/questions/29595/vim%E8%B5%B7%E5%8B%95%E3%81%AE%E9%9A%9B-w18-invalid-character-in-group-name-%E3%81%8C%E5%87%BA%E5%8A%9B%E3%81%95%E3%82%8C%E3%82%8B
"
"nnoremap <silent><C-n> :NERDTreeToggle %:h<CR>
nnoremap <silent><C-n> :NERDTreeToggle<CR>
nnoremap <silent><C-c> :NERDTreeFind<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeQuitOnOpen=1
let NERDTreeShowBookmarks = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinSize=60

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
"let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = { } " needed
"let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tex'] = 'TEX'
"let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['exe'] = 'EXE'
"let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['f90'] = 'F90'
"let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['csv'] = 'CSV'
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
Plug 'wincent/ferret'
"echo ferret#get_default_arguments('rg')
let g:FerretExecutableArguments = {
  \   'rg': '--vimgrep --no-heading --no-config --max-columns 4096 --glob=!tags --glob=!bak --glob=!old --glob=!build --glob=!archive --glob=!*.html'
  \ }

" sudo.vim
Plug 'vim-scripts/sudo.vim'
" 保存時にsudo権限で無理やり保存
cnoremap w! w !sudo tee > /dev/null %<CR> :e!<CR>

" Smartchr
Plug 'kana/vim-smartchr'

" Cmake Syntax Highlighting
"Plug 'pboettch/vim-cmake-syntax'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Parenthesis completion (pear-tree)
"Plug 'tmsvg/pear-tree'

call plug#end() " *** プラグインインパッケージはここから上に書く。***

filetype plugin on
filetype plugin indent on

" 画面配色スキームはプラグインマネジャーの後で宣言する。
"colorscheme PaperColor
"colorscheme evening
"colorscheme default
colorscheme torte

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
