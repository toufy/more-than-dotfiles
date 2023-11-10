#!/bin/bash

TIDIR="$HOME"/.terminfo/x
mkdir -p "$TIDIR"
cp /lib64/kitty/terminfo/x/xterm-kitty "$TIDIR"/xterm-kitty
