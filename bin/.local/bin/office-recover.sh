#!/bin/bash
present() { hyprctl clients -j | jq -e --arg p "$1" '.[]|select(.class|test("^Microsoft"))|select(.title|test($p))' >/dev/null; }
has_class() { hyprctl clients -j | jq -e --arg c "$1" '.[]|select(.class==$c)' >/dev/null; }
has_re() { hyprctl clients -j | jq -e --arg c "$1" '.[]|select(.class|test($c;"i"))' >/dev/null; }
wait_for() { local p="$1" t="${2:-15}" i=0; while (( i < t*2 )); do present "$p" && return 0; sleep 0.5; ((i++)); done; return 1; }
ol_count() { hyprctl clients -j | jq '[.[]|select(.class|test("^Microsoft"))|select(.title|test("Outlook"))]|length'; }
declare -A L=( [Outlook]=outlook-o365 [Teams]=ms-teams [Excel]=excel-o365 )
[[ "$1" == "--hard" ]] && { pkill -f xfreerdp; sleep 1; }
has_class "com.mitchellh.ghostty" || { setsid ghostty >/dev/null 2>&1 & }
has_class "google-chrome" || { setsid google-chrome-stable >/dev/null 2>&1 & }
has_re "whatsapp" || { setsid omarchy-launch-webapp https://web.whatsapp.com/ >/dev/null 2>&1 & }
has_class "org.gnome.Nautilus" || { setsid nautilus >/dev/null 2>&1 & }
has_re "youtube" || { setsid omarchy-launch-webapp https://www.youtube.com/ >/dev/null 2>&1 & }
launched=0
present Outlook || { setsid ~/.local/bin/winapps outlook-o365 >/dev/null 2>&1 & wait_for Outlook 20; launched=1; }
for name in Teams Excel; do
  present "$name" || { setsid ~/.local/bin/winapps "${L[$name]}" >/dev/null 2>&1 & wait_for "$name" 15; launched=1; }
done
if (( launched )); then for i in $(seq 1 8); do (( $(ol_count) > 1 )) && break; sleep 0.5; done; fi
if (( $(ol_count) > 1 )); then
  mapfile -t OL < <(hyprctl clients -j | jq -r '.[]|select(.class|test("^Microsoft"))|select(.title|test("Outlook"))| "\(.title|length)\t\(.address)"' | sort -rn | cut -f2)
  for a in "${OL[@]:1}"; do hyprctl dispatch "hl.dsp.window.close({ window = \"address:$a\" })"; done
fi
sleep 0.5
~/.local/bin/office-layout.sh
