local M = {}

function M:push(v)
	local last = self.last + 1
	self.last = last
	self[last] = v
end

function M:pop()
	local first = self.first
	local v = self[first]
	self[first] = nil
	self.first = first + 1
	return v
end

function M:peek()
	return self[self.last]
end

function M.new()
	local obj = {
		first = 0,
		last = -1
	}
	return setmetatable(obj, { __index = M })
end

return M
