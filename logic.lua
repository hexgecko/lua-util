
local set = require("set")
local M = {}

function M:resume(a,b,c,d)
	if coroutine.status(self.co) == "suspended" then
		local ok,a,b,c,d = coroutine.resume(self.co, self, a,b,c,d)
		if not ok then error(a) end
		return a,b,c,d
	end
	return nil
end

function M:wait(a,b,c,d)
	local evset,s,ev = set.new({a,b,c,d})
	repeat
		s, ev = coroutine.yield()
	until evset:has(ev)
end

function M:sleep(t)
	local s,ev,dt
	self.t = 0
	repeat
		s,ev,dt= coroutine.yield()
		if ev == TICK then
			self.t = self.t + dt
		end
	until self.t >= t
end

function M.new(fn)
	local obj = {
		co = coroutine.create(fn),
		t
	}
	local mt = setmetatable(obj, { __index = M })
	coroutine.resume(obj.co, mt)
	return mt
end

return M
