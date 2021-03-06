#!/bin/bash

# Make sure cwd is the setup directory
olddir=$(pwd)
cd $(dirname $BASH_SOURCE)

# Get root dir with tilde instead of absolute
root_dir=${PWD%/*}
# Create root_dir_human, which replaces home path with ~
[[ "$root_dir" =~ ^"$HOME"(/|$) ]] && root_dir_human="~${root_dir#$HOME}"

force=0
dryrun=0

function update {
    src=$1
    dst=$2
    if [ -e $dst -a $force -eq 0 ] ; then
        echo "$dst file already exists; not updating!"
    else
        if [ $dryrun -eq 0 ] ; then
            echo "Copying to $dst"
            sed s,\$ROOT,$root_dir_human,g $src > $dst
        else
            echo "==="
            echo "Would copy following output to $dst:"
            echo "---"
            sed s,\$ROOT,$root_dir_human,g $src
        fi
    fi
}

function usage {
    echo "Usage: ./setup_bash.sh [-f] [-w] [-h]"
    echo "-f: Force update files"
    echo "-n: Dry run (Shows what would be updated)"
    exit 0
}

while getopts "fhw" opt ; do
    case $opt in 
        f)
            force=1
            ;;
        h)
            usage
            ;;
        n)
            dryrun=1
            ;;
    esac
done

update ./helpers/gitconfig ~/.gitconfig # Also takes care of .gitignore
update ./helpers/vimrc     ~/.vimrc
update ./helpers/gvimrc    ~/.gvimrc
update ./helpers/bashrc    ~/.bashrc    # Also takes care of .inputrc
update ./helpers/profile   ~/.profile
update ./helpers/zprofile  ~/.zprofile
update ./helpers/zshrc     ~/.zshrc
echo "==="

# Initialize submodule
cd "$root_dir"
git submodule init
git submodule update
cd - >/dev/null

# Install vim-plug
if [[ ! -e $root_dir/vim/.vim/autoload/plug.vim ]] ; then
    echo -n "Installing vim-plug..."
    curl --silent -fLo $root_dir/vim/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
        >/dev/null
    if [ "$?" -eq 0 ] ; then echo " Done!" ; else echo " Failed..." ; fi
    vim +PlugInstall +qall
else
    echo "vim-plug already installed."
fi

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Return to correct folder
cd $olddir
