require("const")
local fsm = require("fsm")
local queue = require("queue")
local set = require("set")

local forward_state = set.new(EAST, WEST, NORTH, SOUTH)

function M:on_key_pressed(key)
	self.kq:push(key)
end

function M:on_event(ev)
	local ok,err = coroutine.resume(self.cor, self, ev)
	if not ok then error(err) end
end

function M.new()
	local obj = {
		kq = queue.new(),
		sq = queue.new(),
		dir = fsm.new({
			{EAST, DOWN, EAST_TO_NORTH}
		}),
		cor = coroutine.new(function(self, ev)
			-- wait animation done
			-- if has peek key
				-- if forward
					-- update dir with key
				-- else
					-- update with animation done
			-- update position
			-- change head to type body
			-- push a head to the sn
			-- pop sq and change type to tail delete when animation is done
		end)
	}
	return setmetatable(obj, { __index = M })
end

return M
