queue = require("queue")

local q = queue.new()

q:push("one")
q:push("two")
q:push("three")

print("last(): "..q:last())
print("peek(): "..q:peek())
print("pop(): "..q:pop())
print("pop(): "..q:pop())
print("peek(): "..q:peek())
print("pop(): "..q:pop())
print("peek() "..tostring(q:peek()))
print("pop(): "..tostring(q:pop()))

print("first index: "..q._first.." last index: "..q._last)