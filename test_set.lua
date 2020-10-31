require("const")
local hash = require("hash")
local set = require("set")

local s = set.new({ONE, TWO, THREE})

function test(str)
	local val = hash(str)
	print("has "..str..": "..tostring(s:has(val)))
end

test("one")
test("four")
