#!/bin/bash
SCRDIR=$1

# ini file for distrobox-assemble
read -r -p "press enter to open distrobox config in vim, modify and save it"
vim "$SCRDIR"/boxes.ini

# create boxes and copy to home
distrobox-assemble create --file "$SCRDIR"/boxes.ini
