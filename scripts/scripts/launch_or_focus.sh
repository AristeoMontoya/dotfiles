#!/bin/bash

window_class=$1

# Check if Alacritty is running
if pgrep -xi $window_class > /dev/null; then
    # Try to focus an existing window using kdotool (Wayland-compatible fork of xdotool)
    if command -v kdotool &> /dev/null; then
        # Try to activate Alacritty window by class name
        kdotool search --class $window_class windowactivate
    else
        echo "$window_class is running, but can't focus"
    fi
else
    $window_class &
fi
