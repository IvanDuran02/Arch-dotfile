local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Default Shell: Always launch login Zsh
config.default_prog = { "/usr/bin/zsh", "-l" }

-- Wayland Support
config.enable_wayland = true

-- Font Configuration (Explicitly using JetBrainsMono Nerd Font)
config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono Nerd Font", weight = "Regular" },
	{ family = "JetBrains Mono", weight = "Regular" },
})
config.font_size = 20.0
config.line_height = 1.15

-- Enable font rules for crisp bold & italic rendering
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font({
			family = "JetBrainsMono Nerd Font",
			weight = "Bold",
		}),
	},
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font({
			family = "JetBrainsMono Nerd Font",
			style = "Italic",
		}),
	},
}

-- Color Palette
config.color_scheme = "Catppuccin Mocha"

-- Opacity & Transparency (Replaces old X11 Picom setup)
config.window_background_opacity = 0.88
config.text_background_opacity = 0.80

-- Padding
config.window_padding = {
	left = 12,
	right = 12,
	top = 10,
	bottom = 10,
}

-- Tab Bar Configuration
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.animation_fps = 120

-- Window Frame & Appearance
config.window_decorations = "NONE"

return config
