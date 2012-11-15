" Tips in general [Achal]
" GENERAL
" =======
" Overriding plugin mapping: use <buffer> 
"   (e.g. `:imap <buffer> <BS> <nop>` instead of `:imap <BS> <nop>`)
"
" WEBDEV
" ======
" If html indent is being weird, try :set nocp; dunno why that works.
" If .php file and has html, use :set ft=html
" 

" basic settings
set nocompatible "required for vundle
filetype off "required for vundle
filetype plugin indent on

"================="
"  set up vundle  "
"================="

set rtp+=$HOME/dotfiles/vimfiles/.vim/bundle/vundle
call vundle#rc("$HOME/dotfiles/vimfiles/.vim/bundle")

" Eventually want something not dependent on path, but if
" set up is based on symbolic links, then path will get tripped up.

" TODO fix setup so it simply places a vimrc that sources this vimrc

"let mypath = expand("%:p:h")
"
"set rtp+=expand(mypath."/.vim/bundle/vundle")
"call vundle#rc(expand(mypath."/.vim/bundle/"))

" PLUGINS
" =======
" let Vundle manage Vundle: required for vundle! 
Bundle 'gmarik/vundle'

Bundle 'Tab-Name'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-ragtag'
Bundle 'Townk/vim-autoclose.git'
Bundle 'majutsushi/tagbar'
Bundle 'ichizok/Smooth-Scroll'
Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
Bundle 'xolox/vim-session'
Bundle 'kien/ctrlp.vim'
Bundle 'camelcasemotion'

" language specific
Bundle 'pangloss/vim-javascript'
Bundle 'php.vim-html-enhanced'
Bundle 'indenthtml.vim'
Bundle 'mips.vim'

" THEMES
Bundle 'rdark'
Bundle 'altercation/vim-colors-solarized'
Bundle 'nanotech/jellybeans.vim'
Bundle 'Wombat'
Bundle 'mnoble/tomorrow-night-vim'

" Plugin Options
" --------------

" Super tab (<cr> map messes with my <cr> -> <c-g>u<cr> map)
let g:SuperTabCrMapping = 0

" indent-html.vim:
let g:html_indent_inctags='p' " add indent on new paragraph

" Auto-Close
if has("autocmd")
    au FileType tex,plaintex let b:AutoClosePairs=AutoClose#DefaultPairsModified("$$","")
    au FileType html,php,ejs let b:AutoClosePairs=AutoClose#DefaultPairsModified("<>","")
endif

" Session save
let g:session_directory="~/dotfiles/vimfiles/sessions"
let g:session_command_aliases = 1
let g:session_autoload='no'

" <tabwars>

" 4 col tab generally
set ts=4 sts=4 sw=4 expandtab

if has("autocmd")
	" Make vim treat ejs as html files
	au BufRead,BufNewFile *.ejs setfiletype html
    au BufRead,BufNewFile *.tex setfiletype plaintex

	" tabs to spaces; 4 col tabs
	au FileType python setlocal expandtab ts=4 sts=4 sw=4

    " CS 61C conventions
    au FileType c setlocal expandtab ts=2 sts=2 sw=2

    au Filetype html,css,javascript,ejs,xml,xbl call SetWebdevOptions()

    function! SetWebdevOptions()
        " 2 space tabs
        setlocal expandtab ts=2 sts=2 sw=2

        " Match tags
        runtime! macros/matchit.vim
    endfunction
endif

" </tabwars>

" HELPFUL FUNCTIONS
" =================

function! RunWithoutTimeout(command)
    let l:origTimeoutlen=&timeoutlen
    set timeoutlen=0
    echo &timeoutlen
    exec a:command
    exec "set timeoutlen=".l:origTimeoutlen
endfunction

" INTUITIVE
" =========
" Easy window navigation 
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Easy window resizing
" TODO: Figure out some nice ways to do this.
" <C-m> maps to enter... otherwise <C-m> <C-n> seemed 
" nice for <C-w>> and <C-w>< 
" hm maybe use leaders?
noremap + <C-w>+
noremap _ <C-w>-

