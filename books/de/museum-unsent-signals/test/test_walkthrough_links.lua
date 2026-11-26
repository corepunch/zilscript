local Walk = require("tests.link_walk")
local story = "books.de.museum-unsent-signals.museum-unsent-signals"
local route = {
	"lies messingtafel", "ost", "kipp lupe", "nimm holzspule", "west",
	"nord", "inventar", "leg holzspule in lesemulde", "drueck abhörknopf",
}
local endings = {
	{ "drueck rückantworttaste", "ENDE – PRIVATE RÜCKANTWORT" },
	{ "drueck gedenktaste", "ENDE – EINE MINUTE FÜR DIE LEBENDEN" },
}
for _, ending in ipairs(endings) do
	local walk = Walk.new(story)
	for _, command in ipairs(route) do walk:choose(command) end
	walk:choose(ending[1])
	assert(walk.output:find(ending[2], 1, true), walk.output)
	assert(walk.finishes == 1 and not walk:running())
end
print("Beide deutschsprachigen Museumsenden per Link-Walkthrough bestanden.")
