go.property("game_url", msg.url())
go.property("rotation_speed", 0)
go.property("velocity", vmath.vector3())

local ROTATION_PER_SECOND = math.pi
local MAX_VELOCITY = 3
local ACCELERATION = 1

local LEFT = hash("left")
local RIGHT = hash("right")
local UP = hash("up")
local SPACE = hash("space")
local OFFSCREEN_ZONE = hash("offscreen_zone")
local DELETE_ZONE = hash("delete_zone")
local SHIP_OFFSCREEN = hash("ship_offscreen")
local ASTEROID= hash("asteroid")
local TRIGGER_RESPONSE = hash("trigger_response")

function init(self)
	msg.post(".", "aquire_input_focus")
	self.left = false
	self.right = false
	self.up = false
end

function final(self)
	msg.post(".", "release_input_focus")
end

function update(self, dt)
	if self.left then
		self.rotation_speed = ROTATION_PER_SECOND
	elseif self.right then
		self.rotation_speed = -ROTATION_PER_SECOND
	else
		self.rotation_speed = 0
	end
  go.set("rotation", go.get("rotation") + vmath.quat_rotation_z(self.rotation))
	if self.up then
		self.velocity = self.velocity + vmath.vector3(sin(self.rotation, cos(self.rotation), 0)) * ACCELERATION
		local velocity_length = vmath.length_sqr(selg.velocity)
		if velocity_length > MAX_VELOCITY then
			self.velocity = self.force * MAX_FORCE / force_length
		end
	end
	go.set("position", go.get("position") + self.velocity)
end

function on_input(self, action_id, action)
	if action_id == LEFT then
		if action.pressed then self.left = true end
		if action.released then self.left = false end
	elseif action_id == RIGHT then
		if action.pressed then self.right = true end
		if action.released then self.right = false end
	elseif action_id == UP then
		if action.pressed then self.up = true end
		if action.released then self.up = false end
	elseif action_id == SPACE then
		if action.pressed then
			factory.create("#bullet_factory", go.get_position(), nil, { rotation = self.rotation })
		end
	end
end

function on_message(self, message_id, message)
	if message_id == TRIGGER_RESPONSE then
		if message.other_group == OFFSCREEN_ZONE then
			msg.post(self.game_url, SHIP_OFFSCREEN, {
				ship_url = go.get_id(),
				other_id = message.other_id})
		elseif message.other_group == DELETE_ZONE then
			go.delete()
		elseif message.other_group == ASTEROID then
			go.delete()
		end
	end
end
