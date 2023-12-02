#!/bin/bash
SCRDIR=$1

# preserve ~/.config/environment.d
if [ -d "$HOME"/.config/environment.d ]; then
    mv "$HOME"/.config/environment.d/* "$SCRDIR"/.config/environment.d/
fi
# check if congis exist already
shopt -s dotglob
for dfile in "$SCRDIR"/.config/*; do
    dname=$(basename "$dfile")
    homeconf="$HOME"/.config
    currdir="$homeconf"/"$dname"
    if [ -d "$currdir" ]; then
        # remove existing dir
        rm -rf "$currdir"
    fi
    # symlink configs to $XDG_CONFIG_HOME
    ln -sf "$dfile" "$HOME"/.config/
done

echo 'log out and back in to apply "environment.d" changes'
