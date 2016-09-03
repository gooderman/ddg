local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	local layer = display.newColorLayer(ccc4(255,255,255,250)):addTo(self)
	local label = CCLabelTTF:create("Hello World",CFG_SYSTEM_FONT,64):addTo(self):pos(display.cx, display.cy)    
	label:setColor(ccc3(0,0,0))
	label:arch(0.5,0.5)
end

return MainScene
