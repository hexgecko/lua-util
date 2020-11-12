local set = require("set")
local sys = require("sys")

local M = {}

function M:resume(...)
	if self.run_is_called ~= true then
		error("thread:resume(...) is called before thread:run(...)!", 2)
	end
	if coroutine.status(self.co) == "suspended" then
		local ok,ret = coroutine.resume(self.co, ...)
		if not ok then
			error(ret, 3)
			sys.exit(-1)
		end
		if ret ~= nil then
			return unpack(ret)
		else
			return nil
		end
	elseif coroutine.status(self.co) == "dead" then
		error("thread:resume(...) is dead.", 2)
	elseif coroutine.status(self.co) == "running" then
		error("thread:resume is called from an other thread.", 2)
	end
	return nil
end

function M:run(...)
	self.run_is_called = true
	return self:resume(self, ...)
end

function M:wait_until(...)
	local ret
	local evset = set.new(...)
	repeat
		ret = { coroutine.yield() }
	until evset:has(ret[1])
	return unpack(ret)
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
