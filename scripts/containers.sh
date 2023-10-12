#!/bin/bash
SCRDIR=$1

# set box names
echo "arch box name:"
read -r abn_input
archbox_name=$(sed 's/[^a-zA-Z0-9_-]//g;s/\^//g' <(echo "$abn_input")) # regex removes characters not in [aA-zZ, 0-9, -, _]
echo "fedora box name:"
read -r fbn_input
fedorabox_name=$(sed 's/[^a-zA-Z0-9_-]//g;s/\^//g' <(echo "$fbn_input"))
echo "ubuntu box name:"
read -r ubn_input
ubuntubox_name=$(sed 's/[^a-zA-Z0-9_-]//g;s/\^//g' <(echo "$ubn_input"))

# home directory for dev containers
mkdir -p "$SCRDIR"/dboxes/"$archbox_name"
mkdir -p "$SCRDIR"/dboxes/"$ubuntubox_name"
mkdir -p "$HOME"/dboxes/"$archbox_name"
mkdir -p "$HOME"/dboxes/"$ubuntubox_name"

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
[$fedorabox_name]
additional_packages="git wget vim exa bat"
image=registry.fedoraproject.org/fedora-toolbox:latest
pull=true
init=false
nvidia=$nvidia
entry=false
[$ubuntubox_name]
additional_packages="git vim gcc"
image=quay.io/toolbx-images/ubuntu-toolbox:latest
pull=true
init=true
nvidia=$nvidia
entry=false
[$archbox_name]
additional_packages="git vim python-pip python-pipenv python-poetry"
home=$HOME/dboxes/$archbox_name
image=docker.io/library/archlinux:latest
pull=true
init=true
nvidia=$nvidia
entry=false
EOF

# .gitconfig for arch container (main dev container)
cat >"$SCRDIR"/dboxes/"$archbox_name"/.gitconfig <<EOF
[user]
    name = toufy
    email = ar.toufic@protonmail.com
[core]
    editor = vim
[init]
    defaultBranch = main
[credential]
    helper = cache --timeout=5400
EOF
read -r -p "press enter to open .gitconfig for arch box in vim, modify and save it"
vim "$SCRDIR"/dboxes/"$archbox_name"/.gitconfig

# create boxes and copy to home
distrobox-assemble create --file "$SCRDIR"/custom/distrobox/boxes.ini
cp -rf "$SCRDIR"/dboxes "$HOME"/
