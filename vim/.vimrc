" Notes                                                                       {
" vim: set foldmarker={,} foldmethod=marker:
"
" Folding method lifted from spf13.vim
"
" }

" Tips                                                                        {
" ====
" * Overriding plugin mapping: use <buffer>
"   (e.g. `:imap <buffer> <BS> <nop>` instead of `:imap <BS> <nop>`)
"                                                                             }

" Basic                                                                       {
" I just don't want to deal with moving this right now to a proper section
set nocompatible

" Dotfiles can be anywhere, get correct location
let vimroot=getcwd()

"                                                                             }

" Vundle + Plugins                                                            {
" ================
filetype off
filetype plugin indent on

let &rtp.=','.vimroot."/.vim/bundle/vundle"
call vundle#rc(vimroot."/.vim/bundle")

" NOTE: Comments after Bundle commands are not allowed!
Bundle 'gmarik/vundle'

Bundle 'Tab-Name'
if has('signs') && !has('win32') " Git gutter is slow on Windows
    Bundle 'airblade/vim-gitgutter'
endif
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-repeat'
Bundle 'majutsushi/tagbar'
Bundle 'achalddave/Smooth-Scroll'
Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
Bundle 'camelcasemotion'
 " required for vim-session
Bundle 'xolox/vim-misc.git'
Bundle 'xolox/vim-session'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'int3/vim-extradite'
Bundle 'gregsexton/gitv'
Bundle 'TagHighlight'
Bundle 'docunext/closetag.vim'

" language specific
Bundle 'pangloss/vim-javascript'
Bundle 'php.vim-html-enhanced'
Bundle 'indenthtml.vim'
Bundle 'mips.vim'
Bundle 'othree/html5.vim.git'
Bundle 'atdt/vim-mediawiki'
Bundle 'achalddave/cscope_macros.vim'
Bundle 'groenewege/vim-less'
Bundle 'achalddave/vim-pandoc'
Bundle 'rdark/Windows-PowerShell-Syntax-Plugin'
Bundle 'achalddave/guifontpp.vim'

" themes
" Bundle 'rdark'
" Bundle 'altercation/vim-colors-solarized'
Bundle 'nanotech/jellybeans.vim'
" Bundle 'Wombat'
" Bundle 'jonathanfilip/vim-lucius'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'altercation/vim-colors-solarized'

"                                                                             }

" Plugin Settings                                                             {
" ===============

" Easy tagbar
nnoremap <F2> :TagbarOpen j<CR>
inoremap <F2> <Esc>:TagbarOpen j<CR>a

nnoremap <S-F2> :TagbarToggle<CR>
inoremap <S-F2> <Esc>:TagbarToggle<CR>a

" Super tab (<cr> map messes with my <cr> -> <c-g>u<cr> map)
let g:SuperTabCrMapping = 0

" indent-html.vim:
let g:html_indent_inctags='p' " add indent on new paragraph
" Looks like vim-ragtag sets these as of
" https://github.com/tpope/vim-ragtag/commit/7c7b2464731a5e10016595db4d6aa1428b828efe
" but this is to make it explicit (I don't understand why vim-ragtag would set
" things for me from indenthtml.vim...)
let g:html_indent_style1='inc'   " auto indent css after <style>
let g:html_indent_script1='inc'  " auto indent js after <script>

" Auto-Close
" if has("autocmd")
"     au FileType tex,plaintex let b:AutoClosePairs=AutoClose#DefaultPairsModified("$$","")
"     au FileType html,php,ejs let b:AutoClosePairs=AutoClose#DefaultPairsModified("<>","")
" endif

" Session save
let g:session_directory=vimroot."/sessions"
let g:session_command_aliases = 1
let g:session_autoload='no'
let g:session_autosave='no'

" Ctrl p
let g:ctrlp_max_files = 100000 " Set to 0 if no limit, but this should be enough.

