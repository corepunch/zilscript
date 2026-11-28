local Text = {}

local uppercase = { ["Ä"] = "ä", ["Ö"] = "ö", ["Ü"] = "ü", ["ẞ"] = "ß" }
local germanASCII = { ["ä"] = "ae", ["ö"] = "oe", ["ü"] = "ue", ["ß"] = "ss" }

for codepoint = utf8.codepoint("А"), utf8.codepoint("Я") do
	uppercase[utf8.char(codepoint)] = utf8.char(codepoint + 32)
end
uppercase["Ё"] = "ё"

function Text.lower(value)
	return (value:lower():gsub("[\194-\244][\128-\191]+", uppercase))
end

function Text.russianKey(value)
	return (Text.lower(value):gsub("ё", "е"))
end

function Text.germanKey(value)
	return (Text.lower(value):gsub("[\194-\244][\128-\191]+", germanASCII))
end

-- Preserve multibyte word characters in noun phrases consumed by the reader.
Text.word = "[%w'\128-\255]+"

return Text
