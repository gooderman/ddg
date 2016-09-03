local lz   = require("zlib")
function zip_encode_str(str)
	local nstr,eof,inby,outby = lz.deflate()(str,"finish") 
	-- print("________data.fightRecord zlib  Len = ",outby,inby,eof)
	-- print("________data.fightRecord zlib  str = ",nstr)
	local nnstr = crypto.encodeBase64(nstr)
	return nnstr
end
function unzip_decode_str(str)
	if(str and str~='') then
		local nstr = crypto.decodeBase64(str)
		if(nstr and nstr~="") then
			local nnstr = lz.inflate()(nstr)
			if(nnstr) then
				return nnstr
			end
		end
	end
	return str	
end

function zipfile_open(path)
	local zipfile = CCZipFile:createWithPathName(path)
	if(zipfile) then
        zipfile:retain()
    end
    return zipfile       
end
function zipfile_close(zipfile)
	if(zipfile) then
        zipfile:release()
        zipfile:close()
    end
end
-- zipfile:getFirstFilename()
-- zipfile:getNextFilename()
-- zipfile:getFileDataNoOrder(name)
-- zipfile:getFileList()