" map cap h and cap l to beg and end of line
noremap H ^
noremap L $
noremap HH H
noremap LL L

" semicolon as colon
noremap ; :
" to keep original semicolon functionality:
noremap : ;

" Page up/page down makes no sense to me
"
" <C-d> half page down
" <C-f> half page up
" <C-b> page down
" <C-u> page up
" Use smooth scroll function from the plugin
nnoremap <silent> <C-f> :call RunWithoutTimeout("call SmoothScroll(\"u\", 2, 2)")<CR>
nnoremap <silent> <C-d> :call RunWithoutTimeout("call SmoothScroll(\"d\", 2, 2)")<CR>
nnoremap <silent> <C-u> :call RunWithoutTimeout("call SmoothScroll(\"u\", 1, 1)")<CR>
nnoremap <silent> <C-b> :call RunWithoutTimeout("call SmoothScroll(\"d\", 1, 1)")<CR>

" toggle highlighting
nnoremap <silent> <CR> :let @/ = ""<CR><CR>

" undo blocks auto created in insert mode 
" (no more undoing huge blocks accidentally)
inoremap <CR> <c-g>u<CR>
inoremap <c-w> <c-g>u<c-w>

" LESS WRIST PAIN
"=================

" Going to try 'z' for a while (don't use that key much anyway)
let mapleader="z"

function! LatexMappings()
    inoremap <Leader>/ \
    inoremap <Leader>9 [
    inoremap <Leader>0 ]
    inoremap <Leader>99 {
    inoremap <Leader>00 }

    inoremap <buffer> [ <nop>
    inoremap <buffer> ] <nop>
    inoremap <buffer> { <nop>
    inoremap <buffer> } <nop>
    inoremap \ <nop>
endfunction

if has("autocmd")
    au Filetype latex,tex,plaintex call LatexMappings()
endif

" escape is hard to reach so map kj to <ESC>
inoremap kj <ESC>l
noremap kj <ESC>

" don't allow esc in insert mode (aka save my wrists)
" imap <Esc> <Nop>
" Well, that actually messes everything up... but I'm used to kj now, so it's
" all good.

" easily escape and save from within insert mode
inoremap wq <ESC>:w<Return>l

" EXTRA FUNCTIONALITY
" ===================

" exchange this word with next word using gw
noremap gw :s/\v(<\k*%#\k*>)(\_.{-})(<\k+>)/\3\2\1/<Return> :noh<Return>

" ETC SETTINGS
" ============

" Use putty for SCP
let g:netrw_silent=1
let g:netrw_cygwin = 0
let g:netrw_list_cmd  = 'C:\"Program Files (x86)"\PuTTY\plink.exe -T -batch -ssh'
let g:netrw_scp_cmd  = 'C:\"Program Files (x86)"\PuTTY\pscp.exe -q -batch -scp'
let g:netrw_sftp_cmd = 'C:\"Program Files (x86)"\PuTTY\pscp.exe -q'

" make the working directory be the directory of the current file
set autochdir
let g:netrw_keepdir=0

set incsearch
set ruler
set history=100

" INDENTATION
set autoindent

"When moving the cursor up or down just after inserting indent for
"'autoindent', do not delete the indent.
set cpoptions+=I

" I really don't need vim to put "#" lines in the first column
set cinkeys-=0#
set indentkeys-=0#

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" some terminal issue fixes
if has('mouse')
  set mouse=a
endif

" Wrap cursor
set ww+=<,>,[,]

" stop highlighting the current line if not active
au WinLeave * set nocursorline
au WinEnter * set cursorline
set cursorline

set timeoutlen=150

" case search
set ignorecase
set smartcase

set smarttab 

set backup
if has("win32")
    let mybackupdir = expand($TEMP) . "\\vim-backup"
    if !isdirectory(mybackupdir)
        silent exec "!mkdir " mybackupdir
    endif
    execute "set backupdir=".mybackupdir.",$TEMP,$TMP"
elseif has("unix")
    let mybackupdir = "/tmp/vim-backup"
    if !isdirectory(mybackupdir)
        silent exec "!mkdir " mybackupdir
    endif
    set backupdir=/tmp/vim-backup
endif
