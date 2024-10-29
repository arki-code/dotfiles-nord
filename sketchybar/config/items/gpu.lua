local constants = require("config.constants")
local settings = require("config.settings")

local gpu = sbar.add("item", constants.items.GPU, {
  position = "right",
  update_freq = 10, 
  icon = {
    string = settings.icons.text.gpu,
    color = settings.colors.LIGHT1,
  },
  label = {
    drawing = true,
  },
})

gpu:subscribe("routine", function()
  sbar.exec("system_profiler SPDisplaysDataType | grep 'Chipset Model'", function(output)
    local usage = output:match("Chipset Model: (.+)")
    if usage then
      gpu:set({
        icon = {
          string = settings.icons.text.gpu,
          color = settings.colors.LIGHT1,
        },
        label = {
          string = usage,
          drawing = true,
        },
      })
    else
      gpu:set({
        icon = {
          string = settings.icons.text.gpu,
          color = settings.colors.LIGHT1,
        },
        label = {
          string = "??",
          drawing = true,
        },
      })
    end
  end)
end)