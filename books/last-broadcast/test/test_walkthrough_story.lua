-- Story and companion regressions.
local Walk = require("tests.story_walk")

local walk = Walk.new("books.last-broadcast.last-broadcast")
local env = walk.env

walk:play({
	{ "examine casebook", expect = "Reconstructing the casebook" },
	{ "hint casebook", expect = "voltage chart" },
	"north",
	{ "examine appeal board", expect = "9:21 Ruth discovers Vane" },
	"north",
	{ "examine julian body", expect = "Whatever made it had a matching notch" },
	{ "examine office clock", expect = "independent witness" },
	{ "open service hatch", expect = "will not open without it" },
	{ "down", expect = "bolted shut" },
	"south",
	"east",
	{ "examine ruth bell", expect = "announcer" },
	{ "tell ruth bell about red microphone", expect = "I thought the red meant live" },
	{ "examine red microphone", expect = "HEATER, not ON AIR" },
	"east",
	{ "examine spring-driven gramophone", expect = "pickup is bare" },
	{ "examine routing switch", expect = "found at DISC" },
	{ "push routing switch", expect = "routing lever" },
	{ "move routing switch", expect = "routing lever" },
	"north",
	{ "examine disc cutter", expect = "brass counterweight" },
	{ "take brass counterweight", expect = "Taken" },
	{ "examine brass counterweight", expect = "broken notch" },
	{ "examine cutter register", expect = "after hearing it" },
	"east",
	{ "examine cardboard sleeve", expect = "folded tight" },
	{ "open cardboard sleeve", expect = "lacquer disc" },
	{ "take lacquer disc", expect = "Taken" },
	{ "examine wage ledger", expect = "Mercer, H." },
	{ "take wage ledger", expect = "Taken" },
	"west",
	{ "compare cutter register with lacquer disc", expect = "hear what this disc actually contains" },
	"south",
	"south",
	"examine service workbench",
	{ "take playback stylus", expect = "Taken" },
	{ "take service spanner", expect = "Taken" },
	"down",
	{ "examine voltage chart", expect = "9:12" },
	{ "take voltage chart", expect = "Taken" },
	"north",
	{ "examine passage stain", expect = "precise enough to test" },
	{ "use service hatch with service spanner", expect = "bolt turns" },
	"up",
	{ "compare office clock with voltage chart", expect = "not a killing" },
	{ "examine office clock", expect = "power fault, not the death" },
	{ "compare julian body with brass counterweight", expect = "This is the weapon" },
	{ "examine julian body", expect = "counterweight made it" },
	"south",
	"west",
	{ "examine edith shaw", expect = "medical bag" },
	{ "open medical bag", expect = "bloodied dressing" },
	{ "examine bloodied dressing", expect = "initials R.B." },
	-- The dressing lies in the open bag: the refusal must say why.
	{ "take bloodied dressing", expect = "Taken" },
	{ "show bloodied dressing to edith shaw", expect = "Ruth Bell. Three fragments" },
	{ "examine bloodied dressing", expect = "named the patient" },
	"west",
	{ "examine telegraph receipt", expect = "Show it to Tomas" },
	{ "take telegraph receipt", expect = "Taken" },
	{ "show telegraph receipt to tomas vale", expect = "No interval remains" },
	{ "examine telegraph receipt", expect = "both sides of the strip" },
	{ "accuse tomas vale", expect = "accusation fails" },
	"up",
	"east",
	{ "examine ada mercer", expect = "roster" },
	{ "examine maintenance roster", expect = "9:15 inspection" },
	{ "examine leather boots", expect = "square leather repair" },
	{ "take leather boots", expect = "Taken" },
	{ "show wage ledger to ada mercer", expect = "father's name" },
	{ "accuse ada mercer", expect = "reconstruct it before making this charge" },
	"down",
	"east",
	"east",
	"inventory",
	{ "put lacquer disc in spring-driven gramophone", expect = "Done" },
	{ "play spring-driven gramophone", expect = "fit it to the gramophone" },
	{ "use playback stylus on spring-driven gramophone", expect = "ready to play" },
	"west", "east",
	{ "look", expect = "gramophone is ready to play" },
	{ "examine spring-driven gramophone", expect = "ready to play" },
	{ "play spring-driven gramophone", expect = "gull coughs twice" },
	-- The stylus on the pickup is reported as fitted, not as out of reach.
	{ "use playback stylus on spring-driven gramophone", expect = "already fitted" },
	{ "take lacquer disc", expect = "Taken" },
	"north",
	{ "compare cutter register with lacquer disc", expect = "A17, six minutes" },
	{ "examine cutter register", expect = "matched to the disc you heard" },
	"south",
	"west",
	{ "show lacquer disc to ruth bell", expect = "misunderstand" },
	{ "accuse ruth bell", expect = "tested account" },
	"east",
	"south",
	"down",
	"north",
	{ "compare passage stain with leather boots", expect = "diamond interruption exactly" },
	{ "examine passage stain", expect = "fills it exactly" },
	"inventory",
	{ "hint casebook", expect = "Reconstruct the casebook" },
	{ "reconstruct casebook", expect = "SOUND and PERSON" },
	"up",
	"south",
	"up",
	{ "accuse ada mercer", expect = "CASE SOLVED" },
})

