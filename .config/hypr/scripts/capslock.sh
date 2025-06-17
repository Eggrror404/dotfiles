capslock=$(cat /sys/class/leds/*capslock*/brightness | head -n 1)

if [ "$capslock" = "1" ]; then
    quickshell ipc call osd openIcon "CapsLock On" "caps-lock-symbolic"
else
    quickshell ipc call osd openIcon "CapsLock Off" "caps-lock-off-symbolic"
fi
