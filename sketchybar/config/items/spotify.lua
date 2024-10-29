local constants = require("config.constants")
local settings = require("config.settings")

print("Spotify module loaded")

local spotify = sbar.add("item", constants.items.SPOTIFY, {
  position = "center",
  width = 200,
  icon = {
    drawing = true,
    string = settings.icons.text.spotify,
  },
  label = {
    drawing = true,
    font = {
      family = settings.fonts.text,
      style = settings.fonts.styles.bold,
      size = 12.0
    }
  },
  background = {
    height = 26,
    corner_radius = 9,
    color = settings.colors.DARK2,
    drawing = true
  }
})

local spotify_popup = sbar.add("item", constants.items.SPOTIFY_POPUP, {
  position = "popup." .. constants.items.SPOTIFY,
  drawing = false
})

local function download_cover(url)
  if url and url ~= "" then
    sbar.exec(string.format("curl -s --max-time 20 \"%s\" -o /tmp/spotify_cover.jpg", url))
    return true
  end
  return false
end

spotify:subscribe("media_change", function(env)
  print("Media change event received")
  print("App: " .. (env.INFO.app or "N/A"))
  print("State: " .. (env.INFO.state or "N/A"))
  print("Title: " .. (env.INFO.title or "N/A"))
  print("Artist: " .. (env.INFO.artist or "N/A"))
  print("Album: " .. (env.INFO.album or "N/A"))
  print("Cover URL: " .. (env.INFO.cover_url or "N/A"))

  if env.INFO.app == "Spotify" then
    if env.INFO.state == "playing" then
      local cover_downloaded = download_cover(env.INFO.cover_url)
      spotify:set({
        drawing = true,
        icon = {
          drawing = true,
          string = cover_downloaded and "" or settings.icons.text.spotify,
        },
        label = {
          drawing = true,
          string = env.INFO.artist .. ": " .. env.INFO.title
        },
        background = {
          image = cover_downloaded and "/tmp/spotify_cover.jpg" or nil,
          color = settings.colors.DARK2,
          drawing = true
        }
      })
      
      spotify_popup:set({
        drawing = true,
        label = {
          string = string.format("%s\n%s\n%s", env.INFO.title, env.INFO.artist, env.INFO.album or "")
        }
      })
      
      print("Spotify item updated with current song")
    else
      spotify:set({
        drawing = true,
        width = 200,
        icon = {
          drawing = true,
          string = settings.icons.text.spotify
        },
        label = {
          drawing = true,
          string = "Spotify"
        },
        background = {
          image = nil,
          color = settings.colors.DARK2,
          drawing = true
        }
      })
      spotify_popup:set({
        drawing = false
      })
      print("Spotify not playing")
    end
  end
end)

spotify:subscribe("mouse.clicked", function()
  print("Spotify clicked")
  spotify_popup:set({
    drawing = not spotify_popup:query().drawing
  })
end)

print("Spotify module setup complete")