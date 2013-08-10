#!/bin/bash

root_dir=${PWD%/*}
ln -s $root_dir/gitfiles/.gitconfig ~/.gitconfig
ln -s $root_dir/gitfiles/.gitignore_global ~/.gitignore_global
ln -s $root_dir/vimfiles/.vimrc ~/.vimrc
ln -s $root_dir/vimfiles/.gvimrc ~/.gvimrc
ln -s $root_dir/.bashrc ~/.bashrc
ln -s $root_dir/.inputrc ~/.inputrc

# create ~/.bashrc_local, otherwise ~/.bashrc will complain when sourcing it
# if it exists and we touch, we'd change modification time
if [ ! -e ~/.bashrc_local ] ; then
    touch ~/.bashrc_local
fi

cd $root_dir
git submodule init
git submodule update
cd -