assert(walk.finishes == 1, "the confession must end the story exactly once")
assert(env.LB_WON, "LB-WON must be set by the solved case")
assert(env.LB_RECONSTRUCTED and env.LB_CLOCK and env.LB_SOUND and env.LB_PROVENANCE
	and env.LB_ROUTE and env.LB_WEAPON and env.LB_TRACE and env.LB_RUTH_CLEARED
	and env.LB_EDITH_CLEARED and env.LB_TOMAS_CLEARED and env.LB_MOTIVE,
	"every evidence gate must be established by the typed route")
local steps = walk.steps

-- Off-path replies and vocabulary, on a fresh play.
local side = Walk.new("books.last-broadcast.last-broadcast")
local function typed(command, expect)
	local output = side.game:resume(command)
	assert(type(output) == "string" and output:find(expect, 1, true),
		string.format("\"%s\" should print \"%s\" but printed:\n%s", command, expect, tostring(output)))
	side:record(output)
end
local function prose(command, forbidden)
	local output = side:command(command)
	assert(not output:find(forbidden, 1, true),
		string.format("\"%s\" must not print \"%s\":\n%s", command, forbidden, output))
end
-- Prose speaks to a reader who taps, not to one who types commands.
prose("examine casebook", "HINT CASEBOOK")
prose("reconstruct casebook", "HINT CASEBOOK")
typed("examine notes", "two columns")
side:play({ "north", "north" })
-- The dead man is "Vane" in his own office; the wound and clock parts answer.
typed("examine vane", "One blow behind the ear")
typed("examine brass dust", "skin is entirely clean")
typed("examine stopped hands", "reads 9:12")
typed("examine winding knob", "stamped SET")
side:play({ "south", "east", { "examine ruth bell", expect = "Vane" } })
-- Vane and the broadcast are topics, not documents.



typed("examine tiny plate", "HEATER")
side:play({ "east" })
prose("examine spring-driven gramophone", "USE STYLUS")
prose("play spring-driven gramophone", "USE STYLUS")

typed("pull routing switch", "routing lever")
typed("examine pickup", "pickup is bare")
typed("examine wax dab", "edges meet at DISC")
side:play({ "north", "examine disc cutter" })
typed("examine cover", "inspection cover lifts")
typed("examine retaining lug", "retaining lug")
-- An exhibit lying on the floor is refused for the true reason.
-- The menu offers Show only for what is carried; a typed try says why.
side:play({ "south", "west", "west", "west", "west", "examine telegraph receipt" })

typed("show telegraph receipt to tomas vale", "in hand first")
assert(not side.env.LB_TOMAS_CLEARED, "an unheld receipt clears nobody")
side:play({ "up", "east" })
typed("examine left heel", "square leather repair")
-- Lowering an open hatch still works, and only then.
side.env.FSET(side.env.LB_HATCH, side.env.OPENBIT)
side:play({ "down", "north", { "close service hatch", expect = "bolt falls home" } })
-- The menu no longer offers to lower a bolted hatch; a typed try is refused.

typed("close service hatch", "already bolted shut")

print(string.format("ok - Last Broadcast: typed walkthrough solves the case in %d steps; state prose and off-path replies pass", steps))
