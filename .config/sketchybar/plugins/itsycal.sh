#!/usr/bin/env bash
# Clock click: open Itsycal's calendar by clicking its (hidden) menu bar item.
# Needs SketchyBar in System Settings > Privacy & Security > Accessibility.

pgrep -qx Itsycal || { open -a Itsycal; sleep 1; }

osascript -e 'tell application "System Events" to tell process "Itsycal" to click menu bar item 1 of menu bar 2' \
  >/dev/null 2>&1 || open -a Itsycal
