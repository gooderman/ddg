-- 移动到文件头
-- DEBUG = 1
-- DEBUG_FPS = true
CFG_DEBUG_DM = 1
-- CFG_DEBUG_GD = 1
-- CFG_DEBUG_DMG = 1
-- CFG_DEBUG_SK = 1
-- CFG_DEBUG_NET = 1
-- CFG_GUIDE_FLAG = false
-- FIGHT_DEBUG_INFO = true
-- CFG_TEST_FIGHT = true
-- CFG_DEBUG_FT_RUNINFO = true
-- DEBUG_MEM_USE = true
-- CFG_DEBUG_FIGHT_SCORE = true
-- CFG_DEBUG_CPT = true
-- FIGHT_DEBUG_TOUCH_HERO = true
local function Noprint()
end
local function Nodump()
end
local __print  = print
local __printf  = printf
local function __dump(value, desciption, nesting)

    if type(nesting) ~= "number" then nesting = 3 end

    local lookupTable = {}
    local result = {}

    local function _v(v)
        if type(v) == "string" then
            v = "\"" .. v .. "\""
        end
        return tostring(v)
    end

    local traceback = string.split(debug.traceback("", 2), "\n")
    __print("dump from: " .. string.trim(traceback[3]))

    local function _dump(value, desciption, indent, nest, keylen)
        desciption = desciption or "<var>"
        spc = ""
        if type(keylen) == "number" then
            spc = string.rep(" ", keylen - string.len(_v(desciption)))
        end
        if type(value) ~= "table" then
            result[#result +1 ] = string.format("%s%s%s = %s", indent, _v(desciption), spc, _v(value))
        elseif lookupTable[value] then
            result[#result +1 ] = string.format("%s%s%s = *REF*", indent, desciption, spc)
        else
            lookupTable[value] = true
            if nest > nesting then
                result[#result +1 ] = string.format("%s%s = *MAX NESTING*", indent, desciption)
            else
                result[#result +1 ] = string.format("%s%s = {", indent, _v(desciption))
                local indent2 = indent.."    "
                local keys = {}
                local keylen = 0
                local values = {}
                for k, v in pairs(value) do
                    keys[#keys + 1] = k
                    local vk = _v(k)
                    local vkl = string.len(vk)
                    if vkl > keylen then keylen = vkl end
                    values[k] = v
                end
                table.sort(keys, function(a, b)
                    if type(a) == "number" and type(b) == "number" then
                        return a < b
                    else
                        return tostring(a) < tostring(b)
                    end
                end)
                for i, k in ipairs(keys) do
                    _dump(values[k], k, indent2, nest + 1, keylen)
                end
                result[#result +1] = string.format("%s}", indent)
            end
        end
    end
    _dump(value, desciption, "- ", 1)

    for i, line in ipairs(result) do
        __print(line)
    end
end

function __printLog(tag, fmt, ...)
    local t = {
        "[",
        string.upper(tostring(tag)),
        "] ",
        string.format(tostring(fmt), ...)
    }
    __print(table.concat(t))
end

function __printError(fmt, ...)
    __printLog("ERR", fmt, ...)
    __print(debug.traceback("", 2))
end

-------------------------------------------------------------
--DataManager--Log
printDM = CFG_DEBUG_DM and print or Noprint
dumpDM = CFG_DEBUG_DM and __dump or Noprint
printErrorDM = CFG_DEBUG_DM and __printError or Noprint
--DmgLogic--Log
printDmg = CFG_DEBUG_DMG and print or Noprint
dumpDmg = CFG_DEBUG_DMG and __dump or Noprint
--技能--Log
printSk = CFG_DEBUG_SK and print or Noprint
dumpSk = CFG_DEBUG_SK and __dump or Noprint
printfSk = CFG_DEBUG_SK and __printf or Noprint
printErrorSk = CFG_DEBUG_SK and __printError or Noprint

--NetManager--Log
printNet = CFG_DEBUG_NET and print or Noprint
dumpNet = CFG_DEBUG_NET and __dump or Noprint
printfNet = CFG_DEBUG_NET and printf or Noprint
printErrorNet = CFG_DEBUG_NET and __printError or Noprint

--Guide--Log
printGD = CFG_DEBUG_GD and print or Noprint
dumpGD = CFG_DEBUG_GD and __dump or Noprint
printErrorGD = CFG_DEBUG_GD and __printError or Noprint
------------------------------------------------------------

if(DEBUG == 0) then
	print = Noprint
	printf = Noprint
	dump = Noprint
end
