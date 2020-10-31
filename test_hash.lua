local hash = require "hash"

local h = hash("hello")
print(h)
print(type(h))
print(hash("Foobar"))