-- A complete playthrough by prose links and object menus alone, from the gate
-- to the ending in which the player is made whole. Every step is a command
-- the reader offers at that moment; tests/link_walk.lua refuses any other.
package.path = "./?.lua;./?/init.lua;" .. package.path
local Walk = require("tests.link_walk")
local walk = Walk.new("books.en.blackwood-horror.blackwood-horror", 97)
local env = walk.env

walk:play({
	"north",
	"west",
	-- Reception: the key under the papers opens the numbered drawer.
	{ "examine scattered papers", expect = "brass key" },
	{ "take reception key", expect = "Taken" },
	{ "examine heavy desk", expect = "number 3" },
	{ "open bottom drawer", expect = "patient file" },
	{ "read patient file", expect = "transferred to chapel" },
	"east",
	"north",
	-- Operating theater: the blade.
	{ "examine metal cabinet", expect = "scalpel" },
	{ "take surgical scalpel", expect = "Taken" },
	"south",
	"east",
	-- Patient ward: the strap that holds the morgue shut.
	{ "examine thick chains", expect = "narrow blade" },
	{ "cut thick chains with surgical scalpel", expect = "strap parts" },
	"north",
	-- Morgue: Compound 237 and the doctor's journal.
	{ "examine refrigerated drawers", expect = "glowing serum" },
	{ "take strange serum", expect = "Taken" },
	"examine dissection table",
	{ "read doctor journal", expect = "terrible mistake" },
	"south",
	"west",
	"down",
	"down",
	-- Basement: valve, lantern, coal, fire.
	{ "turn pipe valve", expect = "shriek of metal" },
	"west",
	{ "examine sagging shelves", expect = "lantern" },
	{ "take oil lantern", expect = "Taken" },
	{ "turn on oil lantern", expect = "wick catches" },
	"east",
	"east",
	{ "examine iron boiler", expect = "coal shovel" },
	{ "take coal shovel", expect = "Taken" },
	{ "examine coal bin", expect = "lump of coal" },
	{ "take black coal", expect = "Using the shovel" },
	{ "put black coal in iron boiler", expect = "firebox" },
	{ "burn iron boiler with oil lantern", expect = "deep metallic thud" },
	"drop coal shovel",
	"west",
	{ "north", expect = "vast, flooded chamber" },
	-- Steam frees the door; the boiler's heat has thawed the cabinet beyond.
	{ "open sealed door", expect = "wrench the sealed door open" },
	"east",
	{ "open medicine cabinet", expect = "syringe" },
	{ "take medical syringe", expect = "Taken" },
	"west",
	"north",
	{ "read wall scratches", expect = "remember" },
	"north",
	"west",
	{ "examine strait straitjacket", expect = "familiar" },
	{ "take strait straitjacket", expect = "Taken" },
	"east",
	"east",
	"north",
	"east",
	-- Director's office: hollow book, safe, chapel key.
	"examine massive desk",
	{ "open red book", expect = "hollow hiding place" },
	{ "examine red book", expect = "fits the hollow exactly" },
	{ "examine glued pages", expect = "hug the teeth" },
	{ "take safe key", expect = "Taken" },
	{ "examine safe key", expect = "S-001" },
	{ "examine numbered tag", expect = "two zeroes" },
	{ "examine red book", expect = "rusty outline" },
	{ "examine glued pages", expect = "three little steps" },
	{ "examine mordecai portrait", expect = "wall safe" },
	{ "open wall safe", expect = "chapel key" },
	{ "take chapel key", expect = "Taken" },
	"west",
	"north",
	"west",
	"north",
	{ "open chapel door", expect = "heavy clunk" },
	{ "north", expect = "standing at the altar" },
	-- Chapel: the relic, what the patient remembers, and the dose.
	"examine wooden pews",
	{ "open wooden box", expect = "ancient relic" },
	{ "examine wooden box", expect = "silver cross fitted into the lining" },
	{ "examine box lining", expect = "tips of the cross" },
	{ "take ancient relic", expect = "Taken" },
	{ "examine wooden box", expect = "cross-shaped hollow" },
	{ "examine box lining", expect = "faded to grey" },
	{ "tell patient patient about doctor journal", expect = "Mordecai's name" },
	{ "tell patient patient about strait straitjacket", expect = "remember" },
	{ "inject patient patient with medical syringe", expect = "you are whole" },
})

assert(walk.finishes == 1, "the ending calls FINISH exactly once")
assert(env.GAME_WON, "GAME-WON is set")
assert(env.PATIENT_STATE == 3, "Patient 189 is liberated")
assert(env.PATIENT_LORE > 4, "the links alone gather enough lore for the full ending")
assert(not walk:running(), "the story is over")
assert(#walk:menu() == 0, "a finished story offers nothing more")
assert(walk.output:find("You're free", 1, true), "the ending prose is printed")
assert(not walk.output:find("RESTART", 1, true), "the ending does not address a typing player")
print(string.format("ok - blackwood-horror links-only walkthrough wins in %d steps", walk.steps))
