#!/usr/bin/env bash
# Battery percentage; icon reflects level and charging, colour turns red when low

source "$CONFIG_DIR/colors.sh"

batt=$(pmset -g batt)
pct=$(grep -Eo '[0-9]+%' <<<"$batt" | tr -d '%')
[[ -z $pct ]] && exit 0

case $pct in
  9[0-9]|100) icon=󰁹 ;;
  [7-8][0-9]) icon=󰂁 ;;
  [5-6][0-9]) icon=󰁿 ;;
  [3-4][0-9]) icon=󰁽 ;;
  [1-2][0-9]) icon=󰁻 ;;
  *)          icon=󰂃 ;;
esac
color=$TEXT
(( pct <= 20 )) && color=$RED
grep -q 'AC Power' <<<"$batt" && { icon=󰂄; color=$GREEN; }

sketchybar --set "$NAME" icon="$icon" icon.color=$color label="${pct}%"
