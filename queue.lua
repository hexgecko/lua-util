local M = {}

function M:push(v)
	local last = self._last + 1
	self._last = last
	self[last] = v
end

function M:pop()
	local first = self._first
	if first > self._last then return nil end
	local v = self[first]
	self[first] = nil
	self._first = first + 1
	return v
end

function M:peek()
	return self[self._first]
end

function M:last()
	return self[self._last]
end

function M.new()
	local obj = {
		_first = 0,
		_last = -1
	}
	return setmetatable(obj, { __index = M })
end

return M
