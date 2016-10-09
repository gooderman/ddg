import("uis.GenUiUtil")
local ALayer = import(".ALayer")
local TestScene = class("TestScene", function()
    return display.newScene("TestScene")
end)
local timer = require("framework.scheduler")

local Abeizer = import(".Abeizer")	


function TestScene:pushScene()
	local UI_POS = 
	{   
	    {n="backbtn",  t="mcbtn",  x=70,y=display.height-40,    scale=2.0,  	arc={0.5,0.5}, 		tg = 100,   ftg = 0,   od=1000, res={"s9b.png","s9b.png"}},
	    {n="backtxt",  t="txt",    x=0, y=0,   					arc={0.5,0.5}, 	tg = 1001,  ftg = 100, od=1,    color={0,0,0},size=20,txt="back" },
	 }
	local sc = display.newScene()
	local uis = GenUiUtil.genUis(UI_POS,sc,'ccs/')
	uis.backbtn:onButtonClicked(function()
		display.popScene()
	end)
	if(self.TND) then
		self.TND:removeSelf()
		sc:addChild(self.TND)
	end
	display.pushScene(sc)
end

function TestScene:ctor()
	
	local listconfig=
	{		
		{"tstScrollview",	handler(self,self.tstScrollview)},
		{"tstListview",		handler(self,self.tstListview)},
		{"tstPageview",		handler(self,self.tstPageview)},
		{"tstShader",		handler(self,self.tstShader)},
		{"tstShader2",		handler(self,self.tstShader2)},
		{"tstCCS",			handler(self,self.tstCCS)},
		{"tstSpine",		handler(self,self.tstSpine)},
		{"tstGenUi",		handler(self,self.tstGenUi)},
		{"tstRenderTexture",handler(self,self.tstRenderTexture)},
		{"tstTiled",		handler(self,self.tstTiled)},
		{"tstMesh",			handler(self,self.tstMesh)},	
		{"tstJz",			handler(self,self.tstJz)},
		{"tstTween",		handler(self,self.tstTween)},		
		{"tstJson",			handler(self,self.tstJson)},
		--{"tstImgPick",		handler(self,self.tstImgPick)},
		{"tstHttp",		handler(self,self.tstHttp)},
		{"tstZip",		handler(self,self.tstZip)},
		{"tstFs",		handler(self,self.tstFs)},
		{"tstShrot",	handler(self,self.tstShort)},
		{"tstEdit", 	handler(self,self.tstEdit)},
		{"tstGif",		handler(self,self.tstGif)},
		{"tstBlend",	handler(self,self.tstBlend)},
		{"tstBlendClip",	handler(self,self.tstBlendClip)},
		{"tstAnim",		handler(self,self.tstAnim)},
		{"tstMount",	handler(self,self.tstMount)},
		{"tstLuaSocket", handler(self,self.tstLuaSocket)},	
		{"tstWebView",	handler(self,self.tstWebView)},	
		{"tstBeizer",	handler(self,self.tstBeizer)},

	}
	self.TND = display.newNode()
	self.TND:setPosition(0, 0)
	self.TND:retain()
	--self.TND:setTouchEnabled(true)
	-- self:addChild(self.TND, 2)
	local ListView = require("uis.listview.ListView")
	local ListViewCell = require("uis.listview.ListViewCell")
	local CellBtn = require("uis.listview.CellButton")
	local list = ListView.new(CCRect:new(0,0,display.width-20,display.height-20),1,true)
	local cells={}
	local cell_w = display.width-20
	local cell_h = 100
	for i,v in pairs(listconfig) do
		local cell = ListViewCell.new(CCSize(cell_w,cell_h),i)
		local bg = CCDrawNode:create()
		local points={}
	    points[1] = {0,0}
	    points[2] = {0,cell_h}
	    points[3] = {cell_w,cell_h}
	    points[4] = {cell_w,0}	   
		bg:drawPolygon(points,
                        {   
                            fillColor = cc.c4f(1,1,1,0.5),
                            borderWidth =   2,
                            borderColor =   cc.c4f(1,1,1,0.5)
                        }
                    )
		cell:addChild(bg)
		-------------------------------
		local color=ccc3(255,0,0)
		local outline = ccc3(255, 255, 0)
    	local label = CCLabelTTF:create(v[1],CFG_SYSTEM_FONT,48)    
    	label:setColor(color)
    	label:enableStroke(outline, 2)
    	cell:addChild(label) 
    	label:setAnchorPoint(ccp(0,0.5))
    	label:setPosition(20, cell_h/2)
    	-------------------------------
		cell:addEventListener("onCellTap",
			function(evt)
				print("cell-onCellTap",evt.id)
				self:pushScene()
				listconfig[evt.id][2]()
			end
		)
		table.insert(cells,cell)
	end
	list:addCells(cells)
	list:setPosition(10, 10)
	self:addChild(list)
	list:setTouchEnabled(true)
	list:setCellAlign(0.8)

	-- self:tstShader()
	-- self:tstRenderTexture()
	-- self:tstCCS()
	-- self:tstShader2()
	-- self:tstFs()
	-- self:tstBlend()
