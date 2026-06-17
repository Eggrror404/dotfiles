local curves = {
    expressiveFastSpatial = { { 0.42, 1.67 }, { 0.21, 0.90 } },
    expressiveSlowSpatial = { { 0.39, 1.29 }, { 0.35, 0.98 } },
    expressiveDefaultSpatial = { { 0.38, 1.21 }, { 0.22, 1.00 } },
    emphasizedDecel = { { 0.05, 0.7 }, { 0.1, 1 } },
    emphasizedAccel = { { 0.3, 0 }, { 0.8, 0.15 } },
    standardDecel = { { 0, 0 }, { 0, 1 } },
    menu_decel = { { 0.1, 1 }, { 0, 1 } },
    menu_accel = { { 0.52, 0.03 }, { 0.72, 0.08 } },
}

local animations = {
    -- windows
    windowsIn = { speed = 3, bezier = "emphasizedDecel", style = "popin 80%" },
    windowsOut = { speed = 2, bezier = "emphasizedDecel", style = "popin 90%" },
    windowsMove = { speed = 3, bezier = "emphasizedDecel", style = "slide" },
    border = { speed = 10, bezier = "emphasizedDecel" },

    -- layers
    layersIn = { speed = 1.0, bezier = "emphasizedDecel", style = "popin 96%" },
    layersOut = { speed = 0.8, bezier = "menu_accel", style = "popin 98%" },

    -- fade
    fade = { speed = 3, bezier = "emphasizedDecel" },
    fadeLayersIn = { speed = 0.5, bezier = "menu_decel" },
    fadeLayersOut = { speed = 0.8, bezier = "menu_accel" },

    -- workspaces
    workspaces = { speed = 4, bezier = "menu_decel", style = "slide" },

    -- specialWorkspace
    specialWorkspaceIn = { speed = 2.8, bezier = "emphasizedDecel", style = "slidevert" },
    specialWorkspaceOut = { speed = 1.2, bezier = "emphasizedAccel", style = "slidevert" },
}

for name, points in pairs(curves) do
    hl.curve(name, { type = "bezier", points = points })
end

for leaf, anim in pairs(animations) do
    if anim == false then
        hl.animation { leaf = leaf, enabled = false }
    else
        hl.animation { leaf = leaf, enabled = true, speed = anim.speed, bezier = anim.bezier, style = anim.style }
    end
end
