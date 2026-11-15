-- What a links-only reader tripped over in Blackwood, pinned one case at a
-- time. Steps go through the reader's menus (tests/link_walk.lua) wherever
-- the point is what a tap offers or prints; `typed` talks to the parser where
-- the point is vocabulary or a state reached faster by setting it up.
package.path = "./?.lua;./?/init.lua;" .. package.path
local Walk = require("tests.link_walk")

local failures, checks = {}, 0
local function check(value, message)
	checks = checks + 1
	if not value then table.insert(failures, message) end
end
local function has(text, part) return tostring(text):find(part, 1, true) ~= nil end

local function start()
	local walk = Walk.new("books.blackwood-horror.blackwood-horror", 97)
	local env = walk.env
	local function typed(command)
		local output = walk.game:resume(command)
		walk:record(output)
		return output
	end
	local function enter(room)
		env.HERE = room
		env.MOVE(env.WINNER, room)
		return typed("look")
	end
	local function carry(...)
		for _, object in ipairs({ ... }) do
			env.FCLEAR(object, env.INVISIBLE)
			env.MOVE(object, env.WINNER)
		end
	end
	return walk, env, typed, enter, carry
end

-- Reception: the drawer, its listing, and menus without nonsense pairs.
do
	local walk, env = start()
	local text = walk:choose("move brass plaque")
	check(has(text, "bolted firmly"), "MOVE (the menu's Pull) on the plaque answers in the story's voice")
	walk:play({ "north" })
	check(has(walk:choose("climb grand staircase"), "no way up"), "climbing the grand staircase says there is no way up")
	walk:play({ "west", "examine scattered papers", "take reception key", "examine heavy desk" })
	check(not walk:offers("read scattered papers with reception key"), "papers are not read with a key")
	check(not walk:offers("open filing cabinets with reception key"), "open cabinets take no key")
	check(walk:offers("unlock bottom drawer with reception key"), "the drawer still offers its key")
	walk:play({ { "open bottom drawer", expect = "ledger" } })
	text = walk:choose("unlock bottom drawer with reception key")
	check(has(text, "already unlocked"), "unlocking the open drawer says it is open, not 'It doesn't seem to work'")
	text = walk:choose("look")
	check(not has(text, "Sitting on the"), "the open drawer is not listed as sitting on the desk")
	check(has(text, "bottom drawer stands open"), "the desk tells of its open drawer")
	check(has(text, "ledger") and has(text, "patient file"), "the open drawer shows the ledger and the file")
	check(not has(text, "contains:"), "untouched drawer contents read as prose, not a list")
	check(env.FSETQ(env.BOTTOM_DRAWER, env.NDESCBIT), "the drawer stays part of the desk's description")
end

-- Ward: the opened morgue door.
do
	local walk, env, typed, enter, carry = start()
	carry(env.SCALPEL)
	enter(env.PATIENT_WARD)
	check(has(typed("north"), "bound shut"), "the bound door says why north is closed")
	walk:play({ { "cut thick chains with surgical scalpel", expect = "strap parts" } })
	check(env.SCORE == 4, "cutting the strap scores the chains' value")
	local text = typed("open heavy door")
	check(has(text, "already stands open"), "opening the opened morgue door is answered")
	check(not has(text, "You must tell me how"), "no parser default for the opened door")
end

-- Two vials, two files, three keys: each menu command names one object.
do
	local walk, env, typed, enter, carry = start()
	carry(env.STRANGE_SERUM, env.MORPHINE_VIAL, env.MEDICAL_RECORDS, env.PATIENT_FILE,
		env.BRASS_KEY, env.SAFE_KEY, env.CHAPEL_KEY)
	enter(env.DIRECTORS_OFFICE)
	local text = walk:choose("inventory")
	check(walk:offers("examine morphine vial"), "the morphine vial has its own command")
	check(not walk:offers("examine glass vial"), "no command is shared by both vials")
	check(has(walk:choose("examine morphine vial"), "Morphine Sulfate"), "EXAMINE MORPHINE VIAL reaches the morphine")
	check(has(walk:choose("examine strange serum"), "Compound 237"), "EXAMINE STRANGE SERUM reaches the serum")
	check(has(walk:choose("drop patient file"), "Dropped"), "DROP PATIENT FILE does not ask which file")
	check(env.LOC(env.PATIENT_FILE) == env.HERE and env.LOC(env.MEDICAL_RECORDS) == env.WINNER,
		"the patient file is dropped and the medical records are kept")
	check(has(walk:choose("drop reception key"), "Dropped"), "the reception key drops by its own name")
	text = walk:choose("look")
	check(has(text, "[[brass key->reception key]]") or has(walk.output, "[[brass key->reception key]]"),
		"the dropped reception key links to itself, not to any key")
	check(has(walk:choose("examine reception key"), "number '3'"), "its link examines the reception key")
	check(not has(text, "A oil") and not has(typed("inventory"), "A oil"), "no 'A oil lantern'")
