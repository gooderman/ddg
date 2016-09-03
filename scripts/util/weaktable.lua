
function gen_weak_table()
	local tb  = {}
	setmetatable(tb, {__mode= "v"})
	return tb
end


if(DEBUG_MEM_USE) then
local tstweaktable = gen_weak_table()
function add_to_weak_table(tb)
	table.insert(tstweaktable,tb)
end
function dump_weak_table()
	dumpDM(tstweaktable,"_________dumpWeakTb",1)
end
else

function add_to_weak_table(tb)
end
function dump_weak_table()
end

end