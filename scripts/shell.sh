#!/bin/bash
SCRDIR=$1

if [ -d "$HOME"/.bash ]; then
	rm -rf "$HOME"/.bash
fi

ln -sf "$SCRDIR"/.bash "$HOME"/
ln -sf "$SCRDIR"/.bashrc "$HOME"/.bashrc

