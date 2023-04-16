#!/usr/bin/env bash

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
style="type-1/style-2"
theme="$type/$style"

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

availability='{
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
    jq -cM --argjson types "$types" --argjson avail "$availability" \
        'map(.name as $sink_name | .ports |
      map({ sink_name: $sink_name, name: ( $types[.type] + " " + .description ), avail: $avail[.availability], avail_text: .availability })) |
    flatten | sort_by(.avail)'
}

# Return string: "$index $name"
get_default_device() {
    echo $devices | jq -r --arg default "$(pactl get-default-sink)" \
        '(map(.sink_name) | index($default)) as $index | ($index | tostring) + .[$index].name'
}

get_options() {
    jq -cM \
        'map( .avail_text as $avail | .name |
    if $avail != "available" then . + " <span weight=\"light\" size=\"small\"><i>(" + $avail + ")</i></span>" else . end )'
    # variant=title-caps isn't shown for some reason
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
