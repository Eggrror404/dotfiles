require "animation"
require "binding"
require "env"
require "monitors"
require "start"
require "window_rules"

hl.config {
    general = {
        gaps_in = 2,
        gaps_out = 4,
        border_size = 2,

        -- TODO: use noctalia colors
        col = {
            active_border = { colors = { "rgb(9ccfd8)", "rgb(31748f)" }, angle = 10 },
            inactive_border = { colors = { "rgb(908caa)", "rgb(6e6a86)" }, angle = 30 },
        },

        resize_on_border = false,
        allow_tearing = false,

        layout = "scrolling",
    },

    decoration = {
        rounding = 8,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 2,
            color = "rgba(191724cc)", -- TODO: color
        },

        blur = {
            enabled = true,
            size = 4,
            passes = 2,
            vibrancy = 0.1696,
        },
    },

    animations = { -- defined in animation.lua
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.49,
    },

    misc = {
        vrr = 1,
        focus_on_activate = true,
        key_press_enables_dpms = true,

        enable_anr_dialog = true,
        anr_missed_pings = 3,

        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },

    xwayland = {
        force_zero_scaling = true,
    },
}

--[ INPUT ]--

hl.config {
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        numlock_by_default = true,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            disable_while_typing = true,
            natural_scroll = true,
            scroll_factor = 0.8,
        },

        tablet = {
            output = "current",
            -- left_handed = true
        },
    },
}

hl.gesture {
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
}

--[ PLUGINS ]--

local hs_status, hs = pcall(require, "plugins.hyprsplit")
if hs_status then
    hs.config {
        num_workspaces = 10,
        persistent_workspaces = true,
    }
end

if hl.plugin.dynamic_cursors then
    hl.config {
        plugin = {
            dynamic_cursors = {
                enabled = true,
                mode = "tilt",
                threshold = 2,
                shake = {
                    enabled = true,
                },
                hyprcursor = {
                    enabled = true,
                    fallback = "clientside",
                },
            },
        },
    }
end
