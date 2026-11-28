-- Exercise typed status through the real parser, not just the sheet renderer.
local Walk = require("tests.story_walk")

local function expect(walk, command, expected, absent)
	local output = assert(walk.game:resume(command))
	assert(output:find(expected, 1, true), command .. ": expected " .. expected .. "\n" .. output)
	if absent then
		assert(not output:find(absent, 1, true), command .. ": unexpectedly printed " .. absent .. "\n" .. output)
	end
	return output
end

local meridian = { choose = "choose arc", name = "name sheet", hero = "Ada Storm", named = "Ada Storm",
	  full = { "STATUS", "STAT", "STATS" }, compact = { "DIAGNOSE", "HEALTH" },
	  noHero = "Choose a character first.", noDiagnosis = "You have no ranks yet", profile = "Profile: Arc", rank = "Fighting: 20",
	  north = "north", saveTram = "rescue tram", failure = "failure",
	  resources = "Health: 85/90, Karma: 50", summary = "Health 85 of 90, Karma 50."
}

do
	local walk = Walk.new("books.blackout-at-meridian.blackout-at-meridian", 97)
	local env, rolls, events = walk.env, 0, 0
	env.math.random = function()
		rolls = rolls + 1
		return 1
	end
	expect(walk, meridian.full[1], meridian.noHero)
	expect(walk, meridian.compact[1], meridian.noDiagnosis or meridian.noHero)
	assert(env.MOVES == 0 and rolls == 0 and not env.ZIL_TRUE(env.CLOCK_WAIT))
	assert(walk.game:resume(meridian.name))
	expect(walk, meridian.hero, meridian.named)
	expect(walk, meridian.choose, meridian.rank)
	assert(env.MOVES == 0 and rolls == 0)
	assert(walk.game:resume(meridian.north))
	expect(walk, meridian.saveTram, meridian.failure)
	assert(env.MOVES == 2 and rolls == 1)

	env.ENABLE(env.QUEUE(function() events = events + 1 end, 1))
	for _, command in ipairs(meridian.full) do
		local output = expect(walk, command, meridian.resources)
		assert(output:find(meridian.named .. "\n" .. meridian.profile, 1, true), output)
		assert(output:find(meridian.rank, 1, true), output)
	end
	for _, command in ipairs(meridian.compact) do
		expect(walk, command, meridian.summary, meridian.rank)
	end
	assert(env.MOVES == 2 and rolls == 1 and events == 0 and not env.ZIL_TRUE(env.CLOCK_WAIT))
	expect(walk, meridian.saveTram, meridian.failure)
	assert(env.MOVES == 3 and rolls == 2 and events == 1, "status stole a real turn")
end

do
	local walk = Walk.new("books.the-water-that-answers.the-water-that-answers", 97)
	local env = walk.env
	expect(walk, "status", "Choose a character first.")
	expect(walk, "choose doctor", "old pumping station")
	local output = expect(walk, "status", "Profile: Doctor", "Karma")
	assert(output:find("Composure:", 1, true) and output:find("Medicine: 80", 1, true), output)
	expect(walk, "diagnose", "Composure ", "Medicine")
	expect(walk, "score", "Composure ", "Medicine")
	assert(env.MOVES == 0 and not env.ZIL_TRUE(env.CLOCK_WAIT))
	expect(walk, "east", "telephone")
	assert(env.MOVES == 1, "investigator SCORE must not stop the following turn")
end

print("RPG status: full and compact commands are live and free of turns, interrupts and dice")
