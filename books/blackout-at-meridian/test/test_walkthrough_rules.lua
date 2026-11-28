-- Story and companion regressions.
local Walk = require("tests.story_walk")

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

expect("north", "Choose a profile first")
-- The superhero rules stand on the English base alone: Zork's verbs are not
-- vocabulary, and the ruleset's own words answer when no object does.
expect("dig", 'I don\'t know the word "dig"')
expect("pray", 'I don\'t know the word "pray"')
expect("attack rain", "That is not a target.")
expect("rescue window", "Nobody needs rescuing there.")
expect("disable board", "That is not a control system.")
expect("choose window", "That is not a profile.")
expect("focus window", "That does not help.")
expect("diagnose", "You have no ranks yet")
expect("inventory", "You are carrying:")
-- The sheet stays with the hero after a move.
expect("drop sheet", "You keep your character sheet.")
-- One line per attribute pair: "|" in a ZIL string is a line break, so the
-- sheet must not use it as a column separator.
local sheet = expect("choose bulwark", "Fighting: 30, Agility: 10\n")
assert(sheet:find("Health: 120/120, Karma: 26", 1, true), sheet)
-- An unnamed hero is called Meridian; the name table has no length prefix.
expect("examine sheet", "Hero: Meridian (Bulwark)\n")
expect("north", "Faces crowd the high end")
expect("examine front carriage", "hangs nose-down over the river")
until_success("rescue passengers", "pass the passengers down", 8)
expect("rescue tram", "already safe")
expect("east", "guard drone")
expect("diagnose", "Health ")
until_success("hit drone", "The drone crashes to the floor", 8)
local ending = expect("disable console", "dispatch calls your name: Meridian. Meridian is safe.")
assert(not ending:find("Reason check", 1, true), "a downed drone leaves the lever unguarded:\n" .. ending)
assert(ending:find("THE END: THE LIGHTS OF MERIDIAN", 1, true), ending)
assert(ending:find("Hero: Meridian (Bulwark)", 1, true), "the ending prints the hero:\n" .. ending)
assert(w.finishes == 1 and not w:running(), "the story ends through FINISH when Meridian is safe")
print("ok - Blackout at Meridian typed walkthrough")
