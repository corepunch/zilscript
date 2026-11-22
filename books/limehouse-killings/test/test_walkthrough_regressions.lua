-- Regressions from a links-only QA playthrough of The Limehouse Killings.
-- Link steps go through tests/link_walk.lua; `say` types straight to the
-- parser where the point is vocabulary or scope.
-- Run from the zilscript directory:
--   lua books/limehouse-killings/test/test_walkthrough_regressions.lua
package.path = "./?.lua;./?/init.lua;" .. package.path
local Walk = require("tests.link_walk")
local MODULE = "books.limehouse-killings.limehouse-killings"

local function new() return Walk.new(MODULE, 97) end
local function say(walk, command) return tostring(walk.game:resume(command)) end
local function has(text, part, why)
	assert(text:find(part, 1, true), (why or "expected") .. ": \"" .. part .. "\" in:\n" .. text)
end
local function lacks(text, part, why)
	assert(not text:find(part, 1, true), (why or "unexpected") .. ": \"" .. part .. "\" in:\n" .. text)
end

-- 1. READ on a scenery object used to hang the game: the book redefined
--    GLOBAL-OBJECTS inside itself, so HELD? never reached the top of the tree.
do
	local walk = new()
	assert(walk.env.LOC(walk.env.GLOBAL_OBJECTS) ~= walk.env.GLOBAL_OBJECTS, "GLOBAL-OBJECTS is not its own parent")
	walk:play({ "north", "down", { "read blue kettle", expect = "TEA FIRST" }, { "drink blue kettle", expect = "strong tea" } })
end

-- 2. Every topic a witness names can be asked from that witness's menu.
do
	local walk = new()
	walk:play({ "north", "east", { "tell dr moriarty", expect = "experiments" } })
	assert(walk:offers("tell dr moriarty about medicinal experiments"), "experiments is offered")
	assert(walk:offers("tell dr moriarty about poison"), "poison is offered")
	walk:play({
		{ "examine poison", expect = "question to put to Dr. Moriarty" },
		{ "tell dr moriarty about reading desk", expect = "'I don't know anything about that,' says Moriarty" },
		{ "tell dr moriarty about poison", expect = "walks out to the entrance hall" },
	})
	lacks(walk:choose("look"), "Moriarty", "he has left the library")
	walk:play({ "west", { "tell dr moriarty", expect = "experiments" } })
	assert(walk:offers("tell dr moriarty about poison"), "the topics follow Moriarty to the hall")
	walk:play({ "west", { "tell lady ashworth", expect = "marriage" } })
	for _, topic in ipairs({ "marriage", "alibi", "case" }) do
		assert(walk:offers("tell lady ashworth about " .. topic), "Lady Ashworth offers " .. topic)
	end
	walk:play({
		{ "tell lady ashworth about marriage", expect = "did not kill my husband" },
		{ "tell lady ashworth about case", expect = "my husband's murder" },
		"east", "down", "west", "south",
		{ "tell mr hudson", expect = "The master, my alibi, the study key, or Dr. Moriarty" },
	})
	for _, topic in ipairs({ "master", "alibi", "study key", "dr moriarty" }) do
		assert(walk:offers("tell mr hudson about " .. topic), "Hudson offers " .. topic)
	end
	walk:play({
		{ "tell mr hudson about master", expect = "had enemies" },
		{ "tell mr hudson about dr moriarty", expect = "visited often" },
		{ "tell mr hudson about study key", expect = "He hands you the keyring" },
		{ "tell mr hudson about study keyring", expect = "long one on that ring" },
	})
	assert(walk.env.LOC(walk.env.KEYRING) == walk.env.WINNER, "Hudson's key is carried")
	-- 3. The key opens the study door without a separate UNLOCK step.
	walk:play({ "north", "east", "up", { "open study door", expect = "turns smoothly in the lock" }, "north" })
	assert(walk.env.HERE == walk.env.STUDY, "the hall door leads into the study")
end

-- 4. The name dial is solved from the box's own menu, and offers nothing else.
do
	local walk = new()
	walk.env.CIPHER_SOLVED = true
	walk:play({ "north", "east", "east", "up", { "examine study door", expect = "bolt shot home on this side" } })
	walk:choose("examine stone fireplace")
	has(walk:choose("examine locked box"), "Lady Ashworth, Mr. Hudson, or Dr. Moriarty", "the dial's names are listed")
	for _, name in ipairs({ "dr moriarty", "lady ashworth", "mr hudson" }) do
		assert(walk:offers("align locked box to " .. name), "the dial offers " .. name)
	end
	for _, action in ipairs(walk:menu()) do
		assert(not action.command:find("^turn locked box with"), "no TURN WITH on the dial: " .. action.command)
		assert(not action.command:find("^unlock locked box with"), "no UNLOCK WITH on the dial: " .. action.command)
	end
	walk:play({
		{ "align locked box to mr hudson", expect = "does not connect" },
		{ "examine mr hudson", expect = "shortest stretch of the dial" },
		{ "align locked box to dr moriarty", expect = "sealed-letter engraving" },
	})
	lacks(walk:choose("open locked box"), "TURN BOX", "no typed command in the hint")
	lacks(walk:choose("open tall window"), "OPEN WINDOW", "no typed command in the hint")
	has(say(walk, "turn box to moriarty"), "sealed-letter engraving", "TURN BOX TO still works when typed")
	has(say(walk, "examine engravings"), "name dial", "the engravings are the box")
	has(say(walk, "examine mantelpiece"), "study fireplace", "the mantelpiece is the fireplace")
	has(say(walk, "examine blood drops"), "chalk follows a body", "the drops belong to the outline")
