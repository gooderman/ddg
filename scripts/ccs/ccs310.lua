import(".ccs310anim")
import(".ccsevt")
local M={}
local M_EVT_NAME
local sharedTextureCache     = CCTextureCache:sharedTextureCache()
local sharedSpriteFrameCache = CCSpriteFrameCache:sharedSpriteFrameCache()
local function set_param(nd,t)
	local a
	a=t.Position
	if(a) then
		--print("set_param pos",a.X,a.Y)
		nd:setPosition(a.X, a.Y)
	end
	a=t.AnchorPoint
	if(a) then
		--print("set_param arc",a.ScaleX, a.ScaleY)
		--studio for mac output json test default (0,0)
		nd:setAnchorPoint(ccp(a.ScaleX or 0, a.ScaleY or 0))
	end
	a=t.Scale
	if(a) then
		nd:setScaleX(a.ScaleX or 1.0)
		nd:setScaleY(a.ScaleY or 1.0)
	end
	a=t.Size
	if(a) then
		nd:setContentSize(CCSize(a.X, a.Y))
	end
	a=t.RotationSkewX
	if(a) then
		nd:setRotationX(a)
	end	
	a=t.RotationSkewY
	if(a) then
		nd:setRotationY(a)
	end
	a=t.CColor
	if(a and (a.R or a.G or a.B)) then
		local c = ccc3(a.R or 255, a.G or 255, a.B or 255)
		nd:setColor(c)
	end
	a=t.IconVisible
	if(a) then
		nd:setVisible(a)
	end
	a=t.Tag
	if(a) then
		nd:setTag(a)
	end
	a=t.Name
	if(a) then
		nd:setName(a)
	end
	a=t.BlendFunc
	if(a) then
		local bld = ccBlendFunc()
		if(a.Dst) then bld.dst=a.Dst end
		if(a.Src) then bld.src=a.Src end
		nd:setBlendFunc(bld)
	end
	if(t.FlipX) then
		nd:setFlipX(true)
	end
	if(t.FlipY) then
		nd:setFlipY(true)
	end
end
local function get_scale9cap(t)
	if(t.Scale9Enable) then
		return CCRect(t.Scale9OriginX, t.Scale9OriginY, t.Scale9Width, t.Scale9Height)
	end
end
local function gen_sp(t)	
	local a = t.FileData
	a = a or t.ImageFileData
	if(a and a.Path) then
		local nd
		local s9cap = get_scale9cap(t)
		if((a.Type == "PlistSubImage") or (a.Type=='MarkedSubImage') ) then	
			-- sharedSpriteFrameCache:addSpriteFramesWithFile(a.Plist)
			local frame = display.newSpriteFrame(a.Path)
	        if frame then
	            if s9cap then
	                nd = CCScale9Sprite:createWithSpriteFrame(frame, s9cap)
	            else
	                nd = CCSprite:createWithSpriteFrame(frame)
	            end
	        end
	 	else
			if(s9cap) then
				nd = display.newScale9Sprite(a.Path,nil,nil,nil,s9cap)
			else	
				nd = display.newSprite(a.Path)
			end
		end
		return nd
	end	
end
local function gen_bgsp(t)	
	local a = t.FileData
	if(a and a.Path) then
		local sp = gen_sp(t)
		if(sp) then
			local a=t.Size
			if(a) then
				sp:setContentSize(CCSize(a.X, a.Y))
			end
			return sp
		end
	else
		local a = t.SingleColor
		if(a and (a.R or a.G or a.B)) then
			local c = ccc4(a.R or 255, a.G or 255, a.B or 255,t.BackColorAlpha or 255)
			local nd=display.newColorLayer(c)
			local a=t.Size
			if(a) then
				nd:setContentSize(CCSize(a.X, a.Y))
			end
			nd:ignoreAnchorPointForPosition(false)
			return nd
		end
	end
end		

