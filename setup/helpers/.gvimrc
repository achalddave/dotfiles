if filereadable("~/.gvimrc_before")
    source ~/.gvimrc_before
endif
source $ROOT/vim/.gvimrc
if filereadable("~/.gvimrc_after")
    source ~/.gvimrc_after
endif
