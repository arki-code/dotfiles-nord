local constants = require("config.constants")
local settings = require("config.settings")

sbar.exec(
  "killall network_load >/dev/null; $CONFIG_DIR/bridge/network_load/bin/network_load en0 network_update 2.0"
)

local wifi = sbar.add("item", constants.items.WIFI, {
  position = "right",
  icon = {
    string = settings.icons.text.wifi.connected,
    color = settings.colors.LIGHT1,
    background = {
      color = settings.colors.DARK4,
      height = 24,
      corner_radius = 17,
    },
  },
  label = {
    string = "",
    color = settings.colors.LIGHT1,
    drawing = false,
  },
})

local popupWidth = settings.dimens.graphics.popup.width + 20

local ssid = sbar.add("item", {
  position = "popup." .. wifi.name,
  width = popupWidth,
  icon = {
    string = settings.icons.text.wifi.router,
    font = { style = settings.fonts.styles.bold },
  },
  label = {
    font = { style = settings.fonts.styles.bold, size = settings.dimens.text.label },
    max_chars = 18,
    string = "????????????",
  },
})

local function addPopupItem(title, defaultValue)
  return sbar.add("item", {
    position = "popup." .. wifi.name,
    background = { height = 16 },
    icon = {
      align = "left",
      string = title,
      width = popupWidth / 2,
      font = { size = settings.dimens.text.label },
    },
    label = {
      align = "right",
      string = defaultValue,
      width = popupWidth / 2,
    }
  })
end

local hostname = addPopupItem("Hostname:", "????????????")
local ip = addPopupItem("IP:", "???.???.???.???")
local router = addPopupItem("Router:", "???.???.???.???")
local upload = addPopupItem("Upload:", "??? Bps")
local download = addPopupItem("Download:", "??? Bps")

local currentUpload = "??? Bps"
local currentDownload = "??? Bps"

wifi:subscribe("network_update", function(env)
  currentUpload = env.upload
  currentDownload = env.download
  upload:set({ label = { string = currentUpload } })
  download:set({ label = { string = currentDownload } })
end)

wifi:subscribe({ "wifi_change", "system_woke", "forced" }, function(env)
  sbar.exec([[ipconfig getifaddr en0]], function(ip)
    local ipConnected = not (ip == "")
    local wifiIcon = ipConnected and settings.icons.text.wifi.connected or settings.icons.text.wifi.disconnected
    local wifiColor = ipConnected and settings.colors.white or settings.colors.magenta

    wifi:set({ icon = { string = wifiIcon, color = wifiColor } })

    sbar.exec([[sleep 2; scutil --nwi | grep -m1 'utun' | awk '{ print $1 }']], function(vpn)
      local isVPNConnected = not (vpn == "")
      if isVPNConnected then
        wifi:set({ icon = { string = settings.icons.text.wifi.vpn, color = settings.colors.green } })
      end
    end)
  end)
end)

local function updatePopupInfo()
  sbar.exec("networksetup -getcomputername", function(result) hostname:set({ label = result }) end)
  sbar.exec("ipconfig getifaddr en0", function(result) ip:set({ label = result }) end)
  sbar.exec("ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'", function(result) ssid:set({ label = result }) end)
  sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Router: ' '/^Router: / {print $2}'", function(result) router:set({ label = result }) end)
  upload:set({ label = { string = currentUpload } })
  download:set({ label = { string = currentDownload } })
end

local function toggleDetails()
  local shouldDrawDetails = wifi:query().popup.drawing == "off"
  wifi:set({ popup = { drawing = shouldDrawDetails } })
  if shouldDrawDetails then updatePopupInfo() end
end

local function copyLabelToClipboard(env)
  local label = sbar.query(env.NAME).label.value
  sbar.exec("echo \"" .. label .. "\" | pbcopy")
  sbar.set(env.NAME, { label = { string = settings.icons.text.clipboard, align = "center" } })
  sbar.delay(1, function() sbar.set(env.NAME, { label = { string = label, align = "right" } }) end)
end

wifi:subscribe("mouse.clicked", toggleDetails)
ssid:subscribe("mouse.clicked", copyLabelToClipboard)
hostname:subscribe("mouse.clicked", copyLabelToClipboard)
ip:subscribe("mouse.clicked", copyLabelToClipboard)
router:subscribe("mouse.clicked", copyLabelToClipboard)
upload:subscribe("mouse.clicked", copyLabelToClipboard)
download:subscribe("mouse.clicked", copyLabelToClipboard)
