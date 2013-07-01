#!/bin/bash

ln -s ${PWD%/*}/gitfiles/.gitconfig ~/.gitconfig
ln -s ${PWD%/*}/gitfiles/.gitignore_global ~/.gitignore_global
ln -s ${PWD%/*}/vimfiles/.vimrc ~/.vimrc
ln -s ${PWD%/*}/vimfiles/.gvimrc ~/.gvimrc
ln -s ${PWD%/*}/.bashrc ~/.bashrc
ln -s ${PWD%/*}/.inputrc ~/.inputrc
