-- The reader speaks the story's language: completions and status
-- lines for a German story are German, and every command they send is one the
-- German parser understands. Plays infocom.zork1-de, which is a German story.
local Walk = require("tests.story_walk")
local Language = require("zilscript.reader.Language")
local Session = require("zilscript.reader.Session")

local function titles(list)
	local out = {}
	for _, entry in ipairs(list) do table.insert(out, entry.title) end
	return table.concat(out, "|")
end

-- English stays the default.
local english = Session.new()
assert(titles(english:suggestions("")) == "Look around|Inventory", "English default titles")
assert(english.language.code == "en")
assert(Session.statusLine({}, 3, 10, 7) == "Score 3 of 10 · 7 moves")
assert(Session.statusLine({ statusLine = "moves" }, 0, 0, 5) == "5 moves")
assert(Language.of("German").code == "de" and Language.of("de").code == "de" and Language.of("xx").code == "en")

-- Status lines in German.
assert(Session.statusLine({ language = "de", statusLine = "moves" }, 0, 0, 5) == "5 Züge")
assert(Session.statusLine({ language = "de" }, 3, 10, 1) == "Punkte 3 von 10 · 1 Zug")
assert(Session.statusLine({ language = "de" }, 3, 0, 4) == "Punkte 3 · 4 Züge")

local walk = Walk.new("infocom.zork1-de.zork1")
walk:command("nord")
local session = Session.new()
session.language = Language.of("de")
session.engine = {
	items = function() return walk.game:resume("room-items") end,
	exits = function()
		local directions = {}
		for _, exit in ipairs(walk.game:resume("room-exits")) do table.insert(directions, tostring(exit[1]):lower()) end
		return directions
	end,
}
session:refreshEngineState()
-- The German package names exits in German; the reader reads them all.
assert(session.availableDirections.north and session.availableDirections.east, "German exits are directions")
assert(session.availableDirections.southwest and session.availableDirections.southeast)
session.availableDirections.up = true
table.insert(session.exitList, "up")

assert(titles(session:suggestions("")) == "Umsehen|Inventar", "German default titles")
assert(session:presentation().language == "de")

-- Completions: German verbs and compass words, not "go north".
local function completes(input, command)
	for _, suggestion in ipairs(session:suggestions(input)) do
		if suggestion.text:match("^" .. command) then return true end
	end
	return false
end
assert(completes("n", "nord"), "n completes to nord: " .. titles(session:suggestions("n")))
assert(completes("nim", "nimm"), "nim completes to nimm: " .. titles(session:suggestions("nim")))
assert(not completes("go", "go"), "no English go")
assert(completes("sch", "schau"), "sch completes to schau")

assert(completes("nimm br", "nimm brett"), "object names complete in German")
for _, command in ipairs({ "untersuch brett", "nimm brett" }) do
	local output = walk:command(command)
	assert(not output:find("nicht verstanden", 1, true) and not output:find("kenne das Wort", 1, true), output)
end

for _, direction in ipairs({ "nord", "ost", "rauf", "runter" }) do
	assert(not walk.game:resume(direction):find("kenne das Wort", 1, true), direction .. " is not a word")
end
-- The engine's own fallback menu (bootstrap.lua) follows <LANGUAGE GERMAN> too.
local found = {}
for _, choice in ipairs(walk.game:resume("choices").choices) do found[choice.command] = choice.label end
assert(next(found), "the fallback menu offers exits")
for _, label in pairs(found) do
	assert(label:match("^Gehe zu ") or label:match("^Zurück") or label:match("^Hinauf") or label:match("^Hinunter"), "German label: " .. label)
end
for command, label in pairs(found) do
	assert(not label:find("Walk") and not label:find("Climb"), "English label: " .. label)
	assert(not command:find("north") and not command:find("south"), "English command: " .. command)
end

print("ok - German reader: completions, status lines and companion choices")

-- Umlauts and ß are letters: "Straßenbahn" is one noun, not "enbahn".
local Suggestions = require("zilscript.reader.Suggestions")
assert(Suggestions.noun("Straßenbahn") == "straßenbahn", Suggestions.noun("Straßenbahn"))
assert(Suggestions.noun("großer Schlüssel") == "schlüssel")
