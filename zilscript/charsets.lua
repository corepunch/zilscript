-- Character sets selected by ZIL's <LANGUAGE name> directive.
--
-- Infocom's German sources (and ZILF, which follows them) write characters
-- outside ASCII as % followed by a letter: "H%ande" in a string, H\%ANDE in
-- an atom, where the backslash keeps % from starting a form. The parser
-- decodes them to UTF-8 once, so the runtime, hosts and players only see
-- real text ("Hände"). Atoms are vocabulary, which the dictionary stores in
-- lowercase, so an escaped letter in an atom always decodes to lowercase.
--
-- A new language with its own escapes adds one entry here; a language that
-- writes UTF-8 directly in its sources needs none.
local Charsets = {}

Charsets.GERMAN = {
	strings = {
		a = "ä", o = "ö", u = "ü", s = "ß",
		A = "Ä", O = "Ö", U = "Ü",
		["<"] = "«", [">"] = "»",
	},
	atoms = {
		a = "ä", o = "ö", u = "ü", s = "ß",
		A = "ä", O = "ö", U = "ü", S = "ß",
		["<"] = "«", [">"] = "»",
	},
}

-- Returns the character set for a <LANGUAGE> name, or nil for one that
-- needs no escapes (ENGLISH, or any unknown name).
function Charsets.find(name)
	return name and Charsets[tostring(name):upper()] or nil
end

-- Decodes %X escapes in string text. An unknown %X is left as written.
function Charsets.decodeString(charset, text)
	return (text:gsub("%%(.)", function(ch)
		return charset.strings[ch]
	end))
end

return Charsets