local function gen_node(t)
	local nd = display.newNode()
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)
		return nd
	end
end
local McButton = require("uis.McButton")
local CellButton = require("uis.listview.CellButton")
local function gen_btn(t,class)
	local s9cap = get_scale9cap(t)
	--print("gen_btn_1",s9cap)
	local a,b,c
	local m 
	m = t.NormalFileData
	if(m) then
		a = m.Path
		if(m.Type=="PlistSubImage") then
			a = '#' .. a
		end
	end
	m = t.PressedFileData
	if(m) then
		b = m.Path
		if(m.Type=="PlistSubImage") then
			b = '#' .. b
		end
	end
	m = t.DisabledFileData
	if(m) then
		c = m.Path
		if(m.Type=="PlistSubImage") then
			c = '#' .. c
		end
	end
	--print("gen_btn_2",a,b,c)
	-- local class = cc.ui.UIPushButton
	class = class or McButton
	local nd=class.new(
				{
				    normal  = a,
				    pressed = b,
				    disabled = c,
				}, 
			    {scale9 = s9cap and true or false},
			    {scale9Size = false},
				{scale9CapInsets = s9cap}
			)
	if(nd) then	
		nd:setName(t.Name)
		set_param(nd,t)

		local a = t.ButtonText
		local b = t.FontSize or 24
		local cr = t.TextColor and 	t.TextColor.R or 255
		local cg = t.TextColor and 	t.TextColor.G or 255
		local cb = t.TextColor and 	t.TextColor.B or 255
		if(a) then
			local cl=ccc3(cr,cg,cb)
        	local lb
        	lb = CCLabelTTF:create(a,CFG_SYSTEM_FONT,b)    
        	lb:setColor(cl)    	
        	nd:setButtonLabel("normal", lb)
			lb = CCLabelTTF:create(a,CFG_SYSTEM_FONT,b)
			lb:setColor(cl)
        	nd:setButtonLabel("pressed", lb)
        	--nd:setButtonLabelOffset(0,0)
    	end	
		--print("gen_btn_3",nd)
		if(M_EVT_NAME and t.CallBackType) then
			local evt_name=M_EVT_NAME
			nd:onButtonClicked(function(...)
				ccsevt.dispatchEvent(ccsevt.genevt(evt_name,t.CallBackType,t.CallBackName,nd))
			end)
		end
		return nd
	end
end

local function gen_checkbox(t)
	local onimg
	local offimg
	local a 
	a = t.NodeNormalFileData
	if(a.Type == "PlistSubImage") then	
    	onimg = '#'..a.Path
    else
    	onimg = a.Path	
    end
    a = t.NormalBackFileData
	if(a.Type == "PlistSubImage") then	
    	offimg = '#'..a.Path
    else
    	offimg = a.Path	
    end      
	local nd = cc.ui.UICheckBoxButton.new({
			off = offimg,
			on = onimg,
		})
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)

		if(M_EVT_NAME and t.CallBackType) then
			local evt_name=M_EVT_NAME
			nd:onButtonClicked(function(...)
				local evt = ccsevt.genevt(evt_name,t.CallBackType,t.CallBackName,nd)
				evt.select = nd:isButtonSelected()
				ccsevt.dispatchEvent(evt)
			end)
		end

		return nd
	end
end
local function gen_map(t)
	local nd = display.newNode()
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)
		return nd
	end
end
local function gen_imgview(t)
	local nd = gen_sp(t)
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)		
		return nd
	end	
end
local ListView = require("uis.listview.ListView")
local function gen_listview(t)
	local sz = t.Size
    local direct = t.DirectionType=="Vertical" and 1 or 2
	local nd = ListView.new(CCRect:new(0,0,sz.X,sz.Y),direct,t.ClipAble)
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)
		local bgsp = gen_bgsp(t)
		if(bgsp) then
			nd:setBgSp(bgsp)
		end
		return nd
	end
end

