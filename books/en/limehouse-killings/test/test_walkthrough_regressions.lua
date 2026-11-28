-- Story regressions for The Limehouse Killings.
-- Run from the zilscript directory:
--   lua books/en/limehouse-killings/test/test_walkthrough_regressions.lua
package.path = "./?.lua;./?/init.lua;" .. package.path
local Walk = require("tests.story_walk")
local MODULE = "books.en.limehouse-killings.limehouse-killings"

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
	walk:play({
		{ "examine poison", expect = "question to put to Dr. Moriarty" },
		{ "tell dr moriarty about reading desk", expect = "I don't know anything about that,” says Moriarty" },
		{ "tell dr moriarty about poison", expect = "walks out to the entrance hall" },
	})
	lacks(walk:command("look"), "Moriarty", "he has left the library")
	walk:play({ "west", { "tell dr moriarty", expect = "experiments" } })
	walk:play({ "west", { "tell lady ashworth", expect = "marriage" } })
	walk:play({
		{ "tell lady ashworth about marriage", expect = "did not kill my husband" },
		{ "tell lady ashworth about case", expect = "my husband's murder" },
		"east", "down", "west", "south",
		{ "tell mr hudson", expect = "The master, my alibi, the study key, or Dr. Moriarty" },
	})
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
	walk:command("examine stone fireplace")
	has(walk:command("examine locked box"), "Lady Ashworth, Mr. Hudson, or Dr. Moriarty", "the dial's names are listed")
	walk:play({
		{ "align locked box to mr hudson", expect = "does not connect" },
		{ "examine mr hudson", expect = "shortest stretch of the dial" },
		{ "align locked box to dr moriarty", expect = "sealed-letter engraving" },
	})
	lacks(walk:command("open locked box"), "TURN BOX", "no typed command in the hint")
	lacks(walk:command("open tall window"), "OPEN WINDOW", "no typed command in the hint")
	has(say(walk, "turn box to moriarty"), "sealed-letter engraving", "TURN BOX TO still works when typed")
	has(say(walk, "examine engravings"), "name dial", "the engravings are the box")
	has(say(walk, "examine mantelpiece"), "study fireplace", "the mantelpiece is the fireplace")
	has(say(walk, "examine blood drops"), "chalk follows a body", "the drops belong to the outline")
end

-- 5. Menus offer a tool only where a tool makes sense.
do
	local walk = new()
	walk:play({ "read creased telegram", "north", "examine hall table", "take magnifying glass" })
	walk:play({ "east", "examine reading desk", "read secret ledger", "inventory" })
	lacks(walk:command("read secret ledger with magnifying glass"), "How does one look through", "the lens can be read through")
	has(walk:command("use magnifying glass on secret ledger"), "the last word has bitten clear through the paper")
	has(say(walk, "examine fireplace"), "library grate", "the library fire is not the study's")
	lacks(say(walk, "examine fireplace"), "box")
	has(say(walk, "examine leather-bound ledger"), "UNPAID")
	has(say(walk, "examine brass handle"), "magnifying glass")
end

-- 6. The solved bookcase stays in the fiction.
do
	local walk = new()
	walk:play({ "north", "east", "examine reading desk", "read torn page", "examine colored ribbons",
		"push red book", "push yellow book", "push green book", "push blue book" })
	local text = walk:command("push floor-to-ceiling bookshelves")
	lacks(text, "already solved")
	has(text, "passage stands open")
	has(walk:command("push red book"), "passage already stands open")
end

