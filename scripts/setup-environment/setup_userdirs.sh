#!/bin/bash

# use lowercase folders
usrdirs=("Desktop" "Downloads" "Templates" "Public" "Documents" "Music" "Pictures" "Videos")
for adir in "${usrdirs[@]}"; do
    new_dir=$(echo "$adir" | tr '[:upper:]' '[:lower:]')
    if [ -d "$HOME"/"$adir" ]; then
        mv "$HOME"/"$adir" "$HOME"/"$new_dir"
    fi
    if [ ! -d "$HOME"/"$new_dir" ]; then
        mkdir -p "$HOME"/"$new_dir"
    fi
done
