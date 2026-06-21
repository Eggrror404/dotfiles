local function bind(specs)
    for _, spec in ipairs(specs) do
        local keys = table.concat(spec, " + ", 1, #spec - 1)
        hl.bind(keys, spec[#spec], spec.opts)
    end
end

local HOME = os.getenv "HOME"
local function exec_script(filename)
    return hl.dsp.exec_cmd("sh " .. HOME .. "/.config/hypr/scripts/" .. filename)
end

local mod = "SUPER"

-- apps
bind {
    { mod, "T", hl.dsp.exec_cmd "kitty" },
    { mod, "B", hl.dsp.exec_cmd "zen-browser" },
    { mod, "E", hl.dsp.exec_cmd "nautilus --new-window" },
    { "ALT + Space", hl.dsp.exec_cmd "vicinae toggle" },
    { mod, "ALT + P", hl.dsp.exec_cmd "hyprpicker -a" },
    {
        mod,
        "CTRL + ALT + W",
        hl.dsp.exec_cmd "qs -p $HOME/.config/noctalia-shell kill; qs -p $HOME/.config/noctalia-shell &> /tmp/qs-current.log",
    },
}

-- window
bind {
    { mod, "X", exec_script "killactive.sh" },
    { mod, "V", hl.dsp.window.float { action = "toggle" } },
    { mod, "P", hl.dsp.window.pin { action = "toggle" } },
    { mod, "F", hl.dsp.window.fullscreen { mode = "fullscreen", action = "toggle" } },
    { mod, "SHIFT + F", hl.dsp.window.fullscreen { mode = "maximized", action = "toggle" } },
}

-- move focus
bind {
    { mod, "left", hl.dsp.focus { direction = "l" } },
    { mod, "right", hl.dsp.focus { direction = "r" } },
    { mod, "up", hl.dsp.focus { direction = "u" } },
    { mod, "down", hl.dsp.focus { direction = "d" } },
    { mod, "H", hl.dsp.focus { direction = "l" } },
    { mod, "L", hl.dsp.focus { direction = "r" } },
    { mod, "K", hl.dsp.focus { direction = "u" } },
    { mod, "J", hl.dsp.focus { direction = "d" } },
}

-- move window
bind {
    { mod, "SHIFT + left", hl.dsp.window.move { direction = "l" } },
    { mod, "SHIFT + right", hl.dsp.window.move { direction = "r" } },
    { mod, "SHIFT + up", hl.dsp.window.move { direction = "u" } },
    { mod, "SHIFT + down", hl.dsp.window.move { direction = "d" } },
    { mod, "SHIFT + H", hl.dsp.window.move { direction = "l" } },
    { mod, "SHIFT + L", hl.dsp.window.move { direction = "r" } },
    { mod, "SHIFT + K", hl.dsp.window.move { direction = "u" } },
    { mod, "SHIFT + J", hl.dsp.window.move { direction = "d" } },
}

-- resize window
local function resize(relative)
    return function()
        local active = hl.get_active_window()
        local mon = hl.get_active_monitor()
        if active == nil then
            return
        end
        if active.floating then
            hl.dispatch(hl.dsp.window.resize { x = relative.x, y = relative.y, relative = true })
        elseif mon ~= nil then
            local ratio = relative.x / mon.size.width
            local sign = ratio > 0 and "+" or ""
            hl.dispatch(hl.dsp.layout("colresize " .. sign .. ratio))
        end
    end
end
local repeating = { repeating = true }
bind {
    { mod, "CTRL + left", resize { x = -10, y = 0 }, opts = repeating },
    { mod, "CTRL + right", resize { x = 10, y = 0 }, opts = repeating },
    { mod, "CTRL + up", resize { x = 0, y = -10 }, opts = repeating },
    { mod, "CTRL + down", resize { x = 0, y = 10 }, opts = repeating },
    { mod, "CTRL + H", resize { x = -10, y = 0 }, opts = repeating },
    { mod, "CTRL + L", resize { x = 10, y = 0 }, opts = repeating },
    { mod, "CTRL + K", resize { x = 0, y = -10 }, opts = repeating },
    { mod, "CTRL + J", resize { x = 0, y = 10 }, opts = repeating },
}

-- switch workspaces
local hs_status, hs = pcall(require, "plugins.hyprsplit")
if not hs_status then
    hs = hl
end
bind {
    { mod, "1", hs.dsp.focus { workspace = 1 } },
    { mod, "2", hs.dsp.focus { workspace = 2 } },
    { mod, "3", hs.dsp.focus { workspace = 3 } },
    { mod, "4", hs.dsp.focus { workspace = 4 } },
    { mod, "5", hs.dsp.focus { workspace = 5 } },
    { mod, "6", hs.dsp.focus { workspace = 6 } },
    { mod, "7", hs.dsp.focus { workspace = 7 } },
    { mod, "8", hs.dsp.focus { workspace = 8 } },
    { mod, "9", hs.dsp.focus { workspace = 9 } },
    { mod, "0", hs.dsp.focus { workspace = 10 } },
}

-- move window to workspace
bind {
    { mod, "SHIFT + 1", hs.dsp.window.move { workspace = 1 } },
    { mod, "SHIFT + 2", hs.dsp.window.move { workspace = 2 } },
    { mod, "SHIFT + 3", hs.dsp.window.move { workspace = 3 } },
    { mod, "SHIFT + 4", hs.dsp.window.move { workspace = 4 } },
    { mod, "SHIFT + 5", hs.dsp.window.move { workspace = 5 } },
    { mod, "SHIFT + 6", hs.dsp.window.move { workspace = 6 } },
    { mod, "SHIFT + 7", hs.dsp.window.move { workspace = 7 } },
    { mod, "SHIFT + 8", hs.dsp.window.move { workspace = 8 } },
    { mod, "SHIFT + 9", hs.dsp.window.move { workspace = 9 } },
    { mod, "SHIFT + 0", hs.dsp.window.move { workspace = 10 } },
}

-- mouse move or resize
local mouse = { mouse = true }
bind {
    { mod, "mouse:272", hl.dsp.window.drag(), opts = mouse },
    { mod, "CTRL + mouse:272", hl.dsp.window.resize(), opts = mouse },
    { "mouse:276", hl.dsp.window.drag(), opts = mouse },
}

-- utility with noctalia shell
local function noctalia_ipc(command)
    return hl.dsp.exec_cmd("qs -p $HOME/.config/noctalia-shell ipc call " .. command)
end
local lock_repeat = { locked = true, repeating = true }
bind {
    { "XF86AudioRaiseVolume", noctalia_ipc "volume increase", opt = lock_repeat },
    { "XF86AudioLowerVolume", noctalia_ipc "volume decrease", opt = lock_repeat },
    { "XF86AudioMute", noctalia_ipc "volume muteOutput", opt = lock_repeat },
    { "XF86AudioPlay", noctalia_ipc "media playPause", opt = lock_repeat },
    { "XF86AudioStop", noctalia_ipc "media toggle", opt = lock_repeat },
    { "XF86AudioNext", noctalia_ipc "media next", opt = lock_repeat },
    { "XF86AudioPrev", noctalia_ipc "media previous", opt = lock_repeat },

    { "XF86MonBrightnessUp", noctalia_ipc "brightness increase", opt = lock_repeat },
    { "XF86MonBrightnessDown", noctalia_ipc "brightness decrease", opt = lock_repeat },
}

-- screenshot
bind {
    { "Print", hl.dsp.exec_cmd "grimblast --notify --cursor copy" },
    { mod, "Print", hl.dsp.exec_cmd "grimblast --notify copy area" },
    { "SHIFT + Print", hl.dsp.exec_cmd "grimblast --notify --cursor copy screen" },
}

-- misc
bind {
    { "CAPS + Caps_Lock", exec_script "capslock.sh", opts = { release = true, non_consuming = true } },
    { mod, "KP_Add", exec_script "cursorzoom.sh in" },
    { mod, "KP_Subtract", exec_script "cursorzoom.sh out" },
}

-- power
bind {
    { "SUPER + CTRL + ALT + L", hl.dsp.exec_cmd "hyprlock" },
    { "SUPER + CTRL + ALT + Backspace", hl.dsp.exit() },
    { "SUPER + CTRL + ALT + Delete", hl.dsp.exec_cmd "systemctl poweroff" },
}
