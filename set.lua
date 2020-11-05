local M = {}

function M:has(v)
	return self[v] == true
end

local set_mt = function(obj)
	return setmetatable(obj, {
		__index = M,
		__tostring = function(self)
			local s = "{"
			for e in pairs(self) do
				s = s..tostring(e)..","
			end
			if #s > 1 then
				return s:sub(1,-2).."}"
			else
				return "{}"
			end
		end
	})
end

function M:union(b)
	local obj = {}
	for e in pairs(self) do obj[e] = true end
	for e in pairs(b) do obj[e] = true end
	return set_mt(obj)
end

function M:intersection(b)
	local obj = {}
	for e in pairs(self) do
		if b:has(e) then obj[e] = true end
	end
	return set_mt(obj)
end

function M:difference(b)
	local obj = {}
	for e in pairs(self) do
		if not b:has(e) then obj[e] = true end
	end
	return set_mt(obj)
end

function M.new(...)
	local obj = {}
	for _,v in ipairs({...}) do obj[v] = true end
	return set_mt(obj)
end

return M
