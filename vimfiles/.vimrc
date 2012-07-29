" Tips in general [Achal]
" If html indent is being weird, try :set nocp; dunno why that works.
" If .php file and has html, use :set ft=html

" dotfiles repo hurrah
if has('win32') || has('win64')
	set runtimepath=$HOME/dotfiles/vimfiles/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/vimfiles/after
	" default: runtimepath=$HOME/vimfiles, $VIM/vimfiles, $VIMRUNTIME, $VIM/vimfiles/after, $HOME/vimfiles/after
endif

" call pathogen#helptags()
" call pathogen#runtime_append_all_bundles()

"================="
"  set up vundle  "
"================="

set nocompatible
filetype off

set rtp+=$HOME/dotfiles/vimfiles/.vim/bundle/vundle
call vundle#rc("$HOME/dotfiles/vimfiles/.vim/bundle")

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" github repos
Bundle 'pangloss/vim-javascript'

" vim-scripts
Bundle 'sessionman.vim'
Bundle 'AutoComplPop'
Bundle 'php.vim-html-enhanced'

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed.. (on the same line, that is)

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '" ' . arg1 . '" ' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '" ' . arg2 . '" ' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '" ' . arg3 . '" ' | endif
	let eq = ''
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			let cmd = '" "' . $VIMRUNTIME . '\diff" '
			let eq = '" '
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff" '
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
colorscheme python

" make the working directory be the directory of the current file
set autochdir
let g:netrw_keepdir=0

set autoindent
set incsearch

" 4 col tab generally
set tabstop=4
set softtabstop=4
set shiftwidth=4

if has("autocmd")
	" Make vim treat ejs as html files
	au BufRead,BufNewFile *.ejs setfiletype html

	" markdown filetype file
	au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=mkd

	" 2 col tab for web
	au Filetype html setlocal ts=2 sts=2 sw=2
	au Filetype javascript setlocal ts=2 sts=2 sw=2
	au Filetype css setlocal ts=2 sts=2 sw=2

	" tabs to spaces; 4 col tabs
	au FileType python setlocal expandtab ts=4 sts=4 sw=4
endif

" Use putty for SCP
let g:netrw_silent=1
let g:netrw_cygwin = 0
let g:netrw_list_cmd  = 'C:\"Program Files (x86)"\PuTTY\plink.exe -T -batch -ssh'
let g:netrw_scp_cmd  = 'C:\"Program Files (x86)"\PuTTY\pscp.exe -q -batch -scp'
let g:netrw_sftp_cmd = 'C:\"Program Files (x86)"\PuTTY\pscp.exe -q'

" Easy window navigation 
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Easy window resizing
" TODO: Figure out some nice ways to do this.
" <C-m> maps to enter... otherwise <C-m> <C-n> seemed 
" nice for <C-w>> and <C-w>< 
map + <C-w>+
map _ <C-w>-

" map cap h and cap l to beg and end of line=more intuitive
noremap H ^
noremap L $
noremap HH H
noremap LL L

" semicolon as colon
noremap ; :
" to keep original semicolon functionality:
noremap : ;

" escape is hard to reach so map kj to <ESC>
inoremap kj <ESC>l
cnoremap kj <ESC>

" don't allow esc in insert mode (aka save my wrists)
imap <Esc> <Nop>

" easily escape and save from within insert mode
inoremap ww <ESC>:w<Return>l

" stop highlighting the current line if not active
au WinLeave * set nocursorline
au WinEnter * set cursorline
set cursorline

set timeoutlen=150

" case search
set ignorecase
set smartcase

set smarttab 

" ugly backup files go bye-bye
set nobackup

set nocompatible
set nocp
