#!/bin/bash

if command -v vim >/dev/null 2>&1; then
    # replace vim with neovim
    sudo pacman -Rsnc vim && sudo pacman -S --needed --noconfirm neovim npm gcc python-pip
    # remove vim configs (they can mess with neovim runtime)
    for vfile in "$HOME"/.vim "$HOME"/.vimrc "$HOME"/.viminfo "$HOME"/.cache/vim \
        "$HOME"/.local/share/vim "$HOME"/.local/state/vim; do
        rm -rf "$vfile"
    done
fi

sudo pacman -S --needed --noconfirm neovim npm gcc python-pip lxqt-policykit \
    waybar mako udiskie swaybg syncthing kitty swaylock zenity git wget bat exa
