-- Shared behaviour every book inherits: menus follow an object's present
-- state, taken objects score, and "a" becomes "an" before a vowel.
local Walk = require("tests.link_walk")

-- Wondertown's tin soldier stands in a shut glass case on the countertop.
local toys = Walk.new("books.wondertown.wondertown")
local env = toys.env
env.MOVE(env.WINNER, env.COUNTERTOP)
env.HERE = env.COUNTERTOP
toys:choose("look")
toys:choose("examine dusty case")
assert(not toys:offers("take tin soldier"), "A soldier behind shut glass offers no Take")
assert(toys:offers("open dusty case"), "A shut case offers Open")
assert(not toys:offers("close dusty case"), "A shut case offers no Close")
toys:choose("open dusty case")
assert(toys:offers("take tin soldier"), "An open case lets the soldier be taken")
assert(not toys:offers("open dusty case"), "An open case offers no Open")

-- A lamp offers the switch position it is not in.
local ward = Walk.new("books.blackwood-horror.blackwood-horror")
env = ward.env
env.MOVE(env.OIL_LANTERN, env.WINNER)
ward:choose("inventory")
assert(ward:offers("turn on oil lantern") and not ward:offers("turn off oil lantern"), "An unlit lantern offers only Turn on")
ward:choose("turn on oil lantern")
ward:choose("inventory")
assert(ward:offers("turn off oil lantern") and not ward:offers("turn on oil lantern"), "A lit lantern offers only Turn off")

-- Taking an object with a VALUE scores it once (ITAKE's compile-time OR).
env.MOVE(env.PATIENT_FILE, env.HERE)
local before, value = env.SCORE, env.GETP(env.PATIENT_FILE, env.PQVALUE)
assert(value > 0, "The patient file carries a score value")
ward.game:resume("take patient file")
assert(env.SCORE == before + value, "Taking the file adds its value to the score")

-- Putting away or handing over is offered for what is in hand, not on the floor.
ward.game:resume("drop patient file")
ward:choose("look")
for _, action in ipairs(ward:menu()) do
	assert(not action.command:find("^put patient file") and not action.command:find("^give patient file"),
		"A file on the floor offers no " .. action.command)
end

-- Listings choose their article by the name's first letter.
env.MOVE(env.ANCIENT_RELIC, env.HERE)
env.PUTP(env.ANCIENT_RELIC, env.PQDESC, "ancient relic")
env.FSET(env.ANCIENT_RELIC, env.TOUCHBIT)
env.PROSE_LINKS = false
ward.game:resume("take ancient relic")
local listing = ward.game:resume("inventory")
assert(listing:find("An ancient relic", 1, true), "An inventory line starts \"An\" before a vowel:\n" .. listing)
ward.game:resume("take patient file")
listing = ward.game:resume("inventory")
assert(listing:find("A patient file", 1, true), "Consonant names keep \"A\":\n" .. listing)
print("ok - reader menus follow state, taken objects score, articles agree")
