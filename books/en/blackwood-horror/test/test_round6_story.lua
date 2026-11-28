-- Story and companion regressions.
local Walk = require("tests.story_walk")
local w = Walk.new("books.en.blackwood-horror.blackwood-horror", 97)
local env = w.env
local moves = env.MOVES
w:command("wait")
assert(env.MOVES == moves + 3, "silent callbacks must not stop WAIT after one tick")
w:play({
	"north", "north", "examine metal cabinet", "take surgical scalpel",
	"south", "east", "examine thick chains", "cut thick chains with surgical scalpel",
	"north",
})
assert(env.HERE == env.MORGUE and env.COLD_EXPOSURE == 1, "entering the morgue counts as one tick")

local function wait_for(marker, threshold)
	for _ = 1, 30 do
		local text = w:command("wait")
		if text:find(marker, 1, true) then
			assert(env.COLD_EXPOSURE == threshold, "WAIT ran past the cold threshold: " .. marker)
			return
		end
		assert(w:running(), "the player died before the warning: " .. marker)
	end
	error("no cold event: " .. marker)
end

wait_for("fingers are beginning to stiffen", 8)
wait_for("Staying here much longer", 16)
assert(w:command("south"):find("feeling slowly returns", 1, true), "the real escape route acknowledges recovery")
assert(env.HERE == env.PATIENT_WARD and env.COLD_EXPOSURE == 0, "the ward clears cold exposure")
assert(not w:command("look"):find("feeling slowly returns", 1, true), "recovery does not repeat")
w:command("north")
assert(env.COLD_EXPOSURE == 1, "a new exposure starts at one")
wait_for("fingers are beginning to stiffen", 8)
wait_for("Staying here much longer", 16)
wait_for("the cold has won", 25)
assert(w.finishes == 1 and not w:running(), "reader death must be terminal exactly once")
assert(not env.GAME_WON, "freezing is not the chapel ending")
print("ok - Blackwood cold warnings, retreat, re-entry and terminal death through typed commands")
