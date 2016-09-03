
local ScrollView = class("ScrollView", function(rect)
	local node = display.newNode()
	node:setNodeEventEnabled(true)
	cc(node):addComponent("components.behavior.EventProtocol"):exportMethods()
	return node
end)

--DIRECTION_VERTICAL   = 1
--DIRECTION_HORIZONTAL = 2

local FORCE_ACC=1000 --摩擦力
local OUT_BOUNCE_RATE=10 --越界减速1/15每帧
local SPEED_MIN=50--惯性最低速度
local OUT_BOUNCE_DRAG_RATE=0.4--越界拖动位移系数

function ScrollView:ctor(rect, direction,clip)
	self.drag={}
	self.drag_min=15
	self.outofbounce=true
	self.allsz={0,0}
	self.offset={0,0,0}
	self.offset_v={0,0,0} --下界
	self.offset_h={0,0,0} --上界=0
	self.currdt=0 --当前时间点
	self.speed=0 --惯性滑动速度
	self.recspeed=0 --惯性滑动初速度

	self.direction = direction
	self.cliprect = rect
	self.clipsz = rect.size
	self:setContentSize(self.clipsz)
	self.bgsp=nil
	self.container=nil	
	self.clipnd = nil
	if not clip then
		self.clipnd = display.newNode()	
		self.clipnd:setAnchorPoint(ccp(0,0))
		self.clipnd:setPosition(0, 0)
	else
		self.clipnd = display.newClippingRegionNode(rect)
	end	
	self:addChild(self.clipnd)

	self:setNodeEventEnabled(true)
	self.clipnd:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		return self:onTouch(event.name, event.x, event.y)
	end)
	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT,handler(self,self.update))

	self:scheduleUpdate_()

end

function ScrollView:setBgSp(sp)
	if(self.bgsp) then
		self.bgsp:removeSelf()
	end
	self.bgsp=sp
	self.bgsp:setPosition(self.clipsz.width/2, self.clipsz.height/2)
	self:addChild(self.bgsp,-1)
end
function ScrollView:setBgColor(color)
	if(self.bgsp) then
		self.bgsp:removeSelf()
	end
	self.bgsp=display.newColorLayer(ccc4(color.r,color.g,color.b,color,a))
	self.bgsp:setContentSize(self.clipsz)
	self.bgsp:setPosition(0,0)
	self:addChild(self.bgsp,-1)
end

function ScrollView:setBg(path)

end

function ScrollView:update(dt)	
	self.currdt=self.currdt+dt
	--//速度不为0
	--//摩擦力
	local acc=dt*FORCE_ACC
	if(self.speed~=0) then
		if(acc>math.abs(self.speed)) then
			self:resetspeed()
		else
			if(self.speed>0) then--//上			
				self.speed=self.speed-acc
				if(self.offset[1]>self.offset[3]) then
					self.speed=self.speed-(math.abs(self.recspeed)/OUT_BOUNCE_RATE)--;//越界减速
				end
			elseif(self.speed<0) then--//下			
				self.speed=self.speed+acc
				if(self.offset[1]<self.offset[2]) then
					self.speed=self.speed+(math.abs(self.recspeed)/OUT_BOUNCE_RATE)--;//越界减速
				end
			end
			if(self.direction==1) then
				self:addOffset(0,self.speed*dt)--//微调坐标
			else
				self:addOffset(self.speed*dt,0)--//微调坐标
			end
			if(math.abs(self.speed)<SPEED_MIN) then--//最低速度
				self:resetspeed()
			end
		end	
	elseif(not (self.drag.istap or self:getActionByTag(1000))) then	
		--//速度0 且 没有触摸 时检查回滚		
		self:backscroll()
	end
	if(self.container) then
		if(self.direction==1) then
			self.container:setPositionY(self.offset[1])
		else
			self.container:setPositionX(self.offset[1])
		end	
	end	
end	

