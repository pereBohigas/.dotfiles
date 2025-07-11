#!/bin/zsh

if [ ! -d "$HOME/Library/Developer/Xcode/UserData/KeyBindings/" ]; then
	ln -s "$PWD/Vimious.idekeybindings" "$HOME/Library/Developer/Xcode/UserData/KeyBindings/Vimious.idekeybindings"
fi

