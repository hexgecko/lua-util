require("const")
local logic = require("logic")

local test = logic.new(function(self)
	print("wait TICK")
	self:wait_until(TICK, DOWN)
	print("continue after TICK")
end)

test:resume(LEFT)
test:resume(UP)
test:resume(TICK)

test = logic.new(function(self)
	print("before sleep")
	self:sleep(1)
	print("continue after sleep")
end)

local t = 0
for i=0,11 do
	test:resume(TICK, 0.1)
	t = t + 0.1
	print("time elapsed: "..tostring(t))
end

test = logic.new(function(self,sx,sy)
	sx = sx + 1
	sy = sy + 1
	print("sx: "..sx.." sy: "..sy)
end, 10, 11)
