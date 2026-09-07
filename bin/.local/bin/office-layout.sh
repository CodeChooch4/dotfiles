#!/bin/bash
move() { hyprctl dispatch "hl.dsp.window.move({ workspace = \"$1\", follow = false, window = \"address:$2\" })"; }
# WinApps (one shared class, route by title)
declare -A OFFICE=( [Outlook]=1 [Teams]=2 [Excel]=5 [Word]=5 [PowerPoint]=5 )
hyprctl clients -j | jq -c '.[]|select(.class|test("^Microsoft"))' | while read -r w; do
  addr=$(jq -r '.address' <<<"$w"); title=$(jq -r '.title' <<<"$w")
  for app in "${!OFFICE[@]}"; do [[ "$title" == *"$app"* ]] || continue; move "${OFFICE[$app]}" "$addr"; break; done
done
# Native apps by class
declare -A BYCLASS=( [com.mitchellh.ghostty]=4 [google-chrome]=3 )
for cls in "${!BYCLASS[@]}"; do
  for addr in $(hyprctl clients -j | jq -r --arg c "$cls" '.[]|select(.class==$c)|.address'); do
    move "${BYCLASS[$cls]}" "$addr"
  done
done
# WhatsApp PWA -> workspace 2 (with Teams)
for addr in $(hyprctl clients -j | jq -r '.[]|select(.class|test("whatsapp";"i"))|.address'); do
  move 2 "$addr"
done