end

function TestScene:onEnter()
end

function TestScene:onExit()
end

function TestScene:initUi()
end

function TestScene:addTestNd(nd,notrm)
	if(not notrm) then
		self.TND:removeAllChildren()
	end
	self.TND:addChild(nd)
end
function TestScene:cleanTestNd()
	self.TND:removeAllChildren()
end

function TestScene:initForMap()
	if(not self.initformap) then
		self.initformap=true
		local nd = display.newNode()
		nd:setPosition(0, 0)
		nd:setContentSize(CCSize(640,640))
		self:addTestNd(nd,true)
		self.pf=false
		self.px=0
		self.py=0
		self.ex=0
		self.ey=0
		nd:setTouchEnabled(true)
	    nd:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
	        if(event.name == 'began') then
	        	self.pf=true
	        	self.px = event.x
	        	self.py = event.y
	        	return true
	        end
	        if(not self.pf) then
	        	return
	        end	
	        if(event.name == 'moved' and self.pf) then 
	            self.ex = event.x
	        	self.ey = event.y
	        	local xx = math.floor(self.ex/90) - math.floor(self.px/90)
	        	local yy = math.floor(self.ey/90) - math.floor(self.py/90)
	        	if(xx~=0) then
	        		self:tstTiledSwap(self.px,self.py,self.ex,self.py)
	        		self.pf=false 	 	
	        	elseif(yy~=0) then
	        		self:tstTiledSwap(self.px,self.py,self.px,self.ey)
	        		self.pf=false
	        	end	
	        elseif event.name == "ended" or event.name == "cancelled" then
	        	local x,y=math.floor(event.x),math.floor(event.y)
	            self:tstTiledClick(x,y)            
	        end
	        return true
	    end)
	end
end

function TestScene:tstTiledSwap(a,b,c,d)
	local layer = self.map:getLayerByName('conveyor')
	-- layer:swapAtGid(a,b)
	layer:swapAt(a,b,c,d)
end
function TestScene:tstTiledClick(x,y)
	local layer = self.map:getLayerByName('conveyor')
	layer:setTileAt(math.random(1,126),x,y,true)
	local spt,tid  = layer:getTileAt(x,y)
	-- print(spt)
	-- print(tid)
	if(spt and tid) then
		-- print(spt)
		spt:runAction(
			transition.sequence(
				{
					CCRotateBy:create(1.0,720),
					CCScaleTo:create(0.2,0.0),
					CCScaleTo:create(0.2,1.0),
					-- CCMoveBy:create(0.2,ccp(100,100)),
					-- CCMoveBy:create(0.2,ccp(-100,-100)),
					-- CCCallFunc:create(function()
					-- 		layer:setTileGID(math.random(1,126),x,y)
					-- 	end),				
				}
			)
		)
		
	end
	-- batchnd:setTileGID()
	-- batchnd:setTileGID()
end

function TestScene:tstTiled()
	local map= tiledload.load("1010001.lua","map/",true)
	if(map) then
		self:cleanTestNd()
		self:initForMap()
		for _,v in pairs(map.nodes) do
			self:addTestNd(v.root,true)
		end
		self.map=map
		dump(map,"map",1)
		dump(map:getRootByName('conveyor'),"root",1)
		dump(map:getLayerByName('conveyor'),"layer",1)
		dump(map:getObjectInfo("ground",5),"objinfo",1)
		dump(map:getObjectPropertys("ground",5),"objpro",1)
		dump(map:getTiledInfo(10),'tileinfo',1)
		dump(map:getTiledInfoByType('surface_02_04'))			
	end
