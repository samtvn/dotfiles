#!/usr/bin/env bash
# Output volume; $INFO holds the new volume on volume_change

vol=${INFO:-$(osascript -e 'output volume of (get volume settings)')}
[[ $vol == "missing value" ]] && vol=0

case $vol in
  0)                   icon=󰖁 ;;
  [0-9]|[1-2][0-9])    icon=󰕿 ;;
  [3-6][0-9])          icon=󰖀 ;;
  *)                   icon=󰕾 ;;
esac

sketchybar --set "$NAME" icon="$icon" label="${vol}%"
