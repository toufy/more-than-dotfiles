#!/bin/bash

sudo pacman -S --needed sbctl

read -rp "make sure firmware is in setup mode (type YES to confirm): " confirm &&
    [[ $confirm == "YES" ]] || exit 1

sudo sbctl create-keys
sudo sbctl enroll-keys -m
sudo sbctl verify
echo "copy the paths, paste, then press enter (one by one)."
echo "press 'ctrl+d' when done."
while read -rp "path: " sbctl_img; do
    sudo sbctl sign -s "$sbctl_img"
done

echo "reboot to exit secure-boot setup mode"
