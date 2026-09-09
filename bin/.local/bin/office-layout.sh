#!/bin/bash
move() { hyprctl dispatch "hl.dsp.window.move({ workspace = \"$1\", follow = false, window = \"address:$2\" })"; }
mv_re() { for a in $(hyprctl clients -j | jq -r --arg re "$2" '.[]|select(.class|test($re;"i"))|.address'); do move "$1" "$a"; done; }
mv_cls() { for a in $(hyprctl clients -j | jq -r --arg c "$2" '.[]|select(.class==$c)|.address'); do move "$1" "$a"; done; }
mv_re 1 "outlook.office"
mv_re 2 "whatsapp|telegram"
mv_cls 3 "google-chrome"
mv_re 4 "teams.microsoft"
mv_re 5 "music.youtube"
for a in $(hyprctl clients -j | jq -r '.[]|select(.class|test("youtube";"i"))|select(.class|test("music";"i")|not)|.address'); do move 6 "$a"; done
naddr=$(hyprctl clients -j | jq -r '.[]|select(.class=="org.gnome.Nautilus")|.address' | head -1)
gaddr=$(hyprctl clients -j | jq -r '.[]|select(.class=="com.mitchellh.ghostty")|.address' | head -1)
[ -n "$naddr" ] && move 7 "$naddr"; sleep 0.2
[ -n "$gaddr" ] && move 7 "$gaddr"; sleep 0.3
if [ -n "$naddr" ]; then
  cw=$(hyprctl clients -j | jq -r --arg a "$naddr" '.[]|select(.address==$a)|.size[0]')
  hyprctl dispatch "hl.dsp.window.resize({ x = $((541 - cw)), y = 0, relative = true, window = \"address:$naddr\" })"
fi
