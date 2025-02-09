local wezterm = require("wezterm")
local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main

local act = wezterm.action

return {
	-- appearence
	colors = theme.colors(),
	window_frame = theme.window_frame(),
	font_size = 15,
	window_background_opacity = 0.95,

	-- ui
	enable_wayland = true,
	front_end = "WebGpu",
	max_fps = 120,
	enable_tab_bar = true,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	-- fix scrolling
	mouse_bindings = {
		{
			event = { Down = { streak = 1, button = { WheelUp = 1 } } },
			mods = "NONE",
			action = act.ScrollByLine(-3),
			alt_screen = false,
		},
		{
			event = { Down = { streak = 1, button = { WheelDown = 1 } } },
			mods = "NONE",
			action = act.ScrollByLine(3),
			alt_screen = false,
		},
	},
}
