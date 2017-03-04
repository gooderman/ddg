----------------------------------------------
-- local str=[[<font align=50>字体oo<br>
-- <font size=20 color=00FFDFFF>颜色<br>
-- <image src=fkad width=100 height=50>图片<br>
-- <margin left=100 top=20>缩进<br>
-- <margin left=0>结束]]
----------------------------------------------
-- tag support
-- <canvas width=200 height=200 bgcolor=008800 linespace=2>
-- <font size=24 align=50 color=00FFDD>
-- <img src=ui/xx.png width=100 height=50 align=50>
-- <br>
-- <bdo dir="rtl">
-- <margin left=100 top=20>
-- <indent word=2>

local function parse_color(str)
	local n = string.len(str)
	if(n==8 or n==6) then
		local r = string.sub(str,1,2)
		local g = string.sub(str,3,4)
		local b = string.sub(str,5,6)
		local a = 'FF'
		if(n==8) then
			a=string.sub(str,7,8)
		end	
		r = tonumber(r,16)
		g = tonumber(g,16)
		b = tonumber(b,16)
		a = tonumber(a,16)
		return {r,g,b,a}
	elseif(n==12 or n==9) then
		local r = string.sub(str,1,3)
		local g = string.sub(str,4,6)
		local b = string.sub(str,7,9)
		local a = '255'
		if(n==12) then
			a=string.sub(str,10,12)
		end	
		r = tonumber(r)
		g = tonumber(g)
		b = tonumber(b)
		a = tonumber(a)
		return {r,g,b,a}
	end
	return {255,255,255,255}
end

local function parse_int(str)
	return tonumber(str)
end
local parsefunc =
{
	bgcolor = parse_color,
	color = parse_color,
	align = parse_int,
	size  = parse_int,
	width = parse_int,
	height= parse_int,
	left  = parse_int,
	top   = parse_int,
	right = parse_int,
	linespace = parse_int,
	word  = parse_int,
}
----------------------------------------------
local function parse(str)
	--换行只是为了编辑文本排版方便,判无效
	str = string.gsub(str,"\n","")
	-- print(str)
	-- print(string.len(str))
	local tag={}
	local len = string.len(str)
	local s,e = 1,0
	while(s and e) do  
		s,e = string.find(str, "(<.->)",s)
		if(s and e) then
			table.insert(tag,{
				s=s,
				e=e,
				str=string.sub(str,s,e),
				})
			s=e+1
		end
	end
	for _,t in ipairs(tag) do
		local s=t.str
		t.attr={}
		--type font image margin br
		local style = string.match(s, "^<(%w+)")
		t.type = style
		--attr color src size left
		for k, v in string.gmatch(s, "([%w%-_/]+)=([%w#%-_/%.]+)") do
		    if(not parsefunc[k]) then
		      	t.attr[k] = v
		    else
		    	t.attr[k] = parsefunc[k](v)
		    end	
		end
	end
	----------------------------------------------
	local con={}
	local n = #tag
	for i=2,n do
		local ss = tag[i-1].e+1
		local ee = tag[i].s-1
		if(ss<=ee) then
			table.insert(con,{
					s=ss,
					e=ee,
					str=string.sub(str,ss,ee),
					type='text',
				})
		end
	end
	----------------------------------------------
	for _,v in ipairs(con) do
		table.insert(tag,v)
	end
	table.sort(tag,function(a,b)
		return a.s<b.s
	end)
	----------------------------------------------
	n = #tag
	if(tag[n].e<len) then

		s = tag[n].e+1
		e = len
		-- print(s,e)
		table.insert(tag,{
					s=s,
					e=e,
					str=string.sub(str,s,e),
					type='text',
				})
	end
	return tag
end

--------------------------------------------------

local function getutf8chars(str)
	local rst={}
	local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
	local len = string.len(str)
	local s=1
	while(s<=len)  do
		local tmp = string.byte(str, s)
		local j = 6
		while arr[j] do
            if tmp >= arr[j] then
                table.insert(rst,string.sub(str,s,s+j-1))
                s = s+j
                break
            end
            j = j-1
        end
	end
	return rst
end

