#!/bin/bash
move() { hyprctl dispatch "hl.dsp.window.move({ workspace = \"$1\", follow = false, window = \"address:$2\" })"; }
declare -A OFFICE=( [Outlook]=1 [Teams]=4 [Excel]=7 [Word]=7 [PowerPoint]=7 )
hyprctl clients -j | jq -c '.[]|select(.class|test("^Microsoft"))' | while read -r w; do
  addr=$(jq -r '.address' <<<"$w"); title=$(jq -r '.title' <<<"$w")
  for app in "${!OFFICE[@]}"; do [[ "$title" == *"$app"* ]] || continue; move "${OFFICE[$app]}" "$addr"; break; done
done
for addr in $(hyprctl clients -j | jq -r '.[]|select(.class=="google-chrome")|.address'); do move 3 "$addr"; done
for addr in $(hyprctl clients -j | jq -r '.[]|select(.class|test("whatsapp|telegram";"i"))|.address'); do move 2 "$addr"; done
for addr in $(hyprctl clients -j | jq -r '.[]|select(.class|test("youtube";"i"))|.address'); do move 6 "$addr"; done
# ws5: Nautilus first (left), then terminal splits right; then shrink Nautilus to 541
naddr=$(hyprctl clients -j | jq -r '.[]|select(.class=="org.gnome.Nautilus")|.address' | head -1)
gaddr=$(hyprctl clients -j | jq -r '.[]|select(.class=="com.mitchellh.ghostty")|.address' | head -1)
[ -n "$naddr" ] && move 5 "$naddr"; sleep 0.2
[ -n "$gaddr" ] && move 5 "$gaddr"; sleep 0.3
if [ -n "$naddr" ]; then
  cw=$(hyprctl clients -j | jq -r --arg a "$naddr" '.[]|select(.address==$a)|.size[0]')
  hyprctl dispatch "hl.dsp.window.resize({ x = $((541 - cw)), y = 0, relative = true, window = \"address:$naddr\" })"
fi
