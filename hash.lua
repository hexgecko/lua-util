return function(str)
	local c = 1
	local len = string.len(str)
	for i = 1,len,3 do
		c = math.fmod(c*8161, 4294967279) +
		(string.byte(str,i)*16776193) +
		((string.byte(str,i+1) or
			(len-i+256))*8372226) +
		((string.byte(str,i+2) or
			(len-i+256))*3932164)
	end  
	local h = math.fmod(c, 4294967291)
	return string.format("0x%8x (\"%s\")", h, str)
end