end

function TestScene:tstMesh()
	local spp = CCShaderSprite:create("UI/cpt_bg_02.png")
	spp:setAnchorPoint(ccp(0,0))
	spp:setPosition(display.cx,display.cy)
	-- spp:initVerticesWithRegex(
	-- 	gl.GL_TRIANGLE_STRIP,
	-- 	"-50,50,0,0.5|-100,-50,0,0|100,100,1,1|100,-100,1,0,255,255,0,255",
	-- 	"[^\\|]{1,}\\|{0,1}",
	-- 	"[\\d\\.\\-]{1,}"
	-- 	)
	spp:initVertices(
		gl.GL_TRIANGLE_STRIP,
		"-50,50,0,0.5,255,0,0,255|-100,-50,0,0|100,100,1,1|100,-100,1,0,255,255,0,255"
		)
	self:addTestNd(spp)

	local spp = CCShaderSprite:create("UI/xishouA.png")
	spp:setAnchorPoint(ccp(0,0))
	spp:setScale(1.0)
	spp:setFlipX(true)
	spp:setPosition(display.cx,display.cy+200)
	spp:initVertices(gl.GL_TRIANGLE_FAN,"0,0,0.5,0.5|-100,100,0,1|-100,-100,0,0|100,-100,1,0|100,100,1,1|-100,100,0,1")
	-- spp:initVertices(gl.GL_TRIANGLE_STRIP,"-100,50,0,1|-100,-50,0,0|100,100,1,1|100,-100,1,0")
	-- spp:initVertices(gl.GL_QUADS,"-100,50,0,1|-100,-100,0,0|100,-100,1,0|100,100,1,1")
	-- spp:initVertices(gl.GL_TRIANGLE_STRIP,"100,100,1,1|100,50,1,0.7|-100,50,0,1|100,-50,1,0.3|-100,-50,0,0|100,-100,1,0")
	self:addTestNd(spp,true)
	--spp:runAction(CCRotateBy:create(10.0,720))
end

function TestScene:tstPageview()
	local PageView = require("uis.listview.PageView")
	local ListViewCell = require("uis.listview.ListViewCell")
	local CellBtn = require("uis.listview.CellButton")
	local nd = PageView.new(CCRect:new(0,0,200,200),1,true)
	
	local tb={
		"UI/crit.png",
		"UI/god.png",
		"UI/missA.png",
		"UI/missB.png",		
		"UI/xishouA.png",
		"UI/xishouB.png",
	}
	local cells={}
	for i,v in pairs(tb) do
		local cell = ListViewCell.new(CCSize(200,200))
		local bg = CCDrawNode:create()
		local points={}
	    points[1] = {0,0}
	    points[2] = {0,200}
	    points[3] = {200,200}
	    points[4] = {200,0}	   
		bg:drawPolygon(points,
                        {   
                            fillColor = cc.c4f(1,1,1,0.5),
                            borderWidth =   1,
                            borderColor =   cc.c4f(1,1,1,0.5)
                        }
                    )        
		local cellbtn = CellBtn.new(
				{
				    normal  = tb[i],
				}
			)
		bg:setAnchorPoint(ccp(0,0))
		bg:setPosition(0, 0)
		cell:addChild(bg)
		cellbtn:setAnchorPoint(ccp(0.5,0.5))
		cellbtn:setPosition(100, 100)
		cellbtn:setPressAnima(true)
		cell:addNode(cellbtn)
		table.insert(cells,cell)
	end
	nd:addCells(cells)
	nd:setPosition(100, 100)
	nd:ignoreAnchorPointForPosition(false)
	nd:setAnchorPoint(ccp(0.5,0.5))
	self:addTestNd(nd)
	nd:setTouchEnabled(true)
	nd:setCellAlign(0.0)
	--timer.performWithDelayGlobal(function() print("llllllll") nd:skipToCellIfNeed(5,0) end,2.0)
end

