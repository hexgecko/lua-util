require("const")
local fsm = require("fsm")
local set = require("set")
local queue = require("queue")
local thread = require("thread")

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

local snake_thread = thread.new(function(self)
	while true:
		self:wait_until(ANIM_DONE)
		
		snake_dir:event(input_queue:pop())
		if not forward_state:has(snake_dir.state) then
			snake_dir:event(ANIM_DONE)
		end
		
		-- new position
		
		-- change head to type body
		local head = snake_queue:peek()
		msg.post(head, "type", UPDATE_TYPE, {
			type = BODY
		})
		
		-- push a head to the snake_queue
		factory.create("#factory", nil, nil, {
			x = x, y = y,
			type = HEAD_ANIM,
			direction = snake_dir.state
		})
		
		-- pop snake_queue and change type to tail
		snake_queue:pop()
		local tail = snake_queue:last()
		msg.post(tail, "type", UPDATE_TYPE, {
			type = TAIL_ANIM
		})
	end
end)

function init(self)
	-- push the snake start position
	snake_queue:push()
end

function on_message(self, message_id)
	if message_id == ANIM_DONE then
		snake_thread:resume(ANIM_DONE)
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
				input_queue:push(action_id)
				last_input = action_id
			end
		end
	end
end
