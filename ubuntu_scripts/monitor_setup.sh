#!/bin/bash

# Gets the connected monitors 
connected_monitors=$(xrandr | grep " connected" | awk '{print $1}')

for monitor in $connected_monitors; do
    # Get the specs of the monitor eg HDMI-0 connected 1920x1080+2560+0 (normal left inverted right x axis y axis) 521mm x 293mm 1920x1080 60.00*+ 144.00 119.98 119.88 99.93 74.97 59.94 50.00
    specs=$(xrandr -q | grep "$monitor" -A 1)
    # Get the highest refresh rate eg 144.00
    highest_refresh_rate=$(echo "$specs" | awk '{ for (i=1; i<=NF; i++) if ($i ~ /^[0-9]+\.[0-9]+\*?\+?$/) print $i }' | sort -n | tail -n 1)
    # Get the maximum resolution eg 1920x1080
    resolution=$(echo "$specs" | grep -o "$monitor connected primary [0-9]\+x[0-9]\+" | awk '{print $4}')
    # If resolution is empty (not found with "connected primary" pattern), try "connected" pattern
    if [ -z "$resolution" ]; then
        # If resolution is empty (not found with "connected primary" pattern), try "connected" pattern
        resolution=$(echo "$specs" | grep -o "$monitor connected [0-9]\+x[0-9]\+" | awk '{print $3}')
    fi
    # Set the highest refresh rate
    xrandr --output $monitor --mode $resolution --rate $highest_refresh_rate
done

