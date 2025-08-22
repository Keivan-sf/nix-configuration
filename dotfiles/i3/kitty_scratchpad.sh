#!/bin/bash

# Try to show scratchpad
i3-msg '[instance="scratchpad"] scratchpad show' 2>/dev/null

# If no scratchpad exists (exit code != 0), create one
if [ $? -ne 0 ]; then
    kitty --class scratchpad --name scratchpad & (sleep 0.7 && i3-msg '[instance="scratchpad"] scratchpad show')
    # sleep 0.5
    # i3-msg '[instance="scratchpad"] scratchpad show'
fi
