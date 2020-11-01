require("const")
local fsm = require("fsm")
local hash = require("hash")

function print_back()
	print("back")
end

local test = fsm.new({
	{ ONE, LEFT, TWO },
	{ TWO, RIGHT, ONE, print_back}
})

test:on_event(LEFT)
print(tostring(test.state == TWO))
test:on_event(RIGHT)
print(tostring(test.state == ONE))
