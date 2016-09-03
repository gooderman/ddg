
fs_write_path = CCFileUtils:sharedFileUtils():getWritablePath()
game_upd_path = fs_write_path .. "upd/"
function add_search_path(a)
	return CCFileUtils:sharedFileUtils():addSearchPath(a)
end

function run_lua_file(fileName)	
	local path = CCFileUtils:sharedFileUtils():fullPathForFilename(fileName)
	local function ppp()
	-- local filefun = loadstring(io.readfile(path))
	-- local filefun = loadstring(CCFileUtils:sharedFileUtils():getFileData(path))
	--解压缩代码
		local filefun = loadstring(CZHelperFunc:getFileData(path))
		return filefun()
	end
	local r, fileContent = pcall(ppp)
	if(r) then
		return fileContent
	else
		print("[Error]----run_lua_file ".. (path or ""))
	end	
end

function get_file_data(fileName)	
	local path = CCFileUtils:sharedFileUtils():fullPathForFilename(fileName)
	local r = CZHelperFunc:getFileData(path)
	if(r) then
		return r
	else
		print("[Error]----get_file_data ".. (path or ""))
	end	
end

--取测试配置地址
function get_tst_cfg_file()
	local path= device.writablePath
	if device.platform == "android" then
		return "/sdcard/ip.txt"
	elseif device.platform == "ios" then
		return path .. "ip.txt"	    
	else
		return path .. "res/ip.txt"
	end
end


----------------------------------------------------------

local GameState=require(cc.PACKAGE_NAME .. ".api.GameState") 
local gamedata
--读本地数据
function get_game_data(key)
	gamedata=gamedata or GameState.load() or {}
	return gamedata[key]
end
--写本地数据
function set_game_data(key, value,save)
	gamedata=gamedata or GameState.load() or {}
	gamedata[key]=value
	if(save) then
		GameState.save(gamedata)
	end
end
function save_game_data()
	GameState.save(gamedata or {})
end

--------------------------------------------------------
function unload_code_zip(filename)
	local fd = zipfile_open(filename)
	if(not fd) then
		return
	end
	local tb = fd:getFileList()
	if(tb) then
		for _,v in ipairs(tb) do
			package.loaded[v]=nil
		end
	end
	zipfile_close(fd)
end
function preload_code_zip(filename)
	CCLuaLoadChunksFromZIP(filename)
end
-------------------------------------------------------