end

-- Storage: shelves, their listing, and inventory articles.
do
	local walk, env, typed, enter = start()
	enter(env.STORAGE_ROOM)
	local text = walk:choose("open sagging shelves")
	check(has(text, "You search through the shelves"), "opening the shelves searches them")
	text = walk:choose("look")
	check(not has(text, "contains:"), "shelf contents read as prose, not 'The shelves contains:'")
	check(has(text, "oil lantern") and has(text, "medical bag") and has(text, "medical records"),
		"the searched shelves show all three finds")
	walk:play({ "take oil lantern", "take medical records", "read medical records" })
	text = walk:choose("inventory")
	check(has(text, "A brass oil lantern"), "inventory says 'A brass oil lantern'")
	check(has(text, "A sheaf of medical records"), "inventory says 'A sheaf of medical records'")
end

-- Boiler: an unlit lantern, and the lit boiler's switch.
do
	local walk, env, typed, enter, carry = start()
	carry(env.OIL_LANTERN, env.LUMP_OF_COAL)
	enter(env.BOILER_ROOM)
	walk:choose("inventory")
	check(not walk:offers("burn iron boiler with black coal"), "the boiler is lit with the lantern only")
	local text = walk:choose("burn iron boiler with oil lantern")
	check(has(text, "needs coal first"), "an empty firebox asks for coal")
	walk:play({ "put black coal in iron boiler" })
	text = walk:choose("burn iron boiler with oil lantern")
	check(has(text, "must be lit first"), "an unlit lantern is named as the reason")
	check(not has(text, "??!?"), "no 'With a oil lantern??!?'")
	walk:play({ "turn on oil lantern", { "burn iron boiler with oil lantern", expect = "deep metallic thud" } })
	check(has(walk:choose("turn on iron boiler"), "already burning"), "the lit boiler says it is burning")
	check(has(typed("put lantern in boiler"), "carried by its handle"), "the lantern is not shut away")
end

-- The unlit wing never goes dark: no grue in the sanitarium.
do
	local walk, env, typed, enter, carry = start()
	carry(env.OIL_LANTERN)
	enter(env.BASEMENT_CORRIDOR)
	check(has(typed("north"), "working light"), "the flooded chamber needs a lit lantern")
	typed("turn on lantern")
	enter(env.ISOLATION_WARD)
	walk:choose("inventory")
	local text = walk:choose("turn off oil lantern")
	check(has(text, "only light"), "the lantern is not put out in the unlit wing")
	check(env.FSETQ(env.OIL_LANTERN, env.ONBIT), "the lantern stays lit")
	text = walk:choose("drop oil lantern")
	check(has(text, "only light") and env.LOC(env.OIL_LANTERN) == env.WINNER, "nor set down there")
	text = walk:choose("look")
	check(not has(text, "grue") and has(text, "Small cells"), "the ward is still seen")
	enter(env.OBSERVATION_DECK)
	walk:choose("inventory")
	check(has(walk:choose("drop oil lantern"), "Dropped"), "the lantern can be left in a lit room")
	text = walk:choose("west")
	check(has(text, "working light") and env.HERE == env.OBSERVATION_DECK,
		"without it the stairs down to the theater are refused")
	typed("take lantern")
	typed("turn off lantern")
	check(has(typed("west"), "working light"), "an unlit lantern is no light")
end

-- Electroshock theater and padded cell: sitting, moving, punctuation.
do
	local walk, env, typed, enter, carry = start()
	carry(env.OIL_LANTERN)
	typed("turn on lantern")
	enter(env.ELECTROSHOCK_THEATER)
	check(walk:offers("climb on shock chair") and not walk:offers("board shock chair"),
		"the chair offers sitting, not boarding")
	check(has(walk:choose("climb on shock chair"), "no desire to sit"), "sitting in the chair is refused in voice")
	check(has(walk:choose("move shock chair"), "bolted firmly"), "moving the chair finds it bolted")
	check(has(typed("pull chair"), "bolted firmly"), "so does PULL")
	walk:play({ "west" })
	local text = walk:choose("read rotting padding")
	check(has(text, "PATIENT 189.'") and not has(text, "'."), "the blood message ends once")
	enter(env.ADMINISTRATIVE_WING)
	text = walk:choose("read scattered papers")
	check(has(text, "OFF LIMITS.'") and not has(text, "'."), "the memo ends once")
end

