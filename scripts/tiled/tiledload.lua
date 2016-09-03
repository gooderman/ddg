-------------------------------------
--map class
local M={}
M.__index=M
function M:getObjectByName(tag)
end
--layer root
function M:getRootByName(name)
	for _,v in ipairs(self.nodes) do
		if(v.name==name) then
			return v.root
		end
	end
end
-- layer sub batchsprite only return first
-- return SM
-- bnodes[i]={name=bnd.img,node=bnd.nd}
-- nodes[i]={name=v.name,gw=gw,gh=gh,tw=tw,th=th,node=nd,childs=bnodes}
function M:getLayerByName(name)
	for _,v in ipairs(self.nodes) do
		if(v.name==name) then
			return v
		end
	end
end
--格子元素属性
--编号tid(1-M)
function M:getTiledInfo(tid)
	return self.tiledinfo[tid]
end
--格子元素属性
--编号type
function M:getTiledInfoByType(type)
	return self.tiledinfo_bytype[type]
end
--对象属性gid(1-N) 格子顺序
function M:getObjectInfo(groupname,gid)
	local v = self.objinfo[groupname]
	if(v) then
		return v[gid]
	end
end
--对象属性gid(1-N) 格子顺序
function M:getObjectPropertys(groupname,gid)
	local v = self.objinfo[groupname]
	if(v and v[gid]) then
		return v[gid].properties
	end
end
--------------------------------------
-- map layer class
-- batchnd[i]={}
-- batchnd[i].use = false
-- batchnd[i].name = v.name
-- batchnd[i].img = v.image
-- batchnd[i].node = CCSpriteBatchNode:create(v.image,gw*gh)
-- batchnd[i].firstgid = v.firstgid
-- batchnd[i].endgid = v.endgid	
-- batchnd[i].childs = {}
---- batchnd[i].childs[gid]={tid=g,node=spt}
-- __sm={name=v.name,data=v.data,gw=gw,gh=gh,tw=tw,th=th,root=root,childs=batchnd}
-- girdrect[i-1+v.firstgid] = {x=x,y=y,w=tw,h=th,tiled=TI}
local SM={}
SM.__index=SM
--gid 1-N
--gx,gy 0--N-1
function SM:genGid(x,y)
	y = self.h-y
	x = math.floor(x/self.tw)
	y = math.floor(y/self.th)
	if(x<0 or x>=self.gw or y<0 or y>=self.gh) then
		return
	end
	return y*self.gw+x+1,x,y
end
--gx,gy 0--N-1
function SM:genPos(gx,gy,center)
	if(center) then
		return gx*self.tw+self.tw/2,self.h-(gy*self.th+self.th/2)
	else
		return gx*self.tw,self.h-gy*self.th
	end	
end
--gid 1-N
--gx,gy 0--N-1
function SM:genGxy(gid)
	local gx = math.mod(gid-1,self.gw)
	local gy = math.floor((gid-1)/self.gw)
	return gx,gy
end

function SM:getTileAtGid(gid)
	for _,v in ipairs(self.childs) do
		if(v.use and v.childs[gid] and v.childs[gid].node) then
			return v.childs[gid].node,v.childs[gid].tid
		end
	end
end

function SM:getTileAt(x,y)
	local gid = self:genGid(x,y)
	if(not gid) then
		return
	end
	-- print("getTileAt x   = "..x)
	-- print("getTileAt y   = "..y)
	-- print("getTileAt gid = "..gid)
	-- dump(self.childs)
	return self:getTileAtGid(gid)
end

function SM:setTileAtGid(tid,gid,gx,gy,removeall)
	-- remove all layer
	if(removeall) then
		for _,v in ipairs(self.childs) do
			if(v.use and v.childs[gid]) then
				if(v.childs[gid].node) then
					v.childs[gid].node:removeSelf()
					v.childs[gid].node=nil
					v.childs[gid].tid=0
				end
			end
		end
	end
	local tt = self.girdrect[tid]
	if not(tt and tt.tiled) then
		return
	end
	local bnd = self.childs[tt.tiled]
	if(bnd.node) then
		bnd.use = true
		bnd.childs[gid]=bnd.childs[gid] or {}
		if(bnd.childs[gid].node)then
			bnd.childs[gid].node:removeSelf()
			bnd.childs[gid].node=nil
		end				
		local spt = CCSprite:create(bnd.img,CCRect(tt.x,tt.y,tt.w,tt.h))
		if (gx and gy) then
		else
			gx,gy =self:genGxy(gid)
		end	
		local nx,ny = self:genPos(gx,gy,true)
		-- print("nx = " ..nx)
		-- print("ny = " ..ny)
		spt:setPosition(nx,ny)
		spt:setTag(gid)
		bnd.node:addChild(spt)
		bnd.childs[gid].tid=tid
		bnd.childs[gid].node=spt
		bnd.node:setVisible(true)
	end	
