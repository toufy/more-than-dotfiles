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
    operations=(
        #1
        "$(check_state copy_shell_configs)"
        #2
        "$(check_state user_dirs)"
        #3
        "$(check_state kitty_terminfo)"
        #4
        "$(check_state setup_distrobox)"
        #5
        "quit"
    )
    select _ in "${operations[@]}"; do
        case $REPLY in
        "1")
            bash "$RUNDIR"/copy_configs.sh "$SCRDIR"
            echo "[x] copy shell configs" >"$CHECKDIR"/copy_shell_configs
            break
            ;;
        "2")
            bash "$RUNDIR"/user_dirs.sh
            echo "[x] rename user dirs" >"$CHECKDIR"/user_dirs
            break
            ;;
        "3")
            bash "$RUNDIR"/kitty_terminfo.sh
            echo "[x] copy kitty terminfo" >"$CHECKDIR"/kitty_terminfo
            break
            ;;
        "4")
            bash "$RUNDIR"/setup_distrobox.sh "$SCRDIR"
            echo "[x] setup distrobox" >"$CHECKDIR"/setup_distrobox
            break
            ;;
        "5")
            break 2
            ;;
        *)
            echo "invalid option $REPLY"
            break
            ;;
        esac
    done
done
