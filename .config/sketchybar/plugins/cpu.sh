#!/usr/bin/env bash
# Total CPU usage across all cores, in percent

cores=$(sysctl -n hw.ncpu)
load=$(ps -A -o %cpu= | awk -v n="$cores" '{s+=$1} END {printf "%d", s/n}')

sketchybar --set "$NAME" label="${load}%"
