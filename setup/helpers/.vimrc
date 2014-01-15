if filereadable(expand("~/.vimrc_before"))
    source ~/.vimrc_before
endif

let oldcwd=getcwd()
cd $ROOT/vim/
source $ROOT/vim/.vimrc
cd `=oldcwd`

if filereadable(expand("~/.vimrc_after"))
    source ~/.vimrc_after
endif
