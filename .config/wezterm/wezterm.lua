local wezterm = require("wezterm")
local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main

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
	enable_tab_bar = false,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
}
