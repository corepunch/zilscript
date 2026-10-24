-- Book-owned binary relationships; the shared reader enforces real scope.
local runtime = require("zilscript.runtime")
local Session = require("zilscript.reader.Session")
local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, { "books.last-broadcast.last-broadcast" }, { silent = true }))
env.PROSE_LINKS = true
local game = runtime.create_game(env, true)
game:start()
local session = Session.new()
session.engine = {
	roomName = function() return tostring(env.HERE) end,
	items = function()
		local result = game:resume("room-items")
		for _, item in ipairs(game:resume("inventory-items")) do table.insert(result, item) end
		return result
	end,
}
local function record(output)
	session:refreshEngineState()
	session.openEntry = nil
	session:appendOutput(output, tostring(env.HERE))
end
local function enter(room)
	env.HERE = room
	env.MOVE(env.WINNER, room)
	record(game:resume("look"))
end
local function contains(target, command)
	for _, action in ipairs(session:linkActions(target)) do
		if action.command == command then return true end
	end
	return false
end
-- A newly opened real container must offer its child immediately.
enter(env.LB_CUTTING)
assert(not contains("brass counterweight", "take brass counterweight"), "Closed cutter must hide the weight")
record(game:resume("examine cutter"))
assert(contains("brass counterweight", "take brass counterweight"), "First cutter examination must immediately offer Take weight")
record(game:resume("take brass counterweight"))
assert(env.LOC(env.LB_WEIGHT) == env.WINNER, "Immediate discovery action takes the real weapon")
-- Even with the whole evidence set carried, unrelated pairings stay absent.
for _, item in ipairs({ env.LB_DISC, env.LB_STYLUS, env.LB_SPANNER, env.LB_CHART,
	env.LB_LEDGER, env.LB_BOOTS, env.LB_DRESSING, env.LB_RECEIPT }) do
	env.MOVE(item, env.WINNER)
end
enter(env.LB_CONTROL)
for _, action in ipairs(session:linkActions("routing switch")) do
	assert(not action.command:find(" with ", 1, true)
		and not action.command:find(" to ", 1, true)
		and not action.command:find(" for ", 1, true), "Routing switch has no meaningful binary operation: " .. action.command)
end
assert(contains("gramophone", "use gramophone with playback stylus"), "Pickup exposes the correct tool")
assert(contains("gramophone", "use gramophone with service spanner"), "Pickup permits a selected wrong-tool experiment")
assert(not contains("gramophone", "use gramophone with leather boots"), "Unrelated evidence is not offered as a tool")
assert(contains("lacquer disc", "put lacquer disc in gramophone"), "Record insertion remains available")
assert(not contains("wage ledger", "put wage ledger in gramophone"), "Ledger is never offered as a record")
enter(env.LB_OFFICE)
assert(contains("office clock", "compare office clock with voltage chart"), "Clock comparison remains available")
assert(not contains("office clock", "compare office clock with leather boots"), "Clock does not compare with unrelated boots")
assert(contains("service hatch", "use service hatch with service spanner"), "Hatch exposes the real spanner")
assert(contains("service hatch", "use service hatch with playback stylus"), "Hatch permits a selected wrong tool")
enter(env.LB_BUNKROOM)
record(game:resume("examine ada"))
for _, noun in ipairs({ "lacquer disc", "leather boots", "brass counterweight", "wage ledger" }) do
	assert(contains("ada", "show " .. noun .. " to ada mercer"), "Ada confrontation remains available: " .. noun)
end
assert(contains("ada", "tell ada mercer about broadcast"), "Ada's alibi topic remains available")
assert(not contains("ada", "tell ada mercer about office clock"), "Unrelated topics do not swamp conversation")
print("Last Broadcast: immediate counterweight discovery and authored interaction menus pass")
