capslock=$(cat /sys/class/leds/*capslock*/brightness | head -n 1)

if [ "$capslock" = "1" ]; then
    quickshell -p $HOME/.config/noctalia-shell ipc call toast send '{"title": "CapsLock On", "icon": "xbox-a-filled"}'
else
    quickshell -p $HOME/.config/noctalia-shell ipc call toast send '{"title": "CapsLock Off", "icon": "xbox-a"}'
fi
