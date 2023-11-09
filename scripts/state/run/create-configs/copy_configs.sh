#!/bin/bash
SCRDIR=$1

# `unlink()` workaround
if [ -d "$HOME"/.config/environment.d ]; then # preserve ~/.config/environment.d
    mv "$HOME"/.config/environment.d/* "$SCRDIR"/.config/environment.d/
fi
# check if congis exist already
for cdir in "$SCRDIR"/.config/*; do
    dname=$(basename "$cdir")
    homeconf="$HOME"/.config
    currdir="$homeconf"/"$dname"
    if [ -d "$currdir" ]; then
        # remove existing configs
        rm -rf "$currdir"
    fi
done
# symlink configs to $XDG_CONFIG_HOME
ln -sf "$SCRDIR"/.config/* "$HOME"/.config/

echo 'log out and back in to apply "environment.d" changes'
