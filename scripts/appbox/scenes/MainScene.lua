import("uis.GenUiUtil")
local timer = require("framework.scheduler")
local BaseScene = import(".BaseScene")
local MainScene = class("MainScene", BaseScene)
function MainScene:ctor()
	self:initui()
end

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
		if(evt.data=="good") then
			self:openById('B')
		end
	end)
	-- r.btn_a:onButtonClicked(function()
	-- 		self:openById('A')
	-- 	end)
	
	-- r.btn_b:onButtonClicked(function()
	-- 		self:openById('B')
	-- 	end)
	r.btn_c:onButtonClicked(function()
			self:openById('C')
			--r:childroot("btn_c"):play(5)
			local act = r._btn_c:action(1)
			-- local act = r:childroot("btn_c"):action(1)
			r.btn_c:runAction(act:copy())
			r.btn_a:runAction(act:copy())
			r.btn_b:runAction(act:copy())

			print("tostring self = ",tostring(self))
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