function TestScene:tstListview()
	local timer = require("framework.scheduler")	
	local ListView = require("uis.listview.ListView")
	local ListViewCell = require("uis.listview.ListViewCell")
	local CellBtn = require("uis.listview.CellButton")
	local nd = ListView.new(CCRect:new(0,0,120,200),1,true)
	
	local tb={
		"UI/crit.png",
		"UI/god.png",
		"UI/missA.png",
		"UI/missB.png",		
		"UI/xishouA.png",
		"UI/xishouB.png",

		"UI/crit.png",
		"UI/god.png",
		"UI/missA.png",
		"UI/missB.png",		
		"UI/xishouA.png",
		"UI/xishouB.png",

		"UI/crit.png",
		"UI/god.png",
		"UI/missA.png",
		"UI/missB.png",		
		"UI/xishouA.png",
		"UI/xishouB.png",

		"UI/crit.png",
		"UI/god.png",
		"UI/missA.png",
		"UI/missB.png",		
		"UI/xishouA.png",
		"UI/xishouB.png",
	}
	local cells={}
	for i,v in pairs(tb) do
		local cell = ListViewCell.new(CCSize(120,80))
		local bg = CCDrawNode:create()
		local points={}
	    points[1] = {0,0}
	    points[2] = {0,80}
	    points[3] = {120,80}
	    points[4] = {120,0}	   
		bg:drawPolygon(points,
                        {   
                            fillColor = cc.c4f(1,1,1,0.5),
                            borderWidth =   1,
                            borderColor =   cc.c4f(1,1,1,0.5)
                        }
                    )
		local cellbtn = CellBtn.new(
				{
				    normal  = tb[i],
				}
			)
		bg:setAnchorPoint(ccp(0,0))
		bg:setPosition(0, 0)
		cell:addChild(bg)
		cellbtn:setAnchorPoint(ccp(0.5,0.5))
		cellbtn:setPosition(60, 40)
		cellbtn:setPressAnima(true)
		cell:addNode(cellbtn)
		table.insert(cells,cell)
	end
	nd:addCells(cells)
	nd:setPosition(200, 200)
	self:addTestNd(nd)
	nd:setTouchEnabled(true)
	nd:setCellAlign(0.8)
	timer.performWithDelayGlobal(function() print("llllllll") nd:skipToCellIfNeed(5,0) end,2.0)
end

function TestScene:tstScrollview()
	local ScrollView = require("uis.listview.ScrollView")
	local nd = ScrollView.new(CCRect:new(0,0,200,200),2,true)
	local sp1 = display.newSprite("UI/cpt_bg_01.png")	
	local sp2 = display.newSprite("UI/god.png")
	sp2:addTo(sp1, 0, 100)	
	print("sp2===tag",sp2:getTag())
	sp2:pos(640, 310)
	nd:setContainer(sp1)
	nd:setPosition(300, 400)
	self:addTestNd(nd)
	nd:setTouchEnabled(true)
end

function TestScene:tstCCS()
	-- local r = ccsload.createNode("MainLayer.json")
	local r = ccsload.load("MainScene.json")
	if(r and r.node) then
		r.node:setPosition(0, 0)
		self:addTestNd(r.node,10);
		-- local nd = r:getChildByName("PageView")
		-- local img = r:getChildByName("Image")
		local img = r.Image
		-- GenUiUtil.attackShader(img,"LIGHTBAND")
		--img:runAction(CCRotateBy:create(2.0,720))
		
		local nd = r:getChildByName("ListView")
		
		local ListViewCell = require("uis.listview.ListViewCell")
		local CellBtn = require("uis.listview.CellButton")
		local cells={}
		for i=1,1 do
			local r = ccsload.load_listviewcell("PageCell.json")
			-- dump(r,"PageCell",5)
			-- local btn = r:getChildByName('Button')
			local btn = r.Button
			btn:onButtonClicked(function(evt)
				print("PageCell btn click",evt.x)
			end)
			local cell = r.node
			cell:setId(i)
			table.insert(cells,cell)
			r:getChildRoot("img"):playAnim(5,function(key)
				print("ccs310anim k: ",key)
			end)

		end
		nd:addCells(cells)
		nd:setTouchEnabled(true)
		nd:setCellAlign(0.0)

		local gif = r.gif
		if(gif) then
			gif:enableTouch(true)
			gif:onTouch(function(evt)
		 		if(evt.name=='began') then
		 			if(gif:isplaying()) then
		 				gif:pause()
		 			else
		 				gif:play()
		 			end
		 			return true
		 		end
		 	end)
		 	gif:setloop(false)
	 	end
	end
