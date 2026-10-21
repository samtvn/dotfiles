#!/usr/bin/env bash
# Name and icon of the focused app

source "$CONFIG_DIR/plugins/icon_map.sh"

if [[ $SENDER == "front_app_switched" ]]; then
  __icon_map "$INFO"
  sketchybar --set "$NAME" label="$INFO" icon="$icon_result"
fi
