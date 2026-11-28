local Walk = require("tests.story_walk")

local cases = {
		choose = "choose storm", examine = "examine marvel", north = "north", rescue = "focus skiff",
		reassurance = "The rope is holding for now", cost = "You lose 5 Health",
	}

local words = cases
do
	local walk = Walk.new("books.last-door-of-battleworld.last-door-of-battleworld", 97)
	local env = walk.env
	walk.game:resume(words.choose)
	assert(env.RPG_PRESET_INDEX == 2)
	env.MOVE(env.WINNER, env.CAMP)
	env.HERE = env.CAMP
	local advice = walk.game:resume(words.examine)
	assert(advice:find(words.reassurance, 1, true), advice)

	walk.game:resume(words.north)
	assert(env.HERE == env.SPAN)
	env.math.random = function() return 1 end
	local health = env.STAT(env.HERO, env.A_HEALTH)
	local setback = walk.game:resume(words.rescue)
	assert(setback:find(words.cost, 1, true), setback)
	assert(env.STAT(env.HERO, env.A_HEALTH) == health - 5 and not env.EVACUATED)
end

print("ok - Battleworld rescue advice and five-point setback")