function ScrollView:setContainer(nd)
	self.container = nd
	self.clipnd:removeAllChildren()
	self.allsz = nd:getContentSize()
	self.clipnd:addChild(nd)
	--allsz < allsz 取最大
	self.offset_v={self.clipsz.height,self.clipsz.height,math.max(self.allsz.height,self.clipsz.height)}
	self.offset_h={0,math.min(0,self.clipsz.width-self.allsz.width),0}
	if(self.direction==1) then
		nd:setPosition(self.clipsz.width/2, self.clipsz.height)
		self.offset = self.offset_v
		nd:setAnchorPoint(ccp(0.5,1))
	else	
		nd:setPosition(0, self.clipsz.height/2)
		self.offset = self.offset_h
		nd:setAnchorPoint(ccp(0,0.5))
	end
end
function ScrollView:updataContainer(sz)
	self.container:setContentSize(sz)
	self.allsz = sz
	--allsz < allsz 取最大
	self.offset_v={self.clipsz.height,self.clipsz.height,math.max(self.allsz.height,self.clipsz.height)}
	self.offset_h={0,math.min(0,self.clipsz.width-self.allsz.width),0}
	if(self.direction==1) then
		self.offset[2]=self.offset_v[2]
		self.offset[3]=self.offset_v[3]
	else	
		self.offset[2]=self.offset_h[2]
		self.offset[3]=self.offset_h[3]
	end
end

function ScrollView:getOffset()
	return self.offset[1]
end

function ScrollView:setTouchEnabled(enabled)
	self.clipnd:setTouchEnabled(enabled)
end

function ScrollView:addOffset(dx,dy)
	local rate = OUT_BOUNCE_DRAG_RATE
	if self.direction == 1 then		
		if(self.offset[1]<self.offset[2] and dy<0) then
			self.offset[1]=self.offset[1]+dy*rate
		elseif(self.offset[1]>self.offset[3] and dy>0)  then
			self.offset[1]=self.offset[1]+dy*rate
		else
			self.offset[1]=self.offset[1]+dy
		end
	else
		if(self.offset[1]<self.offset[2] and dx<0) then
			self.offset[1]=self.offset[1]+dx*rate
		elseif(self.offset[1]>self.offset[3] and dx>0)  then
			self.offset[1]=self.offset[1]+dx*rate
		else
			self.offset[1]=self.offset[1]+dx
		end
	end
	if(not self.outofbounce) then
		if(self.offset[1]<self.offset[2]) then
			self.offset[1]=self.offset[2]
		end
		if(self.offset[1]>self.offset[3]) then
			self.offset[1]=self.offset[3]
		end
	end
end
---------------------------------------------------
--越界回滚
function ScrollView:backscroll()	
	local off	
	if(self.offset[1]<self.offset[2]) then
		off = self.offset[2]
	elseif(self.offset[1]>self.offset[3]) then
		off = self.offset[3]
	else
		return false	
	end	
	self:stopActionByTag(1000)
	local act = CCActionTween:create(0.2, "back",self.offset[1],off,function(v,key) self.offset[1]=v end)
	act:setTag(1000)
	self:runAction(act)	
	return true
end

--惯性滚动
function ScrollView:autoscroll()
	local dx = self.drag.ex-self.drag.sx
	local dy = self.drag.ey-self.drag.sy
	local dt = self.drag.etick-self.drag.stick
	if self.direction == 1 then
		if(dt>0.5 or math.abs(dy)<10) then
			self:resetspeed()
			return false
		end
		if(dy~=0) then
			self:setspeed(dy/dt)
			return true
		end
	else
		if(dt>0.5 or math.abs(dx)<10) then
			self:resetspeed()
			return false
		end
		if(dx~=0) then
			self:setspeed(dx/dt)
			return true
		end
	end
end

--惯性速度
function ScrollView:resetspeed()
	self.speed=0 --惯性滑动速度
	self.recspeed=0 --惯性滑动初速度
end
function ScrollView:setspeed(spd)
	self.speed=spd --惯性滑动速度
	self.recspeed=spd --惯性滑动初速度
end

