
local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.color_scheme = "Gruvbox dark, hard (base16)"
-- config.color_scheme = "tokyonight_moon"
config.font = wezterm.font("MonoLisa")
-- work
config.font_size = 12.4
-- home
-- config.font_size = 13.6
-- config.font_size = 13.2
config.line_height = 1.3
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
return config
