#!/bin/bash
SCRDIR=$1

sudo cp -rf "$SCRDIR"/etc/mkinitcpio.conf /etc/mkinitcpio.conf
sudo mkinitcpio -P

echo "reboot for this to take effect"
