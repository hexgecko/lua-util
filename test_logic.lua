require("const")
local logic = require("logic")

local test = logic.new(function(self)
	print("wait TICK")
	self:wait(TICK, DOWN)
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

for i=0,11 do
	test:resume(TICK, i)
end
