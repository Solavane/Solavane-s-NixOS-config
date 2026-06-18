#!/usr/bin/env bash
set -euo pipefail
mkdir -p "$HOME/Pictures/Screenshots"
filepath="$HOME/Pictures/Screenshots/$(date +%Y%m%d%H%M%S).png"

case "${1:-fullscreen}" in
  region)
    p=$(mktemp -u).fifo; mkfifo "$p"
    wayfreeze --after-freeze-timeout 100 --after-freeze-cmd "echo > $p" & wp=$!
    read -r < "$p"; g=$(slurp -d)
    if [ -z "$g" ]; then kill "$wp" 2>/dev/null; rm -f "$p"; exit 1; fi
    grim -g "$g" - | wl-copy -t image/png
    kill "$wp" 2>/dev/null; rm -f "$p" ;;
  window)
    g=$(mmsg get focusing-client | jq -r '"\(.x),\(.y) \(.width)x\(.height)"')
    [ -z "$g" ] && exit 1
    grim -g "$g" - | wl-copy -t image/png ;;
  annotate)
    p=$(mktemp -u).fifo; mkfifo "$p"
    wayfreeze --after-freeze-timeout 100 --after-freeze-cmd "echo > $p" & wp=$!
    read -r < "$p"; g=$(slurp -d)
    if [ -z "$g" ]; then kill "$wp" 2>/dev/null; rm -f "$p"; exit 1; fi
    grim -g "$g" "$filepath"
    kill "$wp" 2>/dev/null; rm -f "$p"
    satty --filename "$filepath" --output-filename "$filepath" --actions-on-enter save-to-file --early-exit
    wl-copy -t image/png < "$filepath" && rm -f "$filepath" ;;
  *) grim - | wl-copy -t image/png ;;
esac
