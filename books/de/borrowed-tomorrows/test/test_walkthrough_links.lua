local walk = require("tests.link_walk").new("books.de.borrowed-tomorrows.borrowed-tomorrows")
local route = {
	"oeffn leihschrank", "nimm morgenblatt", "nord", "lies leihschein", "ost", "inventar",
	"leg morgenblatt in leserahmen", "sued", "lies faltbrett",
	"leg morgenblatt in faltbrett", "nord", "inventar", "leg morgenblatt in leserahmen", "lies leserahmen",
}
for _, command in ipairs(route) do walk:choose(command) end
assert(walk.output:find("ENDE – PLATZ FÜR JEDEN NAMEN", 1, true), walk.output)
assert(walk.finishes == 1 and not walk:running())
print("Deutschsprachiger Link-Walkthrough bestanden.")
