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
# env setup
bash "$SCRDIR"/scripts/env.sh "$SCRDIR"
# distrobox containers
bash "$SCRDIR"/scripts/containers.sh "$SCRDIR"
# shell setup
bash "$SCRDIR"/scripts/shell.sh "$SCRDIR"
# done
echo "log out and back in"

