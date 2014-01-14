if filereadable("~/.vimrc_before")
    source ~/.vimrc_before
endif
source $ROOT/vim/.vimrc
if filereadable("~/.vimrc_after")
    source ~/.vimrc_after
endif
