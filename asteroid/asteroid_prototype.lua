go.property("main_url", msg.url())
go.property("rotation", 0)
go.property("rotation_speed", math.pi/4)
go.property("velocity", vector3(3,3,0))

local OFFSCREEN_ZONE = hash("offscreen_zone")
local DELETE_ZONE = hash("delete_zone")
local SHIP = hash("ship")
local BULLET = hash("bullet")
local ASTEROID_OFFSCREEN = hash("asteroid_offscreen")
local ASTEROID_DESTROYED = hash("asteroid_destroyed")
local COLLISION_RESPONSE = hash("collision_response")

function update (self, dt)
	self.rotation = self.rotation + self.rotation_speed * dt
	go.set_rotation(vmath.quat_rotation_z(self.rotation))
	go.set_position(go.get_position() + self.velocity)
end

function on_messsage(self, message_id, message)
	if message_id == COLLISION_RESPONSE then
		if message.other_group == BULLET then
			msg.post(self.main_url, ASTEROID_DESTROYED, { other_id = message.other_id })
		elseif message.other_group == OFFSCREEN_ZONE then
			mag.post(self.main_url, ASTEROID_OFFSCREEN, { other_id = message.other_id })
		elseif message.other_group == DELETE_ZONE then
			go.delete()
	end
end
