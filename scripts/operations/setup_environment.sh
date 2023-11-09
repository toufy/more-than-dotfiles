#!/bin/bash
SCRDIR=$1

IFS=@
RUNDIR="$SCRDIR"/scripts/state/run/setup-environment
CHECKDIR="$SCRDIR"/scripts/state/check/setup-environment
check_state() {
    cat "$CHECKDIR"/"$1"
}
while true; do
    echo -e "\n---[select operation]---"
    PS3='option: '
    operations=("$(check_state copy_shell_configs)" "$(check_state setup_distrobox)" "quit")
    select _ in "${operations[@]}"; do
        case $REPLY in
        "1")
            bash "$RUNDIR"/copy_configs.sh "$SCRDIR"
            echo "[x] copy shell configs" >"$CHECKDIR"/copy_shell_configs
            break
            ;;
        "2")
            bash "$RUNDIR"/setup_distrobox.sh "$SCRDIR"
            echo "[x] setup distrobox" >"$CHECKDIR"/setup_distrobox
            break
            ;;
        "3")
            break 2
            ;;
        *)
            echo "invalid option $REPLY"
            break
            ;;
        esac
    done
done