local ListViewCell = require("uis.listview.ListViewCell")
local function gen_listviewcell(t)
	local sz = t.Size
	local nd = ListViewCell.new(cc.size(sz.X,sz.Y))
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)
		return nd
	end
end

local ProgressBar = require("uis.ProgressBar")

local function gen_loading(t)
	-- local sp = gen_sp(t.ImageFileData)
	local sp = gen_sp(t)
	local nd = ProgressBar.new(_,sp,0,0)
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)
		nd:setPercent(t.ProgressInfo)
		return nd
	end
end
local PageView = require("uis.listview.PageView")
local function gen_pageview(t)
	local sz = t.Size
    local direct = t.ScrollDirectionType==0 and 1 or 2
	local nd = PageView.new(CCRect:new(0,0,sz.X,sz.Y),direct,t.ClipAble)
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)
		local bgsp = gen_bgsp(t)
		if(bgsp) then
			nd:setBgSp(bgsp)
		end
		return nd
	end
end
local function gen_panel(t)
	local tp = t.ComboBoxIndex	
	local nd
	if(tp==1) then
		-- print("gen_panel",c.r,c.g,c.b,c.a)
		local a = t.SingleColor
		local c
		if(a and (a.R or a.G or a.B)) then
			c = ccc4(a.R or 255, a.G or 255, a.B or 255,t.BackColorAlpha or 255)
		end
		nd = display.newColorLayer(c)
	elseif(tp==2) then
		local a = t.FirstColor or {}
		local b = t.EndColor or {}
		local v = t.ColorVector or {}
		local ac = ccc4(a.R or 255, a.G or 255, a.B or 255,t.BackColorAlpha or 255)
		local bc = ccc4(b.R or 255, b.G or 255, b.B or 255,t.BackColorAlpha or 255)
		local vp = ccp(v.ScaleX or 0,v.ScaleY or 0)
		nd = CCLayerGradient:create(ac,bc,vp)
	else	
		nd = display.newNode()
	end	
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)
		local bgsp = gen_sp(t)
		if(bgsp) then
			nd:addChild(bgsp)
			if(t.Scale9Enable) then
				bgsp:size(t.Size.X,t.Size.Y)
			end
			bgsp:pos(t.Size.X/2,t.Size.Y/2)
		end
		return nd
	end
end
local function gen_particle(t)
	local a=t.FileData
	if(a and a.Path) then
		local nd = CCParticleSystemQuad:create(a.Path)
		if(nd) then
			nd:setName(t.Name)
			set_param(nd,t)
			return nd
		end		
	end
end
local ScrollView = require("uis.listview.ScrollView")
local function gen_scrollview(t)
    local sz = t.Size
    local direct = t.ScrollDirectionType==0 and 1 or 2
	local nd = ScrollView.new(CCRect:new(0,0,sz.X,sz.Y),direct,t.ClipAble)
	--nd:setContainer(display.newSprite("UI/cpt_bg_01.png"))
	--nd:setTouchEnabled(true)
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)
		local bgsp = gen_bgsp(t)
		if(bgsp) then
			nd:setBgSp(bgsp)
		end
		return nd
	end
end
local function gen_audio(t)
	local nd = display.newNode()
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)
		return nd
	end
end
local function gen_sprite(t)	
	local nd = gen_sp(t)
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)		
		return nd
	end	
end
local function gen_textatlas(t)
	if(t.LabelAtlasFileImage_CNB and t.LabelAtlasFileImage_CNB.Path and t.CharWidth and t.CharHeight and t.StartChar) then
		local nd = CCLabelAtlas:create(t.LabelText or "", t.LabelAtlasFileImage_CNB.Path, t.CharWidth, t.CharHeight, string.byte(t.StartChar))	
		if(nd) then
			nd:setName(t.Name)
			set_param(nd,t)
			return nd
		end
	end
