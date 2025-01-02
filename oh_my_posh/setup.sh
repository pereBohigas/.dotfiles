#!/bin/zsh

[ ! -d "$HOME/.config/oh_my_posh" ] && mkdir -p "$HOME/.config/oh_my_posh"
ln -s "$PWD/configuration.toml" "$HOME/.config/oh_my_posh/configuration.toml"

