-- Story and companion regressions.
local Hero = require("books.blackout-at-meridian.test.hero")

local h = Hero.new()
h:force(100)

-- Before a profile: no way out, no ranks, and every hero action refuses.
h:expect("look", "Choose the hero you’ll play as")
h:expect("north", "Choose a profile first")
h:expect("out", "Choose a profile first")
h:expect("examine street door", "bowed inward")
h:expect("open street door", "Profile first")
h:expect("enter street door", "Choose a profile first")
assert(h.env.HERE == h.env.DISPATCH, "the physical exit cannot bypass registration")
h:expect("knock on street door", "loose fitting")
h:expect("knock on window", "little tick")
h:expect("listen to window", "rescue crew's whistles")
h:expect("search duty board", "Three profile cards")
h:expect("touch duty board", "polished by years")
for _, dir in ipairs({ "south", "east", "west", "up", "down" }) do h:expect(dir, "You can't go that way.") end
h:expect("examine sheet", "No profile registered yet.")
h:expect("score", "no profile registered yet")
h:expect("diagnose", "You have no ranks yet")
h:expect("help", "CHOOSE BULWARK, ARC or LENS")
h:expect("rescue tram", "out on the bridge")
h:expect("strike window", "enough to repair")
h:expect("use kit", "You can't see")
h:expect("take bulwark", "stays pinned to the board")
assert(h:state().class == 0, "taking a card does not choose it")
h:expect("examine profile", "Which profile do you mean")
assert(not h.output:find("bulwark bulwark", 1, true), "disambiguation names the profile once:\n" .. h.output)
for _, card in ipairs({ "bulwark", "arc", "lens" }) do h:expect("examine " .. card, "To take it on, choose it.") end

-- The typed name: READ lowercases it, so words are capitalised; spaces are
-- collapsed; a blank line or a non-ASCII line keeps the current name; a long
-- name is cut at the last whole word within 32 characters.
local function name(text, expected)
	h:expect("name sheet", "Type your hero name")
	h:expect(text, expected)
end
name("", "Dispatch will keep calling you Meridian.")
name("   ", "Dispatch will keep calling you Meridian.")
name("Ünïcode", "Your name stays Meridian.")
name("the very long hero name of the night watch", "Registered hero name: The Very Long Hero Name Of The\n")
name("abcdefghijklmnopqrstuvwxyz0123456789abcdefgh", "Registered hero name: Abcdefghijklmnopqrstuvwxyz012345\n")
name("captain rain", "Registered hero name: Captain Rain\n")
name("Ñame", "Your name stays Captain Rain.")
name("", "keep calling you Captain Rain.")
name("  dr.   o'neil-smith, jr.!?  ", "Registered hero name: Dr. O'neil-Smith, Jr.!?\n")
h:expect("read sheet", "Hero: Dr. O'neil-Smith, Jr.!?\n")
h:expect("name me", "That has no name to give.")
h:expect("drop sheet", "You keep your character sheet.")
h:expect("throw sheet at window", "You keep your character sheet.")

-- One profile per call.
h:expect("choose lens", "Dispatch registers you as Lens.")
h:expect("choose arc", "already registered as Lens")
h:expect("choose bulwark", "already registered as Lens")
local s = h:state()
assert(s.class == 3 and s.max == 60 and s.karma == 90, "a second choice changes nothing")
h:expect("examine lens", "This is your profile.")
h:expect("examine board", "The Lens card is marked ACTIVE")
h:expect("look", "red ACTIVE stamp")
h:expect("help", "RESCUE the PASSENGERS")

-- Scenery named in prose answers, per room. Jumping and swimming never kill.
local scenery = {
	{ "examine window", "streaked glass" }, { "open window", "painted shut" }, { "look through window", "streaked glass" },
	{ "examine rain", "silver lines" }, { "listen to rain", "steady roar" }, { "smell rain", "burned wiring" },
	{ "examine city", "dark from the river" }, { "examine river", "high and fast" }, { "examine tram", "red warning light" },
	{ "examine bridge", "short run north" }, { "examine board", "ACTIVE" }, { "listen", "rain on the glass" },
	{ "jump", "ready for anything" }, { "swim", "current would take you" },
}
for _, step in ipairs(scenery) do h:expect(step[1], step[2]) end

