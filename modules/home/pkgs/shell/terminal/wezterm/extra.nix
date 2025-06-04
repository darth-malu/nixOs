/*lua*/''
-- Your lua code / config here
local wezterm = require 'wezterm'
-- local act = wezterm.action
local config =  wezterm.config_builder() -- improves error log msgs

-- Show which key table is active in the status area
-- wezterm.on('update-right-status', function(window, pane))
--   local name = window:active_key_table()
--   if name then
--     name = 'TABLE: ' .. name
--   end
--   window:set_right_status(name or \'\')
-- end)

-- config.font = wezterm.font ('Fira Code', { weight = 'Bold', italic = true })
config.font = wezterm.font_with_fallback({
  {
    family = "JetBrains Mono",
    -- scale = 1.0, -- messes with lualine?
    weight = 'Medium', --Medium, Regular, DemiBold
    style = "Normal",
    stretch = "Normal",
    -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
    -- calt aka:Contextual Alternates
    -- clig aka: Contextual Ligatures Replaces a sequence of glyphs with a single glyph which is preferred for typographic purposes. Unlike other ligature features
    --TODO: investigate further
  },
  { family = "SpaceMono Nerd Font", scale = 1.0, weight = 'Medium', },
  { family = "Symbols Nerd Font", }
  })
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font("JetBrains Mono", { weight = "Bold", stretch = "Normal", style = "Normal" }),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font("JetBrains Mono", { weight = "Bold", stretch = "Normal", style = "Italic" }),
	},
}
config.font_size =  11.2 --10windows::, 12:: linux,
-- config.color_scheme = 'Tokyo Night' -- 'Tokyo Night', 'terafox
config.default_cursor_style = 'SteadyBlock' --SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar
config.animation_fps = 10 -- blinking cursors, visual bell, blinking text
config.max_fps = 200
config.front_end = "OpenGL"

-- Trying font fix
config.freetype_load_flags = 'NO_HINTING'
-- config.line_height = 0.9 --1.0
config.line_height = 1.0
-- config.cell_width = 0.9
config.pane_focus_follows_mouse = true; -- false::
config.default_workspace = "tilde"
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace" -- WhenFollowedBySpace, Always, Never
-- config.background = {
--   {
--     source = {
--       Color = "#282c35",
--       width = "100%",
--       height = "100%",
--       opacity = 0.55,
--     }
--   }
-- }
-- config.skip_close_confirmation_for_processes_named = {
--   'bash',
--   'sh',
--   'zsh',
--   'fish',
--   'tmux',
--   'nu',
--   'cmd.exe',
--   'pwsh.exe',
--   'powershell.exe',
-- }
-- config.colors = {
--
-- }
config.default_cwd = "/home/malu/Shibuya"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.74
config.scrollback_lines = 3500
-- config.compose_cursor = 'orange'
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.leader = { key ="a", mods = "CTRL", timeout_milliseconds = 1000 }
-- config.keys = {
--
-- }
-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.5
}

config.colors = {
  -- The default text color
  foreground = '#35A29F', -- 'silver'
  -- The default background color
  background = '#022223', -- black, #022223

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = '#FAA6FF', -- '#52ad70'
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = 'black',
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = '#FAA6FF',

  -- the foreground color of selected text
  selection_fg = 'black',
  -- the background color of selected text
  selection_bg = '#fffacd',

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#222222',

  -- The color of the split lines between panes
  split = '#52ad70',

  ansi = {
    'black',
    'maroon',
    'green',
    'olive',
    'navy',
    'purple',
    'teal',
    'silver',
  },
  brights = {
    'grey',
    'red',
    'lime',
    'yellow',
    'blue',
    'fuchsia',
    'aqua',
    'white',
  },

  -- Arbitrary colors of the palette in the range from 16 to 255
  -- indexed = { [136] = '#af8700' },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = 'orange',

  -- Colors for copy_mode and quick_select
  -- available since: 20220807-113146-c2fee766
  -- In copy_mode, the color of the active text is:
  -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- 2. selection_* otherwise
  copy_mode_active_highlight_bg = { Color = '#000000' },
  -- use `AnsiColor` to specify one of the ansi color palette values
  -- (index 0-15) using one of the names "Black", "Maroon", "Green",
  --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
  -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
  copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
  copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
  copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

  quick_select_label_bg = { Color = 'peru' },
  quick_select_label_fg = { Color = '#ffffff' },
  quick_select_match_bg = { AnsiColor = 'Navy' },
  quick_select_match_fg = { Color = '#ffffff' },
}

return config      
''
