#!/bin/bash
# On-demand: start the Windows VM, open Excel in WinApps, place on laptop WS10 (scale 140).
cd ~/winvm && docker compose up -d
# wait for RDP (Windows boot can take 30-60s on a cold start)
for i in $(seq 1 90); do (exec 3<>/dev/tcp/127.0.0.1/3389) 2>/dev/null && { exec 3>&-; break; }; sleep 1; done
sleep 3
setsid ~/.local/bin/winapps excel-o365 >/dev/null 2>&1 &
for i in $(seq 1 40); do
  a=$(hyprctl clients -j | jq -r '.[]|select(.class|test("^Microsoft"))|select(.title|test("Excel"))|.address' | head -1)
  [ -n "$a" ] && { hyprctl dispatch "hl.dsp.window.move({ workspace = \"10\", follow = false, window = \"address:$a\" })"; break; }
  sleep 1
done
notify-send "Excel VM" "Excel ready on workspace 10" 2>/dev/null
