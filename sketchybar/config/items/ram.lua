local constants = require("config.constants")
local settings = require("config.settings")

local ram = sbar.add("item", constants.items.RAM, {
  position = "right",
  update_freq = 10,  
  icon = {
    string = settings.icons.text.ram,
    color = settings.colors.LIGHT1,
    background = {
      color = settings.colors.DARK4,
      height = 24,
      corner_radius = 17,
    },
  },
  label = {
    string = "??%",
    color = settings.colors.LIGHT1,
    drawing = true,
  },
  click_script = "sketchybar --set $NAME label.drawing=toggle",
})

local function update_ram()
  sbar.exec([[
    memory_pressure | grep "System-wide memory free percentage:" | awk '{print $5}'
  ]], function(output)
    local pressure = output:match("(%d+)%%")
    if pressure then
      ram:set({
        label = {
          string = pressure .. "%",
        },
      })
    else
      ram:set({
        label = {
          string = "??%",
        },
      })
    end
  end)
end

ram:subscribe("routine", update_ram)

update_ram()  