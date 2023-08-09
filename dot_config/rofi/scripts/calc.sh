#!/usr/bin/env bash

rofi -show calc -modi calc -no-show-match -no-sort -terse -no-history \
  -theme "$HOME/.config/rofi/launchers/launcher.rasi" \
  -theme-str 'configuration { show-icons: false; }'
