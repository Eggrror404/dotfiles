local function on_start()
    hl.exec_cmd "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    hl.exec_cmd "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

    -- daemons
    hl.exec_cmd "fcitx5 -d"
    hl.exec_cmd "hypridle"
    hl.exec_cmd "valent --gapplication-service"
    hl.exec_cmd "vicinae server"
    --  hl.exec_cmd("elephant & walker --gapplication-service")
    hl.exec_cmd "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    --  hl.exec_cmd("nm-applet")
    hl.exec_cmd "qs -p $HOME/.config/noctalia-shell &> /tmp/qs-current.log"

    -- Set cursor
    hl.exec_cmd "hyprctl setcursor Bibata-Modern-Ice 24"

    -- swww for wallpaper
    --  hl.exec_cmd("~/.config/hypr/scripts/wallpapr.sh")

    -- plugins
    hl.exec_cmd "hyprpm reload -n"

    -- clipboard
    hl.exec_cmd "wl-paste --watch cliphist store"

    -- programs
    hl.exec_cmd "zen-browser"

    -- sleep 2 so tray-icon loads
    --  hl.exec_cmd("sleep 2 && vesktop --start-minimized")
    hl.exec_cmd "sleep 4 && keepassxc"
    --  hl.exec_cmd("sleep 2 && openrgb -p 'Breath.' --startminimized")
end

hl.on("hyprland.start", on_start)
