#!/bin/bash
SCRDIR=$1

IFS=@
RUNDIR="$SCRDIR"/scripts/state/run/install-software
CHECKDIR="$SCRDIR"/scripts/state/check/install-software
check_state() {
    cat "$CHECKDIR"/"$1"
}
while true; do
    echo -e "\n---[select operation]---"
    PS3='option: '
    operations=("$(check_state setup_flatpak)" "quit")
    select _ in "${operations[@]}"; do
        case $REPLY in
        "1")
            bash "$RUNDIR"/setup_flatpak.sh "$SCRDIR"
            echo "[x] setup and install flatpaks" >"$CHECKDIR"/setup_flatpak
            break
            ;;
        "2")
            break 2
            ;;
        *)
            echo "invalid option $REPLY"
            break
            ;;
        esac
    done
done
