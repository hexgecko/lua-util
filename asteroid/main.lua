local SHIP_OFFSCREEN = hash("ship_offscreen")

local SCREEN_WIDTH = 320
local SCREEN_HEIGHT = 240

local UPPER = hash("upper")
local LOWER = hash("lower")
local LEFT = hash("left")
local RIGHT = hash("right")

function init(self)
	local center = vmath.vector3(SCREEN_WIDTH*3/2, SCREEN_HEIGHT*3/2, 0)
	factory.create("#ship_factory", center, nil, { ship_url = go.get_id()
	})
end

function on_message(self, message, message_id, sender)
	if message_id == SHIP_OFFSCREEN then
		ship_pos = go.get_position(sender)
		local x = ship_pos.x
		if x > SCREEN_WIDTH*2 then
			x = x - SCREEN_WIDTH
		elseif x < SCREEN_WIDTH then
			x = x + SCREEN_WIDTH
		end
		local y = ship_pos.y
		if y > SCREEN_HEIGHT*2 then
			y = y - SCREEN_HEIGHT
		elseif y < SCREEN_HEIGHT then
			y = y + SCREEN_HEIGHT
		end
		factory.create("#ship_factory", vmath.vector3(x,y,0), nil, {
			ship_url = go.get_id(),
			rotation = go.get(sender, "rotation"),
			velocity = go.get(sender, "velocity")
		})
	end
end
