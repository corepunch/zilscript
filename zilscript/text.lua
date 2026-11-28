local Text = {}

function Text.lower(value)
	return (value:lower():gsub("\195([\128-\158])", function(c)
		if c == "\151" then return nil end
		return "\195" .. string.char(c:byte() + 32)
	end))
end

-- Preserve multibyte word characters in noun phrases consumed by the reader.
Text.word = "[%w'\128-\255]+"

return Text
