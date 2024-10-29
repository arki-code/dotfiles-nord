local wezterm = require("wezterm")
local act = wezterm.action
local config = {}


if wezterm.config_builder then
    config = wezterm.config_builder()
  end

config = {
  --                                           __
  --         ____ ____  ____  ___  _________ _/ /
  --        / __ `/ _ \/ __ \/ _ \/ ___/ __ `/ / 
  --       / /_/ /  __/ / / /  __/ /  / /_/ / /  
  --       \__, /\___/_/ /_/\___/_/   \__,_/_/   
  --      /____/

  color_scheme = 'nord',


  --          __         ____
  --         / /_  ___  / / /
  --        / __ \/ _ \/ / / 
  --       / /_/ /  __/ / /  
  --      /_.___/\___/_/_/

  visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 75,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 150,
  },
  colors = {
    visual_bell = 'rgba(143, 188, 187, 0.5)',
  },

  --                 _           __             
  --       _      __(_)___  ____/ /___ _      __
  --      | | /| / / / __ \/ __  / __ \ | /| / /
  --      | |/ |/ / / / / / /_/ / /_/ / |/ |/ / 
  --      |__/|__/_/_/ /_/\__,_/\____/|__/|__/

  window_close_confirmation = "NeverPrompt",
  adjust_window_size_when_changing_font_size = false,
  window_background_opacity = 0.88,
  window_decorations = "RESIZE",

  window_padding = {
    left = 0, 
    right = 3,
    top = 15,
    bottom = 0,
  },
  window_background_gradient = {
      interpolation = 'Linear',
      orientation = 'Vertical',
      blend = 'Rgb',
    
      colors = {
        '#4C566A',
        '#2E3440'
      }
    },

  --          ____            __      
  --         / __/___  ____  / /______
  --        / /_/ __ \/ __ \/ __/ ___/
  --       / __/ /_/ / / / / /_(__  ) 
  --      /_/  \____/_/ /_/\__/____/

  default_cursor_style = "BlinkingBar",
  font_size = 14,
  font = wezterm.font("Fira Code", { weight = "Regular" }),
  --         __        __       __              
  --        / /_____ _/ /_     / /_  ____ ______
  --       / __/ __ `/ __ \   / __ \/ __ `/ ___/
  --      / /_/ /_/ / /_/ /  / /_/ / /_/ / /    
  --      \__/\__,_/_.___/  /_.___/\__,_/_/

  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  status_update_interval = 1000,
  tab_bar_at_bottom = false,
  show_new_tab_button_in_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  colors = {
    tab_bar = {
      background = "rgba(0,0,0,0)",
    }
  },  
  --                    _          
  --         ____ ___  (_)_________
  --        / __ `__ \/ / ___/ ___/
  --       / / / / / / (__  ) /__  
  --      /_/ /_/ /_/_/____/\___/

  automatically_reload_config = true,
  send_composed_key_when_left_alt_is_pressed = true,
  send_composed_key_when_right_alt_is_pressed = true,
  check_for_updates = true,
  visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 150,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 150,
  },

  --          __              __    _           __    
  --         / /_____  __  __/ /_  (_)___  ____/ /____
  --        / //_/ _ \/ / / / __ \/ / __ \/ __  / ___/
  --       / ,< /  __/ /_/ / /_/ / / / / / /_/ (__  ) 
  --      /_/|_|\___/\__, /_.___/_/_/ /_/\__,_/____/  
  --               /____/

  keys = {
    { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    
    { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'F', mods = 'CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },

    { key = 'p', mods = 'SUPER', action = act.ActivateCommandPalette },
    { key = 't', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },

    { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
    { key = 'f', mods = 'SUPER', action = act.Search 'CurrentSelectionOrEmptyString' },

    { key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },

    { key = 'w', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab{ confirm = true } },
    { key = 'w', mods = 'SUPER', action = act.CloseCurrentTab{ confirm = true } },

    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },

    { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left' },
    { key = 'LeftArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Left', 1 } },
    { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right' },
    { key = 'RightArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' },
    { key = 'UpArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Up', 1 } },
    { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down' },
    { key = 'DownArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Down', 1 } },
    { key = 's', 
      mods = 'SHIFT|CTRL', 
      action = wezterm.action.SplitPane { direction = 'Left', size = { Percent = 50 } },
    },
    { key = 'w', mods = 'SHIFT|CTRL', action = wezterm.action.CloseCurrentPane { confirm = false },
    }, 
    { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Next' },
  },

  --                    __    
  --        __  _______/ /____
  --       / / / / ___/ / ___/
  --      / /_/ / /  / (__  ) 
  --      \__,_/_/  /_/____/

  -- from: https://akos.ma/blog/adopting-wezterm/
  hyperlink_rules = {
    -- Matches: a URL in parens: (URL)
    {
      regex = "\\((\\w+://\\S+)\\)",
      format = "$1",
      highlight = 1,
    },
    -- Matches: a URL in brackets: [URL]
    {
      regex = "\\[(\\w+://\\S+)\\]",
      format = "$1",
      highlight = 1,
    },
    -- Matches: a URL in curly braces: {URL}
    {
      regex = "\\{(\\w+://\\S+)\\}",
      format = "$1",
      highlight = 1,
    },
    -- Matches: a URL in angle brackets: <URL>
    {
      regex = "<(\\w+://\\S+)>",
      format = "$1",
      highlight = 1,
    },
    -- Then handle URLs not wrapped in brackets
    {
      -- Before
      --regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
      --format = '$0',
      -- After
      regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
      format = "$1",
      highlight = 1,
    },
    -- implicit mailto link
    {
      regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
      format = "mailto:$0",
    },
  }
}



  --         ___              __  _             
  --        / _/_ _____  ____/ /_(_)__  ___  ___
  --       / _/ // / _ \/ __/ __/ / _ \/ _ \(_-<
  --      /_/ \_,_/_//_/\__/\__/_/\___/_//_/___/

  function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
      return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
  end
  
  wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
      local edge_background = "rgba(0,0,0,0)"
      local background = '#3B4252'
      local foreground = '#8FBCBB'
  
      if tab.is_active then
        background = '#3B4252'
        foreground = '#c0c0c0'
      elseif hover then
        background = '#3b3052'
        foreground = '#909090'
      end
  
      local edge_foreground = background
  
      local title = tab_title(tab)
    
      return {
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = "" },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = title },
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = " " },
      }
    end
  )
  
  return config