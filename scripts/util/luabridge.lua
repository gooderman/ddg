-----------------------------------------------------------------
local LuaBridgeInfo =
{
	["getMemInfo"] 			= {methodName = "getMemInfo",		javaClassName = "org/cocos2dx/lib/Cocos2dxHelper",	javaMethodSig="(I)I",	ocClassName = "LuaOCBridge"},
	["end"]					= {methodName = "end",				javaClassName = "org/cocos2dx/lib/Cocos2dxHelper",	javaMethodSig="()V",	ocClassName = nil},
	["setEffectsRate"] 		= {methodName = "setEffectsRate",	javaClassName = "org/cocos2dx/lib/Cocos2dxHelper",	javaMethodSig="(I)V",	ocClassName = nil},
	["setAppEventHandler"] 	= {methodName = "setAppEventHandler",	javaClassName = "com/heygam/dsxinfo/DsxInfo",	javaMethodSig="(I)I",	ocClassName = "LuaOCBridge"},
	["notifyAppEvent"] 		= {methodName = "notifyAppEvent",	javaClassName = "com/heygam/dsxinfo/DsxInfo",	javaMethodSig="(Ljava/lang/String;Ljava/lang/String;)I",	ocClassName = nil},
	["Login"] 				= {methodName = "Login",			javaClassName = "com/heygam/dsxinfo/DsxInfo",	javaMethodSig="(I)V",	ocClassName = "LuaOCBridge"},	
	["setServerInfo"] 		= {methodName = "setServerInfo",	javaClassName = "com/heygam/dsxinfo/DsxInfo",	javaMethodSig="(Ljava/lang/String;Ljava/lang/String;)V",	ocClassName = "LuaOCBridge"},
	["setPlayerInfo"] 		= {methodName = "setPlayerInfo",	javaClassName = "com/heygam/dsxinfo/DsxInfo",	javaMethodSig="(Ljava/lang/String;Ljava/lang/String;II)V",	ocClassName = "LuaOCBridge"},
	["payment"] 			= {methodName = "payment",			javaClassName = "com/heygam/dsxinfo/DsxInfo",	javaMethodSig="(II)V",	ocClassName = "LuaOCBridge"},
	["getChanAndSubChan"] 	= {methodName = "getChanAndSubChan",	javaClassName = "com/heygam/dsxinfo/DsxInfo",	javaMethodSig="()Ljava/lang/String;",	ocClassName = "LuaOCBridge"},
	["getPlatformStr"] 		= {methodName = "getPlatformStr",	javaClassName = "com/heygam/dsx/Dsx",	javaMethodSig="()Ljava/lang/String;",	ocClassName = "LuaOCBridge"},
	["getAppVersionCode"] 	= {methodName = "getAppVersionCode",	javaClassName = "com/heygam/dsx/Dsx",	javaMethodSig="()I",	ocClassName = "LuaOCBridge"},
	["getAppVersionName"] 	= {methodName = "getAppVersionName",	javaClassName = "com/heygam/dsx/Dsx",	javaMethodSig="()Ljava/lang/String;",	ocClassName = "LuaOCBridge"},
	["isShowLoginButton"] 	= {methodName = "isShowLoginButton",	javaClassName = "com/heygam/dsxinfo/DsxInfo",	javaMethodSig="()I",	ocClassName = nil},
	["getPlatformImei"] 	= {methodName = "getPlatformImei",	javaClassName = "com/heygam/dsxinfo/DsxInfo",	javaMethodSig="()Ljava/lang/String;"},
	["show_webview"] 		= {methodName = "show_webview",	javaClassName = "org/cocos2dx/lib/Cocos2dxJavaInterface",	javaMethodSig="(Ljava/lang/String;I)V"},
	["hide_webview"] 		= {methodName = "hide_webview",	javaClassName = "org/cocos2dx/lib/Cocos2dxJavaInterface",	javaMethodSig="()V"},
	["del_webview"] 		= {methodName = "del_webview",	javaClassName = "org/cocos2dx/lib/Cocos2dxJavaInterface",	javaMethodSig="()V"},

}
function callLuaBridgeMethod(name,param)
	if(not LuaBridgeInfo[name]) then
		return
	end
	if device.platform == "android" then
		if(not LuaBridgeInfo[name].javaClassName) then
			return
		end
		local ok, ret = luaj.callStaticMethod(LuaBridgeInfo[name].javaClassName, LuaBridgeInfo[name].methodName, param or {}, LuaBridgeInfo[name].javaMethodSig)
        if ok then            
            return ret            
        end
	elseif device.platform == "ios" then
		if(not LuaBridgeInfo[name].ocClassName) then
			return
		end
		-- if(param and #param==0) then
  --           param = nil
  --       end
		local ok, ret = luaoc.callStaticMethod(LuaBridgeInfo[name].ocClassName, LuaBridgeInfo[name].methodName,param)
        if ok then
            return ret
        end
	end	 
end
--[[
function addAppEventHandler()
	local args = {
			function(para)
				if(para) then
					local evt = json.decode(para)
					-- evt.EVT
					-- evt.DATA
				end
			end
        }      
	callLuaBridgeMethod("setAppEventHandler",args)
end

function notifyAppEvent(evtid,evtparam)
	if device.platform == "android" then		
			local jsonparam = json.encode(evtparam) or "[]"
            local args = {
				tostring(evtid),
				jsonparam
            }
            callLuaBridgeMethod("notifyAppEvent",args)
    elseif device.platform == "ios" then
            
    end
end

--获取玩家信息
function sdkPlayerInfo(roleId,roleName,lv,vipLv)
	if device.platform == "android" then
	    local args = { 
	       roleId,
	       roleName, 
	       lv,
	       vipLv    
	    }
	    callLuaBridgeMethod("setPlayerInfo",args)
	elseif device.platform == "ios" then
	    local args = { 
	       roleId = tostring(roleId),
	       roleName = roleName,
	       lv = lv,
	       vipLv = vipLv
	    }
    	callLuaBridgeMethod("setPlayerInfo",args)
	end
	print("887===========sdkPlayerInfo",roleId,roleName,lv,vipLv)
end
--SDK充值
function sdkPayment(charTp,charFee)
	if device.platform == "android" then
        local args = {
         	charTp,
 	  		charFee  
        }
        callLuaBridgeMethod("payment",args)
    elseif device.platform == "ios" then
    	local args = {
         	charTp = tostring(charTp),
 	  		charFee = charFee
        }
        callLuaBridgeMethod("payment",args)
    end
end

--SDK登录
function sdkLogin()
	if device.platform == "android" or device.platform == "ios"then
        local args = { 
           function(event)
                printf("Java method callback value is [%s]", event)
                sdkLoginCallBack(event)
            end        
        }
        callLuaBridgeMethod("Login",args)
	
    end
end

function sdkLoginCallBack(result)	
    if result then
    else
    end
end
--]]







