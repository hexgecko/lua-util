require("const")
local thread = require("thread")

local test = thread.new(function(self)
	print("wait TICK")
	local ev,dt = self:wait_until(TICK, DOWN)
	print("ev: "..ev.." dt: "..tostring(dt))
	print("continue after TICK")
end)

test:run()
print("resume: LEFT")
test:resume(LEFT)
print("resume: UP")
test:resume(UP)
print("resume: TICK")
test:resume(TICK, 0.1)

test = thread.new(function(self)
	print("before sleep")
	self:sleep(0.5)
	self:sleep(0.5)
	print("continue after sleep")
end)

local ok,err = pcall(function()
	test:run()
	local t = 0
	for i=0,11 do
		local dt = 0.05 + math.random(10)/100
		t = t + dt
		print("time elapsed: "..tostring(t))
		test:resume(TICK, dt)
	end
end)

if not ok then print("error: "..err) end

test = thread.new(function(self,sx,sy)
	sx = sx + 1
	sy = sy + 1
	print("sx: "..sx.." sy: "..sy)
	self:yield(sx, sy)
end)

local x,y = test:run(10, 11)
print("x: "..tostring(x).." y: "..tostring(y))

test = thread.new(function(self)
	error("test error")
end)

local ok,err = pcall(function() test:run() end)

if not ok then print("error: "..err) end

test = thread.new(function(self)
	print("Hello!")
end)

local ok,err = pcall(function()
	test:resume("Foobar")
end)

if not ok then print("error: "..err) end
