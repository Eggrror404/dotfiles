#!/usr/bin/env bash

types='{
    "Unknown": " ",
    "Aux": "󱡬 ",
    "Speaker": "󰓃 ",
    "Headphones": "󰋋 ",
    "Line": "󱡬 ",
    "Mic": "󰍬 ",
    "Headset": "󰋎 ",
    "Handset": " ",
    "Earpiece": "󱡏 ",
    "SPDIF": "󱡬 ",
    "HDMI": "󰡁 ",
    "TV": " ",
    "Radio": "󰐹 ",
    "Video": "󰡀 ",
    "USB": "󱇰 ",
    "Bluetooth": "󰗾 ",
    "Portable": "󰴽 ",
    "Handsfree": "󱡏 ",
    "Car": "󱏍 ",
    "HiFi": "󰤽 ",
    "Phone": "󰄜 ",
    "Network": "󱝉 ",
    "Analog": "󱡬 "
}'

devices=''
options=''

get_devices() {
  default_sink=$(pactl get-default-sink)
  pactl --format json list sinks |
    jq -cM --arg default_sink "$default_sink" \
      'map(.name as $sink_name | .description as $desc | .ports[0] | {
          $sink_name, $desc, type, availability, priority,
          is_default: ($sink_name == $default_sink)
      }) | sort_by(.priority) | reverse'
}

get_options() {
  jq -cM --argjson types "$types" \
    'map(
      (if .is_default then "󰄭 " else $types[.type] end) as $icon |
      (if .availability != "available" then "(" + .availability + ")" else "" end) as $avail |
      [$icon, .desc, $avail] | join(" ")
    )'
}

anyrun_cmd() {
  anyrun --plugins libstdin.so --show-results-immediately true
}

devices=$(get_devices)
options=$(echo "$devices" | get_options)

chosen=$(echo "$options" | jq -r 'join("\n")' | anyrun_cmd)

if [ -z "$chosen" ]; then
  exit 0
fi

# Extract sink_name & name from chosen option,
# outputing as "$sink_name $name"
chosen=$(echo $devices | jq -r --argjson options "$options" --arg chosen "$chosen" \
  '.[$options | index($chosen)] | .sink_name + " " + .desc')

pactl set-default-sink "$(echo $chosen | cut -d ' ' -f 1)"

notify-send "Using $(echo $chosen | cut -d ' ' -f 2-)" "Audio sink switched"
