local BaseNode = class("BaseNode", function()
    return display.newNode()
end)
	
function BaseNode:ctor()
end

function BaseNode:onEnter()

end

function BaseNode:onExit()

end

function BaseNode:onCleanup()
	self:delccsevt()
end

function BaseNode:loadccs(file,isevt)
	return ccsload.load(file,isevt and tostring(self))
end
function BaseNode:loadccs_child(file,isevt,child)
	return ccsload.load_child(file,isevt and tostring(self),child)
end
function BaseNode:addccsevt(listener)
	ccsevt.addEventListenerByTarget(self,tostring(self),listener)
end
function BaseNode:delccsevt()
	ccsevt.removeEventListenerByTarget(self)
end

function BaseNode:initui()	
end

return BaseNode
