#!/usr/bin/env bash

zoom=$(hyprctl -j getoption cursor:zoom_factor | jq '.float')

if [[ "$1" != "in" && "$1" != "out" ]]; then
  echo "USAGE: $0 [in/out]"
  exit 1
fi

min=1
max=2
steps=3
dir="$1"

zoom=$(jq -n \
  --argjson min "$min" --argjson max "$max" --argjson steps "$steps" --argjson current "$zoom" --arg dir "$dir" '
  # insane jq math syntax
  ((($max | log) - ($min | log)) / $steps | exp) as $r |
  if $dir == "in" then ($current * $r) else ($current / $r) end as $new |
  if $new > $max then $max elif $new < $min then $min else $new end as $clamped |
  # round to 3 decimals
  ((($clamped * 1000) | round) / 1000)
  ')

hyprctl keyword cursor:zoom_factor "$zoom"