-- 7. Rooms and scenery follow what was taken, shown or dropped.
do
	local walk = new()
	walk.env.CIPHER_SOLVED = true
	walk:play({ "north", "east", "east", "up", "examine mahogany desk", "read unsent letter", "examine stone fireplace", "read poison bottle",
		"open study door", "south", "west", "show unsent letter to lady ashworth" })
	local room = walk:command("look")
	lacks(room, "The letter rests", "the letter is still in the player's hands")
	has(room, "wedding ring")
	assert(walk.env.LOC(walk.env.DEAD_LETTER) == walk.env.WINNER, "showing the letter does not give it away")
	walk:play({ "north", "examine pantry shelves", "take dried foxglove", "take powdered charcoal" })
	local shelves = walk:command("examine pantry shelves")
	has(shelves, "preserves and spices.")
	walk:play({ "south", "inventory", { "drop dried foxglove", expect = "drop" } })
	lacks(walk:command("look"), "among the preserves", "a dropped bottle is not on the pantry shelf")
	walk:command("north")
	has(say(walk, "examine foxglove"), "can't see any", "the foxglove is where it was dropped, not in the pantry")
	has(say(walk, "take charcoal"), "already have", "the carried tin is not also on the shelf")
	-- Reading the greenhouse label with the bottle in hand is the comparison.
	walk:play({ "south", "east", "down", "west", "north",
		{ "examine plant labels", expect = "match the poison bottle label" } })
	assert(walk.env.POISON_IDENTIFIED, "the labels identify the poison")
	walk:command("inventory")
	has(walk:command("use poison bottle on purple flowers"), "once more", "a second comparison is not told as the first")
	has(say(walk, "hint"), "interview every suspect")
	has(say(walk, "examine knife"), "can't see any", "the hidden knife is not in scope before the hedge is searched")
end

-- 8. Wrong accusations answer in the fiction and do not end the story.
do
	local walk = new()
	walk:play({ "north", "west", { "accuse lady ashworth", expect = "has an alibi" },
		"tell lady ashworth", "tell lady ashworth about alibi", "east", "east" })
	local reply = walk:command("accuse dr moriarty")
	has(reply, "no officer to hear it")
	has(reply, "Ask Moriarty about the poison")
	has(reply, "Ask Mr. Hudson in the servants' quarters for his alibi")
	has(reply, "found 0 of the three pieces")
	lacks(reply, "Ask Lady Ashworth")
	walk:play({ "west", "down", "west", "south", { "accuse mr hudson", expect = "in the servants' quarters" } })
	assert(walk:running() and walk.finishes == 0 and walk.env.WRONG_ATTEMPTS == 2)
end

-- 9. The commands a menu sends read like the prose that offered them.
do
	local walk = new()
	walk:play({ "north", "down", "west", "examine stone fountain", "examine overgrown hedges" })
	walk:play({ "south" })
	walk:command("examine wooden trunk")
end

-- 10. A second QA pass: vocabulary collisions, absent witnesses, natural verbs.
do
	local walk = new()
	-- "i" was a dead word: INVENTORY as a noun of the wine-cabinet entry split
	-- it from its verb, so "i" printed "There was no verb in that sentence!"
	has(say(walk, "i"), "You are carrying")
	has(say(walk, "help"), "Hint:")
	for _, c in ipairs({ "north" }) do say(walk, c) end
	-- OPEN was also an adjective, so after the parser asked "unlock ... with
	-- what?", "open study door" was taken as the answer.
	has(say(walk, "unlock study door"), "What do you want to unlock")
	has(say(walk, "open study door"), "study door is locked")
	for _, c in ipairs({ "east" }) do say(walk, c) end
	lacks(say(walk, "attack moriarty"), "What do you want", "attacking a witness needs no weapon")
	has(say(walk, "read titles"), "Gilt titles")
	has(say(walk, "tell dr moriarty about poison"), "walks out to the entrance hall")
	-- Moriarty has left; his name still reaches him, not "the Moriarty".
	has(say(walk, "ask moriarty"), "Dr. Moriarty is not here")
	for _, c in ipairs({ "read secret ledger" }) do say(walk, c) end
	has(say(walk, "show secret ledger to moriarty"), "not here to see it")
	for _, c in ipairs({ "west" }) do say(walk, c) end
	has(say(walk, "show secret ledger to moriarty"), "Where did you find that")
	has(say(walk, "ask moriarty about hudson"), "He's a servant")
	has(say(walk, "ask moriarty about lady ashworth"), "difficult marriage")
	for _, c in ipairs({ "west" }) do say(walk, c) end
	has(say(walk, "ask lady ashworth about moriarty"), "owed him money")
	has(say(walk, "ask lady ashworth about hudson"), "Loyal, but nervous")
	has(say(walk, "ask lady ashworth about husband"), "easy one to owe")
	has(say(walk, "ask lady ashworth about poison"), "know nothing of such things")
	has(say(walk, "accuse hudson"), "Mr. Hudson is not here")
	for _, c in ipairs({ "north" }) do say(walk, c) end
	for _, c in ipairs({ "take dried foxglove", "take powdered charcoal" }) do say(walk, c) end
	has(say(walk, "read foxglove"), "digitalis")
	has(say(walk, "read charcoal"), "swallowed poisons")
	for _, c in ipairs({ "south", "east", "down" }) do say(walk, c) end
	has(say(walk, "ring bell"), "distant bell rings")
	for _, c in ipairs({ "west", "south" }) do say(walk, c) end
	-- Folded note and unsent letter no longer share their nouns.
	for _, c in ipairs({ "examine wooden trunk", "take folded note" }) do say(walk, c) end
	lacks(say(walk, "read note"), "Which note", "the note is the folded note")
