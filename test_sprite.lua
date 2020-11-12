require("const")
local sprite = require("sprite")

sprite.play_flipbook("#sprite", "test_anim")
sprite.set_hflip("#sprite", true)
sprite.set_vflip("#sprite", true)

sprite.play_flipbook("#sprite", "test_anim",function(self, message_id, message)
	print(self)
	print(message_id)
	print(message.id)
	print(message.sender)
	print(message.current_tile)
end)
