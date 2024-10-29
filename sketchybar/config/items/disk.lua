local constants = require("config.constants")
local settings = require("config.settings")

local disk = sbar.add("item", constants.items.DISK, {
  position = "right",
  update_freq = 60,
  icon = {
    string = settings.icons.text.disk,
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

local function update_disk()
  sbar.exec("df -h | grep '/System/Volumes/Data' | awk '{print $5}'", function(output)
    local usage = output:match("(%d+)%%")
    if usage then
      usage = math.floor(tonumber(usage))
      disk:set({
        label = {
          string = usage .. "%",
        },
      })
    else
      disk:set({
        label = {
          string = "??%",
        },
      })
    end
  end)
end

disk:subscribe("routine", update_disk)

update_disk()