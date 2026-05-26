#!/usr/bin/env bash
# Screenshot the focused window and open in swappy for editing.
grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | "\(.rect.x+.window_rect.x),\(.rect.y+.window_rect.y) \(.window_rect.width)x\(.window_rect.height)"')" - | swappy -f -
