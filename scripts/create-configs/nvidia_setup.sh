#!/bin/bash
SCRDIR=$1

sudo pacman -S --needed nvidia nvidia-utils libva-mesa-driver mesa-vdpau libva-nvidia-driver
sudo mkdir -p /etc/udev/rules.d /etc/pacman.d/hooks
# power down gpu when not in use
sudo cp -f "$SCRDIR"/etc/udev/rules.d/80-nvidia-pm.rules /etc/udev/rules.d/
# update hook
sudo cp -f "$SCRDIR"/etc/pacman.d/hooks/nvidia.hook /etc/pacman.d/hooks/
sudo cp -f "$SCRDIR"/etc/modprobe.d/nvidia.conf /etc/modprobe.d/

echo "verify '/etc/mkinitcpio.conf' options and regenerate initramfs to load nvidia kernel modules"
