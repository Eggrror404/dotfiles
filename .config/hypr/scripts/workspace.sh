#!/usr/bin/env sh

# fallback to regular `workspace` when `hyprsplit` doesn't work

out=$(hyprctl dispatch split:workspace $1)

if [[ $out = 'Invalid dispatcher' ]]; then
    hyprctl dispatch workspace $1
fi
