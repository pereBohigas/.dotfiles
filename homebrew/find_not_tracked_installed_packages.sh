#!/bin/zsh

### Script to found current installed packages not tracked ###

# TODO: Finish it
exit 0

brew bundle dump --file=CurrentInstalledPackagesBrewfile

sed '/^[[:blank:]]*$/d' Brewfile | sed '/^#/d' |  sed 's/ #.*//' | sort > SortedBrewfile

nvim -d <(sort CurrentInstalledPackagesBrewfile) SortedBrewfile

rm CurrentInstalledPackagesBrewfile
rm SortedBrewfile

