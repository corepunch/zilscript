local Walk = require("tests.story_walk")
local story = "books.de.museum-unsent-signals.museum-unsent-signals"
local route = {
	"lies messingtafel", "ost", "kipp lupe", "nimm holzspule", "west",
	"nord", "inventar", "leg holzspule in lesemulde", "stoss abhörknopf",
}
local endings = {
	{ "stoss rückantworttaste", "ENDE – PRIVATE RÜCKANTWORT" },
	{ "stoss gedenktaste", "ENDE – EINE MINUTE FÜR DIE LEBENDEN" },
}
for _, ending in ipairs(endings) do
	local walk = Walk.new(story)
	for _, command in ipairs(route) do walk:command(command) end
	walk:command(ending[1])
	assert(walk.output:find(ending[2], 1, true), walk.output)
	assert(walk.finishes == 1 and not walk:running())
end
local retry = Walk.new(story)
retry:play({
	{ "hilfe", expect = "UNTERSUCHE" },
	"ost",
	{ "lies etikett", expect = "ALS LEER EINGETRAGEN" },
	{ "lies papieretikett", expect = "ZUR ÜBERPRÜFUNG" },
	{ "untersuche rand", expect = "Kerben" },
	{ "untersuche kerben", expect = "Kerben" },
	"nimm spule", "west", "nord", "leg spule in lesemulde",
	{ "drücke abhörknopf", expect = "Du weißt es noch nicht" },
	"süd", "ost", "kippe lupe", "west", "nord",
	{ "drücke rückantworttaste", expect = "Abhörknopf erneut" },
	{ "drücke gedenktaste", expect = "Abhörknopf erneut" },
	{ "drücke abhörknopf", expect = "privaten Rückantwortregister" },
	{ "drücke rückantworttaste", expect = "ENDE – PRIVATE RÜCKANTWORT" },
})
assert(retry.finishes == 1 and not retry:running())
print("Beide deutschsprachigen Museumsenden per Text-Walkthrough bestanden.")
