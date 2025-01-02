#!/bin/zsh

[ ! -d "$HOME/.config/amethyst" ] && mkdir -p "$HOME/.config/amethyst"
ln -s "$PWD/amethyst.yml" "$HOME/.config/amethyst/amethyst.yml"

