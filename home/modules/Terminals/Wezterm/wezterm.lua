local wezterm = require("wezterm")
return {
	-- Appearance
	-- Colors, Opacity, and Fonts
	font = wezterm.font("JetBrainsMono Nerd Font Mono"),
	color_scheme = "Catppuccin Mocha",
	window_background_opacity = 0.2,
	colors = {
  	selection_bg = 'rgba(50% 50% 50% 50%)',
  	selection_fg = 'none',
},
	-- Tab Bar
	hide_tab_bar_if_only_one_tab = true,

	-- shell to run
	default_prog = { 'fish', '-l' },

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
