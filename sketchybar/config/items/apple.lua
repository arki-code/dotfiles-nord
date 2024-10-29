local settings = require("config.settings")
local constants = require("config.constants")

local apple = sbar.add("item", "apple", {
  icon = { 
    string = settings.icons.text.apple,
    padding_left = 14,
  },
  label = { drawing = false },
  background = { 
    color = settings.colors.DARK4,
    height = 36,
    corner_radius = 18,
    padding_left = -15,
  },
  width = 40,
  click_script = "sketchybar --set apple popup.drawing=toggle",
  popup = {
    align = "left",
    height = 32,
    horizontal = false,
  }
})

-- Bouton de verrouillage
local lockButton = sbar.add("item", "apple.lock", {
  position = "popup.apple",
  icon = {
    string = settings.icons.text.system.lock,
    font = settings.fonts.icons(),
    color = settings.colors.ACCENT1,
    padding_left = 10,
    width = 32,
  },
  label = {
    string = "Lock",
    color = settings.colors.LIGHT1,
  },
  click_script = "osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down, control down}'"
})


local sleepButton = sbar.add("item", "apple.sleep", {
  position = "popup.apple",
  icon = {
    string = settings.icons.text.system.sleep,
    font = settings.fonts.icons(),
    color = settings.colors.ACCENT1,
    padding_left = 10,
    width = 32,
  },
  label = {
    string = "Sleep",
    color = settings.colors.LIGHT1,
  },
  click_script = "osascript -e 'tell application \"System Events\" to sleep'"
})


local rebootButton = sbar.add("item", "apple.reboot", {
  position = "popup.apple",
  icon = {
    string = settings.icons.text.system.reboot,
    font = settings.fonts.icons(),
    color = settings.colors.ACCENT1,
    padding_left = 10,
    width = 32,
  },
  label = {
    string = "Reboot",
    color = settings.colors.LIGHT1,
  },
  click_script = "osascript -e 'tell app \"System Events\" to restart'"
})


local shutdownButton = sbar.add("item", "apple.shutdown", {
  position = "popup.apple",
  icon = {
    string = settings.icons.text.system.shutdown,
    font = settings.fonts.icons(),
    color = settings.colors.ACCENT1,
    padding_left = 10,
    width = 32,
  },
  label = {
    string = "Shutdown",
    color = settings.colors.LIGHT1,
  },
  click_script = "osascript -e 'tell app \"System Events\" to shut down'"
})

local function hidePopup()
  apple:set({ popup = { drawing = false } })
end

apple:subscribe("mouse.exited.global", hidePopup)


