local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.color_scheme = 'Gruber (base16)'
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
    left = 30,
    right = 30,
    top = 25,
    bottom = 25,
}
config.font = wezterm.font("IosevkaNLNice Nerd Font")
config.font_size = 15
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Cursor
-- config.cursor_blink_rate = 600
-- config.cursor_blink_ease_in = "Constant"
-- config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "SteadyBlock"

config.hide_mouse_cursor_when_typing = true
config.enable_scroll_bar = false
config.colors = {
    selection_bg = "#264f78",
    selection_fg = "#cccccc",
}

return config
