#!/bin/bash

root_dir=${PWD%/*}
ln -s $root_dir/zsh/scripts ~/.zsh_scripts
ln -s $root_dir/zsh/.zshrc ~/.zshrc

# create ~/.zshrc_local, otherwise ~/.zshrc will complain when sourcing it
# if it exists and we touch, we'd change modification time
if [ ! -e ~/.zshrc_local ] ; then
    touch ~/.zshrc_local
fi