local function gen(str,step)
	local bgnd = CCNode:create()
	if(step) then
		-- print("---gen---",str)
		coroutine.yield("start",bgnd)
	end
	local tags = parse(str)
	-- dump(tags,"rich",4)
	local x,y = 0,0
	local bgwidth = 0
	local bgheight = 0
	local bgcolor = ccc4(255,255,255,255)
	local linespace = 0
	local margin_left = 0
	local t = tags[1]
	if(t and t.type=='canvas') then
		bgwidth = t.attr.width
		bgheight = t.attr.height
		linespace = t.attr.linespace or linespace
		bgcolor = ccc4(unpack(t.attr.bgcolor))

		local nd = CCLayerColor:create(bgcolor)
		nd:setContentSize(cc.size(bgwidth,bgheight))
		nd:setIgnoreAnchorPointForPosition(false)
		nd:addTo(bgnd):arch(0,1):pos(0,0)
	end
	local isfirst = true
	local fontcolor = ccc3(255,255,255)
	local fontalpha = 255
	local fontsize = 24
	local textalign = 0	
	local lineheight = fontsize
	local imageheight = 0
	local linenodes={}
	local steplinelayout=function()
		for _,n in ipairs(linenodes) do
			n:setPositionY(y-lineheight-linespace)
		end
		linenodes = {}
	end

	for i,t in ipairs(tags) do
		if(t.type=='font') then
			fontcolor = t.attr.color and ccc3(unpack(t.attr.color,1,3)) or fontcolor
			fontsize = t.attr.size or fontsize
			fontalpha = t.attr.color and t.attr.color[4] or fontalpha
			textalign = t.attr.align or textalign
			lineheight = lineheight>fontsize and lineheight or fontsize
		elseif(t.type=='text') then
			if(textalign~=0) then
				local  lb = CCLabelTTF:create(t.str,"",fontsize)
				lb:setColor(fontcolor)
				lb:setOpacity(fontalpha)
				local w = lb:getContentSize().width
				local xx = (bgwidth - w)*textalign/100
				lb:addTo(bgnd):pos(xx,y-lineheight-linespace):anch(0,0)
				x = xx+w
				textalign = 0
				table.insert(linenodes,lb)
			else
				local strtb = getutf8chars(t.str)
				for _,v in ipairs(strtb) do
					local  lb = CCLabelTTF:create(v,"",fontsize)
					lb:setColor(fontcolor)
					lb:setOpacity(fontalpha)
					local w = lb:getContentSize().width
					if(x+w > bgwidth) then
						steplinelayout()
						x = margin_left
						y = y - lineheight - linespace
						lineheight = fontsize
					end	
					lb:addTo(bgnd):pos(x,y-lineheight-linespace):anch(0,0)
					x = x + w
					isfirst = false
					table.insert(linenodes,lb)
				end
			end
		elseif(t.type=='br') then
			steplinelayout()
			y = y - lineheight - linespace
			x = margin_left
			lineheight = fontsize
			isfirst = true
		elseif(t.type=='margin') then
			margin_left = t.attr.left or 0
			if(isfirst) then
				x = margin_left
			elseif(x<margin_left) then
				x = margin_left
			end
		elseif(t.type=='img') then
			local sp = display.newSprite(t.attr.src)
			if(sp) then
				local sz = sp:getContentSize()
				if(t.attr.width and t.attr.width>0 and t.attr.height and t.attr.height>0) then
					sp:setContentSize(CCSizeMake(t.attr.width, t.attr.height))
					sp:setScaleX(t.attr.width/sz.width)
					sp:setScaleY(t.attr.height/sz.height)
				end
				sz = sp:getContentSize()
				imgheight = sz.height
				local xx = x
				local align = t.attr.align
				if(align) then
					local w = sz.width
					xx = (bgwidth - w)*align/100
				end

				if(x + sz.width>bgwidth or xx<x) then
					steplinelayout()
					x = xx
					y = y - lineheight - linespace
					lineheight = imgheight
				else
					x = xx	
				end

				lineheight = lineheight>imgheight and lineheight or imgheight
				sp:addTo(bgnd):pos(x,y-lineheight-linespace):anch(0,0)
				x = x + sz.width
				table.insert(linenodes,sp)
			end
		end
		if(step) then
			coroutine.yield("step",i)
		end
	end
	steplinelayout()
	return bgnd
end

--[[
--simple function if needed
local M={}
M.load = function(self)
	return gen(self.str)
end
M.start = function(self)
	self.co = coroutine.create(gen)
	local r,s,node = coroutine.resume(self.co,self.str,true)
	self.node=node
end
M.step = function(self)
	return coroutine.resume(self.co)
end
M.new = function(str)
	local r = {}
	r.str=str
	setmetatable(r, {__index=M})
	r:start()
	return r
end

return M
--]]

local RichText = class("RichText", function()
	local node = display.newNode()
	node:setNodeEventEnabled(true)
	return node
end)

function RichText:ctor(str)
	self.str = str
	self.co = nil
	self.richnode = nil
	self.mode=nil
end

function RichText:onEnter()

end

function RichText:onExit()

end

function RichText:onCleanup()
	self.co = nil
end

function RichText:show()
	print('---Ta---',os.clock())
	if(self.richnode) then
		self.richnode:removeSelf()
	end
	self.richnode = gen(self.str)
	self.richnode:addTo(self):pos(0,0)
	print('---Tb---',os.clock())

end

function RichText:step()
	if(not self.co) then
		self.co = coroutine.create(gen)
		local r,s,node = coroutine.resume(self.co,self.str,true)
		self.richnode=node
		self.richnode:addTo(self):pos(0,0)
		self.richnode:hide()
		self:step()
	else
		local act
		act = self:timer(function()
			local r = coroutine.resume(self.co)
			if(not r) then
				self:stopAction(act)
				self.co = nil
				self.richnode:show()
			end
		end,0.01)
	end
end

return RichText

-------------------------------------
-- local ssss = [[
-- <canvas width=400 height=600 bgcolor=202020 linespace=4>
-- <font size=32 align=50>程序员<br>
-- <font size=16>如果你是程序员，或者有一颗喜欢写程序的心，喜欢分享技术干货、项目经验、程序员日常囧事等等，欢迎投稿《程序员》专题
-- <br>
-- <font color=FF0000>投稿须知:
-- <margin left=24>
-- <br>1.<margin left=48>收录相关技术文章，但不限于技术，也可以是项目经验类的文章和程序员日常。
-- <margin left=24>
-- <br>2.<margin left=48>文章內不得有任何推广信息。包括但不...
-- <br>
-- <font size=20 color=FF0FCF>
-- <margin left=0>
-- 专题主编：<margin left=20><font color=00FF00>http://www.jianshu.com/users/4a4eb4feee62/
-- <br>
-- <font color=FF0000>
-- <margin left=0>
-- 编委：<margin left=20><font color=00FF00>Kulbear

-- <br>
-- <font color=FFFFFF>
-- <img src=ui/guanbi.png width=100 height=50>图片<br>
-- </font>

-- 结束
-- ]]
-- local rich = RichText.new(ssss)
-- local node = rich.node
-- if(node) then
-- 	node:addTo(self):pos(200,600)
-- 	node:timer(function ()
-- 			local r = rich:step()
-- 			if(not r) then
-- 				node:stopAllActions()
-- 			end
-- 	end,0.1)
-- end
-------------------------------------
