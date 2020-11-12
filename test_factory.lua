require("const")
local factory = require("factory")

print(factory.create("#factory"))

print(factory.get_status())

factory.load("#factory", function(self, url, result)
	print("self: "..tostring(self))
	print("url: "..tostring(url))
	print("result: "..tostring(result))
end)

factory.unload()