-- Hydrotherapy and the steam door.
do
	local walk, env, typed, enter, carry = start()
	carry(env.OIL_LANTERN)
	typed("turn on lantern")
	env.VALVE_TURNED_FLAG, env.BOILER_LIT, env.BOILER_HEAT, env.CABINET_THAWED = true, true, 3, true
	enter(env.FLOODING_CHAMBER)
	check(has(typed("east"), "corroded shut"), "the sealed door says why east is closed")
	local text = walk:choose("open sealed door")
	check(walk:offers("east"), "the opened steam door links the way east")
	walk:play({ "east" })
	check(has(walk:choose("open porcelain tubs"), "large enough to immerse"), "opening the tubs looks in them")
	walk:play({ { "open medicine cabinet", expect = "syringe" } })
	text = walk:choose("look")
	check(not has(text, "contains:"), "tub and cabinet contents read as prose")
	check(has(text, "syringe") and has(text, "notebook"), "both finds are shown")
end

-- Cafeteria and garden.
do
	local walk, env, typed, enter = start()
	local text = enter(env.CAFETERIA)
	check(not has(text, "Sitting on the"), "the bell is told of in prose")
	text = walk:choose("ring service bell")
	check(has(text, "No one comes") and not has(text, "the Cafeteria"), "the bell does not echo through 'the Cafeteria'")
	walk:play({ "north" })
	text = walk:choose("north")
	check(has(text, "chapel door is locked"), "the locked chapel says so")
	check(not has(text, "can't go that way"), "not 'You can't go that way'")
end

-- Chapel: where the patient stands, what it needs, and what it is told.
do
	local walk, env, typed, enter, carry = start()
	carry(env.SCALPEL, env.SYRINGE, env.MORDECAI_JOURNAL, env.OIL_LANTERN)
	local text = enter(env.CHAPEL)
	check(has(text, "[[Something->patient]]") or has(walk.output, "[[Something->patient]]"), "the first sight links the figure")
	check(walk:offers("climb on wooden pews") and has(walk:choose("climb on wooden pews"), "You sit on one of the pews"),
		"the pews can be sat on")
	walk:choose("inventory")
	check(not walk:offers("inject patient patient with oil lantern"), "only the syringe injects")
	check(not walk:offers("tell patient patient about surgical scalpel"), "the scalpel is no topic")
	check(walk:offers("tell patient patient about doctor journal"), "the journal is a topic")
	local lore = env.PATIENT_LORE
	check(has(walk:choose("tell patient patient about doctor journal"), "Mordecai's name"), "the journal names Mordecai")
	check(env.PATIENT_LORE == lore + 1, "and counts as the Mordecai topic")
	walk:choose("tell patient patient about doctor journal")
	check(env.PATIENT_LORE == lore + 1, "once")
	text = walk:choose("inject patient patient with medical syringe")
	check(has(text, "chamber is empty"), "an empty syringe says so")
	carry(env.STRANGE_SERUM)
	text = typed("inject patient with syringe")
	check(has(text, "hold it still"), "without the relic the patient cannot be approached")
	-- The relic counts while it lies in the box the player carries.
	walk:play({ "look", { "open wooden box", expect = "ancient relic" }, "take wooden box" })
	check(env.LOC(env.ANCIENT_RELIC) == env.WOODEN_BOX and env.LOC(env.WOODEN_BOX) == env.WINNER, "relic in the carried box")
	env.MOVE(env.STRANGE_SERUM, env.MORGUE)
	text = typed("give relic to patient")
	check(has(text, "relic glows warm"), "a boxed relic is still the relic")
	check(not has(text, "words alone"), "not 'words alone won't end this'")
	text = typed("inventory")
	check(has(text, "A [[silver relic"), "inventory says 'A silver relic'")
	-- The patient follows into the garden and is described there, once.
	env.MOVE(env.PATIENT_189, env.OVERGROWN_GARDEN)
	text = typed("look")
	check(has(text, "stands empty") and not has(text, "standing at the altar"), "the chapel does not show an absent patient")
	text = enter(env.OVERGROWN_GARDEN)
	check(has(text, "[[Patient 189->patient]] stands among the dead roses") or has(walk.output, "[[Patient 189->patient]] stands among the dead roses"),
		"the garden links the patient who followed")
	check(not has(text, "standing at the altar"), "and does not put the altar in the garden")
	carry(env.STRANGE_SERUM, env.ANCIENT_RELIC)
	text = typed("inject patient with syringe")
	check(has(text, "at the altar") and not env.GAME_WON, "the ending waits for the chapel")
end

assert(#failures == 0, "\n" .. table.concat(failures, "\n"))
print(string.format("ok - blackwood-horror link regressions (%d checks)", checks))
