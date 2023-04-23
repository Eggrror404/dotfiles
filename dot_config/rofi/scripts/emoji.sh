#!/usr/bin/env bash

rofi -modi emoji -show emoji -emoji-mode copy \
    -theme "$HOME/.config/rofi/launchers/style-5.rasi" -theme-str 'configuration { show-icons: false; }'
