local apps = {
  ["Live"] = ":ableton:",
  ["Adobe Bridge 2024"] = ":adobe_bridge:",
  ["Arc"] = ":arc:",
  ["Cursor"] = ":code:",
  ["WezTerm"] = ":wezterm:",
  ["Spotify"] = ":spotify:",
  ["Discord"] = ":discord:",
  ["default"] = ":default:",
  ["Finder"] = ":finder:",
  ["Spotify"] = ":spotify:",
  ["Cyberduck"] = "󰇥",
  ["Godot"] = "",
  ["Whisky"] = "",
  ["EM Client"] = "",
}

local text = {
  nerdfont = {
    disk = "􀤂",
    plus = "",
    loading = "",
    apple = "",
    gear = "",
    cpu = "",
    ram = "􀫦",
    thermometer = "", 
    clipboard = "󰅇",
    switch = {
      on = "􀦍",
      off = "􀤀",
      visible = "􀋭",
      hidden = "􀋯",
    },
    volume = {
      _100 = "",
      _66 = "",
      _33 = "",
      _10 = "",
      _0 = "",
    },
    battery = {
      _100 = "",
      _75 = "",
      _50 = "",
      _25 = "",
      _0 = "",
      charging = "",
    },
    wifi = {
      upload = "",
      download = "",
      connected = "󰖩",
      disconnected = "󰖪",
      router = "󰑩",
    },
    media = {
      back = "􀊎",
      forward = "􀊐",
      play = "􀊄",
      pause = "􀊅",
    },
    slider = {
      knob = ""
    },
    system = {
      reboot = "􀅉",
      shutdown = "􀆨",
      sleep = "􀥦",
      lock = "􀎠",
    },
  },
}

return {
  text = text.nerdfont,
  apps = apps,
}
