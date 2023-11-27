local wezterm = require 'wezterm'

local config = {}

config.color_scheme = 'Hardcore'

-- font
config.font = wezterm.font 'JetBrainsMonoNL Nerd Font Mono'
config.font_size = 21.0

config.initial_rows = 47
config.initial_cols = 199
-- apparance
config.window_background_opacity = 1.0

config.window_frame = {
    -- The font used in the tab bar.
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    -- Whatever font is selected here, it will have the
    -- main font setting appended to it to pick up any
    -- fallback fonts you may have used there.
    font = wezterm.font { family = 'Roboto', weight = 'Bold' },

    -- The size of the font in the tab bar.
    -- Default to 10.0 on Windows but 12.0 on other systems
    font_size = 18.0,

    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = '#333333',

    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = '#333333',
}

config.window_background_gradient = {
    -- Can be "Vertical" or "Horizontal".  Specifies the direction
    -- in which the color gradient varies.  The default is "Horizontal",
    -- with the gradient going from left-to-right.
    -- Linear and Radial gradients are also supported; see the other
    -- examples below
    orientation = 'Horizontal',

    -- Specifies the set of colors that are interpolated in the gradient.
    -- Accepts CSS style color specs, from named colors, through rgb
    -- strings and more
    colors = {
        '#0f0c29',
        '#302b63',
        '#24243e',
    },

    -- Instead of specifying `colors`, you can use one of a number of
    -- predefined, preset gradients.
    -- A list of presets is shown in a section below.
    -- preset = "Warm",

    -- Specifies the interpolation style to be used.
    -- "Linear", "Basis" and "CatmullRom" as supported.
    -- The default is "Linear".
    interpolation = 'Linear',

    -- How the colors are blended in the gradient.
    -- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
    -- The default is "Rgb".
    blend = 'Rgb',

    -- To avoid vertical color banding for horizontal gradients, the
    -- gradient position is randomly shifted by up to the `noise` value
    -- for each pixel.
    -- Smaller values, or 0, will make bands more prominent.
    -- The default value is 64 which gives decent looking results
    -- on a retina macbook pro display.
    -- noise = 64,

    -- By default, the gradient smoothly transitions between the colors.
    -- You can adjust the sharpness by specifying the segment_size and
    -- segment_smoothness parameters.
    -- segment_size configures how many segments are present.
    -- segment_smoothness is how hard the edge is; 0.0 is a hard edge,
    -- 1.0 is a soft edge.
    segment_size = 6,
    segment_smoothness = 0.9,
}

config.colors = {
    tab_bar = {
        -- The color of the inactive tab bar edge/divider
        inactive_tab_edge = '#575757',
    },
}

config.inactive_pane_hsb = {
    saturation = 0.2,
    brightness = 0.2,
}

config.hide_tab_bar_if_only_one_tab = true

-- keybinding
config.disable_default_key_bindings = false
config.leader = { key = 'w', mods = 'META', timeout_milliseconds = 2000 }

local act = wezterm.action

config.keys = {
    -- pane
    { key = 'v', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
    { key = 's', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = 'q', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true }, },
    { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState, },

    -- tab
    { key = 't', mods = 'CMD', action = act.SpawnTab 'CurrentPaneDomain', },
    { key = 't', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain', },
    { key = 'w', mods = 'CMD', action = act.CloseCurrentTab { confirm = true }, },

    -- copy and paste
    -- mac
    { key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard', },
    { key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
    -- window
    { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard', },
    { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },

    -- search
    { key = 'f', mods = 'LEADER', action = act.Search { Regex = '', }, },
    -- copy mode
    { key = 'v', mods = 'META', action = act.ActivateCopyMode },
    -- quick select mode
    { key = 's', mods = 'META', action = act.QuickSelect },
}

for i = 1, 8 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'CTRL',
        action = act.ActivateTab(i - 1),
    })
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'CMD',
        action = act.ActivateTab(i - 1),
    })
end

config.quick_select_patterns = {
    -- match things that look like sha1 hashes
    -- (this is actually one of the default patterns)
    '[0-9a-zA-Z]{3,40}',
}

return config
