-- Exercise the nouns a reader discovers in prose and the world state shared
-- by typed aliases and the next description of the room.
local Walk = require("tests.story_walk")

local function enter(walk, room)
	local env = walk.env
	env.MOVE(env.WINNER, room)
	env.HERE = room
	walk:record(walk.game:resume("look"))
end

local function book(name)
	return Walk.new("books." .. name .. "." .. name)
end

local function expect(text, fragment)
	assert(text:find(fragment, 1, true), fragment .. " missing in " .. text)
end

local function typeCommand(walk, command)
	local text = walk.game:resume(command)
	walk:record(text)
	return text
end

local w = book("wondertown")
local e = w.env
enter(w, e.COUNTERTOP)
typeCommand(w, "examine case")
expect(w:command("raise brass latch"), "Pip opens")
assert(e.FSETQ(e.DISPLAY_CASE, e.OPENBIT))
typeCommand(w, "close latch")
expect(typeCommand(w, "turn crank"), "behind the glass")
typeCommand(w, "pull latch")
expect(typeCommand(w, "turn crank"), "melody")
assert(e.MUSIC_BOX_PLAYED)
enter(w, e.TOOL_BENCH)
expect(typeCommand(w, "examine rack"), "hammer")
expect(typeCommand(w, "take hammer"), "Taken.")
assert(e.LOC(e.DETAIL_HAMMER) == e.WINNER)
assert(not typeCommand(w, "examine rack"):find("hammer", 1, true))
typeCommand(w, "drop hammer")
assert(e.LOC(e.DETAIL_HAMMER) == e.TOOL_BENCH)
expect(typeCommand(w, "look"), "hammer")

w = book("blackwood-horror")
e = w.env
enter(w, e.ADMINISTRATIVE_WING)
typeCommand(w, "examine papers")
expect(w:command("read staff memo"), "Subject 189")
expect(typeCommand(w, "read memo"), "Chapel is OFF LIMITS")
enter(w, e.CAFETERIA)
typeCommand(w, "take bell")
enter(w, e.ADMINISTRATIVE_WING)
typeCommand(w, "examine bell")
expect(w:command("ring brass dome"), "tinny sound")
enter(w, e.CHAPEL)
e.FSET(e.CHAPEL, e.ONBIT)
typeCommand(w, "look")
typeCommand(w, "open clasp")
assert(not e.FSETQ(e.WOODEN_BOX, e.OPENBIT))
e.MOVE(e.SCALPEL, e.WINNER)
expect(typeCommand(w, "open clasp with scalpel"), "clasp")
assert(e.FSETQ(e.WOODEN_BOX, e.OPENBIT))

w = book("limehouse-killings")
e = w.env
enter(w, e.DINING_ROOM)
typeCommand(w, "examine cabinet")
e.CABINET_CLUE_SEEN = false
expect(w:command("read handwritten entry"), "private laboratory")
assert(e.CABINET_CLUE_SEEN)
enter(w, e.ASHWORTH_MANOR_GATE)
expect(typeCommand(w, "lift latch"), "raised position")
enter(w, e.STUDY)
expect(typeCommand(w, "turn dial"), "Which")
assert(not e.LOCKED_BOX_OPENED)

w = book("pocket-weather")
e = w.env
local cardLocation = e.LOC(e.CARD)
expect(typeCommand(w, "read forecast"), "continuous rain")
assert(e.LOC(e.CARD) == cardLocation)
expect(typeCommand(w, "read forecast card"), "blank weather card")
enter(w, e.ARCH)
typeCommand(w, "examine chime")
expect(w:command("ring hard clapper"), "CLANG")
e.MOVE(e.RIBBON, e.CHIME)
expect(typeCommand(w, "ring clapper"), "Tok")
enter(w, e.ARCHIVE)
typeCommand(w, "lift brass lip")
assert(e.FSETQ(e.WEATHERBOX, e.OPENBIT))
typeCommand(w, "take report")
typeCommand(w, "close weatherbox")
typeCommand(w, "lift brass lip")
assert(e.LOC(e.REPORT) == e.WINNER)

w = book("last-broadcast")
e = w.env
enter(w, e.LB_PLATFORM)
w:command("cross covered walk")
assert(e.HERE == e.LB_BUNKROOM)
typeCommand(w, "cross walk")
assert(e.HERE == e.LB_PLATFORM)
enter(w, e.LB_OFFICE)
local clock = typeCommand(w, "read office clock")
expect(typeCommand(w, "turn winding knob"), "minute hand")
expect(clock, "9:12")
expect(typeCommand(w, "read office clock"), "9:12")

w = book("silent-vector")
e = w.env
typeCommand(w, "examine frame")
expect(w:command("open restraint buckle"), "strap falls loose")
expect(typeCommand(w, "examine frame"), "hangs loose")
assert(e.FSETQ(e.DETAIL_BUCKLE, e.OPENBIT) and not e.POWER)
expect(typeCommand(w, "close buckle"), "a click")
expect(typeCommand(w, "release buckle"), "strap falls loose")
enter(w, e.QUARANTINE)
expect(typeCommand(w, "open interlock"), "bolt holds")
e.PROOF = true
expect(typeCommand(w, "read inspection flags"), "TRACE tab shows white")
assert(not e.ISOLATED)
e.ISOLATED = true
expect(typeCommand(w, "open interlock"), "bolt is back")

print("Discovery actions passed in all six books.")
