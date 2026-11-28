local walk = require("tests.link_walk").new("books.de.borrowed-tomorrows.borrowed-tomorrows")
local route = {
	"oeffn leihschrank", "nimm morgenblatt", "nord", "lies leihschein", "ost", "inventar",
	"leg morgenblatt in leserahmen", "sued", "lies faltbrett",
	"leg morgenblatt in faltbrett", "nord", "inventar", "leg morgenblatt in leserahmen", "lies leserahmen",
}
for _, command in ipairs(route) do
	walk:choose(command)
	if command == "oeffn leihschrank" then
		assert(walk:choose("such leihschrank"):find("im offenen Schrank", 1, true))
	elseif command == "nimm morgenblatt" then
		assert(walk:choose("such leihschrank"):find("blattförmiger Fleck", 1, true))
	end
end
assert(walk.output:find("ENDE – PLATZ FÜR JEDEN NAMEN", 1, true), walk.output)
assert(walk.finishes == 1 and not walk:running())
print("Deutschsprachiger Link-Walkthrough bestanden.")