" Guifontpp
let guifontpp_smaller_font_map="<Leader>-"
let guifontpp_larger_font_map="<Leader>="
let guifontpp_original_font_map="<>"

" Gitv
let g:Gitv_OpenPreviewOnLaunch=1

"                                                                             }

" Indentation                                                                 {
" ===========

set autoindent
set smarttab

" When moving the cursor up or down just after inserting indent for
" 'autoindent', do not delete the indent.
set cpoptions+=I

" 4 col tab generally
set ts=4 sts=4 sw=4 expandtab

" Highlight tabs instead of spaces
set list
set listchars=tab:>~,trail:·

if has("autocmd")
    " Make vim treat ejs as html files
    au BufRead,BufNewFile *.ejs setfiletype html
    au BufRead,BufNewFile *.tex setfiletype plaintex

    " tabs to spaces; 4 col tabs
    au FileType python setlocal expandtab ts=4 sts=4 sw=4
    au FileType c setlocal expandtab ts=4 sts=4 sw=4
    au FileType cpp setlocal expandtab ts=4 sts=4 sw=4

    au Filetype html,css,javascript,ejs,xml,xbl,less call SetWebdevOptions()

    function! SetWebdevOptions()
        " 2 space tabs
        setlocal expandtab ts=2 sts=2 sw=2

        " Match tags
        runtime! macros/matchit.vim
    endfunction
endif

set formatoptions+=ro " Automatically insert comment leader after <Enter>/o/O

"                                                                             }

" Mappings                                                                    {
" ========

let mapleader=","
set timeoutlen=150

" Easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Easy window resizing
" TODO: Figure out some nice ways to do this.  <C-m> maps to enter...
" otherwise <C-m> <C-n> seemed nice for <C-w>> and <C-w>< hm maybe use
" leaders?
noremap + <C-w>+
noremap _ <C-w>-

" map shift h and shift l to beg and end of line
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
" <C-f> one page down
" <C-d> half page down
" <C-b> one page up
" <C-u> half page up
" Use smooth scroll function from the plugin
nnoremap <silent> <C-d> :call RunWithoutTimeout("call SmoothScroll(\"d\", 2, 2)")<CR>
nnoremap <silent> <C-u> :call RunWithoutTimeout("call SmoothScroll(\"u\", 2, 2)")<CR>

" toggle highlighting
nnoremap <silent> <space> :noh<CR><space>

" undo blocks auto created in insert mode (no more undoing huge blocks
" accidentally)
inoremap <CR> <c-g>u<CR>
inoremap <c-w> <c-g>u<c-w>

" k/j to move through lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

if has("autocmd")
    au Filetype latex,tex,plaintex call LatexMappings()
endif

" escape is hard to reach so map kj to <ESC>
inoremap kj <ESC>l
noremap kj <ESC>

" easily escape and save from within insert mode
inoremap wq <ESC>:w<Return>l

