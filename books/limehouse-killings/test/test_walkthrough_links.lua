-- The Limehouse Killings from the gate to the arrest, played only through the
-- prose links and object menus a reader can tap (tests/link_walk.lua refuses
-- any command no menu offers).
-- Run from the zilscript directory:
--   lua books/limehouse-killings/test/test_walkthrough_links.lua
package.path = "./?.lua;./?/init.lua;" .. package.path
local Walk = require("tests.link_walk")

local walk = Walk.new("books.limehouse-killings.limehouse-killings", 97)
local env = walk.env

walk:play({
	{ "read creased telegram", expect = "name of the person it concerned" },
	"north",
	{ "open study door", expect = "need the study key" },
	{ "take magnifying glass", expect = "take the magnifying glass" },
	"east",
	{ "read torn page", expect = "red, yellow, green, blue" },
	{ "read secret ledger", expect = "UNPAID" },
	{ "examine colored ribbons", expect = "red book" },
	{ "push red book", expect = "clicks into place" },
	{ "push yellow book", expect = "clicks into place" },
	{ "push green book", expect = "clicks into place" },
	{ "push blue book", expect = "hidden stair" },
})
assert(env.CIPHER_SOLVED, "the four books open the passage")

-- The first interview: the topic Moriarty names is in his own menu.
walk:play({
	{ "tell dr moriarty", expect = "poison" },
	{ "tell dr moriarty about poison", expect = "walks out to the entrance hall" },
})
assert(env.MORIARTY_INTERVIEWED, "asking about poison is Moriarty's interview")
assert(env.LOC(env.DR_MORIARTY) == env.ASHWORTH_ENTRANCE_HALL, "Moriarty waits by the front door")

walk:play({
	"east",
	{ "up", expect = "chalk outline" },
	{ "examine mahogany desk", expect = "yellowed envelope" },
	{ "read unsent letter", expect = "expose you to Scotland Yard" },
	{ "read poison bottle", expect = "Wolfsbane" },
	{ "examine locked box", expect = "three names" },
	{ "align locked box to dr moriarty", expect = "purple-flower engraving" },
	{ "open study door", expect = "interior bolt" },
	"south",
	"west",
	{ "tell lady ashworth", expect = "alibi" },
	{ "tell lady ashworth about alibi", expect = "drawing room" },
	{ "show unsent letter to lady ashworth", expect = "burned the first draft" },
	"east",
	"down",
	"west",
	{ "examine overgrown hedges", expect = "knife" },
	{ "take blood-stained knife", expect = "take the knife" },
	"north",
	{ "examine plant labels", expect = "match the poison bottle label" },
})
assert(env.STUDY_UNLOCKED and env.LADY_INTERVIEWED and env.POISON_IDENTIFIED)
assert(not env.INSPECTOR_PRESENT, "Lestrade waits for the third interview")

walk:play({
	"south",
	"south",
	{ "tell mr hudson", expect = "The master, my alibi" },
	{ "tell mr hudson about alibi", expect = "Scotland Yard has arrived" },
	"north",
	"east",
	{ "up", expect = "Inspector Lestrade has arrived" },
	"north",
	{ "examine locked box", expect = "Dr. Moriarty" },
	{ "align locked box to lady ashworth", expect = "does not connect" },
	{ "align locked box to dr moriarty", expect = "bank statement" },
	{ "read bank statement", expect = "overdrawn" },
	"south",
	{ "accuse dr moriarty", expect = "not yet an argument" },
	{ "show unsent letter to inspector lestrade", expect = "first link" },
	{ "show poison bottle to inspector lestrade", expect = "second link" },
	{ "show bank statement to inspector lestrade", expect = "chain is complete" },
	{ "accuse dr moriarty", expect = "Which proof leads the charge" },
})
assert(env.INSPECTOR_PRESENT and env.LOCKED_BOX_OPENED)
assert(env.LETTER_PRESENTED and env.POISON_PRESENTED and env.MOTIVE_PRESENTED)
assert(walk:running() and not env.GAME_WON, "the charge still needs its leading proof")

walk:play({
	{ "accuse dr moriarty with unsent letter", expect = "THE LIMEHOUSE KILLINGS -- SOLVED" },
})
assert(walk.output:find("under arrest for the murder of Lord Ashworth", 1, true), "the arrest is told")
assert(walk.output:find("Score: 65 of 65", 1, true), "the ending reports the full score")
assert(walk.finishes == 1, "the ending is terminal")
assert(env.GAME_WON and env.CORRECT_ACCUSATION and env.KILLER_ACCUSED and env.GAME_ENDED, "the win is recorded")
assert(not walk:running() and #walk:menu() == 0, "nothing is offered after the ending")

print(string.format("ok - Limehouse Killings link walkthrough: solved in %d steps", walk.steps))
