return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.16.1",
  orientation = "orthogonal",
  renderorder = "left-up",
  width = 7,
  height = 7,
  tilewidth = 90,
  tileheight = 90,
  nextobjectid = 1,
  backgroundcolor = { 255, 156, 85 },
  properties = {},
  tilesets = {
    {
      name = "surface",
      firstgid = 1,
      tilewidth = 90,
      tileheight = 90,
      spacing = 2,
      margin = 2,
      image = "surface.png",
      imagewidth = 462,
      imageheight = 370,
      transparentcolor = "#910091",
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 20,
      tiles = {}
    },
    {
      name = "elem",
      firstgid = 21,
      tilewidth = 90,
      tileheight = 90,
      spacing = 2,
      margin = 2,
      image = "elem.png",
      imagewidth = 1024,
      imageheight = 1024,
      transparentcolor = "#910091",
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 121,
      tiles = {}
    },
    {
      name = "conveyor",
      firstgid = 142,
      tilewidth = 90,
      tileheight = 90,
      spacing = 2,
      margin = 2,
      image = "conveyor.png",
      imagewidth = 462,
      imageheight = 278,
      transparentcolor = "#910091",
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 15,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "surface",
      x = 0,
      y = 0,
      width = 7,
      height = 7,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJxjYEAAZgZMwAfE7EDMDcQ8QMyLJs8JFePCopcJiAWgNDoAmccPxKxY5ECABYc4NgAARugAlA=="
    }
  }
}