end
local function gen_input(t)
	local nd = ui.newEditBox(
                        {
                            size = cc.size(t.Size.X,t.Size.Y),
                        })
    nd:setPlaceHolder(t.PlaceHolderText)
    if(t.FontResource and t.FontResource.Path) then
    	nd:setFontName(t.FontResource.Path)
	end
    nd:setFontSize(t.FontSize or 24)

    local a=t.CColor
	if(a and (a.R or a.G or a.B)) then
		local c = ccc3(a.R or 255, a.G or 255, a.B or 255)
		nd:setFontColor(c)
	end
    nd:setText(t.LabelText)
    if t.PasswordEnable then
    	nd:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)
	end
	if t.MaxLengthEnable then
		nd:setMaxLength(t.MaxLengthText)
	end
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)
		return nd
	end
end

local align_map=
{
  HT_Top=ui.TEXT_ALIGN_LEFT,
  HT_Center=ui.TEXT_ALIGN_CENTER,
  HT_Bottom=ui.TEXT_ALIGN_RIGHT,
  VT_Top   =ui.TEXT_VALIGN_TOP,
  VT_Center=ui.TEXT_VALIGN_CENTER,
  VT_Bottom=ui.TEXT_VALIGN_BOTTOM,
}

local function gen_text(t)
	local nd
	local fontsz = t.FontSize or 24
	local txt = t.LabelText or ""
	local a=t.Size
	if(t.IsCustomSize and a and a.X and a.Y) then
		local align=align_map[a.HorizontalAlignmentType or "HT_Center"]
		local valign=align_map[a.VerticalAlignmentType or "VT_Center"]
		nd = CCLabelTTF:create(txt, CFG_SYSTEM_FONT, fontsz, CCSize(a.X,a.Y), align, valign)
	else
		nd = CCLabelTTF:create(txt, CFG_SYSTEM_FONT, fontsz)
	end	
	
	if(t.OutlineEnabled) then
		a=t.OutlineColor	
		local c = ccc3(a.R or 255, a.G or 255, a.B or 255)		
		nd:enableStroke(c, 2)
	end
	a=t.ShadowEnabled
	if(a) then		
		local sz = CCSize(t.ShadowOffsetX or 1.0,t.ShadowOffsetY or -1.0)		
		nd:enableShadow(sz,0.8,0.5)
		a=t.ShadowColor
		if(a) then		
			local c = ccc3(a.R or 255, a.G or 255, a.B or 255)		
			nd:enableStroke(c, 2)
		end
	end
	if(nd) then
		nd:setName(t.Name)
		set_param(nd,t)
		return nd
	end
end


local function gen_bmfont(t)
	local a=t.LabelBMFontFile_CNB
	if(a and a.Path) then
		local nd = CCLabelBMFont:create()
		if(nd) then
			nd:setFntFile(a.Path)
			nd:setString(t.LabelText or "")
			nd:setName(t.Name)
			set_param(nd,t)
			return nd
		end
	end
end

local function gen_gif(t)
	local a=t.UserData
	if(a and string.len(a)>0) then
		local nd = InstantGif:create(a)
		if(nd) then
			nd:setName(t.Name)
			t.Size=nil
			t.AnchorPoint=nil
			set_param(nd,t)
			return nd
		end
	end
end

