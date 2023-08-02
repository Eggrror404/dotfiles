#!/usr/bin/env bash

rofi -modi emoji -show emoji -emoji-mode copy \
  -theme "$HOME/.config/rofi/launchers/launcher.rasi" \
  -theme-str 'configuration { show-icons: false; }'
