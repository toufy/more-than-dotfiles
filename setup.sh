#!/bin/bash

### ---some safety checks--- ###
set -e
if [ "$EUID" == 0 ]; then
    echo "don't run as root"
    exit 1
fi
if ! command -v vim >/dev/null 2>&1; then
    echo "overlay/install vim, or replace 'vim' with your command of choice"
    exit 1
fi
if ! command -v distrobox >/dev/null 2>&1; then
    echo "overlay/install distrobox"
    exit 1
fi
SCRDIR=$(dirname "$0")

### ---setup devstuff--- ###
## vscode settings.json
mkdir -p "$SCRDIR"/custom/vscode
cat >"$SCRDIR"/custom/vscode/settings.json <<EOF
{
    // --- general --- //
    // telemetry
    "telemetry.telemetryLevel": "off",
    // workbench
    "workbench.startupEditor": "none",
    "workbench.colorTheme": "Dark Material Dracula",
    "workbench.iconTheme": "vscode-icons",
    // editor
    "editor.fontLigatures": true,
    "editor.fontFamily": "JetBrains Mono",
    "editor.fontSize": 14,
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true,
    "editor.detectIndentation": false,

    // --- extensions --- //
    //dev containers
    "dev.containers.dockerPath": "$HOME/.local/bin/podman-host",
    // git
    "git.autofetch": true,
    // python
    "python.analysis.typeCheckingMode": "strict",
    // prettier
    "prettier.htmlWhitespaceSensitivity": "strict",
    "prettier.singleAttributePerLine": true,
    "prettier.proseWrap": "always",
    "prettier.tabWidth": 4,
    // license
    "license.author": "toufy <ar.toufic@protonmail.com>",
    "license.year": "auto",
    "license.filename": "LICENSE",
    "license.default": "gpl-3.0",
    "license.extension": "",

    // --- languages --- //
    "[java]": {
        "editor.defaultFormatter": "redhat.java"
    },
    "[python]": {
        "editor.defaultFormatter": "ms-python.black-formatter"
    },
    "[shellscript]": {
        "editor.defaultFormatter": "foxundermoon.shell-format"
    },
    "[dotenv]": {
        "editor.defaultFormatter": "foxundermoon.shell-format"
    },
    "[ignore]": {
        "editor.defaultFormatter": "foxundermoon.shell-format"
    }
}
EOF
read -r -p "press enter to open settings.json in vim, modify and save it"
vim "$SCRDIR"/custom/vscode/settings.json

## distrobox containers
mkdir -p "$SCRDIR"/custom/distrobox
echo "arch box name:"
read -r abn_input
archbox_name=$(sed 's/[^a-zA-Z0-9_-]//g;s/\^//g' <(echo "$abn_input")) # regex removes characters not in [aA-zZ, 0-9, -, _]
# home directory for arch container, fedora uses host home (not for dev)
mkdir -p "$SCRDIR"/dboxes/"$archbox_name"
mkdir -p "$HOME"/dboxes/"$archbox_name"
echo "fedora box name:"
read -r fbn_input
fedorabox_name=$(sed 's/[^a-zA-Z0-9_-]//g;s/\^//g' <(echo "$fbn_input")) # regex removes characters not in [aA-zZ, 0-9, -, _]
echo "integrate host nvidia drivers? [Y,n]"
read -r ihnd
if [[ $ihnd == n* || $ihnd == N* ]]; then
    nvidia=false
else
    nvidia=true
fi
# ini file for distrobox-assemble
cat >"$SCRDIR"/custom/distrobox/boxes.ini <<EOF
[$fedorabox_name]
additional_packages="git wget vim"
image=registry.fedoraproject.org/fedora-toolbox:latest
pull=true
init=false
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

### ---apply configs and copy to home--- ###
## vscode
# install vscode flatpak if it doesn't exist and copy settings.js
if ! flatpak list | grep -q com.visualstudio.code; then
    echo "vscode flatpak not found, installing"
    flatpak install flathub com.visualstudio.code
fi
cp -f "$SCRDIR"/custom/vscode/settings.json "$HOME"/.var/app/com.visualstudio.code/config/Code/User/
mkdir -p "$HOME"/.local/bin
# podman host wrapper (for dev containers extension)
cp -f "$SCRDIR"/.local/bin/podman-host "$HOME"/.local/bin/

## env vars
cp -rf "$SCRDIR"/.config/environment.d "$HOME"/.config/

## distrobox
distrobox-assemble create --file "$SCRDIR"/custom/distrobox/boxes.ini
cp -rf "$SCRDIR"/dboxes "$HOME"/

echo "log out and back in"
