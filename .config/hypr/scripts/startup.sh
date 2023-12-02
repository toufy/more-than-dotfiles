#!/usr/bin/bash
# kill and wait
for proc in lxqt-policykit-agent waybar mako udiskie swaybg syncthing; do
    proc_id=$(pgrep -f "$proc")
    if [ -n "$proc_id" ]; then
        killall -q $proc
    fi
    while pgrep -x $proc >/dev/null; do sleep 1; done
done
# reload event
if [ $# -eq 0 ]; then
    hyprctl reload
fi
lxqt-policykit-agent &
waybar &
mako &
udiskie &
swaybg -i "$HOME"/.config/.bg_img -m fill &
syncthing serve --no-browser &
