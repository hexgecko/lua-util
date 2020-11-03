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

test:event(LEFT)
print(tostring(test.state == TWO))
test:event(RIGHT)
print(tostring(test.state == ONE))