end	
function SM:setTileAt(tid,x,y,removeall)
	local gid,gx,gy = self:genGid(x,y)
	if(not gid) then
		return
	end
	-- print("setTileGID gx   = "..gx)
	-- print("setTileGID gy   = "..gy)
	-- print("setTileGID gid = "..gid)
	return self:setTileAtGid(tid,gid,gx,gy,removeall)	
end

function SM:delTileAtGid(gid)
	for _,v in ipairs(self.childs) do
		if(v.use and v.childs[gid]) then
			if(v.childs[gid].node) then
				v.childs[gid].node:removeSelf()
				v.childs[gid].node=nil
				v.childs[gid].tid=0
			end
		end
	end
end

function SM:delTileAt(x,y)
	local gid = self:genGid(x,y)
	if(not gid) then
		return
	end
	-- print("delTileAt x   = "..x)
	-- print("delTileAt y   = "..y)
	-- print("delTileAt gid = "..gid)
	delTileAtGid(gid)
end

function SM:swapAtGid(ogid,ngid)
	-- print("swapAtGid")
	for _,v in ipairs(self.childs) do
		if(v.use and v.childs[ogid] and v.childs[ogid].node and v.childs[ngid] and v.childs[ngid].node) then
			local nd = v.childs[ogid].node
			local x,y = nd:getPosition()
			local tid = v.childs[ogid].tid

			local _nd = v.childs[ngid].node
			local _x,_y = _nd:getPosition()
			local _tid = v.childs[ngid].tid
			-- printf("swapAtGid=%d,%d,%d",x,y,tid)
			-- printf("swapAtGid=%d,%d,%d",_x,_y,_tid)
			v.childs[ogid].node =  _nd
			v.childs[ogid].tid = _tid
			v.childs[ogid].node:setPosition(x, y)
			v.childs[ngid].node =  nd
			v.childs[ngid].tid = tid
			v.childs[ngid].node:setPosition(_x, _y)
			-- printf("swapAtGid=%d,%d",v.childs[ngid].node:getPosition())
			break
		end
	end
end

function SM:swapAt(x,y,dx,dy)
	local ogid,ogx,ogy = self:genGid(x,y)
	-- print("swapAt",ogid)
	if(not ogid) then
		return
	end
	local ngid,ngx,ngy = self:genGid(dx,dy)
	-- print("swapAt",ngid)
	if(not ngid) then
		return
	end
	local t = math.abs(ogid-ngid)
	if(t==1 or t==self.gh) then
		return self:swapAtGid(ogid,ngid)
	end
end
--------------------------------------
--------------------------------------
require "pack"
local function unzip(data)
	local tb={}
	local str = unzip_decode_str(data) or ""
	for i=1,string.len(str),4 do
		local __,__v= string.unpack(str,"<I",i)
		-- print(math.ceil(i/4).."=="..__v)
		tb[math.ceil(i/4)] = __v
	end
	return tb
