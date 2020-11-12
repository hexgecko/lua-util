require("const")
local go = require("go")

go.property("direction", EAST)
print(go.get("direction"))

go.set("direction", WEST)
print(go.get("direction"))

go.get(":main/baz", "direction")
go.set(":main/baz", "direction")

go.delete()

print("id: "..go.get_id())

local ok,err = pcall(function()
	go.get("foo")
end)

if not ok then print("error: "..err) end
