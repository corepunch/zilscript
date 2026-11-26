-- Complete links-only walkthroughs of The Silent Vector, from the opening to
-- both final commitments, plus regressions for what a tapping reader tripped
-- over: stale descriptions, a default reply after Senn's, duplicated content
-- lists, menu actions that undid progress, and prose that named typed commands.
local Walk = require("tests.link_walk")

local function plain(walk)
	return (walk.output:gsub("%[%[([^%]]-)%->[^%]]-%]%]", "%1"):gsub("%[%[([^%]]-)%]%]", "%1"))
end

-- Chooses a link command and checks what it printed.
local function step(walk, command, expect, reject)
	local text = walk:choose(command)
	if expect then
		assert(text:find(expect, 1, true),
			string.format("\"%s\" should print \"%s\" but printed:\n%s", command, expect, text))
	end
	if reject then
		assert(not text:find(reject, 1, true),
			string.format("\"%s\" should not print \"%s\" but printed:\n%s", command, reject, text))
	end
	return text
end

local function prepare()
	local walk = Walk.new("books.en.silent-vector.silent-vector")
	local env = walk.env

	-- Cradle: the breaker's description follows its state.
	step(walk, "examine habitat breaker", "tripped, not broken")
	step(walk, "push habitat breaker", "one atmosphere")
	step(walk, "examine habitat breaker", "reset and holding", "tripped")
	step(walk, "north", "junction tastes")

	-- Torque shop: the recesses the room names are a link.
	step(walk, "west", "tool recesses")
	assert(not walk:offers("take torque wrench"), "The tools are discovered in the recesses")
	step(walk, "examine tool recesses", "long slot")
	step(walk, "take torque wrench", "Taken")
	step(walk, "take null spool", "Taken")
	step(walk, "examine tool recesses", "round slot is empty", "fills the round one")
	step(walk, "read protocol card", "FIT SPOOL TO BUS")
	step(walk, "east")

	-- Galley: a topic is asked about, not read.
	step(walk, "east", "portrait")
	step(walk, "examine operator ivo", "signal")
	assert(walk:offers("tell operator ivo about missing daughter"), "Ivo can be asked about the daughter")
	assert(not walk:offers("read missing daughter"), "A conversation topic offers no Read")

	-- Physical archive: the recorder is no longer sealed once it is open.
	step(walk, "east", "recorder")
	step(walk, "examine witness recorder", "sealed")
	step(walk, "open witness recorder", "witness strip")
	step(walk, "examine witness recorder", "lid stands open", "sealed")
	step(walk, "take witness strip", "Taken")
	step(walk, "examine witness recorder", "drum is bare", "Open it to recover")
	step(walk, "west")
	step(walk, "west")

	-- Clinic and laboratory.
	step(walk, "north", "examination area")
	step(walk, "examine examination area", "ceramic shears")
	step(walk, "take ceramic shears", "Taken")
	step(walk, "north", "comparator")
	step(walk, "examine optical comparator", "Comparing a witness strip", "COMPARE STRIP")
	step(walk, "compare optical comparator with witness strip", "Four breath loads")
	assert(env.PROOF, "The comparison establishes the proof")
	step(walk, "south")
	step(walk, "south", "measured breath-load")
	step(walk, "east")
	step(walk, "show witness strip to operator ivo", "consent to evacuation")
	assert(env.CONSENT, "Ivo consents")
	step(walk, "west")

	-- Coolant well.
	step(walk, "down", "draught")
	step(walk, "west", "pump")
	step(walk, "turn coolant pump with ceramic shears", "calibrated torque wrench", "TURN PUMP")
	step(walk, "turn coolant pump with torque wrench", "calibrated click")
	assert(env.COOLING, "The pump is sealed")
	step(walk, "east")

	-- Relay: the fitted spool is told once, by the room, and says it is fitted.
	step(walk, "east", "sings")
	step(walk, "fit incoming bus to null spool", "locks onto")
	step(walk, "look", "fitted null spool", "contains")
	step(walk, "examine null spool", "locked onto the bus termination", "Fit it to the bus before cutting")
	step(walk, "take null spool", "Leave it there")
	step(walk, "cut incoming bus with ceramic shears", "ceramic edges")
	assert(env.ISOLATED, "The bus is severed")
	step(walk, "look", "severed", "contains")

	-- Receiver vault: the receiver's description follows the open housing.
	step(walk, "north", "receiver")
	step(walk, "examine signal receiver", "can now open the housing")
	step(walk, "open signal receiver", "memory wafer")
	step(walk, "examine signal receiver", "housing stands open", "can now open")
	assert(not walk:offers("read memory wafer"), "Reading the wafer would pick it up; only Examine is offered")
	step(walk, "examine memory wafer", "RESCUE-COMPRESSION")
	assert(not walk.output:find("source.  You", 1, true), "The index and the memory are two paragraphs")
	assert(walk.output:find("power source.\n\nYou remember", 1, true), "The index and the memory are two paragraphs")
	assert(env.ORIGIN, "The origin index has been examined")
	step(walk, "take memory wafer", "Taken")
	step(walk, "examine signal receiver", "open and empty", "can now open")
	step(walk, "south")
	step(walk, "west")
	step(walk, "up", "syllable is gone")

	-- Quarantine: Senn's own description is the whole reply.
	step(walk, "north")
	step(walk, "north")
	step(walk, "east", "Senn")
	step(walk, "examine researcher senn", "palms apart", "nothing special")
	step(walk, "tell researcher senn about missing daughter", "Lena died at nine")
	step(walk, "examine researcher senn", "hands closed", "nothing special")

	-- Cold core: the archive's own text links the wafer to be put in it, the
	-- stored wafer is told once, and examining it leaves it stored.
	step(walk, "north", "breath hangs")
	step(walk, "examine cold archive", "memory wafer")
	assert(walk:offers("put memory wafer in cold archive"), "The archive's description offers the wafer")
	step(walk, "put memory wafer in cold archive", "Frost")
	step(walk, "look", "rests in cold", "contains")
	step(walk, "examine memory wafer", "RESCUE-COMPRESSION", "Taken")
	assert(env.LOC(env.WAFER) == env.COLD_ARCHIVE, "Examining the stored wafer leaves it in the archive")
	step(walk, "take memory wafer", "Taken")
	step(walk, "drop memory wafer", "Dropped")
	step(walk, "look", "memory wafer lies here")
	step(walk, "take memory wafer", "Taken")
	step(walk, "put memory wafer in cold archive", "Frost")
	step(walk, "examine decision console", "PRESERVE seals", "PRESERVE CONSOLE")
	assert(not plain(walk):find("ERASE CONSOLE", 1, true), "The console names its commitments, not typed commands")
	step(walk, "push decision console", "Choose PRESERVE or ERASE")
	step(walk, "preserve decision console", "Arm the rendezvous beacon")
	assert(walk.finishes == 0 and not env.RESOLVED, "A premature commitment does not end the story")

	-- Launch cupola.
	step(walk, "south")
	step(walk, "west")
	step(walk, "south")
	step(walk, "south")
	step(walk, "up", "stars")
	assert(walk:offers("examine distant stars"), "The stars are linked")
	step(walk, "push mechanical beacon", "arms with")
	assert(env.EVAC, "The beacon is armed")
	step(walk, "down", "Mara is waiting")
	step(walk, "north", "gone to the launch")
	step(walk, "north")
	step(walk, "east")
	step(walk, "north", "rests in cold")
	return walk
