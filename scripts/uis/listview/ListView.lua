
local ScrollView = import(".ScrollView")
local ListView = class("ListView", ScrollView)

function ListView:ctor(rect, direction,clip)
	ListView.super.ctor(self,rect, direction,clip)
	self.cells={}
	self.curridx=1
	self.selectidx=0
	self.touchcell=nil
	self.touchidx=0
	self.cellalign=0--(0-1)
	local nd = display.newNode()
	self:setContainer(nd)
	self.listnd = display.newNode()
	self.container:addChild(self.listnd)
end

function ListView:setContainer(nd)
	if(not self.container) then
		ListView.super.setContainer(self,nd)
	end
end

function ListView:setCellAlign(align)
	if(align>0 and align<=1) then
		self.cellalign = align
	end
end

function ListView:gettouchcell()
	return self.touchcell
end

function ListView:getcurrcell()
	if self.curridx > 0 then
		return self.cells[self.curridx]
	else
		return nil
	end
end

function ListView:getcurridx()
	return self.curridx
end

function ListView:setcurridx(index,anim)
	self:skipToCell(index,nil,anim)
end

function ListView:__addCell(cell)
	self.listnd:addChild(cell)
	self.cells[#self.cells + 1] = cell	
end

function ListView:addCell(cell)
	self:__addCell(cell)
	self:reorder_allcells()
	self:dispatchEvent({name = "addCell", count = #self.cells})
end

function ListView:addCells(cells)
	for _,cell in pairs(cells) do
		self:__addCell(cell)
	end
	self:reorder_allcells()
	self:dispatchEvent({name = "addCells", count = #self.cells})
end


function ListView:setHilight(idx,tag)
	self.selectidx = idx
    for i,v in pairs(self.cells) do
        if(i==idx) then
            v:setHilight(true,tag)
        else
            v:setHilight(false,tag)
        end
    end
end

function ListView:getHilight()
	return self.selectidx or 1
end

function ListView:insertCellAtIndex(cell, index, isRunAction)
	self.view:addChild(cell)
	table.insert(self.cells, index, cell)
	self:reorder_allcells(isRunAction)
	self:dispatchEvent({name = "insertCellAtIndex", index = index, count = #self.cells})
end

function ListView:removeCellAtIndex(index, isRunAction)
	local cell = self.cells[index]
	if isRunAction == true then
	    local pMoveTo = CCMoveTo:create(0.5, ccp(cell:getPositionX()-cell:getContentSize().width, cell:getPositionY()))
	    local pCallFunc = CCCallFunc:create(function ()
	        cell:removeSelf()
	    end)
	    cell:runAction(transition.sequence({pMoveTo, pCallFunc}))
	else
		cell:removeSelf()
	end
	
	table.remove(self.cells, index)
	self:reorder_allcells(isRunAction)
	self:dispatchEvent({name = "removeCellAtIndex", index = index, count = #self.cells})
end

function ListView:skipToCell(index,base,anim, time, easing)

	base = base or 0
	if(anim==nil) then
		anim = true
	end
	time = time or 0.2

	local count = #self.cells
	if count < 1 then
		self.curridx = 0
		return
	end

	if index < 1 then
		index = 1
	elseif index > count then
		index = count
	end
	self.curridx = index

	local offset = 0
	for i = 2, index do
		local cell = self.cells[i-1]
		local size = cell:getContentSize()
		if self.direction == 2 then
			offset = offset + size.width
		else
			offset = offset + size.height
		end
	end

	local cell=self.cells[index]
	local size = cell:getContentSize()
	if self.direction == 2 then
		offset = offset + size.width*self.cellalign
	else
		offset = offset + size.height*self.cellalign
	end

	self:setOffset(base,offset,anim,time,easing)

	self:dispatchEvent({name = "skipToCell", anim = anim, time = time, easing = easing})
end

function ListView:skipToCellIfNeed(index,base,anim, time, easing)

	local count = #self.cells
	if index < 1 or index>count then        
		return
	end
	local offset = 0
	local curoff = 0
	for i = 1, index do
		local cell = self.cells[i]
		local size = cell:getContentSize()
		if self.direction == 2 then
			curoff = offset
			offset = offset + size.width
		else
			curoff = offset
			offset = offset + size.height
		end
	end 
	if(self.direction==1) then  
		if (self.offset[1]-curoff) <= self.clipsz.height and (self.offset[1]-offset) >= 0 then
			return 
		end
	else   
		if (self.offset[1]+offset) <= self.clipsz.width and (self.offset[1]+curoff) >= 0 then
			return
		end     
	end
	self:skipToCell(index,base,anim, time, easing)
end


function ListView:reorder_allcells(isRunAction)
	local count = #self.cells
	local x, y = 0, 0
	local maxw, maxh = 0, 0
	for i = 1, count do
		local cell = self.cells[i]

		if isRunAction == true then
			local pMoveTo = CCMoveTo:create(0.15, ccp(x, y))
			cell:runAction(transition.sequence({CCDelayTime:create(0.55), pMoveTo}))
		else
			cell:setPosition(x, y)
		end
		if self.direction == 2 then
			local width = cell:getContentSize().width
			x = x + width
			maxw= maxw+width
		else
			cell:setAnchorPoint(0, 1)
			local height = cell:getContentSize().height
			y = y - height
			maxh= maxh+height
		end
	end

	if count > 0 then
		if self.curridx < 1 then
			self.curridx = 1
		elseif self.curridx > count then
			self.curridx = count
		end
	else
		self.curridx = 0
	end

	local size
	if self.direction == 1 then
		self.listnd:setPosition(x, maxh)
		size = CCSize(self.clipsz.width, maxh)
	else
		self.listnd:setPosition(0, 0)
		size = CCSize(maxw, self.clipsz.height)
	end
	-- print("----------0000000",x,maxw,maxh)
	self:updataContainer(size)
end

function ListView:onCleanup()
	self:removeAllEventListeners()
end

function ListView:onTouch(event, x, y)
	self.tpp = self.listnd:convertToNodeSpace(ccp(x,y))
	return ListView.super.onTouch(self,event, x, y)
end

function ListView:onTouchBegan(x, y)
	self.touchidx = 0
	self.touchcell = nil
	for i,cell in pairs(self.cells) do
		if(cell:getBoundingBox():containsPoint(ccp(self.tpp.x, self.tpp.y))) then
			self.touchidx = i
			self.touchcell = cell
			self.touchcell:onTouch("began", x, y)
			-- print("onTouchBegan touchcell_idx",i)
			break
		end
	end  
	return ListView.super.onTouchBegan(self,x,y)
end

function ListView:onTouchMoved(x, y)
	ListView.super.onTouchMoved(self,x,y)
	if(self.drag.isdrag) then
		if(self.touchcell) then			
			--print("onTouchMoved touchcell cancelled")	
			self.touchcell:onTouch("cancelled", x, y, true)
			--self.touchidx = 0
			self.touchcell = nil
		end
	else
		if(self.touchcell) then
			--print("onTouchMoved touchcell moved")	
			self.touchcell:onTouch("moved", x, y)
		end
	end
end

function ListView:onTouchEnded(x, y)
	if(self.touchcell) then
		self.touchcell:onTouch("ended", x, y)
	end
	ListView.super.onTouchEnded(self,x,y)
end

return ListView
