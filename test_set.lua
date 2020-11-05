require("const")
local hash = require("hash")
local set = require("set")

local s = set.new(ONE, TWO, THREE)

function test(str)
	local val = hash(str)
	print("has "..str..": "..tostring(s:has(val)))
end

test("one")
test("four")

local a,b
a = set.new(1,2)
b = set.new(1,2)
print("union: "..tostring(a:union(b)))
print("intersection: "..tostring(a:intersection(b)))
print("difference: "..tostring(a:difference(b)))

a = set.new(1,2)
b = set.new(2,3)
print("union: "..tostring(a:union(b)))
print("intersection: "..tostring(a:intersection(b)))
print("difference: "..tostring(a:difference(b)))

a = set.new(1,2,3)
b = set.new(4,5,6)
print("union: "..tostring(a:union(b)))
print("intersection: "..tostring(a:intersection(b)))
print("difference: "..tostring(a:difference(b)))
