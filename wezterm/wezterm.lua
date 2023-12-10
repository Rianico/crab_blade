local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Windows
local os_name = string.lower(os.getenv("OS") or "")
if string.find(os_name, "windows") ~= nil then
    config.webgpu_power_preference = 'HighPerformance'
    config.default_domain = 'WSL:Ubuntu-22.04'
    config.font_size = 12.3
else
    config.webgpu_power_preference = 'LowPower'
    config.font_size = 22.0
end

-- apparance
-- when start up, we maximize the window
wezterm.on('gui-startup', function(window)
    local tab, pane, window = wezterm.mux.spawn_window({})
    local gui_window = window:gui_window();
    gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)

config.color_scheme = 'catppuccin-macchiato'

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- font
config.font = wezterm.font_with_fallback {
    'JetBrainsMonoNL Nerd Font Mono',
}
config.text_background_opacity = 0.618

-- cursor
config.default_cursor_style = 'SteadyUnderline'

-- apparance
config.window_background_opacity = 0.93

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
        '#070d0f',
        '#244048',
        '#44172f',
        '#244048',
        '#925761',
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
    segment_size = 1618,
    segment_smoothness = 1.0,
}

config.colors = {
    tab_bar = {
        -- The color of the inactive tab bar edge/divider
        inactive_tab_edge = '#575757',
    },
}

config.inactive_pane_hsb = {
    saturation = 0.618,
    brightness = 0.382,
}

-- keybinding
config.disable_default_key_bindings = false
config.leader = { key = 'w', mods = 'META', timeout_milliseconds = 2000 }

local act = wezterm.action

config.keys = {
    -- pane
    { key = 'v', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
    { key = 's', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = 'q', mods = 'LEADER', action = act.CloseCurrentPane { confirm = false }, },
    { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState, },

    -- tab
    -- mac
    { key = 't', mods = 'CMD', action = act.SpawnTab 'CurrentPaneDomain', },
    -- windows
    { key = 't', mods = 'META', action = act.SpawnTab 'CurrentPaneDomain', },
    { key = 'w', mods = 'CMD', action = act.CloseCurrentTab { confirm = false }, },

    -- copy and paste
    -- mac
    { key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard', },
    { key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
    -- windows
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
    '[0-9a-zA-Z]{3,40}',
}

return config
