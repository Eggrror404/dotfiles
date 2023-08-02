#!/usr/bin/env bash

theme="$HOME/.config/rofi/applets/audio-device.rasi"

types='{
    "Unknown": "",
    "Aux": "󱡬",
    "Speaker": "󰓃",
    "Headphones": "󰋋",
    "Line": "󱡬",
    "Mic": "󰍬",
    "Headset": "󰋎",
    "Handset": "",
    "Earpiece": "󱡏",
    "SPDIF": "󱡬",
    "HDMI": "󰡁",
    "TV": "",
    "Radio": "󰐹",
    "Video": "󰡀",
    "USB": "󱇰",
    "Bluetooth": "󰗾",
    "Portable": "󰴽",
    "Handsfree": "󱡏",
    "Car": "󱏍",
    "HiFi": "󰤽",
    "Phone": "󰄜",
    "Network": "󱝉",
    "Analog": "󱡬"
}'

avail_prio='{
    "available": 0,
    "availability unknown": 1,
    "not available": 2
}'

devices=''
options=''
current=''

active=''

get_devices() {
  pactl --format json list sinks |
    jq -cM --argjson types "$types" --argjson avail "$avail_prio" \
      'map(.name as $sink_name | .ports |
      map({ sink_name: $sink_name, name: ( $types[.type] + " " + .description ), availability, avail_prio: $avail[.availability] })) |
    flatten | sort_by(.avail_prio)'
}

# Return string: "$index $name"
get_default_device() {
  echo $devices | jq -r --arg default "$(pactl get-default-sink)" \
    '(map(.sink_name) | index($default)) as $index | ($index | tostring) + .[$index].name'
}

get_options() {
  jq -cM \
    'map(
      if .availability != "available"
      then .name + " <span weight=\"light\" size=\"small\"><i>(" + .availability + ")</i></span>"
      else .name end
    )'
}

rofi_cmd() {
  rofi -theme-str "listview {columns: 1;}" \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    ${active} \
    -markup-rows \
    -theme ${theme}
}

devices=$(get_devices)
options=$(echo "$devices" | get_options)

current=$(get_default_device)

# Theme elements
prompt="Output Devices"
mesg="Current: $(echo "$current" | cut -d ' ' -f 2)"

active="-a $(echo "$current" | cut -d ' ' -f 1)"

chosen=$(echo "$options" | jq -r 'join("\n")' | rofi_cmd)

if [ -z "$chosen" ]; then
  exit 0
fi

# Extract sink_name & name from chosen option,
# outputing as "$sink_name $name"
chosen=$(echo $devices | jq -r --argjson options "$options" --arg chosen "$chosen" \
  '.[$options | index($chosen)] | .sink_name + " " + .name')

pactl set-default-sink "$(echo $chosen | cut -d ' ' -f 1)"

notify-send "Set default audio output as $(echo $chosen | cut -d ' ' -f 2-)"
