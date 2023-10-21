#!/bin/bash
SCRDIR=$1

### .gitconfig
read -r -p "press enter to open gitconfig in vim, modify and save it"
vim "$SCRDIR"/.config/git/config

### ~/.config/
# `unlink()` workaround
if [ -d "$HOME"/.config/environment.d ]; then # preserve ~/.config/environment.d
	mv "$HOME"/.config/environment.d/* "$SCRDIR"/.config/environment.d/
fi
for cdir in "$SCRDIR"/.config/*; do
	dname=$(basename "$cdir")
	homeconf="$HOME"/.config
	currdir="$homeconf"/"$dname"
	if [ -d "$currdir" ]; then
		rm -rf "$currdir"
	fi
done

ln -sf "$SCRDIR"/.config/* "$HOME"/.config/

