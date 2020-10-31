queue = require("queue")

local q = queue.new()

q:push("one")
q:push("two")
q:push("three")

print(q:pop())
print(q:pop())
print(q:peek())
print(q:pop())
print(q:peek())
print(q:pop())
