#!/bin/bash

sudo pacman -S --needed --noconfirm git
# paru deps
sudo pacman -S --asdeps --needed --noconfirm rust bat devtools

sudo git clone https://aur.archlinux.org/paru /opt/paru
sudo chown -R "$USER":users /opt/paru
pushd /opt/paru || exit 1
makepkg -Ccsi
popd || exit 1
