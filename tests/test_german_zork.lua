-- Plays the opening of the German Zork I (infocom/zork1-de) on the German
-- language package: umlauts in and out, articles by gender and case,
-- pronouns by gender, separable verbs, room exits and the object tree.
local runtime = require("zilscript.runtime")

local env = runtime.create_game_env()
assert(runtime.init(env, true), "bootstrap failed")
env.require("zilscript")
assert(runtime.load_modules(env, { "infocom.zork1-de.zork1" }, { silent = true }), "German Zork I failed to load")
local game = runtime.create_game(env, true)

local function expect(output, texts, command)
	for _, text in ipairs(texts) do
		assert(output:find(text, 1, true), string.format("%s should print %q but printed:\n%s", command, text, output))
	end
end

expect(game:start(), {
	"ZORK I: Das Große Unterweltreich",
	"Westlich vom Haus",
	"westlich von einem weißen Haus",
	"Hier ist ein kleiner Briefkasten.",
}, "the opening")

local route = {
	-- A phone keyboard capitalizes the first word: Ö must find öffne.
	-- An adjective in front of the noun
	{ "untersuche den kleinen Briefkasten", "Briefkasten" },
	{ "Öffne den Briefkasten", "Der kleine Briefkasten, der geöffnet ist, enthält ein Zettel." },
	{ "nimm den Zettel", "Genommen." },
	-- Zettel is masculine (DERBIT), so "ihn" refers to it.
	{ "lies ihn", "»Willkommen in Zork!" },
	{ "nord", "Nördlich vom Haus" },
	{ "ost", "Hinter dem Haus" },
	-- ASCII spellings of umlauts are vocabulary too.
	{ "oeffne das fenster", "öffnest du das Fenster" },
	{ "west", "Küche", "Auf dem Tisch steht eine Flasche.", "Auf dem Tisch ist ein länglicher brauner Sack." },
	{ "nimm den sack", "Genommen." },
	{ "west", "Wohnzimmer", "Messingleuchte ist auf dem Trophäenschrank." },
	{ "nimm die lampe", "Genommen." },
	-- A separable verb: the prefix "an" closes the sentence.
	{ "mach die lampe an", "an." },
	{ "nimm das schwert", "Genommen." },
	{ "inventar", "Du trägst:", "Ein Elfenschwert", "Ein brauner Sack", "Ein Zettel" },
	{ "schieb den teppich", "Falltüre kommt zum Vorschein" },
	{ "öffne die falltür", "baufällige Treppe" },
	{ "runter", "Keller", "jemand sie verriegelt" },
	{ "nord", "Trollzimmer", "Ein widerlicher Troll" },
}

for _, step in ipairs(route) do
	local command = step[1]
	local output = game:resume(command)
	assert(type(output) == "string", command .. " printed nothing")
	expect(output, { table.unpack(step, 2) }, command)
	assert(not output:find("%a%%[aouAOUs<>]"), command .. " printed an undecoded escape:\n" .. output)
	assert(not output:find("nil", 1, true), command .. " printed nil:\n" .. output)
end
assert(game:is_running(), "the story is still running at the troll")
print("ok - German Zork I: opening to the troll room")