end

function TestScene:tstJson()
	local str = get_file_data("test.json")
	if(str) then
		print("test.json len",string.len(str),json.decode(str))
	end	
end

function TestScene:tstGenUi()
	local al = ALayer:new()
	self:addTestNd(al)
end
function TestScene:tstShader()
	local spp = GenUiUtil.genJpgMaskSp("hero1014.jpg","hero1014a.jpg","UI/")
	spp:setSdf4(1,0.5,0.1,0.9,1.0)
	spp:setScale(0.5)
	spp:setPosition(display.cx,display.cy)
	self:addTestNd(spp)
	local str = "UI/cup.png"
	-- local str = "UI/hero1015.jpg"
	-- local str = "UI/hero1014.jpg"
	local str = "UI/monkey.png"
	local str = "UI/item_2.png"
	local spp = CCShaderSprite:create(str)
	spp:scale(2.0)
	GenUiUtil.attackShader(spp,"LIGHTBAND")
	spp:setPosition(display.cx,display.cy)
	spp:setColor(ccc3(255,255,255))
	self:addTestNd(spp)
	local __mb = ccBlendFunc()
    __mb.src = GL_SRC_ALPHA
    __mb.dst = GL_ONE_MINUS_SRC_ALPHA
    spp:setBlendFunc(__mb)
 	local sp_w =spp:getContentSize().width
 	local sp_h =spp:getContentSize().height
 	spp:setTouchEnabled(true)
 	spp:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(evt)
 		local pp = spp:convertToNodeSpace(ccp(evt.x,evt.y))
 		spp:setSdf(1,pp.x/sp_w)
 		spp:setSdf(2,1-pp.y/sp_h)
 		return true
 	end)

end
function TestScene:tstJz()
	local spp = CCShaderSprite:create("UI/cpt_bg_01.png")
	GenUiUtil.runJzEffect(spp,1,64,6,false,function (...)
		print("tstJzAnim over")
		GenUiUtil.runJzEffect(spp,1,64,12,true,function (...)
			self:cleanTestNd()
		end)
	end)
	spp:setSdf(4,1.0)
	spp:setPosition(display.cx,display.cy)
	self:addTestNd(spp)
end

function TestScene:tstTween()
	local act = CCActionTween:create(1.0,"look",100,200,function(v,key)
		print("CCActionTween",v,key)
	end)
	self:runAction(act)
end

function TestScene:tstSpine()
	local skeletonNode = SkeletonAnimation:createWithFile("data/A160413.json", "data/A160413.atlas", 0.3)
	dump(SkeletonRenderer)

	skeletonNode:setMix("pig_1", "pig_2", 0.2)
	skeletonNode:setMix("pig_2", "pig_3", 0.2)
	skeletonNode:setAnimation(0, "pig_1", true)
	local jumpEntry = skeletonNode:addAnimation(0, "pig_3", false, 3)
	skeletonNode:addAnimation(0, "pig_2", true)
	skeletonNode:setPosition(display.width / 2, 20)
	self:addTestNd(skeletonNode)
	skeletonNode:setScriptHandlerForAnima(function(name,trackidx,tp,evt,loopct)
		print(name,trackidx,tp,evt.data.name,loopct)
	end)
	skeletonNode:setScriptHandlerForTrack(function(name,trackidx,tp,evt,loopct)
		print(name,trackidx,tp,evt.data.name,loopct)
	end)
end

