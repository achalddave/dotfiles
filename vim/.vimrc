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
let &rtp.=','.vimroot."/.vim"

" vim-plug + Plugins                                                            {
" ================
call plug#begin(vimroot."/.vim/plugged")

" Helper plugins
Plug 'xolox/vim-misc' " Required for vim-session
Plug 'google/maktaba' " Required for Google plugins
Plug 'google/glaive' " Required for Google plugins

Plug 'lervag/vimtex'
Plug 'Tab-Name'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'majutsushi/tagbar'
Plug 'achalddave/Smooth-Scroll'
Plug 'ervandew/supertab'
Plug 'kien/ctrlp.vim'
Plug 'suy/vim-ctrlp-commandline'
Plug 'vim-scripts/camelcasemotion'
Plug 'xolox/vim-session'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'int3/vim-extradite'
Plug 'gregsexton/gitv'
Plug 'vim-scripts/TagHighlight'
Plug 'docunext/closetag.vim'
Plug 'mbbill/undotree'
Plug 'jlanzarotta/bufexplorer'
Plug 'navicore/vissort.vim'
Plug 'junegunn/goyo.vim'
Plug 'google/vim-codefmt'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
Plug 'achalddave/guifontpp.vim', { 'on': [] } " Only load if gui running
Plug 'scrooloose/syntastic'

" language specific
Plug 'pangloss/vim-javascript'
Plug 'vim-scripts/mips.vim'
Plug 'othree/html5.vim'
Plug 'atdt/vim-mediawiki'
Plug 'achalddave/cscope_macros.vim'
Plug 'groenewege/vim-less'
Plug 'achalddave/vim-pandoc'
Plug 'rdark/Windows-PowerShell-Syntax-Plugin'
Plug 'vim-scripts/MatlabFilesEdition'
Plug 'JuliaLang/julia-vim'
Plug 'briancollins/vim-jst'
Plug 'rust-lang/rust.vim'
Plug 'uarun/vim-protobuf'

" Themes
Plug 'nanotech/jellybeans.vim'
Plug 'achalddave/vim-tomorrow-theme'
Plug 'altercation/vim-colors-solarized'

call plug#end()
call glaive#Install() " Initialize Google plugins

"                                                                             }

" Plugin Settings                                                             {
" ===============

" Easy tagbar
nnoremap <F2> :TagbarOpen j<CR>
inoremap <F2> <Esc>:TagbarOpen j<CR>a

nnoremap <S-F2> :TagbarToggle<CR>
inoremap <S-F2> <Esc>:TagbarToggle<CR>a

" Undo tree
nnoremap <F5> :UndotreeToggle<CR>
inoremap <F5> <Esc>:UndotreeToggle<CR>a

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

" Session save
let g:session_directory=vimroot."/sessions"
let g:session_command_aliases = 1
let g:session_autoload='no'
let g:session_autosave='no'

" Ctrl p
let g:ctrlp_max_files = 100000 " Set to 0 if no limit, but this should be enough.
let g:ctrlp_extensions = ['commandline'] " CtrlP through search history
" Remove <C-h> to left mapping
let g:ctrlp_prompt_mappings = {
            \ 'PrtCurLeft()': ['<left>', '<c-^>'],
            \ 'PrtBS()': ['<c-h>', '<BS>']
            \ }
cnoremap <silent> <C-g> <C-c>:call ctrlp#init(ctrlp#commandline#id())<CR>

" Gitv
let g:Gitv_OpenPreviewOnLaunch=1

" MATLAB Files Edition
autocmd BufEnter *.m    compiler mlint

" Codefmt
Glaive codefmt plugin[mappings]

function! s:AddCodefmtEqualMapping() abort
    " Replace all the various ={motion} keys to codefmt
    nnoremap <buffer> = :set opfunc=codefmt#FormatMap<CR>g@
    nnoremap <buffer> == :FormatLines<CR>
    vnoremap <buffer> = :FormatLines<CR>
endfunction

autocmd BufEnter *.prototxt set syntax=proto
autocmd FileType python,cpp,proto,javascript call s:AddCodefmtEqualMapping()
autocmd FileType python let b:codefmt_formatter = 'yapf'
" Python style guide recommends 79 characters, not 80.
autocmd FileType python set colorcolumn=79 textwidth=79

" vimtex
if system("uname") =~ "Darwin"
    let g:vimtex_view_general_viewer
      \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
    let g:vimtex_view_general_options = '@line @pdf @tex'
end

function! VimtexMappingUpdates()
    silent! unmap <buffer> {
    silent! unmap <buffer> }
endfunction
au Filetype latex,tex,plaintex call VimtexMappingUpdates()

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0 " Don't auto open/close location list
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode="passive"
let g:syntastic_enable_signs=0
nnoremap <F7> :SyntasticCheck<CR> :lopen<CR>

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
set listchars=tab:>~,trail:�

if has("autocmd")
    " tabs to spaces; 4 col tabs
    au FileType bibtex,python,c,cpp setlocal expandtab ts=4 sts=4 sw=4

    au Filetype html,css,javascript,ejs,xml,xbl,less call SetWebdevOptions()

    function! SetWebdevOptions()
        " 2 space tabs
        setlocal expandtab ts=2 sts=2 sw=2

        " Match tags
        runtime! macros/matchit.vim
    endfunction
endif

set formatoptions+=ro " Automatically insert comment leader after <Enter>/o/O.
set formatoptions-=t  " Don't auto wrap based on text width.

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

" Add lines in normal mode.
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>


" Use smooth scroll function from the plugin
nnoremap <silent> <C-d> :call SmoothScroll("d", 2, 2)<CR>
nnoremap <silent> <C-u> :call SmoothScroll("u", 2, 2)<CR>

