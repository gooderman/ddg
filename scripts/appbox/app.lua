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
require("util.fs")
require("http.http")


local App = class("App", cc.mvc.AppBase)

function App:ctor()
    App.super.ctor(self,"App",'appbox')
end

function App:run()
    self:enterScene("MainScene")
end

return App