end

local preserve = prepare()
step(preserve, "preserve decision console", "ENDING: THE UNPLAYED WITNESS")
assert(preserve.output:find("next watch.\n\nEventually", 1, true), "The ending's last paragraph is its own paragraph")
assert(preserve.finishes == 1, "Preservation ends the story once")
assert(preserve.env.RESOLVED, "Preservation resolves the story")
assert(preserve.env.LOC(preserve.env.WAFER) == preserve.env.COLD_ARCHIVE, "The preserved wafer stays in the archive")
assert(#preserve:menu() == 0, "Nothing is offered after the ending")
local preserveSteps = preserve.steps

local erase = prepare()
step(erase, "erase decision console", "ENDING: FOUR PULSES")
assert(erase.finishes == 1, "Erasure ends the story once")
assert(erase.env.RESOLVED, "Erasure resolves the story")
assert(erase.env.LOC(erase.env.WAFER) ~= erase.env.COLD_ARCHIVE, "The erased wafer is gone from the archive")

-- Vocabulary: the reflector the beacon launches is the beacon's alone.
local parser = Walk.new("books.en.silent-vector.silent-vector")
parser.env.POWER = true
parser.env.HERE = parser.env.LAUNCH
parser.env.MOVE(parser.env.WINNER, parser.env.LAUNCH)
local reply = parser.game:resume("examine reflector")
assert(reply:find("passive reflector", 1, true) and not reply:find("Which", 1, true),
	"EXAMINE REFLECTOR names the beacon without asking which:\n" .. reply)
parser.env.HERE = parser.env.RELAY
parser.env.MOVE(parser.env.WINNER, parser.env.RELAY)
parser.env.MOVE(parser.env.SPOOL, parser.env.WINNER)
reply = parser.game:resume("put spool in bus")
assert(reply:find("Fit the spool to the bus", 1, true) and not reply:find("FIT SPOOL TO BUS", 1, true),
	"Putting the spool in the bus is answered in prose:\n" .. reply)

print(string.format("ok - silent-vector links walkthrough: %d steps to each ending, regressions pass", preserveSteps))