function TestScene:tstRenderTexture()
		local rt = CCRenderTexture:create(display.width,display.height)
		rt:setAnchorPoint(ccp(0,0))
		rt:setPosition(0,0)
		local str = "UI/monkey.png"
		local spp = display.newSprite(str)
		if(spp) then
			print("----------",spp:getContentSize().width,spp:getContentSize().height)
			spp:setPosition(display.cx,display.cy)
			rt:addChild(spp)
		end

		local bg = CCDrawNode:create()
		local points={}
	    points[1] = {0,0}
	    points[2] = {50,100}
	    points[3] = {150,100}
	    points[4] = {100,0}	   
		bg:drawPolygon(points,
                        {   
                            fillColor = cc.c4f(1,1,1,0.5),
                            borderWidth =   4,
                            borderColor =   cc.c4f(1,1,1,0.5)
                        }
                    )
		local __pb = ccBlendFunc()
		__pb.src = GL_SRC_ALPHA
		__pb.dst = GL_ONE_MINUS_SRC_ALPHA
		spp:setBlendFunc(__pb)
		bg:setBlendFunc(__pb)
		rt:addChild(bg)
		rt:begin()
	    spp:visit()
	    bg:visit()
	    rt:endToLua()

		print("llllllll333=%d,%d")
		local rtspt = CCSprite:createWithTexture(rt:getSprite():getTexture())
    	rtspt:setFlipY(true)
    	rtspt:setAnchorPoint(ccp(0,0))
    	self:addTestNd(rtspt)
end

function TestScene:tstShader2()
	local rock = "UI/hero1015.jpg"
	-- local rock = "UI/monkey.png"
	local noise = "UI/noise.png"
	local water = "UI/water.png"
	local spp = CCShaderSprite:create(rock)
	local watertextute = CCTextureCache:sharedTextureCache():addImage(water)
	spp:setCC_Texture1(watertextute)

	local noisetextute = CCTextureCache:sharedTextureCache():addImage(noise)
	spp:setCC_Texture2(noisetextute)
	spp:setSdf(1,0.0)
	spp:setSdf(2,0.0)
	self.dt=0.0

	 spp:schedule(function(dt)
						self.dt=self.dt+1.0/60.0;
						spp:setSdf(1,math.mod(self.dt/50.0,1.0))
						spp:setSdf(2,math.mod(self.dt,1.0))
					end, 0.01)

	local tp = ccTexParams()
    tp.minFilter = gl.GL_LINEAR
    tp.magFilter = gl.GL_LINEAR
    tp.wrapS = gl.GL_REPEAT
    tp.wrapT = gl.GL_REPEAT
	noisetextute:setTexParameters(tp)
	watertextute:setTexParameters(tp)
	spp:scale(2.5)
	GenUiUtil.attackShader(spp,"WATERWAVE")
	spp:setPosition(display.cx,display.cy)
	spp:setColor(ccc3(255,255,128))
	self:addTestNd(spp)

		local __pb = ccBlendFunc()
		__pb.src = GL_SRC_ALPHA
		__pb.dst = GL_ZERO
		spp:setBlendFunc(__pb)
end
function TestScene:tstImgPick()
	print("imgpick_hasCamera = ",imgpick_hasCamera())
    timer.delay(imgpick_fromalbum,2.0)
end
function TestScene:tstHttp()
	function httprsp(id,type,data)
			if(type==0) then
				print(id,type,string.len(data))
			elseif(type==1) then
				print(id,type,data[1],data[2])
			elseif(type==-1) then
				print(id,type,data)
			elseif(type==-2) then
				print(id,type,data)
			end
	end
	http.get('bing',"http://www.bing.com",20,httprsp)
	http.get('sina',"http://www.sina.com",20,httprsp)
end
function TestScene:tstZip()
	local fd = zipfile_open('framework_precompiled.zip')
	-- local fd = zipfile_open('test.zip')
	if(fd) then
		local str = fd:getFirstFilename()
		while(str and str~='') do
			 print("zipfile: ",str)
			 str = fd:getNextFilename()
		end
	end
	local tb = fd:getFileList()	
	print("tb",tb)
	if(tb) then
		dump(tb,"getFileList")
		for i,v in ipairs(tb) do
			print(v)
			-- package.preload[v]=nil
		end
	end
	unload_code_zip('framework_precompiled.zip')
	local data = fd:getFileDataNoOrder("framework.init")
	if(data) then
		print("get framework.json: ",string.len(data),string.byte(data,1,4))
	end
	print("get no exits: ",fd:getFileDataNoOrder("exits.json"))
	zipfile_close(fd)
	--dump(package.loaded,2)
	for k,v in pairs(package.loaded) do
		if(k~='_G') then
			print(k)
		end
	end
	print("llllllllllll")
