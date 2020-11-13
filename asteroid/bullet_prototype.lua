go.property("rotation", 0)

local VELOCITY = 20

local DELETE_ZONE = hash("delete_zone")
local ASTEROID = hash("asteroid")
local COLLISION_RESPONSE = hash("collision_response")

function init(self)
	self.velocity_per_second = vmath.vector3(sin(self.rotation, cos(self.rotation), 0)) * VELOCITY
end

function update(self, dt)
	go.set_position(go.get_position() + self.velocity_per_second * dt)
end

function on_message(self, message_id, message)
	if message_id == COLLISION_RESPONSE then
		if message.other_group == ASTEROID or message.other_group == DELETE_ZONE then
			go.delete()
		end
	end
end
