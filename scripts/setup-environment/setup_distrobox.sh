#!/bin/bash
SCRDIR=$1

# ini file for distrobox-assemble
read -r -p "press enter to open distrobox config in neovim, modify and save it"
nvim "$SCRDIR"/boxes.ini

# create boxes and copy to home
distrobox-assemble create --file "$SCRDIR"/boxes.ini

echo "use distrobox enter <box> to continue setup"