--------------------------------------
local config=
{
	ButtonObjectData		= gen_btn,
	CheckBoxObjectData		= gen_checkbox,
	--GameMapObjectData		= gen_map,
	ImageViewObjectData		= gen_imgview,
	ListViewObjectData		= gen_listview,
	LoadingBarObjectData	= gen_loading,
	PageViewObjectData		= gen_pageview,
	PanelObjectData			= gen_panel,
	ParticleObjectData		= gen_particle,
	ScrollViewObjectData	= gen_scrollview,
	ListViewCell         	= gen_listviewcell,--custom class
	CellButton         		= function(t)
								return gen_btn(t,CellButton)
							  end,--custom class addto ListViewCell
	--SimpleAudioObjectData	= gen_audio,
	SingleNodeObjectData	= gen_node,--scene.ccs root node
	LayerObjectData			= gen_node,--layer.css root node
	SpriteObjectData		= gen_sprite,
	TextAtlasObjectData		= gen_textatlas,
	TextFieldObjectData		= gen_input,
	TextObjectData 			= gen_text,
	TextBMFontObjectData    = gen_bmfont,
	Gif 					= gen_gif,

}
--------------------------------------
--[[[
"ccsload" = {
    "childs" = {
        "AtlasLabel" = {
            "node" = userdata: 05FCD028
            "tag"  = 18
        }
        "Button" = {
            "node" = userdata: 05FCB720
            "tag"  = 14
        }
        "Image" = {
            "node" = userdata: 05FCCAD0
            "tag"  = 16
        }
        "LoadingBar" = {
            "node" = userdata: 05FCD0B8
            "tag"  = 19
        }
        "Particle" = {
            "node" = userdata: 05FCB5B8
            "tag"  = 9
        }
        "Sprite" = {
            "node" = userdata: 05FCCBF0
            "tag"  = 12
        }
        "Text" = {
            "node" = userdata: 05FCCDE8
            "tag"  = 17
        }
        "TextField" = {
            "node" = userdata: 05FCD1D8
            "tag"  = 21
        }
    }
    "node"   = userdata: 05FCAD90
    "tag"    = -1
}
--]]
--------------------------------------
M.__index=function(self,k)
	if(M[k]) then
		return M[k]
	elseif(type(k)=="string") then
		if(string.byte(k)==95) then --'_'
			return M.getChildRoot(self,string.sub(k,2))
		else	
			return M.getChildByName(self,k)
		end
	elseif(type(k)=="number") then
		return 	M.getChildByTag(self,k)
	end
	return nil
end
function M:getChildByTag(tag)
	if(tag>=0) then
		local childs = rawget(self,'childs')
		if(childs) then
			for _,v in pairs(childs) do
				if(v.tag==tag) then
					return rawget(v,'node')
				end
			end
		end
	end
end
function M:getChildByName(name)
	--return self.childs and self.childs[name] and self.childs[name].node
	local r = rawget(self,'childs')
	r  = r and rawget(r,name)
	r  = r and rawget(r,'node')
	return r
end
function M:getChildRoot(name)
	-- print("------getChildRoot")
	-- return self.childs and self.childs[name]
	local r = rawget(self,'childs')
	r  = r and rawget(r,name)
	return r
end
function M:playAnim(rpt,handler)
	local act = self:genAction(rpt,handler)
	if(act) then
		self.node:runAction(act)
		return true
	end
end
function M:stopAnim()
	if(self.actag) then
		self.node:stopActionByTag(self.actag)
	end
end

function M:playAll(rpt,handler)
	self:playAnim(rpt, handler)
	for _,v in pairs(self.childs or {}) do
		v:playAnim(rpt, nil)		
	end
end
function M:stopAll()
	self:stopAnim()
	for _,v in pairs(self.childs or {}) do
		v:stopAnim()
	end
end
-- r.tag = a.Tag or -1
-- r.actag = a.ActionTag or 0
-- r.json = a
-- r.childs
-- r.parent
function M:genAction(rpt,handler)
	if(not self.actag or self.actag == 0) then
		return
	end
	local anim 		= self.anim
	local animlist  = self.animlist
	local parent = self.parent
	while((not anim) and parent) do
		anim = parent.anim
		animlist = parent.animlist
		parent = parent.parent
	end
	if(anim) then
		local pp = {self.json.Position.X,self.json.Position.Y}
		local act = ccsanim.gen(self.actag,anim,animlist,handler,{pos=pp})
		if(not act) then
			return
		end
		if(rpt<=1) then
			act:setTag(self.actag)
			return act
		elseif(rpt==-1) then
			act = CCRepeatForever:create(act)
			act:setTag(self.actag)
			return act
		else	
			act = CCRepeat:create(act,rpt)
			act:setTag(self.actag)
			return act
		end
	end
end



M.play = M.playAnim
M.childroot = M.getChildRoot
M.action = M.genAction

local function gen(a)
	local tp = a.ctype
	if(not tp) then
		return
	end
	--print("-----"..tp)
	local f = config[a.CustomClassName] or config[tp]
	if(not f) then
		print("-----no config----"..tp)
		return
	end
	local r={}
	r.node = f(a)
	if(not r.node) then
		return
	end
	r.tag = a.Tag or -1
	r.actag = a.ActionTag or 0
	r.json = a
	if(a.Children) then
		r.childs={}
		--parse childs
		for _,v in ipairs(a.Children) do
			local n = gen(v)
			if(n and n.node) then
				r.node:addChild(n.node)
				--table.insert(r.childs,n)
				r.childs[v.Name]=n
				n.parent = r
			end
		end
	end
	setmetatable(r, M)
	return r
end	
--conver json to table
function M.load_tb(jsontb,evtname,func)
	M_EVT_NAME=evtname
	local res = jsontb.Content.Content.UsedResources
	local root = jsontb.Content.Content.ObjectData
	local anim = jsontb.Content.Content.Animation
	local animlist = jsontb.Content.Content.AnimationList
	--use custom class name force if editor not mark
	if(func) then
		-- local rt = root
		root=func(root)
		-- print(tostring(rt))
		-- print(tostring(root))
		if not root then
			return
		end
	end	
	------------------------------------------------
	for _,v in ipairs(res) do
		if(string.match(v,'%.plist$')) then
			sharedSpriteFrameCache:addSpriteFramesWithFile(v)
		end
	end	
	------------------------------------------------
	local size = root.Size
	local name = root.Name
	local nodes = root.Children
	local r=gen(root)
	if(r) then
		r.anim=anim
		r.animlist=animlist
	end
	return r
end
function M.load(jsonfile,evtname,func)
	local str = get_file_data(jsonfile)
	if(not str) then
		return false
	end
	local rst={}
	local jsontb = 	json.decode(str)
	if(not jsontb) then
		return false
	end
	return M.load_tb(jsontb,evtname,func)
end

function M.load_listviewcell(jsonfile)	
	return M.load(jsonfile,nil,function(root)
								root.CustomClassName = "ListViewCell"
								for _,v in ipairs(root.Children) do
									if(v.ctype=='ButtonObjectData') then
										v.CustomClassName='CellButton'										
									end									
								end
								return root
						   end
	)	
end	

function M.load_child(jsonfile,evtname,childname)
	return M.load(jsonfile,evtname,function(root)
								local function search(parent,name)
									for _,v in ipairs(parent.Children or {}) do
										if(v.Name==name) then
											return v
										else
											local r = search(v,name)
											if(r) then
												return r
											end
										end								
									end									
								end
								root = search(root,childname)
								return root
						   end
	)
end

----------------------------------------------
--gen node
function M.createNode(jsonfile)
	local r=M.load(jsonfile)
	if(r) then
		dump(r,"ccsload",5)
		--print("r.getChildByName",tostring(r:getChildInfo"Text":getChildByName("Text")))
		--print("r.getChildByTag ",tostring(r:getChildByTag(17)))
		return r
	end
end
--[[
1.can parse scene.ccs and layer.css as same format
2.img and sprite can use plist
3.btn can use plist
4.listviewcell pageviewvell use CustomClassName:ListViewCell
5.CellBtn use CustomClassName:CellBtn
6.support regist evt, use evtdata from editor
7.support gen one node by load_child according childname
-------------------------------------------------------------
no finish:
1.play all anim by parent node,now just support play anim of one node.
--]]
ccsload=M

 
