[[ -f ~/.bashrc ]] && . "$HOME"/.bashrc
# tmpfs in home
[[ -L ~/tmp ]] && [[ ! -d /tmp/"$USER" ]] && mkdir /tmp/"$USER"

# load environment.d
ENVD="$HOME"/.config/environment.d
set -a
if [ -d "$ENVD" ]; then
    for cfile in "$ENVD"/*.conf; do
        . "$cfile"
    done
fi
set +a
unset ENVD

# start hyprland on tty1
([[ "$(tty)" == "/dev/tty1" ]] && exec Hyprland) || neofetch