end

function TestScene:tstFs()
	local str = string.gsub(string.sub(fs_write_path,1,-2),'\\','/')
	print('tstFs',str)
	local dir,file = fs.list(str)
	print("dir",#dir)
	print("file",#file)
end

function TestScene:tstShort()
	local nd = display.newSprite("UI/pig.jpg"):pos(100,100):arch(0,0)
	self:addTestNd(nd)

end	

function TestScene:tstEdit()

	local nd = ui.newEditBox(
                        {
                            size = cc.size(200,50),
                        })
    nd:setPlaceHolder("please inputfffff")
    nd:setFontSize(48)
    nd:setColor(ccc3(255,255,0))
    nd:arch(0.5,0.5)
    nd:setText("name jackf")
	nd:pos(display.cy,display.cy-200)
	self:addChild(nd)
	nd:setContentSize(cc.size(200,50))
	print(nd:getPositionY(),nd:isVisible())
	-- nd:runAction(CCScaleTo:create(2.0, 100.0))

end	
function TestScene:tstGif()
	--self.TND:setTouchEnabled(true)
	local name = "UI/g4.gif";
	local gif = InstantGif:create(name)
	print(gif)
	gif:arch(0.5,0.5)
	gif:pos(display.cx,display.cy)
	gif:scale(2.0)
	self:addTestNd(gif)
	gif:setTouchEnabled(true)
	gif:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(evt)
 		if(evt.name=='began') then
 			if(gif:isplaying()) then
 				gif:pause()
 			else
 				gif:play()
 			end
 			return true
 		end
 	end)
 	-- gif:setloop(false)
	-- local name = "UI/g2.gif"
	-- local gif = CacheGif:create(name)
	-- gif:arch(0.5,0.5)
	-- gif:pos(400,700)
	-- gif:scale(0.5);
	-- self:addTestNd(gif,true)
	-- gif:setTouchEnabled(true)
	-- gif:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(evt)
	-- 	if(evt.name=='began') then
	-- 		if(gif:isplaying()) then
	-- 			gif:pause()
	-- 		else
	-- 			gif:play()
	-- 		end
	-- 		return true
	-- 	end
	-- end)
	-- gif:setloop(false)

end
function TestScene:tstBlend()
	local nd = display.newSprite("UI/cpt_bg_01.png")
	nd:arch(0,0):pos(0,0):scale(2.0)
	self:addTestNd(nd)

	local bg , mask = GenUiUtil.genMaskNode("UI/filter.png",60)
	if(bg and mask) then
		self:addTestNd(bg,true)
		mask:pos(320,500)
		local seq = transition.sequence({
				CCScaleTo:create(5.0,5.0),
				CCScaleTo:create(5.0,1.0)
			})
		mask:runAction(seq)
		mask:runAction(CCRotateBy:create(12.0,3600))
		GenUiUtil.setDraggable(mask)
	end
end
function TestScene:tstBlendClip()
	local bg = display.newSprite("UI/cpt_bg_02.png")
	bg:arch(0,0):pos(0,0):scale(2.0)
	self:addTestNd(bg)

	local nd = GenUiUtil.genClipLoadingBar("UI/cpt_bg_01.png","UI/filter2.png",{50,50,1,1})
	if(nd) then
		nd:scale(0.5)
		self:addTestNd(nd,true)
		GenUiUtil.setDraggable(nd)
		local act = CCActionTween:create(5.0,"per",1,100,function(v,key)
			nd:setPercent(v)
		end)
		nd:runAction(act)
	end

	local nd , sp, clip = GenUiUtil.genClipNode("UI/head.jpg","UI/filter2.png")
	if(nd and sp) then
		self:addTestNd(nd,true)
		sp:pos(320,500)
		sp:scale(1.5)
		clip:pos(320,500)
		local seq = transition.sequence({
			CCScaleTo:create(2.0,5.0),
			CCScaleTo:create(2.0,0.5)
		})
		clip:runAction(CCRepeatForever:create(seq))
		GenUiUtil.setDraggable(clip)
	end
	
