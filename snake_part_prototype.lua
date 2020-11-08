require("const")

go.property("x", 0)
go.property("y", 0)
go.property("type", HEAD)
go.property("direction", EAST)

local type_direction = {
	HEAD = {
		EAST = { "head_anim_fwd", 4, 4, 90, false, false}
		EAST_TO_NORTH = ...
	},
	BODY = { ... }
}

local function head_anim_done()
	msg.post("#snake", HEAD_ANIM_DONE)
end

local function tail_anim_done()
	msg.post("#snake", TAIL_ANIM_DONE)
end

function setup_sprite(self)
	local part = type_direction[self.type][self.direction]
	local id,x,y,rotation,hflip,vflip = table.unpack(part)
	
	local anim_done = nil
	if self.type == HEAD_ANIM then
		anim_done = head_anim_done
	end
	
	-- rotate and translate
	local url = msg.url("#sprite")
	sprite.set_hflip(url, hflip == true)
	sprite.set_vflip(url, vflip == true)
	sprite.set_flipbook("#sprite", hash(id), anim_done)
end

function init(self)
	setup_sprite(self)
end

function on_message(self, message_id)
	if message_id == UPDATE_SPRITE then
		setup_sprite(self)
	end
end
