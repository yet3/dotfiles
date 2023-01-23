local wezterm = require 'wezterm'

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local edge_background = '#191724'
    local background = '#1f1d2e'
    local foreground = '#6e6a86'

    if tab.is_active then
      background = '#26233a'
      foreground = '#e0def4'
    end

    local edge_foreground = background

    local title = wezterm.truncate_right(tab.active_pane.title, max_width - 3)

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = ' ' },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = '' },
    }
  end
)

local keys = {
  {
    key = 'w',
    mods = 'CMD|SHIFT',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'w',
    mods = 'CMD|CTRL',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'l',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ActivatePaneDirection("Right")
  },
  {
    key = 'h',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ActivatePaneDirection("Left")
  },
  {
    key = 'k',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ActivatePaneDirection("Up")
  },
  {
    key = 'j',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ActivatePaneDirection("Down")
  },
  {
    key = 'v',
    mods = 'CMD|CTRL',
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" })
  },
  {
    key = 'h',
    mods = 'CMD|CTRL',
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" })
  },
  {
    key = 'f',
    mods = 'CMD|CTRL',
    action = wezterm.action.TogglePaneZoomState
  },


  {
    key = 'l',
    mods = 'CMD',
    action = wezterm.action.ActivateTabRelative(1)
  },
  {
    key = 'h',
    mods = 'CMD',
    action = wezterm.action.ActivateTabRelative(-1)
  },

  {
    key = 'c',
    mods = 'CMD',
    action = wezterm.action.CopyTo("Clipboard")
  },
  {
    key = 'v',
    mods = 'CMD',
    action = wezterm.action.PasteFrom("Clipboard")
  },
  {
    key = 'n',
    mods = 'CMD',
    action = wezterm.action.SpawnWindow
  },
  {
    key = '-',
    mods = 'CMD',
    action = wezterm.action.DecreaseFontSize
  },
  {
    key = '=',
    mods = 'CMD',
    action = wezterm.action.IncreaseFontSize
  },
  {
    key = '0',
    mods = 'CMD',
    action = wezterm.action.ResetFontSize
  },
  {
    key = 't',
    mods = 'CMD',
    action = wezterm.action.SpawnTab("CurrentPaneDomain")
  },
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentTab({ confirm = true })
  },

  {
    key = '9',
    mods = 'CMD',
    action = wezterm.action.ActivateTab(-1)
  }
}

-- Quick tab switching using CMD + 1-9
for i = 0, 7 do
  table.insert(keys,
    {
      key = tostring(i + 1),
      mods = 'CMD',
      action = wezterm.action.ActivateTab(i)
    }
  )
end

return {
  font                         = wezterm.font('CaskaydiaCove Nerd Font'),
  font_size                    = 16.0,
  color_scheme                 = 'Rosé Pine (base16)',
  window_background_opacity    = 0.99,
  enable_tab_bar               = true,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar            = false,
  tab_bar_at_bottom            = true,
  window_padding               = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  },

  tab_max_width = 24,
  colors = {
    tab_bar = {
      background = '#191724',
      active_tab = {
        italic = true,
        intensity = 'Bold',
        bg_color = '#26233a',
        fg_color = '#e0def4',
      },
      new_tab = {
        bg_color = '#191724',
        fg_color = '#908caa',
      }
    }
  },
  disable_default_key_bindings = true,
  keys = keys
}
