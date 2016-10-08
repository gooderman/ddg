import("uis.GenUiUtil")
local timer = require("framework.scheduler")
local BaseScene = import(".BaseScene")
local MainScene = class("MainScene", BaseScene)
function MainScene:ctor()
	self:initui()
end

function MainScene:initui()

	local r = self:loadccs("appbox/box.json",true)
	if(r and r.node) then
		self:addChild(r.node)
	else
		return
	end
	self:addccsevt(function(evt)
		print(evt.type)
		print(evt.data)
		print(evt.node:getName())
		if(evt.data=="btn_a") then
			self:openById('A')
		elseif(evt.data=="btn_b") then
			self:openById('B')
		elseif(evt.data=="btn_c") then
			-- self:openById('C')
			local act = r._btn_a:action(1)
			r.btn_c:runAction(act:copy())
			r.btn_a:runAction(act:copy())
			r.btn_b:runAction(act:copy())
			print("tostring self = ",tostring(self))
		elseif(evt.data=="play") then
			r:playAll(1)
		end
	end)
	-- local function foo(a)
	-- 	for i=1,a do
	-- 		local r = coroutine.yield(i)
	-- 		print("###===",i,r)
	-- 	end
	-- 	return a
	-- end
	-- local co = coroutine.create(foo)
	-- local rst,i = coroutine.resume(co,4)
	-- local tmact	
	-- local act = self:timer(function()
	-- 	rst,i = coroutine.resume(co,i*2)
	-- 	-- print(rst,i)
	-- 	if(not rst) then
	-- 		print("act == ",tostring(tmact))
	-- 		self:stopAction(tmact)
	-- 	end
	-- end,1.0)
	-- tmact=act

	GenUiUtil.setDraggable(r.img)
	r.img:scale(1.0)
	r.img:rotation(0)
end

function MainScene:openById(name)
	local srccode = true
	if(srccode) then
		--from lua file and dir
		local prefix = "appbox/game/"..name.."/"
		local res = fs.fullpath(prefix..'res/')
		local res_v1 = fs.fullpath(prefix..'res_v1/')  
		fs.mountclean()
		-- print(res)
		local rst = fs.mount(name,res,false)
		if(not rst) then
			print("mount fail",res)
			return
		end
		local rst = fs.mount(name,res_v1,false)
		if(not rst) then
			print("mount fail",res_v1)
			return
		end
		local run = require("appbox.game.".. name ..".main")
		run()
	else
		--from zip code and res
		local prefix = "appbox/game/"..name.."/"
		local res = fs.fullpath(prefix .."res.zip")
		local code = fs.fullpath(prefix .."code.zip")
		fs.mountclean()
		
		local rst = fs.mount(name,res,true)
		if(not rst) then
			print("mount fail",res)
			return
		end
		unload_code_zip(code)
		preload_code_zip(code)
		local run = require("game.".. name ..".main")
		run()

	end
end

return MainScene
