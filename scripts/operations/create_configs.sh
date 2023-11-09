#!/bin/bash
SCRDIR=$1

IFS=@
RUNDIR="$SCRDIR"/scripts/state/run/create-configs
CHECKDIR="$SCRDIR"/scripts/state/check/create-configs
check_state() {
    cat "$CHECKDIR"/"$1"
}
while true; do
    echo -e "\n---[select operation]---"
    PS3='option: '
    operations=("$(check_state copy_configs)" "quit")
    select _ in "${operations[@]}"; do
        case $REPLY in
        "1")
            bash "$RUNDIR"/copy_configs.sh "$SCRDIR"
            echo "[x] copy configs" >"$CHECKDIR"/copy_configs
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
