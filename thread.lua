local set = require("set")

local M = {}

function M:resume(...)
	if coroutine.status(self.co) == "suspended" then
		local ok,ret = coroutine.resume(self.co, ...)
		if not ok then error(a) end
		if ret ~= nil then
			return table.unpack(ret)
		else
			return nil
		end
	end
	return nil
end

function M:run(...)
	return self:resume(self, ...)
end

function M:wait_until(...)
	local ev
	local evset = set.new(...)
	repeat
		ev = coroutine.yield()
	until evset:has(ev)
end

function M:sleep(delay)
	local t = delay + self.t
	repeat
		local ev,dt = coroutine.yield()
		if ev == TICK then
			t = t - dt
		end
	until t < 0
	self.t = t
end

function M:yield(...)
	return coroutine.yield({...})
end

function M.new(fn)
	local obj = {
		t = 0,
		co = coroutine.create(fn)
	}
	return setmetatable(obj, { __index = M })
end

return M
