#!/bin/bash
SCRDIR=$1

# set box names
echo "dev box name:"
read -r dbn_input
devbox_name=$(\
	sed 's/[^a-zA-Z0-9_-]//g;s/\^//g'\  # regex removes characters not in [aA-zZ, 0-9, -, _]
	<(echo "$dbn_input")\
)

# check nvidia integration
echo "integrate host nvidia drivers? [Y,n]"
read -r ihnd
if [[ $ihnd == n* || $ihnd == N* ]]; then
    nvidia=false
else
    nvidia=true
fi

# ini file for distrobox-assemble
mkdir -p "$SCRDIR"/custom/distrobox
cat >"$SCRDIR"/custom/distrobox/boxes.ini <<EOF
[$devbox_name]
additional_packages="git neovim exa bat"
image=docker.io/library/archlinux:latest
pull=true
init=false
nvidia=$nvidia
entry=false
EOF
read -r -p "press enter to open distrobox config in vim, modify and save it"
vim "$SCRDIR"/custom/distrobox/boxes.ini

# create boxes and copy to home
distrobox-assemble create --file "$SCRDIR"/custom/distrobox/boxes.ini
