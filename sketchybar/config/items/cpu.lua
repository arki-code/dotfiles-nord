local constants = require("config.constants")
local settings = require("config.settings")

local cpu = sbar.add("item", constants.items.CPU, {
  position = "right",
  update_freq = 10,
  icon = {
    string = settings.icons.text.cpu,
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

local function update_cpu()
  sbar.exec("top -l 1 | grep 'CPU usage' | awk '{print $3}'", function(output)
    local usage = output:match("(%d+%.%d+)%%")
    if usage then
      usage = math.floor(tonumber(usage))
      cpu:set({
        label = {
          string = usage .. "%",
        },
      })
    else
      cpu:set({
        label = {
          string = "??%",
        },
      })
    end
  end)
end

cpu:subscribe("routine", update_cpu)

update_cpu()