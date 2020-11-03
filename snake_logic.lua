require("const")
local fsm = require("fsm")
local set = require("set")
local queue = require("queue")
local logic = require("logic")

local forward_state = set.new(EAST, WEST, NORTH, SOUTH)
local move_input = set.new(LEFT, RIGHT, UP, DOWN)
local vert_move = set.new(UP, DOWN)
local horz_move = set.new(LEFT, RIGHT)
local last_input = EAST
local input_queue = queue.new()
local snake_queue = queue.new()
local snake_dir = fsm.new({
	{EAST, DOWN, EAST_TO_NORTH}
})
local snake_logic = logic.new(function(self)
	while true:
		self:wait_until(ANIM_DONE)
		if forward_state:has(snake_dir.state) then
			snake_dir:event(input_queue:pop())
		else
			snake_dir:event(ANIM_DONE)
		end
		-- update position
		-- change head to type body
		-- push a head to the snake_queue
		-- pop snake_queue and change type to tail
	end
end)

function init(self)
	-- push the snake start position
end

function on_message(self, message_id, message, sender)
	if message_id == ANIM_DONE then
		if message.id == HEAD then
			snake:logic(ANIM_DONE)
		elseif message.id == TAIL then
			-- go.delete(sender)
		end
	end
end

function on_input(self, action_id, action)
	if action.pressed then
		if horz_move:has(action_id) then
			if vert_move:has(last_input) then
				input_queue:push(action_id)
				last_input = action_id
			end
		elseif vert_move:has(action_id) then
			if horz_move:has(last_input) then
				input_queue:push(last_input)
				last_input = action_id
			end
		end
	end
end