end

-- 5. Menus offer a tool only where a tool makes sense.
do
	local walk = new()
	walk:play({ "read creased telegram", "north", "examine hall table", "take magnifying glass" })
	for _, action in ipairs(walk:menu()) do
		assert(not action.command:find("study door with", 1, true), "nothing carried fits the study door: " .. action.command)
	end
	walk:play({ "east", "examine reading desk", "read secret ledger", "inventory" })
	lacks(walk:choose("read secret ledger with magnifying glass"), "How does one look through", "the lens can be read through")
	has(walk:choose("use magnifying glass on secret ledger"), "nothing there that your unaided eye had missed")
	has(say(walk, "examine fireplace"), "library grate", "the library fire is not the study's")
	lacks(say(walk, "examine fireplace"), "box")
	has(say(walk, "examine open ledger"), "UNPAID")
	has(say(walk, "examine brass handle"), "magnifying glass")
end

-- 6. The solved bookcase stays in the fiction.
do
	local walk = new()
	walk:play({ "north", "east", "examine reading desk", "read torn page", "examine colored ribbons",
		"push red book", "push yellow book", "push green book", "push blue book" })
	local text = walk:choose("push floor-to-ceiling bookshelves")
	lacks(text, "already solved")
	has(text, "passage stands open")
	has(walk:choose("push red book"), "passage already stands open")
end

-- 7. Rooms and scenery follow what was taken, shown or dropped.
do
	local walk = new()
	walk.env.CIPHER_SOLVED = true
	walk:play({ "north", "east", "east", "up", "examine mahogany desk", "read unsent letter", "examine stone fireplace", "read poison bottle",
		"open study door", "south", "west", "show unsent letter to lady ashworth" })
	local room = walk:choose("look")
	lacks(room, "The letter rests", "the letter is still in the player's hands")
	has(room, "wedding ring")
	assert(walk.env.LOC(walk.env.DEAD_LETTER) == walk.env.WINNER, "showing the letter does not give it away")
	walk:play({ "north", "examine pantry shelves", "take dried foxglove", "take powdered charcoal" })
	local shelves = walk:choose("examine pantry shelves")
	has(shelves, "preserves and spices.")
	walk:play({ "south", "inventory", { "drop dried foxglove", expect = "drop" } })
	lacks(walk:choose("look"), "among the preserves", "a dropped bottle is not on the pantry shelf")
	walk:choose("north")
	has(say(walk, "examine foxglove"), "can't see any", "the foxglove is where it was dropped, not in the pantry")
	has(say(walk, "take charcoal"), "already have", "the carried tin is not also on the shelf")
	-- Reading the greenhouse label with the bottle in hand is the comparison.
	walk:play({ "south", "east", "down", "west", "north",
		{ "examine plant labels", expect = "match the poison bottle label" } })
	assert(walk.env.POISON_IDENTIFIED, "the labels identify the poison")
	walk:choose("inventory")
	has(walk:choose("use poison bottle on purple flowers"), "once more", "a second comparison is not told as the first")
	has(say(walk, "hint"), "interview every suspect")
	has(say(walk, "examine knife"), "can't see any", "the hidden knife is not in scope before the hedge is searched")
end

-- 8. Wrong accusations answer in the fiction and do not end the story.
do
	local walk = new()
	walk:play({ "north", "west", { "accuse lady ashworth", expect = "has an alibi" },
		"east", "east", { "accuse dr moriarty", expect = "no officer to hear it" },
		"west", "down", "west", "south", { "accuse mr hudson", expect = "in the servants' quarters" } })
	assert(walk:running() and walk.finishes == 0 and walk.env.WRONG_ATTEMPTS == 2)
end

-- 9. The commands a menu sends read like the prose that offered them.
do
	local walk = new()
	walk:play({ "north", "down", "west", "examine stone fountain", "examine overgrown hedges" })
	for _, command in ipairs({ "take plaster cast", "take blood-stained knife", "examine stone fountain", "examine overgrown hedges" }) do
		assert(walk:offers(command), "offered: " .. command)
	end
	walk:play({ "south" })
	walk:choose("examine wooden trunk")
	for _, command in ipairs({ "take oil lantern", "examine wooden trunk", "examine narrow beds" }) do
		assert(walk:offers(command), "offered: " .. command)
	end
end

print("ok - Limehouse Killings link regressions")
