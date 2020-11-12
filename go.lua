local hash = require("hash")

local M = {}

M.self = {}

function M.property(name, value)
	M.self[name] = value
end

function M.set(...)
	local p = {...}
	if #p == 2 then
		local property,value = unpack(p)
		M.self[property] = value
	elseif #p ~= 3 then
		error("usage go.set([url],property,value)")
	end
end

function M.get(...)
	local p = {...}
	if #p == 1 then
		local property = unpack(p)
		if M.self[property] ~= nil then
			return M.self[property]
		else
			error("go.get(...) no such property: \""..property.."\"")
		end
	elseif #p ~= 2 then
		error("usage: go.get([url],property)")
	end
end

function M.get_id(path)
	if path ~= nil then
		return hash(":main/a_path")
	else
		return hash(":main/this")
	end
end

function M.delete(id, recursive)
end

return M
