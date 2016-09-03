require("lfs")
fs={}
--检查文件是否存在
function fs.exists(path)
    return CCFileUtils:sharedFileUtils():isFileExist(path)
end

function fs.size(path)
    return io.filesize(path)
end

function fs.isfile(path) 
    return not fs.isdir(path)
end
function fs.isdir(path)
    local mode = lfs.attributes(path,"mode")    
    return mode == "directory"
end

--重命名文件
function fs.rename(oldname,newname)
    return os.rename(oldname, newname)    
end

--读文件
function fs.read(path)
    local file = io.open(path, "rb")
    if file then
        local content = file:read("*all")
        io.close(file)
        return content
    end
    return nil
end

--写文件
function fs.write(path, content, mode)
    mode = mode or "w+b"
    local file = io.open(path, mode)
    if file then
        if file:write(content) == nil then return false end
        io.close(file)
        return true
    else
        return false
    end
end

--删除路径
function fs.remove(path)
    local mode = lfs.attributes(path,"mode")    
    if mode == "directory" then            
        local dirPath = path.."/"
        for file in lfs.dir(dirPath) do
            if file ~= "." and file ~= ".." then 
                local f = dirPath..file 
                fs.remove(f)
            end 
        end
        lfs.rmdir(path)
    else
        os.remove(path)
    end
end

function fs.list(path)
    local files={}
    local dirs={}
    local function lll(dir)
        for file in lfs.dir(dir) do
            if file== "." or file == ".." then 
            else
                local p = dir..'/'..file
                local mode = lfs.attributes(p,"mode")
                if mode == "directory" then
                    lll(p)
                    table.insert(dirs,p)
                else
                    table.insert(files,p)
                end
            end
        end
    end
    local mode = lfs.attributes(path,"mode")
    if mode ~= "directory" then
        return        
    end
    lll(path)
    return dirs,files
end

function fs.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

--创建目录
function fs.mkdir(path)
    if not fs.exists(path) then
        return lfs.mkdir(path)
    end
    return true
end

function fs.dofile(path)
    local fileData = CZHelperFunc:getFileData(path)
    local fun = loadstring(fileData)
    local ret, r = pcall(fun)
    if ret then
        return r
    end
end

--md5
function fs.md5(filepath)
	if filepath ~= nil then
		return CCCrypto:MD5File(filepath)
	else
		return nil
	end
end

--mount
function fs.mount(prefix,source,iszip,order)
    return CCFileUtils:sharedFileUtils():mount(prefix,source,iszip or false,order or 0)
end
function fs.unmount(source)
    return CCFileUtils:sharedFileUtils():unmount(source)
end
function fs.mountclean(prefix)
    return CCFileUtils:sharedFileUtils():clean(prefix or "")
end
function fs.data(name)    
    local path = CCFileUtils:sharedFileUtils():fullPathForFilename(name)
    local r = CZHelperFunc:getFileData(path)
    if(r) then
        return r
    else
        print("[Error]----fs.data ".. (path or ""))
    end 
end
--
function fs.fullpath(name)
    return CCFileUtils:sharedFileUtils():fullPathForFilename(name)
end

return fs
