#!/usr/bin/env sh

WALLPAPER=~/Pictures/wallpapr/GWPT7pzbsAAlI4p.jpg

swww-daemon &

sleep 1
swww img $WALLPAPER
