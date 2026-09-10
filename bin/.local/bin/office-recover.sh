#!/bin/bash
has_re() { hyprctl clients -j | jq -e --arg c "$1" '.[]|select(.class|test($c;"i"))' >/dev/null; }
has_cls() { hyprctl clients -j | jq -e --arg c "$1" '.[]|select(.class==$c)' >/dev/null; }
web() { setsid omarchy-launch-webapp "$1" >/dev/null 2>&1 & }
has_re "outlook.office" || web "https://outlook.office.com/"
has_re "teams.microsoft" || web "https://teams.microsoft.com/"
has_re "web.whatsapp" || web "https://web.whatsapp.com/"
has_re "music.youtube" || web "https://music.youtube.com/"
has_re "www.youtube" || web "https://www.youtube.com/"
has_cls "google-chrome" || { setsid google-chrome-stable >/dev/null 2>&1 & }
has_cls "foot" || { setsid foot >/dev/null 2>&1 & }
has_cls "org.gnome.Nautilus" || { setsid nautilus >/dev/null 2>&1 & }
has_re "telegram" || { setsid Telegram >/dev/null 2>&1 & }
sleep 3
~/.local/bin/office-layout.sh
