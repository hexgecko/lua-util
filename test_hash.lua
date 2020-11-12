local hash = require("hash")

local h = hash("hello")
print(h)
print(tonumber(h))
print(hash("Foobar"))