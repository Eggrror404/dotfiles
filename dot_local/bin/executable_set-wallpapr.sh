#!/usr/bin/env bash

MONITORS='{
    "*": "PPTR54t.jpeg",
    "HEADLESS-1": "UjkbRe5.jpg",
    "HEADLESS-2": "69851956_p0_master1200.jpg"
}'

hyprctl monitors -j |
  jq -rcM --argjson papr "$MONITORS" '.[] | .name | . + "	" + ($papr[.] // $papr["*"])' |
  while read monitor; do
    swww img "$HOME/Pictures/Wallpapr/$(cut -f2 <<<$monitor)" -o "$(cut -f1 <<<$monitor)"
  done