h:expect("enter street door", "Faces crowd the high end")
h:expect("knock on tram", "taps back twice")
assert(not h:state().rescued and #h.reports == 0, "a reassuring knock is not a rescue attempt")
h:expect("help", "RESCUE the PASSENGERS")
for _, step in ipairs({
	{ "examine crew", "yellow coats" }, { "talk to crew", "won't hold for long" }, { "ask crew about tram", "won't hold for long" },
	{ "examine rails", "bent outward" }, { "climb rails", "long way down" }, { "take rails", "bolted" },
	{ "examine cable", "another strand snaps" }, { "touch cable", "It is dead." }, { "listen to cable", "sings in the wind" },
	{ "listen to passengers", "child crying" }, { "push tram", "Push it, and it falls" }, { "strike tram", "people inside" },
	{ "rescue crew", "Nobody needs rescuing there." }, { "strike crew", "on your side" },
	{ "examine river", "high and fast" }, { "swim in river", "current would take you" }, { "jump off bridge", "current would take you" },
	{ "examine rain", "sideways" }, { "examine city", "dark from the river" }, { "examine bridge", "old steel bridge" },
	{ "examine station", "squat concrete" }, { "examine door", "torn off its lock" }, { "close door", "will not close" },
	{ "listen", "cable creaking" }, { "jump", "think better of it" }, { "swim", "current would take you" },
	{ "east", "Rescue them first." }, { "enter station", "Rescue them first." }, { "down", "The crew has the riverbank." },
	{ "north", "You can't go that way." }, { "west", "You can't go that way." },
}) do h:expect(step[1], step[2]) end
assert(h:running(), "no scenery verb ends the story")
h:expect("south", "emergency dispatch office")
h:expect("north", "Faces crowd the high end")
h:expect("pull cable", "pass the passengers down")
h:expect("look", "passengers are safe")
h:expect("knock on tram", "enormous tin drum")
h:expect("examine tram", "Nobody is inside now.")
h:expect("talk to crew", "shut it down")
h:expect("help", "STRIKE the DRONE or DISABLE the CONSOLE")
h:expect("enter door", "concrete hall")
h:expect("search kit", "a single dose")
h:expect("smell kit", "disinfectant and wet concrete")
assert(not h:state().boosted, "inspecting the kit is not using it")
h:expect("west", "passengers are safe")
h:expect("go back", "concrete hall")
for _, step in ipairs({
	{ "examine station", "You are inside it." }, { "examine door", "torn off its lock" }, { "examine rain", "concrete roof" },
	{ "examine bridge", "runs west into the rain" }, { "examine drone", "Integrity 40 of 40" }, { "examine eye", "Integrity 40 of 40" },
	{ "talk to drone", "RESTRICTED AREA" }, { "take drone", "You would have to fight it." }, { "listen to drone", "rotors whine" },
	{ "examine console", "manual bypass lever" }, { "examine lever", "manual bypass lever" }, { "take console", "bolted" },
	{ "strike console", "The lever will do." }, { "examine kit", "costs 10 Karma" }, { "take kit", "Use it where it hangs." },
	{ "listen", "whine of the drone" }, { "jump", "ready for anything" }, { "rescue drone", "Nobody needs rescuing there." },
	{ "choose drone", "That is not a profile." }, { "focus drone", "That does not help." }, { "east", "You can't go that way." },
}) do h:expect(step[1], step[2]) end
h:expect("out", "passengers are safe")
h:expect("east", "concrete hall")
assert(h:running() and h:state().health == 60, "nothing in the station hurts until the hero acts")

h:expect("disable console", "Meridian is safe.")
assert(not h:running(), "the lever ends the story")

-- Downed drone, used kit and the bridge after the rescue.
h = Hero.new()
h:force(100)
h:start("arc")
h:send("rescue tram")
h:send("east")
h:force(1)
h:send("strike drone")
h:send("use kit")
h:force(100)
h:send("strike drone")
h:expect("south", "You can't go that way.")
h:expect("west", "passengers are safe")
h:send("south")

print("ok - Blackout at Meridian world and names")
