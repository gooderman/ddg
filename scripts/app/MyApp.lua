require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")
require("framework.scheduler")
require("util.util")
require("util.luabridge")
require("util.zip")
add_search_path(game_upd_path)
add_search_path("res/")
----------------------------
run_lua_file("config_game.lua")
run_lua_file(get_tst_cfg_file())

require("config_debug")
----------------------------
require("util.weaktable")
require("ccs.ccs310")
require("tiled.tiledload")
----------------------------
require("http.http")
----------------------------

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    self:enterScene("MainScene")
end

return MyApp
