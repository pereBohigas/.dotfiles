#!/bin/zsh

[ ! -d "$HOME/.config/mise" ] && mkdir -p "$HOME/.config/mise"
ln -s "$PWD/config.toml" "$HOME/.config/mise/config.toml"
mise trust "$PWD/config.toml"

