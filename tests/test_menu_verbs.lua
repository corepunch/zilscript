-- Reader menus offer only commands the parser accepts as things stand, and
-- speak each action by its base verb whatever synonyms a story adds.
local Walk = require("tests.link_walk")

local function check(walk, command, wanted)
	local offered = walk:offers(command)
	if offered ~= wanted then
		error(string.format("%s should %sbe offered in %s. Offered:\n%s", command,
			wanted and "" or "not ", walk:room(), walk:describeMenu()), 2)
	end
end

local function typed(walk, command)
	local text = walk.game:resume(command)
	walk:record(text)
	return text
end

-- A HAVE verb waits until the object is held; TAKE HAVE may take it first,
-- but only when it can be taken.
local w = Walk.new("tests.menu-verbs.menu-verbs")
check(w, "shake pebble", false)
check(w, "twirl pebble", true)
check(w, "shake boulder", false)
check(w, "twirl boulder", false)
check(w, "examine boulder", true)
assert(w:choose("twirl pebble"):find("twirl", 1, true))
check(w, "shake pebble", true)
assert(w:choose("shake pebble"):find("rattles", 1, true))

-- The story's FIX synonym for V-PUT-ON does not replace PUT, and the put
-- checks (a container or surface to put it on) still hold for it.
check(w, "put pebble on shelf", true)
check(w, "fix pebble on shelf", false)
check(w, "fix pebble on boulder", false)
check(w, "put pebble on boulder", false)
w:choose("put pebble on shelf")
assert(w.env.LOC(w.env.PEBBLE) == w.env.SHELF)
check(w, "shake pebble", false)

-- The books where the menus first offered "You don't have the reed wick."
w = Walk.new("books.bell-grew-leaves.bell-grew-leaves")
w:choose("east")
check(w, "shake reed wick", false)
check(w, "take reed wick", true)
w:choose("take reed wick")
check(w, "shake reed wick", true)

w = Walk.new("books.borrowed-tomorrows.borrowed-tomorrows")
typed(w, "open cabinet")
check(w, "shake tomorrow leaf", false)

print("ok - menu verbs need the object in hand and use the base verb")
