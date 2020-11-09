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
	msg.post(":main/snake", ANIM_DONE)
end

local function tail_anim_done()
	go.delete()
end

function setup_sprite(self)
	local part = type_direction[self.type][self.direction]
	local id,x,y,rotation,hflip,vflip = table.unpack(part)
	
	local anim_done = nil
	if self.type == HEAD_ANIM then
		anim_done = head_anim_done
	elseif self.type == ANIM_DONE then
		anim_done = tail_anim_fone
	end
	
	-- rotate and translate
	local url = msg.url("#sprite")
	sprite.set_hflip(url, hflip == true)
	sprite.set_vflip(url, vflip == true)
	sprite.set_flipbook(url, hash(id), anim_done)
end

function init(self)
	setup_sprite(self)
end

function on_message(self, message_id, message)
	if message_id == UPDATE_TYPE then
		go.set("type", message.type)
		setup_sprite(self)
	end
end
