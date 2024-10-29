local constants = require("config.constants")
local settings = require("config.settings")

local currentAudioDevice = "None"

local volumeValue = sbar.add("item", constants.items.VOLUME .. ".value", {
  position = "right",
  icon = {
    string = settings.icons.text.volume._100,
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
    padding_left = 4,
    drawing = true,
  },
})

local volumeBracket = sbar.add("bracket", constants.items.VOLUME .. ".bracket", { volumeValue.name }, {
  popup = {
    align = "center"
  },
})

local volumeSlider = sbar.add("slider", constants.items.VOLUME .. ".slider", settings.dimens.graphics.popup.width, {
  position = "popup." .. volumeBracket.name,
  slider = {
    highlight_color = settings.colors.ACCENT1,
    background = {
      height = 6,
      corner_radius = 3,
      color = settings.colors.DARK4,
    },
    knob = settings.icons.text.slider.knob,
  },
  click_script = 'osascript -e "set volume output volume $PERCENTAGE"'
})

local toggleLabelVisibility = sbar.add("item", constants.items.VOLUME .. ".toggle", {
  position = "popup." .. volumeBracket.name,
  icon = {
    string = settings.icons.text.switch.visible,
    font = settings.fonts.icons(),
    color = settings.colors.ACCENT1,
  },
  label = {
    string = "Hide current volume",
    color = settings.colors.LIGHT1,
  },
  click_script = "sketchybar --set " .. constants.items.VOLUME .. ".value label.drawing=toggle --trigger volume_toggle_update"
})

volumeValue:subscribe("volume_change", function(env)
  local icon = settings.icons.text.volume._0
  local volume = tonumber(env.INFO)

  sbar.exec("SwitchAudioSource -t output -c", function(result)
    local currentOutputDevice = result:sub(1, -2)
      if currentOutputDevice == "AirPods Pro de Jack" then
        icon = "􀟥"
      elseif currentOutputDevice == "Mega Bose" then
        icon = "􀑈"
      elseif currentOutputDevice == "Haut-parleurs MacBook Pro" then
        icon = "􀝎"
      else
        if volume > 60 then
          icon = settings.icons.text.volume._100
        elseif volume > 30 then
          icon = settings.icons.text.volume._66
        elseif volume > 10 then
          icon = settings.icons.text.volume._33
        elseif volume > 0 then
          icon = settings.icons.text.volume._10
        end
      end

    local lead = ""
    if volume < 10 then
      lead = "0"
    end

    volumeSlider:set({ slider = { percentage = volume } })

    local hasVolume = volume ~= 0
    volumeValue:set({
      icon = {
        string = icon,
        color = settings.colors.LIGHT1,
      },
      label = {
        string = hasVolume and lead .. volume .. "%" or "",
        drawing = volumeValue:query().label.drawing,
      },
    })
  end)
end)

local function toggleVolumeDetails(env)
  if env.BUTTON == "right" then
    sbar.exec("open /System/Library/PreferencePanes/Sound.prefpane")
    return
  end

  local shouldDraw = volumeBracket:query().popup.drawing == "off"
  volumeBracket:set({ popup = { drawing = shouldDraw } })

  if shouldDraw then
    sbar.exec("SwitchAudioSource -t output -c", function(result)
      currentAudioDevice = result:sub(1, -2)

      sbar.exec("SwitchAudioSource -a -t output", function(available)
        local current = currentAudioDevice
        local counter = 0

        for device in string.gmatch(available, '[^\r\n]+') do
          local color = settings.colors.LIGHT1
          if current == device then
            color = settings.colors.ACCENT1
          end

          sbar.add("item", constants.items.VOLUME .. ".device." .. counter, {
            position = "popup." .. volumeBracket.name,
            align = "center",
            label = { string = device, color = color },
            click_script = 'SwitchAudioSource -s "' ..
                device ..
                '" && sketchybar --set /' .. constants.items.VOLUME .. '.device\\.*/ label.color=' ..
                settings.colors.LIGHT1 .. ' --set $NAME label.color=' .. settings.colors.ACCENT1
          })
          counter = counter + 1
        end
      end)
    end)
  else
    sbar.remove("/" .. constants.items.VOLUME .. ".device\\.*/")
  end
end


local function updateToggleVisibility()
  local isLabelVisible = volumeValue:query().label.drawing == "true"
  local newIcon = isLabelVisible and settings.icons.text.switch.visible or settings.icons.text.switch.hidden
  local newLabel = isLabelVisible and "Hide current volume" or "Show current volume"
  
  toggleLabelVisibility:set({
    icon = { 
      string = newIcon,
      color = settings.colors.ACCENT1
    },
    label = { 
      string = newLabel
    }
  })
end

sbar.subscribe("volume_toggle_update", updateToggleVisibility)

updateToggleVisibility()

local function changeVolume(env)
  local delta = env.SCROLL_DELTA
  sbar.exec('osascript -e "set volume output volume (output volume of (get volume settings) + ' .. delta .. ')"')
end

volumeValue:subscribe("mouse.clicked", toggleVolumeDetails)
volumeValue:subscribe("mouse.scrolled", changeVolume)
