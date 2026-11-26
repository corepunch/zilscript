-- Regressions from a QA playthrough of The Midnight Ledger: nouns the prose
-- names answer as objects, natural verbs reach the book's replies, and a
-- restored game keeps the evidence it had.
-- Run from the zilscript directory:
--   lua5.4 books/the-midnight-ledger/test/test_walkthrough_regressions.lua
package.path = "./?.lua;./?/init.lua;" .. package.path
local Walk = require("tests.link_walk")
local MODULE = "books.the-midnight-ledger.the-midnight-ledger"

local function say(walk, command) return tostring(walk.game:resume(command)) end
local function has(walk, command, part)
	local text = say(walk, command)
	assert(text:find(part, 1, true), command .. ": expected \"" .. part .. "\" in:\n" .. text)
	return text
end
local function lacks(walk, command, part)
	local text = say(walk, command)
	assert(not text:find(part, 1, true), command .. ": unexpected \"" .. part .. "\" in:\n" .. text)
	return text
end

local walk = Walk.new(MODULE, 97)
-- Sitting alone used to ask "What do you want to sit with?"
has(walk, "sit", "nothing here to sit on")
has(walk, "east", "Porter Ives")
-- Radiator had the pegs' text; the pocket things were unknown words.
has(walk, "examine radiator", "iron radiator")
has(walk, "search coat", "dispatch [[chalk]]")
has(walk, "examine chalk", "tram ticket")
has(walk, "eat sweet", "Leave a man his sweet")
-- ATTACK needed a weapon, so it never reached the actors.
lacks(walk, "attack ives", "What do you want")
has(walk, "hit ives", "hard enough on him")
has(walk, "west", "vestibule")
has(walk, "north", "hearing chamber")
has(walk, "sit", "first time you have sat down")
has(walk, "examine papers", "blank finding form")
has(walk, "take pen", "Mine")
has(walk, "east", "records room")
-- "take key" used to say the cabinet was screwed to the wall.
has(walk, "take key", "keys stay on their hooks")
has(walk, "examine tag", "Orr's tag")
assert(walk.env.CAB_SEEN, "examining the keys establishes the cabinet evidence")
has(walk, "close cabinet", "push the door to")
-- OPEN was an adjective of the grille, so after "unlock cabinet" asked
-- "with what?", "open cabinet" was read as the answer.
has(walk, "unlock cabinet", "What do you want to unlock")
has(walk, "open cabinet", "clink on their hooks")
has(walk, "open grille", "already open")
has(walk, "north", "transit cage")
has(walk, "examine felt", "felt corners")
has(walk, "examine oil", "hinge pin")
has(walk, "examine wire", "wire mesh")
has(walk, "close crate", "lid down")
has(walk, "take crate", "stays in the cage")
has(walk, "south", "records room")
has(walk, "west", "hearing chamber")
has(walk, "west", "weigh room")
has(walk, "take strip", "stays on the printer")
has(walk, "examine tube", "speaking tube")
has(walk, "east", "hearing chamber")
has(walk, "north", "document [[sleeve]]")
has(walk, "examine sleeve", "fatter than valuations")
has(walk, "take sleeve", "stay with me")

-- Save, gather evidence, restore: the evidence gathered after the save is gone
-- and the hint asks for it again.
has(walk, "save", "Ok")
has(walk, "read register", "11:55")
assert(walk.env.REG_READ)
has(walk, "restore", "Ok")
assert(not walk.env.REG_READ, "restore rewinds the register reading")
has(walk, "south", "hearing chamber")
has(walk, "hint", "Compare the scale")
print("ok - the-midnight-ledger regressions")
