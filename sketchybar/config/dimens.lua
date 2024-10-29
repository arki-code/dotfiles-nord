local padding = {
  background = 8,
  icon = 8,
  label = 8,
  bar = 8,
  item = 8,
  popup = 8,
}

local graphics = {
  bar = {
    height = 36,
    offset = 5,
  },
  background = {
    height = 28,
    corner_radius = 18,
  },
  slider = {
    height = 20,
  },
  popup = {
    width = 200,
    large_width = 300,
  },
  blur_radius = 30,
}

local text = {
  icon = 16.0,
  label = 14.0,
}

return {
  padding = padding,
  graphics = graphics,
  text = text,
}