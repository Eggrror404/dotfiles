capslock=$(cat /sys/class/leds/*capslock*/brightness | head -n 1)

if [ "$capslock" = "1" ]; then
    quickshell ipc call osd openIcon "CapsLock On" "keyboard_capslock_badge"
else
    quickshell ipc call osd openIcon "CapsLock Off" "keyboard_capslock"
fi
