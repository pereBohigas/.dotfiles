#!/bin/zsh

[ ! -d "$HOME/.vim" ] && mkdir -p "$HOME/.vim"
[ ! -d "$HOME/.vim/undo" ] && mkdir -p "$HOME/.vim/undo"
ln -s "$PWD/vimrc" "$HOME/.vim/vimrc"

