local Text = {}

local germanUppercase = { ["Ä"] = "ä", ["Ö"] = "ö", ["Ü"] = "ü", ["ẞ"] = "ß" }
local germanASCII = { ["ä"] = "ae", ["ö"] = "oe", ["ü"] = "ue", ["ß"] = "ss" }

function Text.lower(value)
	return (value:lower():gsub("[\194-\244][\128-\191]+", germanUppercase))
end

function Text.germanKey(value)
	return (Text.lower(value):gsub("[\194-\244][\128-\191]+", germanASCII))
end

-- Preserve multibyte word characters in noun phrases consumed by the reader.
Text.word = "[%w'\128-\255]+"

return Text