" exchange this word with next word using gw
noremap gw :s/\v(<\k*%#\k*>)(\_.{-})(<\k+>)/\3\2\1/<Return> :noh<Return>

"                                                                             }

" Commands                                                                    {
" ========

command! -range=% Strip :<line1>,<line2>s/\s\+$//g
command! E :Explore
command! Ex :Extradite

" Allow saving of files as sudo when I forgot to start vim using sudo.
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
if has("unix")
    cmap w!! w !sudo tee > /dev/null %
endif

"                                                                             }

" Backup                                                                      {
" ======

set backup
if has("win32")
    let mybackupdir = $TEMP . "/vim-backup"
    let myswpdir = $TEMP . "/vim-swp"
elseif has("unix")
    let mybackupdir = "/tmp/vim-backup"
    let myswpdir = "/tmp/vim-swp"
endif

if !isdirectory(mybackupdir)
    call mkdir(mybackupdir)
endif
if !isdirectory(myswpdir)
    call mkdir(myswpdir)
endif
execute "set backupdir=".mybackupdir
execute "set directory=".myswpdir

"                                                                             }

" Appearance                                                                  {
" ==========

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
  " have to toggle filetype for issue (Vim not detecting CoffeeScript
  " filetype): http://stackoverflow.com/questions/5602767/
  filetype off
  filetype on
  set hlsearch
endif

colorscheme slate
" always have status line
set laststatus=2
set ruler

" if we have enough colors
if &t_Co >= 256 || has("gui_running")
    colorscheme Tomorrow-Night-Bright

    " slight blue color
    hi CursorLine guibg=#121129
    hi Visual guibg=#232249
    hi Search guibg=#9999ee

    " so apparently bg/fg are reversed for inc search
    hi IncSearch guibg=#0000ff
    hi IncSearch guifg=#9999ee
    hi Cursor guibg=#333399
    hi Cursor guifg=#ffffff

endif

if has("gui_running")
    " Default fonts suck
    if has("unix")
        let s:uname = system("uname")
        if s:uname == "Darwin\n"
            set guifont=Monaco:h10
        endif
    elseif has ("win32")
        set guifont=Consolas:h10
    endif
else
    " vim can't change the background of a terminal, as far as I can tell no
    " point changing the background of the text alone
    hi Normal ctermbg=NONE
endif

" string like todos
hi! Todo None
hi! link Todo String

" Echo the syntax group my cursor is over
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" no error bells
set vb t_vb=

" i need line numbers
set nu

"                                                                             }

" Other settings                                                              {
" ==============

" Use putty for SCP
if has("win32")
    let g:netrw_silent = 1
    let g:netrw_cygwin = 0
    let g:netrw_list_cmd  = 'C:\"Program Files (x86)"\PuTTY\plink.exe HOSTNAME ls -Fa'
    let g:netrw_scp_cmd  = 'C:\"Program Files (x86)"\PuTTY\pscp.exe -q -batch'
    let g:netrw_sftp_cmd = 'C:\"Program Files (x86)"\PuTTY\psftp.exe'
endif

" make the working directory be the directory of the current file
set autochdir
let g:netrw_keepdir=0

" Sort netrw case insensitive
let g:netrw_sort_options="i"

" case search
set ignorecase
set smartcase
set incsearch

set history=1000

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

" Ask instead of erroring.
set confirm

" Use unix line endings by default
set fileformat=unix
set fileformats=unix,dos

" Highlight at 80 char by default.
set colorcolumn=80

" On Linux, suspending Vim removes copied text from the clipboard; this is a
" workaround as suggested by
" http://stackoverflow.com/questions/6453595/
" TODO: check if this works (or is necessary on OSX)
if has("unix")
    autocmd VimLeave * call system("xsel -ib", getreg("+"))
    nnoremap <silent> <C-z> :call system("xsel -ib", getreg("+"))<CR><C-z>
end

"                                                                             }

" Helper functions                                                            {
" ================

" if you want to hit, e.g. k multiple times without vim waiting for j (kj->esc
" mapping)
function! RunWithoutTimeout(command)
    let l:origTimeoutlen=&timeoutlen
    set timeoutlen=0
    exec a:command
    exec "set timeoutlen=".l:origTimeoutlen
endfunction

function! LatexMappings()
    inoremap <buffer> f/ \
    inoremap <buffer> fj {
    inoremap <buffer> fk }

    inoremap <buffer> { <nop>
    inoremap <buffer> } <nop>
    inoremap <buffer> \ <nop>

    inoremap <buffer> <Leader>r \rightarrow

    " compile latex file, then run it (%:r = filename without .tex extensions)
    if has("win32")
        nnoremap <silent> <buffer> <f3> :exec("silent ! pdflatex % && start %:r".".pdf")<cr>
    elseif has("unix")
        nnoremap <silent> <buffer> <f3> :exec("silent ! pdflatex % ; start %:r".".pdf")<cr>
    endif
endfunction