end

-- 11. The wolfsbane warns plainly before it kills, charcoal recovers, and
--     a third taste ends the story through FINISH.
do
	local walk = new()
	walk.env.MOVE(walk.env.POISON_BOTTLE, walk.env.WINNER)
	walk.env.MOVE(walk.env.CHARCOAL, walk.env.WINNER)
	has(say(walk, "taste poison bottle"), "perhaps that wasn't wise")
	has(say(walk, "drink poison bottle"), "One more taste")
	has(say(walk, "eat powdered charcoal"), "dizziness recedes")
	assert(walk.env.PLAYER_HEALTH == 2, "charcoal restores one step")
	say(walk, "taste poison bottle")
	assert(walk:running(), "two tastes after the charcoal are survivable")
	has(say(walk, "taste poison bottle"), "UNSOLVED")
	assert(walk.env.GAME_LOST and walk.finishes == 1, "death ends the story")
end

-- 12. Hints name the next step of the case, not one generic line.
do
	local walk = new()
	has(say(walk, "hint"), "study is locked")
	walk.env.STUDY_UNLOCKED = true
	has(say(walk, "hint"), "study desk")
	walk.env.DEAD_LETTER_FOUND = true
	walk.env.POISON_IDENTIFIED = true
	has(say(walk, "hint"), "ask him about poison")
	walk.env.MORIARTY_INTERVIEWED, walk.env.LADY_INTERVIEWED, walk.env.HUDSON_INTERVIEWED = true, true, true
	has(say(walk, "hint"), "at least three pieces of evidence")
	walk.env.INSPECTOR_PRESENT = true
	has(say(walk, "hint"), "box in the study fireplace")
	walk.env.BANK_STATEMENT_FOUND = true
	has(say(walk, "hint"), "show him the threat")
	walk.env.LETTER_PRESENTED, walk.env.POISON_PRESENTED, walk.env.MOTIVE_PRESENTED = true, true, true
	has(say(walk, "hint"), "accuse Dr. Moriarty")
end

-- 13. The right order opens the shelf without the torn page in hand, and the
--     chair the furrow points to is in the study.
do
	local walk = new()
	for _, c in ipairs({ "north", "east", "push red book", "push yellow book", "push green book" }) do say(walk, c) end
	has(say(walk, "push blue book"), "shelving slides aside")
	assert(walk.env.CIPHER_SOLVED, "the cipher is solved by the order alone")
	for _, c in ipairs({ "east", "up" }) do say(walk, c) end
	has(say(walk, "examine chair"), "stands by the hearth")
	has(say(walk, "take chair"), "leave the chair")
	has(say(walk, "look in fireplace"), "cold ashes")
end

print("ok - Limehouse Killings story regressions")
