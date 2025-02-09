#!/usr/bin/env sh

# fallback to regular `movetoworkspace` when `hyprsplit` doesn't work

out=$(hyprctl dispatch split:movetoworkspace $1)

if [[ $out = 'Invalid dispatcher' ]]; then
    hyprctl dispatch movetoworkspace $1
fi
