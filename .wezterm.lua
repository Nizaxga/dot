local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.color_scheme = 'Gruvbox Dark (Gogh)'
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
    left = 25,
    right = 25,
    top = 25,
    bottom = 25,
}
config.font = wezterm.font("IosevkaNLNice Nerd Font")
config.font_size = 17
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

-- Cursor
config.cursor_blink_rate = 600
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "SteadyBlock"
config.freetype_load_target = 'Light'
config.freetype_render_target = 'HorizontalLcd'
config.hide_mouse_cursor_when_typing = true
config.enable_scroll_bar = false

return config
