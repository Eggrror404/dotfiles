--[ WINDOW RULE ]--

local function match_class(class, props)
    hl.window_rule {
        match = { class = class },
        table.unpack(props),
    }
end

match_class("[Ww]aydroid.*", { float = true })
match_class("qalculate-gtk", { float = true })
match_class("obsidian", { opacity = "0.95" })
match_class("scrcpy", { tile = true })

hl.window_rule {
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
}

hl.window_rule {
    name = "firefox pip",
    match = {
        class = "firefox|zen",
        title = "Picture-in-Picture",
    },
    float = true,
    pin = true,
    move = { "monitor_w - window_w - 8", "monitor_h - window_h - 8" },
    size = { "monitor_w / 3", "monitor_w / 3" },
}

hl.window_rule {
    name = "obs projector",
    match = {
        title = "Windowed Projector \\(Preview\\)",
    },
    float = true,
    pin = true,
}

--[ LAYER RULE ]--

hl.layer_rule {
    name = "all blur",
    match = {
        namespace = "^.*$",
    },
    blur = true,
    ignore_alpha = 0.5,
}

hl.layer_rule {
    name = "vicinae no animation",
    match = {
        namespace = "vicinae",
    },
    no_anim = true,
}
