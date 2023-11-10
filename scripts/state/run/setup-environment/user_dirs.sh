#!/bin/bash

# temporary solution
usrdirs=("Desktop" "Downloads" "Templates" "Public" "Documents" "Music" "Pictures" "Videos")
for adir in "${usrdirs[@]}"; do
    if [ -d "$HOME"/"$adir" ]; then
        new_dir=$(echo "$adir" | tr '[:upper:]' '[:lower:]')
        mv "$HOME"/"$adir" "$HOME"/"$new_dir"
    fi
done