---------------------------------------------------
function ScrollView:onTouch(event, x, y)
	----[[
	-- local pp = self.clipnd:convertToNodeSpace(ccp(x,y))
	-- print("=======A",x,y)
	-- print("=======B",pp.x,pp.y)
	-- local pp = self.container:convertToNodeSpace(ccp(x,y))
	-- print("=======C",pp.x,pp.y)
	-- if(self.container:getChildByTag(100)) then
	-- 	local pp = (self.container:getChildByTag(100)):convertToNodeSpace(ccp(x,y))
	-- 	print("=======D",pp.x,pp.y)
	-- end
	----]]	
	if event == "began" then
		local pp = self.clipnd:convertToNodeSpace(ccp(x,y))
		if not self.cliprect:containsPoint(pp) then return false end
		self:resetspeed()
		return self:onTouchBegan(x, y)
	elseif event == "moved" then
		self:onTouchMoved(x, y)
	elseif event == "ended" then
		self:onTouchEnded(x, y)
	else-- cancelled
		self:onTouchCancelled(x, y)
	end
end

function ScrollView:onTouchBegan(x, y)
	self.drag = {
		sx = x,
		sy = y,
		px = x,
		py = y,
		ex = x,
		ey = y,
		stick = self.currdt,
		ptick = self.currdt,
		etick = self.currdt,
		istap = true,
		isdrag= false,
	}
	return true
end

function ScrollView:onTouchMoved(x, y)	
	local dx = x-self.drag.px
	local dy = y-self.drag.py
	local ddd		
	if self.direction == 1 then
		ddd=dy
	else
		ddd=dx
	end
	if(not self.drag.isdrag) then
		if(math.abs(ddd)>self.drag_min) then
			self.drag.isdrag = true
			self.drag.sx=x
			self.drag.sy=y
			self.drag.px=x
			self.drag.py=y
			self.drag.stick=self.currdt
		end	
	else
		self.drag.px=x
		self.drag.py=y
		self:addOffset(dx,dy)
	end
	self.drag.ptick = self.currdt

end

function ScrollView:onTouchEnded(x, y)	
	local dx = x-self.drag.px
	local dy = y-self.drag.py	
	local ddd	
	if self.direction == 1 then
		ddd=dy
	else
		ddd=dx
	end
	if(math.abs(ddd)>self.drag_min) then
		self:addOffset(dx,dy)
	end
	self.drag.ex = x
	self.drag.ey = y
	self.drag.etick = self.currdt
	
	if self.drag.istap then
		self:onTouchEnded_tap(x, y)
	else
		self:onTouchEnded_notap(x, y)
	end
	self.drag.istap = false
end

function ScrollView:onTouchEnded_tap(x, y)	
	if(not self:backscroll()) then	
		-- print("onTouchEnded_tap__2")
		self:autoscroll()
	end
end

function ScrollView:onTouchEnded_notap(x, y)
	
end

function ScrollView:onTouchCancelled(x, y)
end

--//滚动层的off位置,对齐到(屏幕高度*base）的位置
--//V top->bottom base [0-1.0] 0表示off对齐到顶部 0.5表示对齐到中 1表示对齐到底部
--//H left->right base [0-1.0] 0表示off对齐到左边 0.5表示对齐到中 1表示对齐到右边
--//V off 范围 [0-ALL高度] top(0)->bottom(all)
--//H off 范围 [0-ALL宽度] left(0)->right(all)
function ScrollView:setOffset(base,off,anim,dt,easing)
	local tmpbase = 0
	local tmpoff = 0
	local offset = self.offset[1]		
	local offset_min = self.offset[2]
	local offset_max = self.offset[3]
	base=base or 0.5
	dt = dt or 0.2
	if self.direction == 1 then		
		tmpbase = base*self.clipsz.height
		tmpoff= offset_min+off-tmpbase
	else
		tmpbase = base*self.clipsz.width		
		tmpoff= offset_max-off+tmpbase
	end	
	if(offset<offset_min) then
		tmpoff=offset_min
	end
	if(offset>offset_max) then
		tmpoff=offset_max
	end
	if(anim) then
		self:stopActionByTag(1000)
		if(offset~=tmpoff) then
			local act = CCActionTween:create(dt, "skip",offset,tmpoff,
							function(v,key)
								self.offset[1]=v								
							end
						)
			act:setTag(1000)
			self:runAction(CCEaseSineInOut:create(act))
		end
	else
		self.offset[1]=tmpoff
	end
	self:resetspeed()
end

function ScrollView:onCleanup()
	self:removeAllEventListeners()
end

return ScrollView