end	
function TestScene:tstAnim()
	local r = ccsload.load("AnimScene.json")
	if(r and r.node) then
		r.node:setPosition(0, 0)
		self:addTestNd(r.node)
	end
	r:getChildRoot("img"):playAnim(5,function(key)
		print("img frame ",key)
	end)
	r:getChildRoot("gif"):playAnim(-1)
	r.gif:setTouchEnabled(true)
	r.gif:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(evt)
 		if(evt.name=='began') then
 			if(r.gif:isplaying()) then
 				r.gif:pause()
 				transition.resumeTarget(r.gif)
 			else
 				r.gif:play()
 				transition.pauseTarget(r.gif)
 			end
 			return true
 		end
 	end)
 	r.gif:setloop(true)

end
function TestScene:tstMount()
	local fd = zipfile_open('res.zip')
	-- local fd = zipfile_open('test.zip')
	if(fd) then
		local str = fd:getFirstFilename()
		while(str and str~='') do
			 print("Mount zipfile: ",str)
			 str = fd:getNextFilename()
		end
	end
	local tb = fd:getFileList()	
	if(tb) then
		dump(tb,"Mount getFileList")
		for i,v in ipairs(tb) do
			print(v)
			-- package.preload[v]=nil
		end
	end
	print("get no exits: ",fd:getFileDataNoOrder("exits.json"))
	zipfile_close(fd)

	local source = fs.fullpath("res.zip")
	print("mount @app == ",fs.mount("app",source,true))
	print("@app/a.txt == ",fs.data("@app/a.txt"))
	print("@app/add/b.txt == ",fs.data("@app/add/b.txt"))
	print("@app/add/ccc/c.txt == ",fs.data("@app/add/ccc/c.txt"))
	fs.unmount(source)
	print("@app/a.txt == ",fs.data("@app/a.txt"))
	fs.mountclean()

end

function TestScene:tstLuaSocket()
	local socket = require "socket"
	local socket_core = require "socket.core"
	print(socket==socket_core)
	local ltn12 = require("ltn12") 		
	print(ltn12)
	local mime = require("mime") 		
	print(mime)
	local ftp = require("socket.ftp") 	
	print(ftp)
	local headers = require("socket.headers") 
	print(headers)
	local mbox = require("socket.mbox") 		
	print(mbox)
	local smtp = require("socket.smtp") 
	print(smtp)
	local tp = require("socket.tp") 
	print(tp)
	local url = require("socket.url") 
	print(url)
	local httptt = require("socket.http")
	print(httptt)

	local addrinfo,err = socket.dns.getaddrinfo("www.bing.com")
	dump(addrinfo)
	local addrinfo,err = socket.dns.getaddrinfo("192.168.1.1")
	dump(addrinfo)
	local myip = socket.dns.toip("www.baidu.com")
	print("myip = ",myip)

	local t={}
	local r,e,h= 
		httptt.request{ 
	    	url = "http://www.baidu.com", 
	    	sink = ltn12.sink.table(t),
	    	--sink = ltn12.sink.file(io.open("/Users/jeep/a.txt"))
	    	port= 80,
	    	timeout = 1,
	    	useragent= "good",
	    }

	print(e)
	print(r)
	dump(h)
	for k,v in pairs(t) do
		print(k,string.sub(v,1,16))
	end	
end
function lua_js_callback(data)
	print("lua_js_callback",data)
	local obj = json.decode(data)
	if(obj) then
		if(obj.cmd=='goback') then
			callLuaBridgeMethod("hide_webview",{})
			show_webview = false
		elseif(obj.cmd=='del') then
			callLuaBridgeMethod("del_webview",{})
			show_webview = false
		end	
	end
	
end

function TestScene:tstWebView()
	if(not show_webview) then
		show_webview = true
		callLuaBridgeMethod("show_webview",{"res/js/game.html",lua_js_callback})
		-- callLuaBridgeMethod("show_webview",{"http://192.168.1.27:8080/zhpay/index.html",lua_js_callback})		
		-- callLuaBridgeMethod("show_webview",{"http://gamecenter.egret-labs.org/?chanId=20409&welcome=1",lua_js_callback})

	end	
end

function TestScene:tstBeizer()
	self:addTestNd(Abeizer:new())
end



return TestScene
