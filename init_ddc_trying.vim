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
  let g:python3_host_prog='~\AppData\Local\Programs\Python\Python310\python.exe'
elseif s:is_mac
"pip3 uninstall neovim
"pip3 uninstall pynvim
"pip3 install pynvim
endif

"
" Get back to the last edited line when file is opened.
"
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"silent !setxkbmap -option "ctrl:nocaps"

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
:nnoremap <F1> :make clean<CR>
:nnoremap <F2> :NeoDebug <CR> file ~/gdb/fortran_debug <CR>
:nnoremap <F3> :make debug<CR>
:nnoremap <F6> :make release<CR>
:nnoremap <F4> :make test<CR>
:nnoremap <F5> :make run<CR>
:nnoremap <F9> :sp<CR>
":nnoremap <F11> :vsp<CR>:terminal<CR>i 
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
" Vundle
"
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Latex
set runtimepath+=~/latex/ftplugin/tex_quickrun.vim

" ddc.vim本体
Plugin 'Shougo/ddc.vim'
" DenoでVimプラグインを開発するためのプラグイン
Plugin 'vim-denops/denops.vim'
Plugin 'vim-denops/denops-helloworld.vim'
" ポップアップウィンドウを表示するプラグイン
Plugin 'Shougo/pum.vim'
" カーソル周辺の既出単語を補完するsource
Plugin 'Shougo/ddc-around'
" ファイル名を補完するsource
Plugin 'LumaKernel/ddc-file'
" 入力中の単語を補完の対象にするfilter
Plugin 'Shougo/ddc-matcher_head'
" 補完候補を適切にソートするfilter
Plugin 'Shougo/ddc-sorter_rank'
" 補完候補の重複を防ぐためのfilter
Plugin 'Shougo/ddc-converter_remove_overlap'

Plugin 'mattn/vim-lsp-settings'
Plugin 'prabirshrestha/vim-lsp'

" taketa begin -------------------------------------------

"
" Cmake syntax
"
Plugin 'pboettch/vim-cmake-syntax'

"
" ALE --Asynchronous Lint Engine-- 
"
Plugin 'dense-analysis/ale'

"
" vim-syntastic 
"
"Plugin 'vim-syntastic/syntastic'

"
" Previm
"
Plugin 'tyru/open-browser.vim'
Plugin 'kannokanno/previm'

"
" Neodebug
"
Plugin 'cpiger/NeoDebug'

"
" Latex (vimtex and vim - quickrun)
"
Plugin 'lervag/vimtex'
Plugin 'thinca/vim-quickrun'

"
" vim-fugitive and vim-rhubarb
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
" autodate.vim
"
Plugin 'vim-scripts/autodate.vim' 

"
" sakhnik/nvim-gdb
"
Plugin 'sakhnik/nvim-gdb'

"
" vim-tags
"
"Plugin 'szw/vim-tags'
Plugin 'soramugi/auto-ctags.vim'

"
" CSV 
"
Plugin 'chrisbra/csv.vim'

"
" vim-auto-save
"
Plugin 'vim-scripts/vim-auto-save'

"
" vim-easy-align
"
Plugin 'junegunn/vim-easy-align'

"
" Enhanced multi-file search for Vim
"
Plugin 'wincent/ferret'

"
" NERDTree
"
"Plugin 'scrooloose/nerdtree'
Plugin 'preservim/nerdtree'

"
" vim theme
"
Plugin 'jdkanani/vim-material-theme'
Plugin 'jacoborus/tender.vim'
"Plugin 'tomasr/colors/molokai.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

"
" R plugins
"
Plugin 'jalvesaq/Nvim-R'
Plugin 'gaalcaras/ncm-R'
"Plugin 'ncm2/ncm2'
Plugin 'sirver/UltiSnips'
Plugin 'ncm2/ncm2-ultisnips'

call vundle#end()
filetype plugin indent on

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

" Inverse search for SumatraPDF in Windows
"cmd /c for /F %i in ('type C:\Users\hss\AppData\Local\Temp\vimtexserver.txt') do nvr --servername %i -c 'normal! zzzv' +'%l' '%f'
function! s:write_server_name() abort
  let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/vimtexserver.txt'
  call writefile([v:servername], nvim_server_file)
endfunction

if (has('win32') || has('win64') || has('win32unix'))
  let g:vimtex_view_general_viewer = 'SumatraPDF'
  let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
  autocmd FileType tex call s:write_server_name()
else
  let g:vimtex_compiler_progname = 'nvr'
  let g:vimtex_view_general_viewer = 'okular'
  let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
endif

" Edit .latexmkrc
"
"$latex = 'lualatex -interaction=nonstopmode -synctex=-1 -recorder %O %S';
"
let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {'build_dir': 'build'}
" Disable overfull/underfull \hbox and all package warnings
augroup filetype
  autocmd!
  " tex file (I always use latex)
  autocmd BufRead,BufNewFile *.tex set filetype=tex
  "autocmd BufRead,BufNewFile *.tex :execute "normal \\ll"
  autocmd BufRead,BufNewFile *.tex :nnoremap <C-p> :make default<CR>
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
let g:auto_save_in_insert_mode = 1

" This will run :TagsGenerate after each save
"let g:auto_save_postsave_hook = 'Ctags'
let g:auto_save_no_updatetime = 0

"
" vim-easy-align
"

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Align Fortran :: symbols
vnoremap <F2> :s/=/<equal>/ge<CR> :'<,'>s/::/=/g<CR> :'<,'>EasyAlign =<CR> :'<,'>s/=/::/g<CR> :'<,'>s/<equal>/=/ge<CR>

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

" Run entire sourve by 'Ctrl+a' by tkd
au FileType r nnoremap <C-a> :execute "normal \\aa"<Cr>

"au! FileType tex nnoremap <ESC> <ESC> <ESC>

"====================================================================
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

"" Use deoplete.
"let g:deoplete#enable_at_startup = 1

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
let g:NERDTreeBookmarksFile = '/home/hss/.NERDTreeBookmarks' 
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

" DDC configuration

" Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
call ddc#custom#patch_global('sources', ['around'])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \ })

" Change source options
call ddc#custom#patch_global('sourceOptions', {
      \ 'around': {'mark': 'A'},
      \ })
call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ })

" Customize settings on a filetype
call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'clangd'])
call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
      \ 'clangd': {'mark': 'C'},
      \ })
call ddc#custom#patch_filetype('markdown', 'sourceParams', {
      \ 'around': {'maxSize': 100},
      \ })

" Mappings

" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ ddc#map#pum_visible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'

" Use ddc.
call ddc#enable()


