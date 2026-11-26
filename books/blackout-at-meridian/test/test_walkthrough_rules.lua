-- Plays Blackout at Meridian with typed commands on the seeded generator
-- link_walk.lua installs, so every d100 roll replays.
local Walk = require("tests.link_walk")

local w = Walk.new("books.blackout-at-meridian.blackout-at-meridian")
local function send(command)
	local output = w.game:resume(command)
	assert(type(output) == "string" and output:match("%S"), command .. " printed nothing")
	return output
end
local function expect(command, text)
	local output = send(command)
	assert(output:find(text, 1, true), string.format("%q should print %q but printed:\n%s", command, text, output))
	return output
end
-- Retries a percentile check until it succeeds; failures cost health, so the
-- bound stays well inside the profile's Health.
local function until_success(command, text, tries)
	for _ = 1, tries do
		if send(command):find(text, 1, true) then return end
		assert(w:running(), command .. " ended the story")
	end
	error(command .. " never printed " .. text)
end

expect("north", "Choose a profile first.")
-- The superhero rules stand on the English base alone: Zork's verbs are not
-- vocabulary, and the ruleset's own words answer when no object does.
expect("dig", 'I don\'t know the word "dig"')
expect("pray", 'I don\'t know the word "pray"')
expect("attack sheet", "That is not a target.")
expect("inventory", "You are carrying:")
expect("drop sheet", "Dropped.")
expect("take sheet", "Taken.")
-- One line per attribute pair: "|" in a ZIL string is a line break, so the
-- sheet must not use it as a column separator.
local sheet = expect("choose bulwark", "Fighting: 30, Agility: 10\n")
assert(sheet:find("Health: 120/120, Karma: 26", 1, true), sheet)
-- An unnamed hero is called Meridian; the name table has no length prefix.
expect("examine sheet", "Meridian\n")
expect("north", "Rescue its passengers.")
expect("examine front carriage", "caught on a cable")
until_success("rescue passengers", "guide the last passenger", 8)
expect("rescue tram", "already safe")
expect("east", "guard drone")
expect("diagnose", "Health ")
until_success("hit drone", "The drone drops.", 8)
expect("disable console", "Dispatch calls your name: Meridian. Meridian is safe.")
assert(not w:running(), "the story ends when Meridian is safe")
print("ok - Blackout at Meridian typed walkthrough")
