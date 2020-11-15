go.property("game_url", msg.url())
go.property("rotation_speed", math.pi/4)
go.property("velocity", vector3(3,3,0))

local OFFSCREEN_ZONE = hash("offscreen_zone")
local DELETE_ZONE = hash("delete_zone")
local SHIP = hash("ship")
local BULLET = hash("bullet")
local ASTEROID_OFFSCREEN = hash("asteroid_offscreen")
local ASTEROID_DESTROYED = hash("asteroid_destroyed")
local TRIGGER_RESPONSE = hash("trigger_response")

function update (self, dt)
	go.set("rotation", go.get("rotation", vmath.quat_rotation_z(self.rotation_speed*dt))
	go.set("position", go.get("position") + self.velocity)
end

function on_messsage(self, message_id, message)
	if message_id == TRIGGER_RESPONSE then
		if message.other_group == BULLET then
			msg.post(self.game_url, ASTEROID_DESTROYED, {
				asteroid_url = go.get_id(),
				other_id = message.other_id
			})
		elseif message.other_group == OFFSCREEN_ZONE then
			mag.post(self.game_url, ASTEROID_OFFSCREEN, {
				asteroid_url = go.get_id(),
				other_id = message.other_id
			})
		elseif message.other_group == DELETE_ZONE then
			go.delete()
	end
end
