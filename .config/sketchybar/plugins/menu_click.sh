#!/usr/bin/env bash
# Open an app's (hidden) menu bar menu by clicking its status item.
# Usage: menu_click.sh <process name>
# Needs SketchyBar in Accessibility permissions. Real menu bar icons can't be
# mirrored on macOS 27 (SketchyBar issue #849), so the bar shows its own icon.

app=$1
osascript -e "tell application \"System Events\" to tell process \"$app\" to click menu bar item 1 of menu bar 2" \
  >/dev/null 2>&1 || open -a "$app"
