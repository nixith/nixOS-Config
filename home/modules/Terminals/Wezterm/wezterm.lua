local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.webgpu_preferred_adapter = {
	backend = "Vulkan",
	device = 8066,
	device_type = "DiscreteGpu",
	driver = "NVIDIA",
	driver_info = "530.41.03",
	name = "NVIDIA GeForce GTX 1650",
	vendor = 4318,
}
config.front_end = "WebGpu"

config = {
	-- enable_wayland = false,

	-- Appearance
	window_decorations = "NONE",
	enable_scroll_bar = false,
	window_padding = {
		left = "0px",
		right = "0px",
		top = "0px",
		bottom = "0px",
	},

	-- Colors, Opacity, and Fonts
	font = wezterm.font("Lilex Nerd Font", { weight = "Bold" }),
	color_scheme = "Catppuccin Macchiato",
	window_background_opacity = 0.4,
	-- colors = {
	-- 	selection_bg = "rgba(50% 50% 50% 50%)",
	-- 	selection_fg = "none",
	-- },
	-- Tab Bar
	hide_tab_bar_if_only_one_tab = true,

	-- shell to run
	default_prog = { "fish", "-l" },

	-- Keybinds
	leader = {
		key = " ",
		mods = "CTRL",
		timeout_milliseconds = 1000,
	},
	keys = {
		{
			key = " ",
			mods = "LEADER|CTRL",
			action = wezterm.action.ShowLauncher,
			name = "Command Pallete",
		},

		{
			key = "|",
			mods = "LEADER|SHIFT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
			name = "horizontal split",
		},

		{
			key = "_",
			mods = "LEADER|SHIFT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
			name = "vertical split",
		},
	},
}

return config