" toggle highlighting
nnoremap <silent> <space> :noh<CR><space>

" undo blocks auto created in insert mode (no more undoing huge blocks
" accidentally)
inoremap <CR> <c-g>u<CR>
inoremap <c-w> <c-g>u<c-w>

" k/j to move through lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

" escape is hard to reach so map kj to <ESC>
" Also, if I'm in insert mode, hit kj, and hit <i>, I want to be in the same
" position; hence the extra <l>.
inoremap kj <ESC>l
noremap kj <ESC>

" exchange this word with next word using gw
noremap gw :s/\v(<\k*%#\k*>)(\_.{-})(<\k+>)/\3\2\1/<Return> :noh<Return>

" Word-wise Ctrl-Y Ctrl-E in insert mode
" http://vim.wikia.com/wiki/Wordwise_Ctrl-Y_in_insert_mode
" I actually don't fully understand this (well, mostly the '\\|.' in the end,
" but it seems potentially useful.
inoremap <expr> <c-y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')
inoremap <expr> <c-e> matchstr(getline(line('.')+1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" Paste mode
set pastetoggle=<F3>
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
" Adding "//" at the end asks Vim to use the absolute path of the file to avoid
" filename collisions.
if has("win32")
    let mybackupdir = $TEMP . "/vim-backup//"
    let myswpdir = $TEMP . "/vim-swp//"
elseif has("unix")
    let mybackupdir = $HOME . "/.vim-backup//"
    let myswpdir = $HOME . "/.vim-swp//"
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
    if has("autocmd")
        " Tomorrow doesn't highlight tex properly.
        au FileType tex set syntax=plaintex
    end

    " so apparently bg/fg are reversed for inc search
    hi IncSearch guibg=#0000ff
    hi IncSearch guifg=#9999ee
    hi Cursor guibg=#333399
    hi Cursor guifg=#ffffff

endif

if has("gui_running")
    call plug##load('guifontpp')

    " Default fonts suck
    if has("unix")
        if system('uname') =~ 'Darwin'
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

if has("autocmd")
    au BufRead,BufNewFile *.md set fo+=t
end

" Show as much as possible of last line on screen instead of `@'
set display=lastline

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
autocmd WinLeave * set nocursorline
autocmd WinEnter * if !&diff | set cursorline | endif
set cursorline

" Ask instead of erroring.
set confirm

" Use unix line endings by default.
set fileformat=unix
set fileformats=unix,dos

" Highlight at 80 char by default.
set colorcolumn=80

" Show (partial) command in status line (e.g. the 23 in "23k" before you press
" k).
set showcmd

" Round indent to nearest shiftwidth.
set shiftround

" Text width 80, not 79 (which is the default).
set textwidth=80

set encoding=utf-8

"                                                                             }

" Filetype specific                                                           {

if has("autocmd")
    let maplocalleader=","
    au Filetype latex,tex,plaintex call LatexMappings()
    " Turn off indentexpr for LaTeX, as it is extremely frustrating.
    " See, for example, the issue raised here (in 2008!)
    " <http://sourceforge.net/p/vim-latex/mailman/message/19080857/>
    au Filetype latex,tex,plaintex set indentexpr=
    au Filetype matlab call MatlabSettings()
    au BufRead,BufNewFile *.ejs setfiletype html
    au BufRead,BufNewFile *.xaml setfiletype xml
endif

" Use LaTeX flavor
let g:tex_flavor="latex"


"                                                                             }

" Helper functions                                                            {
" ================

function! MatlabSettings()
    nnoremap <buffer> <LocalLeader>m :exec(":e " . expand("<cword>") . ".m")<CR>
endfunction

function! LatexMappings()
    inoremap <buffer> fl \
    inoremap <buffer> fj {
    inoremap <buffer> fk }

    inoremap <buffer> fm \mathcal{

    inoremap <buffer> { <nop>
    inoremap <buffer> } <nop>
    inoremap <buffer> \ <nop>

    inoremap <buffer> <LocalLeader>tf \tfrac{
    inoremap <buffer> <LocalLeader>f \frac{
    inoremap <buffer> <LocalLeader>a \abs{}<Left>
    inoremap <buffer> <LocalLeader>b \begin{}<CR>\end{}<Esc>k$i
    inoremap <buffer> <LocalLeader>ba \begin{align*}<CR>\end{align*}<C-o>O
    inoremap <buffer> <LocalLeader>be \begin{enumerate}<CR>\end{enumerate}<C-o>O

    inoremap <buffer> <LocalLeader>l \left
    inoremap <buffer> <LocalLeader>r \right

    " compile latex file, then run it (%:r = filename without .tex extensions)
    if has("win32")
        nnoremap <silent> <buffer> <f3> :exec("silent ! latexmk -pdf % && start %:r".".pdf")<cr>:redraw!<cr>
        nnoremap <silent> <buffer> <f4> :exec("silent ! make %:r".".pdf && start %:r".".pdf")<cr>:redraw!<cr>
    elseif has("unix")
        if system('uname') =~ 'Darwin'
            nnoremap <silent> <buffer> <f3> :exec("silent ! latexmk -pdf % ; open %:r".".pdf")<cr>:redraw!<cr>
            nnoremap <silent> <buffer> <f4> :exec("silent ! make %:r".".pdf ; open %:r".".pdf")<cr>:redraw!<cr>
        else
            nnoremap <silent> <buffer> <f3> :exec("silent ! latexmk -pdf % ; xdg-open %:r".".pdf")<cr>:redraw!<cr>
            nnoremap <silent> <buffer> <f4> :exec("silent ! make %:r".".pdf ; xdg-open %:r".".pdf")<cr>:redraw!<cr>
        endif
    endif
    let g:surround_36 = "$\r$"
endfunction
