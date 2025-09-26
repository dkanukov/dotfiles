local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.window_background_image = "/Users/dmkanukov/.config/wezterm/img/114753344_p0.png"
config.window_background_image_hsb = {
	brightness = 0.5,
	hue = 1.0,
	saturation = 1.0,
}

config.color_scheme = "Gruvbox Dark (Gogh)"

config.font = wezterm.font("FiraMono Nerd Font", { weight = "Medium" })
config.font_size = 16

config.use_fancy_tab_bar = false

config.window_decorations = "RESIZE"

config.keys = {
	{
		key = "d",
		mods = "SUPER",
		action = wezterm.action.SplitHorizontal,
	},
	{
		key = "d",
		mods = "SHIFT|SUPER",
		action = wezterm.action.SplitVertical,
	},
	{
		key = "h",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "x",
		mods = "SUPER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "LeftArrow",
		mods = "SHIFT|CTRL",
		action = wezterm.action.MoveTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "SHIFT|CTRL",
		action = wezterm.action.MoveTabRelative(1),
	},
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action { SendString = "\x1bb" } },
	{ key = "RightArrow", mods = "OPT", action = wezterm.action { SendString = "\x1bf" } },
}

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
	position = "top",
	separator = {
		space = 1,
		left_icon = false,
		right_icon = "",
		field_icon = wezterm.nerdfonts.indent_line,
	},
	modules = {
		username = {
			enabled = false,
		},
		hostname = {
			enabled = false,
		},
	},
})

return config
