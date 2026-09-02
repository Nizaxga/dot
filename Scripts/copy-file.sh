#!/bin/bash

if command -v pbcopy >/dev/null 2>&1; then
    CLIP_CMD="pbcopy" # MacOS
elif command -v xclip >/dev/null 2>&1; then
    CLIP_CMD="xclip" # Linux X11
elif command -v wl-copy >/dev/null 2>&1; then
    CLIP_CMD="wl-copy" # Linux Wayland
else
    echo "No clipboard utility found (install pbcopy, xclip, or wl-copy)"
    exit 1
fi

# If input is a file
if [ -n "$1" ]; then
    if [ ! -f "$1" ]; then
        echo "File not found: $1"
        exit 1
    fi
    cat "$1" | eval "$CLIP_CMD"
else
    # Read from stdin
    cat | eval "$CLIP_CMD"
fi