end
local function gen(T,path,suppm)
	local r={}
	local nodes={}
	local girdrect={}
	local tiledinfo={}
	local tiledinfo_bytype={}
	local objinfo={}
	--r.data = T
	r.nodes=nodes
	r.girdrect=girdrect--[gid](1-N)
	r.tiledinfo=tiledinfo--[tid](1-N)
	r.tiledinfo_bytype=tiledinfo_bytype--[type]
	r.objinfo=objinfo--[group][gid](1-N)
	-- r.objects={}
	-- r.tiles={}
	local tw = T.tilewidth
	local th = T.tileheight
	local gw = T.width
	local gh = T.height
	local w = tw*gw
	local h = th*gh
	--unzip for tilelayer
	--gid for objectgroup
	for _,v in ipairs(T.layers) do
		if(v.type=='tilelayer') then
			if(type(v.data)=='string') then
				if(v.encoding=="base64" and v.compression == "zlib") then
					v.data =  unzip(v.data)
				else
					print("no base64 or no zlib")
					return
				end
			end
		elseif(v.type=='objectgroup') then
			local t={}
			for _,vv in ipairs(v.objects) do
				if(vv.x>w or vv.x<0 or vv.y>h or vv.y<0) then
					vv.gid = 0
				else	
					local x = math.floor((tw-1+vv.x)/tw)
					local y = math.floor(vv.y/th)
					vv.gid = x + y*gw
				end
				t[vv.gid]=vv
			end
			objinfo[v.name]=t
			--dump(v.objects)
		end
	end
	-- dump(objinfo)
	-- modify tilesets
	for TI,v in ipairs(T.tilesets) do
		v.image = path..v.image --add full path
		v.endgid = v.firstgid+v.tilecount-1
		--only one grid tiles empty
		local tw = v.tilewidth
		local th = v.tileheight
		local iw = v.imagewidth
		local ih = v.imageheight
		local mar = v.margin
		local spc = v.spacing
		local gw =  math.floor((iw-mar)/(tw+mar))
		local gh =  math.floor((ih-spc)/(th+spc))
		v.gw = gw
		v.hg = gh
		for i=1,v.tilecount do
			local x = mar + math.mod(i-1,gw)*(tw+mar)
			local y = math.floor((i-1)/gw)*(th+spc)
			--vv.y = ih - vv.y
			--add gird rect 
			girdrect[i-1+v.firstgid] = {x=x,y=y,w=tw,h=th,tiled=TI}
		end
		for _,vv in ipairs(v.tiles) do
			vv.properties.tid = vv.id+v.firstgid
			tiledinfo[vv.id+v.firstgid] = vv.properties
			if(vv.properties.type) then
				tiledinfo_bytype[vv.properties.type] = vv.properties
			end
		end
	end
	-- dump(girdrect)
	-- dump(tiledinfo)
	-- dump(a.tilesets,"fuck",6)
	-- gen node
	for _,v in ipairs(T.layers) do
		--prepare batchnd
		local batchnd={}
		for i,v in ipairs(T.tilesets) do
			batchnd[i]={}
			batchnd[i].use = false
			batchnd[i].name = v.name
			batchnd[i].img = v.image
			batchnd[i].node = CCSpriteBatchNode:create(v.image,gw*gh)
			-- batchnd[i].node = CCSpriteBatchNode:create(v.image)
			batchnd[i].firstgid = v.firstgid
			batchnd[i].endgid = v.endgid
			batchnd[i].childs = {}
			--batchnd[i].childs[tag]={gid=g,node=spt}

		end
		local function __find(g)
			for i,bnd in ipairs(batchnd) do
				if(g>=bnd.firstgid and g<=bnd.endgid) then
					return bnd
				end
			end
		end
		local root = display.newNode()
		local use=false
		if(v.type=='tilelayer') then			
			root:setContentSize(CCSize(tw*v.width,th*v.height))
			for i,g in ipairs(v.data) do
				local col = math.mod(i-1,gw)
				local row = math.floor((gw+i-1)/gw)
				local x = col*tw
				local y = h-row*th
				--find batchnd
				local bnd = __find(g)
				if(bnd) then
					use = true
					local sx = girdrect[g].x
					local sy = girdrect[g].y
					local sw = girdrect[g].w
					local sh = girdrect[g].h
					local spt = CCSprite:create(bnd.img,CCRect(sx,sy,sw,sh))
					local gid = i--start from 1
					spt:setTag(gid)
					--add to batch node
					--spt:setAnchorPoint(ccp(0,0))
					spt:setPosition(x+tw/2, y+th/2)
					bnd.node:addChild(spt)
					bnd.use = true
					bnd.childs[gid]={tid=g,node=spt}
				end	
			end
		elseif(v.type=='imagelayer') then
			local spt = CCSprite:create(path..v.image)
			local sz = spt:getContentSize()
			-- spt:setAnchorPoint(ccp(0,0))
			local x = v.offsetx
			local y = h-sz.height-v.offsety
			spt:setPosition(x+sz.width/2,y+sz.height/2)
			root:addChild(spt)
			use=true
		end
		--add batchnd to node
		for i,bnd in ipairs(batchnd) do
			if(bnd.use or suppm) then
				use = true
				root:addChild(bnd.node)
				bnd.node:setAnchorPoint(ccp(0,0))
				bnd.node:setPosition(0,0)
				if(not bnd.use) then
					bnd.node:setVisible(false)
				end
			else
				bnd.node=nil
			end
		end
		if(not v.visible) then
			root:setVisible(false)
		end
		if(use) then
			--girdrect record tiled_id
			--batchnd record all tileds even not use by layer
			--use batchnd to gen sprite by gid
			local __sm={name=v.name,data=v.data,w=w,h=h,gw=gw,gh=gh,tw=tw,th=th,root=root,childs=batchnd,girdrect=girdrect}
			setmetatable(__sm, SM)
			table.insert(nodes,__sm)
		end
	end
	setmetatable(r, M)	
	return r
end	

--conver json to table
function M.load(luafile,path,supp_more_image_each_layer)
	path = path or ""
	local tb = run_lua_file(path..luafile)
	if(not tb) then
		return
	end
	return gen(tb,path,supp_more_image_each_layer)
end
----------------------------------------------
tiledload=M
