local timer = require("framework.scheduler")
local Game = class("GameScene", function()
    return display.newScene("GameScene")
end)
	
function Game:ctor()
	self:initUi()
end

function Game:onEnter()
end

function Game:onExit()
end

function Game:initUi()
	local r = ccsload.load("@A/gma.json")
	if(r and r.node) then
		self:addChild(r.node)
	end
	r.back:onButtonClicked(function()
		display.popScene()
	end)
	local sp = display.newSprite("@A/img.png", display.cx,display.cy)
	if(sp) then
		sp:addTo(self)
		sp:runAction(CCRepeatForever:create(CCRotateBy:create(1.0,30)))
	end
	http.get("img",'https://cn.bing.com/rms/rms%20answers%20Homepage%20ZhCn$BingAppQR/ic/23813331/c3977686.png',30,function(id,code,data)
		print("http = ",id,code)
		if(code==0) then
			local path = fs.fullpath("appbox/game/A/").."res_v2/"
			fs.mkdir(path)
			fs.write(path .. "down.png", data, 'w+b')
		end
	end)
end

return Game
