#!/bin/bash
SCRDIR=$1

if [ -d "$HOME"/.bash ]; then
    rm -rf "$HOME"/.bash
fi

ln -s "$SCRDIR"/.bash "$HOME"/
ln -sf "$SCRDIR"/.bashrc "$HOME"/.bashrc
ln -sf "$SCRDIR"/.bash_profile "$HOME"/.bash_profile

echo "reload the shell or exit the terminal emulator to apply configs"
