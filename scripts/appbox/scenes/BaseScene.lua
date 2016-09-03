local BaseScene = class("BaseScene", function()
    return display.newScene("BaseScene")
end)
	
function BaseScene:ctor()
end

function BaseScene:onEnter()

end

function BaseScene:onExit()

end

function BaseScene:onCleanup()
	self:delccsevt()
end

function BaseScene:loadccs(file,isevt)
	return ccsload.load(file,isevt and tostring(self))
end
function BaseScene:addccsevt(listener)
	ccsevt.addEventListenerByTarget(self,tostring(self),listener)
end
function BaseScene:delccsevt()
	ccsevt.removeEventListenerByTarget(self)
end

function BaseScene:initui()	
end

return BaseScene
