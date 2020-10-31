local M = {}

function M:add(vortbl)
	if type(vortbl) == "number" or type(vortbl) == "string" then
		self[vortbl] = true
	elseif type(vortbl == "table") then
		for _,v in ipairs(vortbl) do
			self[v] = true
		end
	end
end

function M:remove(vortbl)
	if type(vortbl) == "number" or type(vortbl) == "string" then
		self[vortbl] = nil
	elseif type(vortbl == "table") then
		for _,v in ipairs(vortbl) do
			self[v] = nil
		end
	end
end

function M:has(v)
	return self[v] == true
end

function M.new(tbl)
	local obj = {}
	if tbl ~= nil then
		for _,v in ipairs(tbl) do
			obj[v] = true
		end
	end
	return setmetatable(obj, { __index = M})
end

return M
