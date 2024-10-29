local colors = {
  black = 0xff181819,
  white = 0xfff8f8f2,
  red = 0xf1cc3e44,
  green = 0xff8aff81,
  blue = 0xff5199ba,
  yellow = 0xffffff81,
  orange = 0xfff4c07b,
  magenta = 0xd3fc7ebd,
  purple = 0xff796fa9,
  other_purple = 0xff302c45,
  cyan = 0xff7bf2de,
  grey = 0xff7f8490,
  dirty_white = 0xc8cad3f5,
  dark_grey = 0xff2b2736,
  transparent = 0x00000000,
  DARK1="0xFF2E3440",
  DARK2="0xFF3B4252",
  DARK3="0xFF434C5E",
  DARK4="0xFF4C566A",
  LIGHT1="0xFFD8DEE9",
  LIGHT2="0xFFE5E9F0",
  LIGHT3="0xFFECEFF4",
  LIGHT4="0xFF8FBCBB",
  ACCENT1="0xFF88C0D0",
  ACCENT2="0xFF81A1C1",
  ACCENT3="0xFF5E81AC",
  ACCENT4="0xFFBF616A",
  ACCENT5="0xFFD08770",
  ACCENT6="0xFFEBCB8B",
  ACCENT7="0xFFA3BE8C",
  ACCENT8="0xFFB48EAD",
  bar = {
    bg = 0xFF2E3440,
    border = 0xff2c2e34,
  },
  popup = {
    bg = 0xFF3B4252,
    border = 0xFF4C566A,
  },
  slider = {
    bg = 0xFF4C566A,
    border = 0xFF88C0D0,
  },
  bg1 = 0xd322212c,
  bg2 = 0xff302c45,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}

return colors