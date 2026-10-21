#!/usr/bin/env bash
# One workspace item: highlighted when focused, shows its apps' icons,
# hidden when empty and not focused.

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/icon_map.sh"

AEROSPACE=/opt/homebrew/bin/aerospace
SID=${NAME#space.}
# Set by the aerospace_workspace_change trigger; ask AeroSpace for other events
FOCUSED=${FOCUSED_WORKSPACE:-$($AEROSPACE list-workspaces --focused)}

icons=""
while IFS= read -r app; do
  [[ -z $app ]] && continue
  __icon_map "$app"
  icons+="$icon_result "
done < <($AEROSPACE list-windows --workspace "$SID" --format '%{app-name}' 2>/dev/null | sort -u)

if [[ $SID == "$FOCUSED" ]]; then
  sketchybar --set "$NAME" drawing=on background.color=$ACCENT \
             icon.color=$BASE label.color=$BASE label="$icons" label.drawing=on
elif [[ -n $icons ]]; then
  sketchybar --set "$NAME" drawing=on background.color=$SURFACE \
             icon.color=$TEXT label.color=$SUBTEXT label="$icons" label.drawing=on
else
  sketchybar --set "$NAME" drawing=off
fi
