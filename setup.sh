#!/bin/bash
set -e
if [ "$EUID" == 0 ]; then
    echo "don't run as root"
    exit
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

# setup devstuff
mkdir -p "$SCRDIR"/custom/vscode
echo "arch box name:"
read -r abn_input
archbox_name=$(sed 's/[^a-zA-Z0-9_-]//g;s/\^//g' <(echo "$abn_input"))
mkdir -p "$SCRDIR"/dboxes/"$archbox_name"
echo "fedora box name:"
read -r fbn_input
fedorabox_name=$(sed 's/[^a-zA-Z0-9_-]//g;s/\^//g' <(echo "$fbn_input"))
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

cat >"$SCRDIR"/dboxes/"$archbox_name"/.gitconfig <<EOF
[user]
    name = toufy
    email = ar.toufic@protonmail.com
[core]
    editor = vim
[init]
    defaultBranch = main
EOF
read -r -p "press enter to open .gitconfig for arch box in vim, modify and save it"
vim "$SCRDIR"/dboxes/"$archbox_name"/.gitconfig

# distrobox (create boxes)
#
# TODO:
#   make boxes with distrobox create
#   confirm nvidia arg
#   copy the dboxes/$archbox_name directory to home
#

# vscode (install the appropriate extensions for each container)
if ! flatpak list | grep -q com.visualstudio.code; then
    echo "vscode flatpak not found, installing"
    flatpak install flathub com.visualstudio.code
fi
cp -f "$SCRDIR"/custom/vscode/settings.json "$HOME"/.var/app/com.visualstudio.code/config/Code/User/
mkdir -p "$HOME"/.local/bin
cp -f "$SCRDIR"/.local/bin/podman-host "$HOME"/.local/bin/

# env vars
cp -rf "$SCRDIR"/.config/environment.d "$HOME"/.config/

echo "log out and back in"
