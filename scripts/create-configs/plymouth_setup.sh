#!/bin/bash
SCRDIR=$1

sudo pacman -S --needed plymouth
sudo cp -f "$SCRDIR"/etc/plymouth/plymouthd.conf /etc/plymouth/

echo "verify '/etc/mkinitcpio.conf' and regenerate initramfs to activate plymouth"
