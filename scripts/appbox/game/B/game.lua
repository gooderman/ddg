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
	local r = ccsload.load("@B/gmb.json")
	if(r and r.node) then
		self:addChild(r.node)
	end
	r.back:onButtonClicked(function()
		display.popScene()
	end)
	local sp = display.newSprite("@B/B.png", display.cx,display.cy)
	sp:addTo(self)
	sp:runAction(CCRepeatForever:create(CCRotateBy:create(1.0,30)))
end

return Game
