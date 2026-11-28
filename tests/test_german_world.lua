-- Plays an original two-room German story (tests/fixtures/de-probe) over the
-- German package alone, with no Zork and no ruleset: the world verbs, genders
-- and cases, pronouns, umlauts in and out, ALL, containers and doors.
local runtime = require("zilscript.runtime")

local env = runtime.create_game_env()
assert(runtime.init(env, true), "bootstrap failed")
env.require("zilscript")
assert(runtime.load_modules(env, { "tests.fixtures.de-probe.de-probe" }, { silent = true }), "the German probe story failed to load")
local game = runtime.create_game(env, true)

local function check(command, output, texts)
	assert(type(output) == "string", command .. " printed nothing")
	for _, text in ipairs(texts or {}) do
		assert(output:find(text, 1, true), string.format("%s should print %q but printed:\n%s", command, text, output))
	end
	assert(not output:find("%%[aouAOUs<>]"), command .. " printed an undecoded escape:\n" .. output)
	assert(not output:find("nil", 1, true), command .. " printed nil:\n" .. output)
	assert(not output:find("attempt to", 1, true) and not output:find("stack traceback", 1, true), command .. " raised a Lua error:\n" .. output)
	for _, zork in ipairs({ "Zork", "ZORK", "Briefkasten", "Unterweltreich", "Haus", "Troll" }) do
		assert(not output:find(zork, 1, true), command .. " printed Zork text " .. zork .. ":\n" .. output)
	end
end

check("the opening", game:start(), {
	"Werkstatt",
	"Eine enge Werkstatt voller Späne.",
	"Ein schwerer Hammer liegt auf dem Boden.",
	"Hier ist eine Bürste.",
	"Hier ist ein Buch.",
})

local route = {
	{ "schau", "Werkstatt", "Hier ist eine Bürste." },
	-- Masculine, feminine and neuter things take their own article and case.
	{ "untersuche den Hammer", "Da ist nichts Besonderes an dem Hammer." },
	{ "untersuche die Bürste", "Da ist nichts Besonderes an der Bürste." },
	{ "nimm den Hammer", "Genommen." },
	-- ihn/sie/es follow the grammatical gender, also of a thing a player touched
	{ "lass ihn fallen", "Fallen gelassen." },
	{ "nimm den hammer", "Genommen." },
	{ "nimm die bürste", "Genommen." },
	{ "inventar", "Du trägst:", "Ein Hammer", "Eine Bürste" },
	{ "untersuche sie", "Da ist nichts Besonderes an der Bürste." },
	{ "lass die Bürste fallen", "Fallen gelassen." },
	{ "nimm sie", "Genommen." },
	-- A capitalized umlaut (a phone keyboard) and an ASCII spelling
	{ "Öffne die Kiste", "Die Kiste", "Nagel" },
	{ "schließ die kiste", "Geschlossen." },
	{ "oeffne die kiste", "Nagel" },
	{ "NIMM DIE BÜRSTE", "Das hast du doch schon!" },
	{ "nimm das Buch", "Genommen." },
	{ "lies es", "Alles Gute kommt von unten." },
	{ "lies das Buch", "Alles Gute kommt von unten." },
	{ "nimm den Nagel", "Genommen." },
	{ "lege den Hammer in die Kiste", "Geschafft." },
	{ "schau in die Kiste", "Hammer" },
	{ "nimm den hammer aus der kiste", "Genommen." },
	-- An adjective tells two things of one name apart; a question about which
	-- one is answered by a noun, an adjective or a whole new command.
	{ "nord", "Hof" },
	{ "untersuche karte", "Welche Karte meinst du, die rote Karte oder die blaue Karte?" },
	{ "untersuche blaue karte", "blaue Karte" },
	{ "untersuche karte", "Welche Karte meinst du" },
	{ "rote", "rote Karte" },
	{ "untersuche karte", "Welche Karte meinst du" },
	{ "untersuche blau", "blaue Karte" },
	{ "untersuche die rote Karte", "rote Karte" },
	{ "süd", "Werkstatt" },
	-- Two rooms
	{ "nord", "Hof", "Hier ist eine rote Karte." },
	{ "öffne das Tor", "Das Tor öffnet." },
	{ "schließe das Tor", "Das Tor" },
	{ "gehe süd", "Werkstatt" },
	{ "nord", "Hof" },
	{ "süd", "Werkstatt" },
	{ "osten", "In die Richtung kannst du nicht gehen." },
	{ "warte", "Zeit vergeht..." },
	{ "springe" },
	{ "hilfe" },
	{ "punktestand", "Keine Punkte." },
	{ "version", "Probe" },
	{ "save" },
	-- ALL
	{ "lass alles fallen", "Hammer: Fallen gelassen.", "Buch: Fallen gelassen.", "Nagel: Fallen gelassen.", "Bürste: Fallen gelassen." },
	{ "inventar", "Deine Hände sind leer." },
	{ "nimm alles", "Hammer: Genommen.", "Buch: Genommen.", "Bürste: Genommen." },
	{ "inventar", "Du trägst:", "Ein Hammer", "Ein Buch", "Eine Bürste" },
	{ "lass alles fallen", "Fallen gelassen." },
}

for _, step in ipairs(route) do
	local command = step[1]
	check(command, game:resume(command), { table.unpack(step, 2) })
end
assert(game:is_running(), "the story is still running")
-- The German package names none of Zork's rooms and objects and tests no
-- ZORK-NUMBER: Zork's special cases live in infocom/zork1-de.
local function read(path)
	local file = assert(io.open(path))
	local text = file:read("a")
	file:close()
	return text
end
local files = { "base", "globals", "init", "loop", "messages", "parser", "syntax", "verbs" }
local defined = {}
for _, name in ipairs(files) do
	for object in read("languages/de/" .. name .. ".zil"):gmatch("\n<[A-Z]+%s+([%w%-%?]+)") do defined[object] = true end
end
local zork = {}
for _, kind in ipairs({ "OBJECT", "ROOM" }) do
	for object in read("infocom/zork1-de/dungeon.zil"):gmatch("\n<" .. kind .. "%s+([%w%-%?]+)") do
		if not defined[object] then zork[object] = true end
	end
end
assert(zork["WEST-OF-HOUSE"] and zork.TREE and zork["GLOBAL-WATER"] and not zork.GROUND, "the Zork name list reads dungeon.zil")
for _, name in ipairs(files) do
	local text = read("languages/de/" .. name .. ".zil")
	assert(not text:find("ZORK-NUMBER", 1, true), name .. ".zil tests ZORK-NUMBER")
	for used in text:gmatch(",([%w%-%?]+)") do
		assert(not zork[used], name .. ".zil names the Zork object " .. used)
	end
end
print("ok - German world verbs on an original German story")
