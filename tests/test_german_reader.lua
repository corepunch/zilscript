-- The reader speaks the story's language: menus, completions and status
-- lines for a German story are German, and every command they send is one the
-- German parser understands. Plays infocom.zork1-de, which is a German story.
package.path = "./tests/?.lua;" .. package.path
local Walk = require("link_walk")
local Language = require("zilscript.reader.Language")
local Session = require("zilscript.reader.Session")

local function titles(list)
	local out = {}
	for _, entry in ipairs(list) do table.insert(out, entry.title) end
	return table.concat(out, "|")
end

local function commands(list)
	local out = {}
	for _, entry in ipairs(list) do out[entry.command] = entry.title end
	return out
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

local walk = Walk.new("infocom.zork1-de.zork1", 97, "de")
walk:record(walk.game:resume("nord"))
local session = walk.session
assert(session.language.code == "de")
session.running = true
-- The German package names exits in German; the reader reads them all.
assert(session.availableDirections.north and session.availableDirections.east, "German exits are directions")
assert(session.availableDirections.southwest and session.availableDirections.southeast)
session.availableDirections.up = true
table.insert(session.exitList, "up")

assert(titles(session:suggestions("")) == "Umsehen|Inventar", "German default titles")
assert(session:presentation().language == "de")

-- Item menus: German titles, German commands, never English words.
local actions = commands(session:linkActions("brett"))
assert(actions["untersuch brett"] == "Untersuchen", "examine in German: " .. titles(session:linkActions("brett")))
assert(actions["heb auf brett"] == "Aufheben", "take in German")
for command in pairs(actions) do
	assert(not command:match("^examine") and not command:match("^take"), "English command offered: " .. command)
	local output = walk.game:resume(command)
	assert(type(output) == "string" and output ~= "", command .. " printed nothing")
	assert(not output:find("nicht verstanden", 1, true) and not output:find("kenne das Wort", 1, true),
		command .. " was not understood:\n" .. output)
end

-- Directions: compass words of the German parser, German titles.
local north = session:linkActions("north")
assert(north[1].command == "nord" and north[1].title == "Geh nach Norden", titles(north))
assert(session:linkActions("up")[1].command == "rauf")

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

print("ok - German reader: menus, completions and status lines")

-- Umlauts and ß are letters: "Straßenbahn" is one noun, not "enbahn".
local Suggestions = require("zilscript.reader.Suggestions")
assert(Suggestions.noun("Straßenbahn") == "straßenbahn", Suggestions.noun("Straßenbahn"))
assert(Suggestions.noun("großer Schlüssel") == "schlüssel")
