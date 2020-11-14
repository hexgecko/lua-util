go.property("max_asteroid_velocity", 3)

local SHIP_OFFSCREEN = hash("ship_offscreen")
local ASTEROID_OFFSCREEN = hash("asteroid_offscreen")
local ASTEROID_DESTROYED = hash("asteroid_destroyed")

local SCREEN_WIDTH = 320
local SCREEN_HEIGHT = 240

local UPPER = hash("upper")
local LOWER = hash("lower")
local LEFT = hash("left")
local RIGHT = hash("right")
local MEDIUM = hash("medium")
local SMALL = hash("small")

local function calc_clone_pos(sender)
	pos = go.get_position(sender)
	local x = pos.x
	local y = pos.y
	if x > SCREEN_WIDTH*2 then
		x = x - SCREEN_WIDTH
	elseif x < SCREEN_WIDTH then
		x = x + SCREEN_WIDTH
	end
	if y > SCREEN_HEIGHT*2 then
		y = y - SCREEN_HEIGHT
	elseif y < SCREEN_HEIGHT then
		y = y + SCREEN_HEIGHT
	end
	return vmath.vector3(x,y,0)
end

local function random_spread(self)
	local ret = {}
	for i=1,4 do
		local a = math.rad(i*45 - 15 + math.random(300)/30)
		res[i] = vmath.vector3(sin(a),cos(a)) * (1 + math.random((self.max_asteroid_velocity - 1)*10)/10
	end
end

function on_message(self, message, message_id, sender)
	if message_id == SHIP_OFFSCREEN then
		local pos = calc_clone_pos(sender)
		factory.create("#ship_factory", pos, nil, {
			game_url = go.get_id(),
			rotation = go.get(sender, "rotation"),
			rotation_speed = go.get("rotation_speed"),
			velocity = go.get(sender, "velocity")
		}
	elseif message_id == ASTEROID_OFFSCREEN then
		local pos = calc_clone_pos(sender)
		local asteroid_factory = "#big_asteroid_factory"
		if message.other_id == MEDIUM then
			size = "#medium_asteroid_factory"
		elseif message.other_id == SMALL then
			size = "#small_asteroid_factory"
		end
		factory.create(asteroid_factory, pos, nil, {
			game_url = go.get_id(),
			rotation = go.get(sender, "rotation"),
			rotation_speed = go.get("rotation_speed"),
			velocity = go.get(sender, "velocity")
		}
	elseif message_id == ASTEROID_DESTROYED then
		local pos = go.get_position(sender)
		if message.other_id == BIG then
			for _,v in ipairs(random_spread) do
				local r = math.random(2*math.pi)
				local s = math.random(math.pi)
				factory.create("#medium_asteroid_factory", pos, nil, {
					game_url = go.get_id(),
					rotation = vmath.quat_rotation_z(r),
					rotation_speed = s
					velocity = v
				})
			end
		elseif message.other_id == MEDIUM then
			for _,v in ipairs(random_spread) do
				local r = math.random(2*math.pi)
				local s = math.random(math.pi)
				factory.create("#small_asteroid_factory", pos, nil, {
					game_url = go.get_id(),
					rotation = vmath.quat_rotation_z(r),
					rotation_speed = s
					velocity = v
				})
			end
		end
	end
end
