#!/bin/bash

### ---safety checks--- ###
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
SCRDIR=$(
    cd -- "$(dirname "$0")" >/dev/null 2>&1
    pwd -P
)

### ---setup--- ###
IFS=@
OPTDIR="$SCRDIR"/scripts/operations
while true; do
    echo -e "\n---[select operation]---"
    PS3='option: '
    operations=("create configs" "setup environment" "install software" "quit")
    select _ in "${operations[@]}"; do
        case $REPLY in
        "1")
            bash "$OPTDIR"/create_configs.sh "$SCRDIR"
            break
            ;;
        "2")
            bash "$OPTDIR"/setup_environment.sh "$SCRDIR"
            break
            ;;
        "3")
            bash "$OPTDIR"/install_software.sh "$SCRDIR"
            break
            ;;
        "4")
            break 2
            ;;
        *)
            echo "invalid option $REPLY"
            break
            ;;
        esac
    done
done
