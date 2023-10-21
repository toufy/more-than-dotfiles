#!/bin/bash
SCRDIR=$1

# .gitconfig
mkdir -p "$SCRDIR"/.config/git/
cat >"$SCRDIR"/.config/git/config <<EOF
[user]
    name = toufy
    email = ar.toufic@protonmail.com
[core]
    editor = nvim
[init]
    defaultBranch = main
[credential]
    helper = cache --timeout=5400
EOF
read -r -p "press enter to open gitconfig in vim, modify and save it"
vim "$SCRDIR"/.config/git/config

# .config/
cp -rf "$SCRDIR"/.config/ "$HOME"/

