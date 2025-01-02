#!/bin/zsh

[ ! -d "$HOME/.config/nvim" ] && mkdir -p "$HOME/.config/nvim"
ln -s "$PWD/after" "$HOME/.config/nvim/after"
ln -s "$PWD/lua" "$HOME/.config/nvim/lua"
ln -s "$PWD/spell" "$HOME/.config/nvim/spell"
ln -s "$PWD/init.lua" "$HOME/.config/nvim/init.lua"
ln -s "$PWD/../vim/vimrc" "$HOME/.config/nvim/vimrc"

