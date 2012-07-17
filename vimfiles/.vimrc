if has('win32') || has('win64')
  set runtimepath=$HOME/dotfiles/vimfiles/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/vimfiles/after
endif

call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" default: runtimepath=$HOME/vimfiles, $VIM/vimfiles, $VIMRUNTIME, $VIM/vimfiles/after, $HOME/vimfiles/after

" Tips in general [Achal]
" If html indent is being weird, try :set nocp; dunno why that works.
" If .php file and has html, use :set ft=html

set nocompatible
set nocp

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
colorscheme python
set guifont=lucida_console:h14

" Start my edits

" Set the colorscheme to tomorrownight in gui
colorscheme tomorrownight

" **STOP AUTOCOPYING STUFF** 
"if has("gui_running")
"	set guioptions-=a
"	set guioptions-=A
"	set guioptions-=aA
"endif

" Remove gvim's ugly toolbar and menu
set guioptions-=T
set guioptions-=m

" Courier New sucks
set guifont=Consolas

" make the working directory be the directory of the current file
set autochdir
let g:netrw_keepdir=0

" Set autoindent
set autoindent

" Incremental searching
set incsearch

" 4 col tab generally
set tabstop=4
set softtabstop=4
set shiftwidth=4

if has("autocmd")
	" Make vim treat ejs as html files
	au BufRead,BufNewFile *.ejs setfiletype html

	" 2 col tab for web
	au Filetype html setlocal ts=2 sts=2 sw=2
	au Filetype javascript setlocal ts=2 sts=2 sw=2

	au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
endif

" Use putty for SCP
let g:netrw_silent=1
let g:netrw_cygwin = 0
let g:netrw_list_cmd  = 'C:\"Program Files (x86)"\PuTTY\plink.exe -T -batch -ssh'
let g:netrw_scp_cmd  = 'C:\"Program Files (x86)"\PuTTY\pscp.exe -q -batch -scp'
let g:netrw_sftp_cmd = 'C:\"Program Files (x86)"\PuTTY\pscp.exe -q'

""" START Stolen from Samvit """

" Easy window navigation 
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"map cap h and cap l to beg and end of line=more intuitive
noremap H ^
noremap L $
noremap HH H
noremap LL L

"semicolon as colon
noremap ; :
"to keep original semicolon functionality:
noremap : ;

"escape is hard to reach so map kj to <ESC>
"noremap kj <ESC>
inoremap kj <ESC>l
"nnoremap kj <ESC>
"vnoremap kj <ESC>
cnoremap kj <ESC>

"easily escape and save from within insert mode
inoremap ww <ESC>:w<Return>l

au WinLeave * set nocursorline
au WinEnter * set cursorline
set cursorline
""" END Stolen from Samvit """

" don't allow esc in insert mode
imap <Esc> <Nop>

set timeoutlen=150  

" case search
set ignorecase
set smartcase

set smarttab 

set nobackup

set nocompatible
set nocp
