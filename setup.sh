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
# vscode
bash "$SCRDIR"/scripts/vscode.sh "$SCRDIR"
# distrobox containers
bash "$SCRDIR"/scripts/containers.sh "$SCRDIR"

### ---apply configs and copy to home--- ###
# env vars
cp -rf "$SCRDIR"/.config/environment.d "$HOME"/.config/

# done
echo "log out and back in"
