local M = {}

function M:on_event(ev)
	local col = self[self.state]
	if col ~= nil then
		local nx = col[ev]
		if nx ~= nil then
			self.state = nx[1]
			local ac = nx[2]
			if ac ~= nil then ac() end
		end
	end
end

function M.new(tbl)
	local obj = {
		state = tbl[1][1]
	}
	for _,col in ipairs(tbl) do
		local cs = col[1]
		local ev = col[2]
		local ns = col[3]
		local ac = col[4]
		if obj[cs] == nil then obj[cs] = {} end
		obj[cs][ev] = { ns, ac }
	end
	return setmetatable(obj, { __index = M })
end

return M
