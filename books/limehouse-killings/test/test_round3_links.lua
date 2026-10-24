-- Blind round 3 reached a complete case, but no accusation/proof was offered.
local runtime = require("zilscript.runtime")
local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, { "books.limehouse-killings.limehouse-killings" }, { silent = true }))
local game = runtime.create_game(env, true)
game:start()
local function hasAccusation(name)
	for _, item in ipairs(game:resume("room-items")) do
		if item[1]:lower() == name:lower() then
			for _, verb in ipairs(item[2]) do
				if verb == "ACCUSE" then return true end
			end
		end
	end
	return false
end
local function enter(room)
	env.HERE = room
	env.MOVE(env.WINNER, room)
end
enter(env.SERVANTS_QUARTERS)
assert(hasAccusation("Mr. Hudson"), "Hudson offers the actual accusation action")
enter(env.DINING_ROOM)
assert(hasAccusation("Lady Ashworth"), "Lady Ashworth offers the actual accusation action")
enter(env.LIBRARY)
assert(hasAccusation("Dr. Moriarty"), "Moriarty offers the actual accusation action")
local response = game:resume("accuse moriarty")
assert(response:find("only theatre", 1, true), "An early accusation keeps the inspector gate")
assert(not env.GAME_WON, "Declaring the affordance cannot bypass the investigation")
env.INSPECTOR_PRESENT = true
env.LETTER_PRESENTED, env.POISON_PRESENTED, env.MOTIVE_PRESENTED = true, true, true
response = game:resume("accuse moriarty")
assert(response:find("Which proof", 1, true), "A complete case requests the lead evidence")
assert(not env.GAME_WON, "An accusation without proof does not win")
enter(env.STUDY)
game:resume("take poison bottle")
enter(env.LIBRARY)
response = game:resume("accuse moriarty with poison bottle")
assert(response:find("THE LIMEHOUSE KILLINGS -- SOLVED", 1, true), "The supported proof action finishes the story")
assert(env.GAME_WON, "The ending records success")
print("Limehouse round 3 accusation affordances: ok")
