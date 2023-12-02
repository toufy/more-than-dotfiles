#!/bin/bash
SCRDIR=$1

sudo pacman -S --needed refind
sudo refind-install --yes
read -rp "secure boot with sbctl? (YES to confirm): " confirm &&
    [[ $confirm == "YES" ]] || exit 0
sudo mkdir -p /etc/pacman.d/hooks
sudo sbctl sign -s /boot/EFI/refind/refind_x64.efi
sudo cp -f "$SCRDIR"/etc/pacman.d/hooks/refind.hook /etc/pacman.d/hooks/

echo "reboot to change bootloader (refind is chosen automatically)"
