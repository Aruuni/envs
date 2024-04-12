#!/bin/bash
connected_monitors=$(xrandr | grep " connected" | awk '{print $1}')

for monitor in $connected_monitors; do
    specs=$(xrandr -q | grep "$monitor" -A 1)
    highest_refresh_rate=$(echo "$specs" | awk '{ for (i=1; i<=NF; i++) if ($i ~ /^[0-9]+\.[0-9]+\*?\+?$/) print $i }' | sort -n | tail -n 1)
    resolution=$(echo "$specs" | grep -o "$monitor connected primary [0-9]\+x[0-9]\+" | awk '{print $4}')
    if [ -z "$resolution" ]; then
        resolution=$(echo "$specs" | grep -o "$monitor connected [0-9]\+x[0-9]\+" | awk '{print $3}')
    fi
    xrandr --output $monitor --mode $resolution --rate $highest_refresh_rate
done