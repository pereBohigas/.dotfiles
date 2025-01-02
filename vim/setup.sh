#!/bin/zsh

[ ! -d "$HOME/.vim" ] && mkdir -p "$HOME/.vim"
ln -s "$PWD/vimrc" "$HOME/.vim/vimrc"

