#!/bin/zsh

ln -s "$PWD/zshenv" "$HOME/.zshenv"
[ ! -d "$HOME/.config/zsh" ] && mkdir -p "$HOME/.config/zsh"
ln -s "$PWD/zprofile" "$HOME/.config/zsh/.zprofile"
ln -s "$PWD/zsh_aliases" "$HOME/.config/zsh/zsh_aliases"
ln -s "$PWD/zshrc" "$HOME/.config/zsh/.zshrc"
ln -s "$PWD/../shell_scripts/zsh_functions" "$HOME/.config/zsh/zsh_functions"
touch ~/.hushlogin # disable the “Last Login” message on new terminal session
