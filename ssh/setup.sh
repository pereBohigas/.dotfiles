#!/bin/zsh

[ ! -d "$HOME/.ssh" ] && mkdir -p "$HOME/.ssh"
ln -s "$PWD/config" "$HOME/.ssh/config"

