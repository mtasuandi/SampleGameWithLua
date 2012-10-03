return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 3,
  height = 1,
  tilewidth = 600,
  tileheight = 400,
  properties = {
  },
  tilesets = {
    {
      name = "parallax-ingame-new-bg",
      firstgid = 1,
      tilewidth = 600,
      tileheight = 400,
      spacing = 0,
      margin = 0,
      image = "parallax-ingame-new-bg.png",
      imagewidth = 600,
      imageheight = 400,
      tiles = {
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 3,
      height = 1,
      visible = true,
      opacity = 1,
      properties = {
      },
      encoding = "lua",
      data = {
        1, 1, 1
      }
    }
  }
}
