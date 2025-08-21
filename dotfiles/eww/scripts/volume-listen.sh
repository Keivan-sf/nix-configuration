#!/bin/sh

# Emit the current volume immediately
get_vol() {
    pactl get-sink-volume @DEFAULT_SINK@ \
        | grep -oP '\d+%' \
        | head -n 1
}

get_vol

# Subscribe to volume events and update when relevant
pactl subscribe | grep --line-buffered "sink" | while read -r _; do
    get_vol
done
