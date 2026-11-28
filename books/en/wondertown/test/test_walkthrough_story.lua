-- Story and companion regressions.
package.path = "./?.lua;./?/init.lua;" .. package.path
local Walk = require("tests.story_walk")

local walk = Walk.new("books.en.wondertown.wondertown", 97)
walk:play({
	-- Workshop: the oil can under the bench frees the loft ladder.
	{ "examine enormous bench", expect = "tiny copper oil can" },
	{ "take tiny can", expect = "Taken" },
	{ "examine folding ladder", expect = "rusted solid" },
	{ "lubricate rusty mechanism", expect = "loosens" },
	{ "climb folding ladder", expect = "storage loft" },
	{ "wind old clock", expect = "only the fox knows how to open it" },
	{ "open dusty box", expect = "porcelain doll arm" },
	{ "take porcelain arm", expect = "Taken" },
	"down",
	-- Tool bench: the key in the nutcracker's back winds him where it sits.
	{ "east", expect = "in his back" },
	{ "wind painted nutcracker", expect = "at your service" },
	{ "ask bertrand about heart", expect = "heart needs company" },
	{ "climb makeshift steps", expect = "toy display" },
	"examine rag doll",
	{ "take spare button", expect = "Taken" },
	{ "give spare button to rag doll", expect = "hidden latch" },
	{ "open dusty case", expect = "opens the display case" },
	{ "take tin soldier", expect = "Taken" },
	{ "take music box", expect = "Taken" },
	"down",
	"west",
	-- Wrenfold by night.
	{ "north", expect = "footprints cross the snow" },
	{ "east", expect = "just out of reach" },
	{ "wind brass mechanism", expect = "extra hours" },
	{ "east", expect = "mailbox" },
	"examine red mailbox",
	{ "take red scarf", expect = "Taken" },
	"west",
	{ "south", expect = "something pale shows through" },
	{ "examine broken piles", expect = "doll head" },
	{ "take doll head", expect = "Taken" },
	{ "give doll head to scrap cart", expect = "rolls aside" },
	-- The fox gives up the key once she has been shown kindness.
	{ "east", expect = "ticks faintly around her neck" },
	"examine cosy bed",
	{ "take red ball", expect = "Taken" },
	{ "give red ball to patchy fox", expect = "her paw twitches" },
	{ "inventory", expect = "red wool scarf" },
	{ "give red scarf to patchy fox", expect = "Thank you" },
	{ "take workshop key", expect = "Take it" },
	"west",
	"north",
	"west",
	"south",
	-- Old Tick calls Nutmeg to the latch; the workshop clock swings open.
	"climb folding ladder",
	{ "wind old clock", expect = "It has swung open" },
	{ "down", expect = "lead into the study" },
	{ "enter old clock", expect = "chair" },
	"examine wooden desk",
	{ "examine winding diagram", expect = "surround the heart with companions" },
	{ "down", expect = "keyhole waits" },
	{ "wind giant mechanism", expect = "PLACE TIN SOLDIER BESIDE HEART" },
	"look",
	{ "examine workshop key", expect = "one notch" },
	{ "position music box", expect = "Let me help" },
	"look",
	{ "examine music box", expect = "plucks the next note" },
	{ "examine brass tooth", expect = "feel it trembling" },
	"drop tin soldier",
	{ "position tin soldier", expect = "must carry that companion" },
	"take tin soldier",
	{ "place tin soldier beside heart", expect = "Pip has restored the heart of Wrenfold" },
})

local env = walk.env
assert(walk.output:find("wooden bear lifts one paw", 1, true), "The music box earns a visible payoff")
assert(walk.output:find("newly waking toys return his silent salute", 1, true), "The tin soldier earns a visible payoff")
assert(walk.finishes == 1, "The winning scene ends the story exactly once")
assert(not walk:running(), "Nothing is offered after the ending")
assert(env.GAME_WON, "GAME-WON is set")
assert(env.ENDING_TIER == 3, "The full rewind is ending tier 3")
assert(env.KEY_FOUND and env.KEY_WOUND, "The workshop key was found and wound into the heart")
assert(env.NUTMEG_SAVED, "Nutmeg joined the heart")
assert(env.COMPANION_COUNT == 3, "Music box, Nutmeg and the tin soldier lend their strength")
print(string.format("Wondertown typed walkthrough: ok (%d steps)", walk.steps))
