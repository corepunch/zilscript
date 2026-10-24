-- Round 3: a carried morphine vial must not swallow the glowing-serum link,
-- and the successful climax must enter FINISH rather than permit more turns.
local runtime = require("zilscript.runtime")
local Session = require("zilscript.reader.Session")
local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, { "books.blackwood-horror.blackwood-horror" }, { silent = true }))
env.PROSE_LINKS = true
local finishes = 0
local finish = env.FINISH
env.FINISH = function(...)
	finishes = finishes + 1
	return finish(...)
end
local game = runtime.create_game(env, true)
game:start()
local failures = {}
local function check(value, message)
	if not value then table.insert(failures, message) end
end
local function enter(room)
	env.HERE = room
	env.MOVE(env.WINNER, room)
end
local function actionsFor(output)
	local items = game:resume("room-items")
	for _, item in ipairs(game:resume("inventory-items")) do table.insert(items, item) end
	local session = Session.new()
	session.engine = {
		roomName = function() return env.HERE.DESC or "" end,
		items = function() return items end,
	}
	session:refreshEngineState()
	session:appendOutput(output, "Morgue")
	local actions = {}
	local _, links = Session.parseLinks(output)
	for _, link in ipairs(links) do
		for _, action in ipairs(session:linkActions(link.target)) do table.insert(actions, action) end
	end
	return actions
end
enter(env.MORGUE)
-- The deterministic low roll reproduced inherited random refusal with eight
-- clue/tool objects, even though their combined weight is below the limit.
env.RANDOM = function() return 1 end
for _, object in ipairs({ env.BRASS_KEY, env.SCALPEL, env.PATIENT_FILE,
	env.PATIENT_LEDGER, env.MORDECAI_NOTES, env.OBSERVATION_LOGBOOK,
	env.CHAPEL_KEY, env.MORPHINE_VIAL }) do env.MOVE(object, env.WINNER) end
local output = game:resume("open refrigerated drawers")
local found = false
for _, action in ipairs(actionsFor(output)) do
	if action.command == "take glowing serum" or action.command == "take strange serum" then
		found = true
		game:resume(action.command)
		break
	end
end
check(found, "The serum link offers its own take command while morphine is carried")
check(env.LOC(env.STRANGE_SERUM) == env.WINNER, "The linked command takes the actual serum")
check(env.LOC(env.MORPHINE_VIAL) == env.WINNER, "The linked command leaves morphine alone")
enter(env.CHAPEL)
output = game:resume("look")
check(output:find("[[south]]", 1, true), "The chapel return direction is linked")
env.MOVE(env.ANCIENT_RELIC, env.WINNER)
env.MOVE(env.STRANGE_SERUM, env.WINNER)
env.MOVE(env.SYRINGE, env.WINNER)
output = game:resume("inject patient with syringe")
check(env.GAME_WON, "The prepared injection records victory")
check(finishes == 1, "The successful climax calls FINISH exactly once")
check(not game:is_running(), "The successful climax ends the reader's game coroutine")
check(not output:find("Type RESTART", 1, true), "A finished link reader does not advertise unsupported parser controls")
assert(#failures == 0, table.concat(failures, "\n"))
print("Blackwood round 3 link identity and terminal ending: ok")
