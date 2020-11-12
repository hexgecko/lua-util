local hash = require("hash")
local go = require("go")

local M = {}

function M.play_flipbook(url,id,complete_function, play_properties)
	if type(complete_function) == "function" then
		complete_function(go.self,hash("animation_done"), {
				current_tile = 5,
				id = hash("test_anim"),
				sender = hash(":main/foobar#sprite")
		})
	end
end

function M.set_hflip(url,flip)
end

function M.set_vflip(url,flip)
end

return M
