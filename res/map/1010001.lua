return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.16.1",
  orientation = "orthogonal",
  renderorder = "right-up",
  width = 7,
  height = 7,
  tilewidth = 90,
  tileheight = 90,
  nextobjectid = 36,
  properties = {},
  tilesets = {
    {
      name = "conveyor",
      firstgid = 1,
      filename = "conveyor.tsx",
      tilewidth = 90,
      tileheight = 90,
      spacing = 2,
      margin = 2,
      image = "conveyor.png",
      imagewidth = 462,
      imageheight = 278,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 15,
      tiles = {
        {
          id = 0,
          properties = {
            ["direction"] = "right",
            ["type"] = "conveyor_01_01"
          }
        },
        {
          id = 1,
          properties = {
            ["direction"] = "down",
            ["type"] = "conveyor_01_02"
          }
        },
        {
          id = 2,
          properties = {
            ["direction"] = "left",
            ["type"] = "conveyor_01_03"
          }
        },
        {
          id = 3,
          properties = {
            ["direction"] = "top",
            ["type"] = "conveyor_01_04"
          }
        },
        {
          id = 4,
          properties = {
            ["direction"] = "right",
            ["type"] = "conveyor_02_01"
          }
        },
        {
          id = 5,
          properties = {
            ["direction"] = "down",
            ["type"] = "conveyor_02_02"
          }
        },
        {
          id = 6,
          properties = {
            ["direction"] = "left",
            ["type"] = "conveyor_02_03"
          }
        },
        {
          id = 7,
          properties = {
            ["direction"] = "top",
            ["type"] = "conveyor_02_04"
          }
        },
        {
          id = 8,
          properties = {
            ["direction"] = "down",
            ["type"] = "conveyor_02_05"
          }
        },
        {
          id = 9,
          properties = {
            ["direction"] = "left",
            ["type"] = "conveyor_02_06"
          }
        },
        {
          id = 10,
          properties = {
            ["direction"] = "top",
            ["type"] = "conveyor_02_07"
          }
        },
        {
          id = 11,
          properties = {
            ["direction"] = "right",
            ["type"] = "conveyor_02_08"
          }
        },
        {
          id = 12,
          properties = {
            ["type"] = "conveyor_04_01"
          }
        },
        {
          id = 13,
          properties = {
            ["type"] = "conveyor_04_02"
          }
        }
      }
    },
    {
      name = "surface",
      firstgid = 16,
      filename = "surface.tsx",
      tilewidth = 90,
      tileheight = 90,
      spacing = 2,
      margin = 2,
      image = "surface.png",
      imagewidth = 462,
      imageheight = 370,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 20,
      tiles = {
        {
          id = 0,
          properties = {
            ["type"] = "surface_01_01"
          }
        },
        {
          id = 1,
          properties = {
            ["type"] = "surface_01_02"
          }
        },
        {
          id = 2,
          properties = {
            ["type"] = "surface_01_03"
          }
        },
        {
          id = 3,
          properties = {
            ["type"] = "surface_01_04"
          }
        },
        {
          id = 4,
          properties = {
            ["type"] = "surface_02_01"
          }
        },
        {
          id = 5,
          properties = {
            ["type"] = "surface_02_02"
          }
        },
        {
          id = 6,
          properties = {
            ["type"] = "surface_02_03"
          }
        },
        {
          id = 7,
          properties = {
            ["type"] = "surface_02_04"
          }
        },
        {
          id = 8,
          properties = {
            ["type"] = "surface_02_05"
          }
        },
        {
          id = 9,
          properties = {
            ["type"] = "surface_03_01"
          }
        },
        {
          id = 10,
          properties = {
            ["type"] = "surface_03_02"
          }
        },
        {
          id = 11,
          properties = {
            ["type"] = "surface_03_03"
          }
        },
        {
          id = 12,
          properties = {
            ["type"] = "surface_03_04"
          }
        },
        {
          id = 13,
          properties = {
            ["type"] = "surface_03_05"
          }
        },
        {
          id = 14,
          properties = {
            ["type"] = "surface_03_06"
          }
        },
        {
          id = 15,
          properties = {
            ["type"] = "surface_04_01"
          }
        }
      }
    },
    {
      name = "surfacecollect",
      firstgid = 36,
      filename = "surfacecollect.tsx",
      tilewidth = 90,
      tileheight = 90,
      spacing = 2,
      margin = 2,
      image = "surfacecollect.png",
      imagewidth = 186,
      imageheight = 94,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 2,
      tiles = {
        {
          id = 0,
          properties = {
            ["type"] = "surfacecollect_01_01"
          }
        }
      }
    },
    {
      name = "top",
      firstgid = 38,
      filename = "top.tsx",
      tilewidth = 90,
      tileheight = 90,
      spacing = 2,
      margin = 2,
      image = "top.png",
      imagewidth = 370,
      imageheight = 94,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 4,
      tiles = {
        {
          id = 0,
          properties = {
            ["type"] = "top_01_01"
          }
        },
        {
          id = 1,
          properties = {
            ["type"] = "top_01_02"
          }
        },
        {
          id = 2,
          properties = {
            ["type"] = "top_01_03"
          }
        }
      }
    },
    {
      name = "elem",
      firstgid = 42,
      filename = "elem.tsx",
      tilewidth = 90,
      tileheight = 90,
      spacing = 2,
      margin = 2,
      image = "elem.png",
      imagewidth = 1024,
      imageheight = 1024,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 121,
      tiles = {
        {
          id = 0,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_01_01"
          }
        },
        {
          id = 1,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_01_02"
          }
        },
        {
          id = 2,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_01_03"
          }
        },
        {
          id = 3,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_01_04"
          }
        },
        {
          id = 4,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_01_05"
          }
        },
        {
          id = 5,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_02_01"
          }
        },
        {
          id = 6,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_02_02"
          }
        },
        {
          id = 7,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_02_03"
          }
        },
        {
          id = 8,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_02_04"
          }
        },
        {
          id = 9,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_02_05"
          }
        },
        {
          id = 10,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_03_01"
          }
        },
        {
          id = 11,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_03_02"
          }
        },
        {
          id = 12,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_03_03"
          }
        },
        {
          id = 13,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_03_04"
          }
        },
        {
          id = 14,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_03_05"
          }
        },
        {
          id = 15,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_04_01"
          }
        },
        {
          id = 16,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_04_02"
          }
        },
        {
          id = 17,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_04_03"
          }
        },
        {
          id = 18,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_04_04"
          }
        },
        {
          id = 19,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_04_05"
          }
        },
        {
          id = 20,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_05_01"
          }
        },
        {
          id = 21,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_05_02"
          }
        },
        {
          id = 22,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_05_03"
          }
        },
        {
          id = 23,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_05_04"
          }
        },
        {
          id = 24,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_05_05"
          }
        },
        {
          id = 25,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_06_01"
          }
        },
        {
          id = 26,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_06_02"
          }
        },
        {
          id = 27,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_06_03"
          }
        },
        {
          id = 28,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_06_04"
          }
        },
        {
          id = 29,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_06_05"
          }
        },
        {
          id = 30,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "ture",
            ["type"] = "fruit_11_01"
          }
        },
        {
          id = 31,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_01_01"
          }
        },
        {
          id = 32,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_01_02"
          }
        },
        {
          id = 33,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_01_03"
          }
        },
        {
          id = 34,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_01_04"
          }
        },
        {
          id = 35,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_01_05"
          }
        },
        {
          id = 36,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_01_06"
          }
        },
        {
          id = 37,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_02_01"
          }
        },
        {
          id = 38,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_03_01"
          }
        },
        {
          id = 39,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_03_02"
          }
        },
        {
          id = 40,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_03_03"
          }
        },
        {
          id = 41,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_04_01"
          }
        },
        {
          id = 42,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_05_00"
          }
        },
        {
          id = 43,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_05_01"
          }
        },
        {
          id = 44,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_05_02"
          }
        },
        {
          id = 45,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_05_03"
          }
        },
        {
          id = 46,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_05_04"
          }
        },
        {
          id = 47,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_05_05"
          }
        },
        {
          id = 48,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_05_06"
          }
        },
        {
          id = 49,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_05_07"
          }
        },
        {
          id = 50,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_05_08"
          }
        },
        {
          id = 51,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_05_09"
          }
        },
        {
          id = 52,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_06_01"
          }
        },
        {
          id = 53,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_06_02"
          }
        },
        {
          id = 54,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_07_01"
          }
        },
        {
          id = 55,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_08_01"
          }
        },
        {
          id = 56,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "false",
            ["crashEffect"] = "false",
            ["crashRule"] = "false",
            ["type"] = "obstacle_08_02"
          }
        },
        {
          id = 57,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_09_00"
          }
        },
        {
          id = 58,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_09_00"
          }
        },
        {
          id = 59,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_10_00"
          }
        },
        {
          id = 60,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_11_00"
          }
        },
        {
          id = 61,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_12_01"
          }
        },
        {
          id = 62,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_12_02"
          }
        },
        {
          id = 63,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_12_03"
          }
        },
        {
          id = 64,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_12_04"
          }
        },
        {
          id = 65,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_12_05"
          }
        },
        {
          id = 66,
          properties = {
            ["type"] = "blank"
          }
        },
        {
          id = 67,
          properties = {
            ["type"] = "blank"
          }
        },
        {
          id = 68,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_09_00"
          }
        },
        {
          id = 69,
          properties = {
            ["canFall"] = "false",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_09_00"
          }
        },
        {
          id = 70,
          properties = {
            ["type"] = "blank"
          }
        },
        {
          id = 71,
          properties = {
            ["type"] = "blank"
          }
        },
        {
          id = 72,
          properties = {
            ["type"] = "blank"
          }
        },
        {
          id = 73,
          properties = {
            ["type"] = "blank"
          }
        },
        {
          id = 74,
          properties = {
            ["type"] = "blank"
          }
        },
        {
          id = 75,
          properties = {
            ["type"] = "blank"
          }
        },
        {
          id = 76,
          properties = {
            ["type"] = "blank"
          }
        },
        {
          id = 77,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "false",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_12_06"
          }
        },
        {
          id = 78,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_13_01"
          }
        },
        {
          id = 79,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "true",
            ["crashEffect"] = "true",
            ["crashRule"] = "false",
            ["type"] = "obstacle_13_02"
          }
        },
        {
          id = 80,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "false",
            ["crashRule"] = "false",
            ["type"] = "obstacle_14_01"
          }
        },
        {
          id = 81,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "random_01_01"
          }
        },
        {
          id = 82,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_16_01"
          }
        },
        {
          id = 83,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_16_02"
          }
        },
        {
          id = 84,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_16_03"
          }
        },
        {
          id = 85,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_16_04"
          }
        },
        {
          id = 86,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_16_05"
          }
        },
        {
          id = 87,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_16_06"
          }
        },
        {
          id = 88,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_16_07"
          }
        },
        {
          id = 89,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_16_08"
          }
        },
        {
          id = 90,
          properties = {
            ["canFall"] = "true",
            ["canTouch"] = "true",
            ["crashCollision"] = "false",
            ["crashEffect"] = "true",
            ["crashRule"] = "true",
            ["type"] = "obstacle_16_09"
          }
        }
      }
    },
    {
      name = "mark",
      firstgid = 163,
      filename = "mark.tsx",
      tilewidth = 90,
      tileheight = 90,
      spacing = 2,
      margin = 2,
      image = "mark.png",
      imagewidth = 278,
      imageheight = 186,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 6,
      tiles = {
        {
          id = 0,
          properties = {
            ["type"] = "mark_01_01"
          }
        },
        {
          id = 1,
          properties = {
            ["type"] = "mark_01_02"
          }
        },
        {
          id = 2,
          properties = {
            ["type"] = "mark_02_01"
          }
        },
        {
          id = 3,
          properties = {
            ["type"] = "mark_03_01"
          }
        },
        {
          id = 4,
          properties = {
            ["type"] = "mark_03_02"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "conveyor",
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
      data = "eJxjYGBg4ANiXiBWh9IgvgaSODpfA0mcFBqEGXDIqzMgALI4NoAuDgAvdwJ4"
    },
    {
      type = "imagelayer",
      name = "imagelayer",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      image = "surface.png",
      transparentcolor = "#000000",
      properties = {}
    },
    {
      type = "tilelayer",
      name = "surface",
      x = 0,
      y = 0,
      width = 7,
      height = 7,
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJxjYBj6AAAAxAAB"
    },
    {
      type = "tilelayer",
      name = "object",
      x = 0,
      y = 0,
      width = 7,
      height = 7,
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["bb"] = "cc"
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJxTYWBgUIFiEDABYmcoWwuI9aFi+lBxSyRxLSQxEyjfEknOBE2NFtQeZzQzTKD2qSBhmDnoANmtMBoAOTkHbQ=="
    },
    {
      type = "objectgroup",
      name = "ground",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 27,
          name = "",
          type = "",
          shape = "rectangle",
          x = 317,
          y = 134,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["fallCube"] = "{cherry,cherry,pear}",
            ["fallNum"] = "5",
            ["fallType"] = "listQueue"
          }
        },
        {
          id = 28,
          name = "",
          type = "",
          shape = "rectangle",
          x = 401,
          y = 38,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["fallCube"] = "{pear,cherry,banana,cherry}",
            ["fallNum"] = "10",
            ["fallType"] = "listQueue"
          }
        },
        {
          id = 29,
          name = "",
          type = "",
          shape = "rectangle",
          x = 221,
          y = 36,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["fallCube"] = "{pear,banana,cherry,banana}",
            ["fallNum"] = "10",
            ["fallType"] = "listQueue"
          }
        },
        {
          id = 30,
          name = "",
          type = "",
          shape = "rectangle",
          x = 588,
          y = 117,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["fallCube"] = "{pear,banana,cherry,banana}",
            ["fallNum"] = "10",
            ["fallType"] = "listQueue"
          }
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "rectangle",
          x = 39,
          y = 117,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["fallCube"] = "{pear,cherry,banana,cherry}",
            ["fallNum"] = "10",
            ["fallType"] = "listQueue"
          }
        },
        {
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = 652.5,
          y = -22.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      name = "top",
      x = 0,
      y = 0,
      width = 7,
      height = 7,
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJxjYBj6AAAAxAAB"
    }
  }
}
