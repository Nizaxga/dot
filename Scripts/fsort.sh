#!/bin/bash

only_folders_remain() {
    shopt -s nullglob
    for f in *; do
        [ -f "$f" ] && return 1
    done
    return 0
}

while ! only_folders_remain; do
    shopt -s nullglob
    for file in *; do
        if [ -f "$file" ]; then
            extension="${file##*.}"
            if [ "$file" == "$extension" ]; then
                extension="no_extension"
            fi
            mkdir -p "$extension"
            mv -- "$file" "$extension/"
        fi
    done
done
