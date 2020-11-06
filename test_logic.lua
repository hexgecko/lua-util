require("const")
local logic = require("logic")

local test = logic.new(function(self)
	print("wait TICK")
	self:wait_until(TICK, DOWN)
	print("continue after TICK")
end)

test:run()
print("resume: LEFT")
test:resume(LEFT)
print("resume: UP")
test:resume(UP)
print("resume: TICK")
test:resume(TICK)

test = logic.new(function(self)
	print("before sleep")
	self:sleep(0.5)
	self:sleep(0.5)
	print("continue after sleep")
end)

test:run()
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
	self:yield(sx, sy)
end)

local x,y = test:run(10, 11)
print("x: "..tostring(x).." y:"..tostring(y))
