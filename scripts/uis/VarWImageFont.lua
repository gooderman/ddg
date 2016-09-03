--
-- 可变宽度文字图片
--
local VarWImageFont = class("VarWImageFont", function()
    return display.newNode()
end)

local FIGHT_FONT_CFG=
{    
     "font/sh_txt_b01.png",
     "0,1,2,3,4,5,6,7,8,9,+,-",
     {28,20,27,27,30,27,28,26,28,28,32,32}
}

function VarWImageFont:ctor(data)
	-- print("data", data)
	self.fontImg = data[1]
	self.fontData = string.split(data[2], ",")
	self.fontWidth = data[3]

	self.fontCharId = {}

	for k,v in pairs(self.fontData) do
		self.fontCharId[v] = k
	end
	self.fontNumb = #self.fontData	

	self:setCascadeOpacityEnabled(true) 
	self.fontSp={}
	self.str = ""
end

-- function VarWImageFont:setOpacity(opa)
-- 	for _,sp in pairs(self.fontsp) do
-- 		sp:setOpacity(opa)
-- 	end
-- 	-- if self.mySp then
-- 	-- 	self.mySp:setOpacity(opa)
-- 	-- end	
-- end
function VarWImageFont:getString()
	return self.str
end
function VarWImageFont:setString(Str)
	self.str = Str
	self:removeAllChildrenWithCleanup(true)
	local tmpW = 0
	local tmpH = 0
	-- print("self.fontDataList[tmpChar] num",#Str)
	if #Str > 0 then 
		for i=1,#Str do
			local tmpChar = string.sub(Str, i, i)
			-- print("tmpChar", tmpChar)
			local charId = self.fontCharId[tmpChar]
			if charId then
				local sp,cw,ch = self:genCharSp(charId)				
				sp:setAnchorPoint(ccp(0,0))
				sp:setPosition(tmpW,0)
				tmpW = tmpW + cw
				tmpH = ch				
				self:addChild(sp)
				self.fontSp[i]=sp
			end
		end
		self:setContentSize(CCSizeMake(tmpW, tmpH))
	end
	
end


function VarWImageFont:genCharSp(id)
    local sp = display.newSprite(self.fontImg)
    local sz = sp:getContentSize()
    local cw = self.fontWidth[id]
    -- {28,20,27,27,30,27,28,26,28,27,32,32}
    local x = 0
    for i=1,id do
    	if(i==id) then
    		break
    	end
    	x = x + self.fontWidth[i]
    end
    sp:setTextureRect(CCRectMake(x, 0, cw, sz.height))

    return sp,cw,sz.height
end

function VarWImageFont.test()
	local txt = string.format("%s", "-+9876543210")	
	local skin = VarWImageFont.new(FIGHT_FONT_CFG)
	skin:setString(txt)
	return skin
end
return VarWImageFont