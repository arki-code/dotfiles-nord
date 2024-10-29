local constants = require("config.constants")
local settings = require("config.settings")

local temperature = sbar.add("item", constants.items.TEMPERATURE, {
  position = "right",
  update_freq = 30, 
  icon = {
    string = settings.icons.text.thermometer,
    color = settings.colors.LIGHT1,
    background = {
      color = settings.colors.DARK4,
      height = 24,
      corner_radius = 17,
    },
  },
  label = {
    string = "??°C",
    color = settings.colors.LIGHT1,
    drawing = true,
  },
  click_script = "sketchybar --set $NAME label.drawing=toggle",
})

local function update_temperature()
  sbar.exec("/usr/local/bin/smctemp -c", function(output)
    local temp = output and output:match("(%d+%.?%d*)")
    
    if temp then
      local rnd_temp = math.floor(tonumber(temp))
      temperature:set({
        label = {
          string = rnd_temp .. "°C",
        },
      })
    else
      temperature:set({
        label = {
          string = "??°C",
        },
      })
    end
  end)
end

temperature:subscribe("routine", update_temperature)

update_temperature()