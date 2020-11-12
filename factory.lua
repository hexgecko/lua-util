local hash = require("hash")
local go = require("go")

local M = {}

M.STATUS_LOADED	= hash("STATUS_LOADED")
M.STATUS_LOADING = hash("STATUS_LOADING")
M.STATUS_UNLOADED	= hash("STATUS_UNLOADING")

local itr = 0

function M.create(url,position,rotation, properties,scale)
	itr = itr + 1
	return hash(":main/instance"..tostring(itr))
end

function M.get_status()
	return M.STATUS_LOADED
end

function M.load(url,complete_function)
	if type(complete_function) == "function" then
		complete_function(go.self,url,true)
	end
end

function M.unload()
end

return M
