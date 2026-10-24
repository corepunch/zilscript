-- Book-authored binary relationships, exercised through real reader menus.
package.path = "../../../?.lua;../../../lua/?.lua;" .. package.path
local runtime = require("zilscript.runtime")
local Session = require("apps.adventure-arena.models.Session")
local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, { "books.silent-vector.silent-vector" }, { silent = true }))
env.PROSE_LINKS = true
local game = runtime.create_game(env, true)
game:start()
local failures = {}
local function check(value, message)
	if not value then table.insert(failures, message) end
end
local session = Session.new()
session.engine = {
	roomName = function() return "Fixture" end,
	items = function()
		local items = game:resume("room-items")
		for _, item in ipairs(game:resume("inventory-items")) do table.insert(items, item) end
		return items
	end,
}
local function enter(room)
	env.HERE = room
	env.MOVE(env.WINNER, room)
	session:refreshEngineState()
	session:appendOutput(game:resume("look"), "Fixture")
end
local function actions(target)
	local output = game:resume("examine " .. target)
	session:refreshEngineState()
	session:appendOutput(output, "Fixture")
	local commands = {}
	for _, action in ipairs(session:linkActions(target)) do commands[action.command] = true end
	return commands
end
local function includes(commands, fragment)
	for command in pairs(commands) do
		if command:find(fragment, 1, true) then return true end
	end
	return false
end
for _, object in ipairs({env.WRENCH, env.SHEARS, env.SPOOL, env.STRIP, env.WAFER}) do env.MOVE(object, env.WINNER) end
enter(env.WORKSHOP)
local commands = actions("protocol")
check(includes(commands, "read "), "Empty interaction metadata retains unary reading")
check(not includes(commands, " with "), "A protocol card does not offer tool-assisted reading")
enter(env.COOLANT)
commands = actions("pump")
check(includes(commands, "turn coolant pump with torque wrench"), "Correct torque repair remains offered")
check(includes(commands, "turn coolant pump with ceramic shears"), "A plausible wrong tool retains its authored explanation")
check(not includes(commands, "witness strip") and not includes(commands, "memory wafer"), "Pump menus exclude unrelated clue/sample cross-products")
check(not includes(commands, "read coolant pump with"), "Pump reading has no invented instrument")
enter(env.RELAY)
commands = actions("bus")
check(includes(commands, "fit incoming bus to null spool"), "Room-first fitting remains discoverable")
check(includes(commands, "cut incoming bus with ceramic shears"), "Correct isolation remains offered")
check(includes(commands, "cut incoming bus with torque wrench"), "Wrong conductive tool keeps its safety response")
check(not includes(commands, "witness strip") and not includes(commands, "memory wafer"), "Bus menus exclude unrelated evidence")
enter(env.LAB)
commands = actions("comparator")
check(includes(commands, "compare optical comparator with witness strip"), "The independent comparison remains offered")
check(includes(commands, "compare optical comparator with torque wrench"), "A wrong comparison retains a useful diagnostic")
check(not includes(commands, "ceramic shears") and not includes(commands, "memory wafer"), "Comparator menu excludes arbitrary partners")
enter(env.CLINIC)
commands = actions("mara")
check(includes(commands, "show witness strip to ") and includes(commands, "show memory wafer to "), "Actor-reversed Show exposes both relevant evidence objects")
check(not includes(commands, "show torque wrench") and not includes(commands, "show ceramic shears"), "Crew evidence menus exclude tool exhibitions")
check(includes(commands, " about received signal") and includes(commands, " about missing daughter"), "Authored NPC topics remain available")
enter(env.CORE)
commands = actions("wafer")
check(includes(commands, " in cold archive"), "Actual containment remains offered in the cold core")
check(not includes(commands, " in incoming bus"), "A sample does not offer a termination socket as storage")
enter(env.RECEPTION)
commands = actions("wafer")
check(includes(commands, " in signal receiver"), "Informative wrong storage remains offered beside the receiver")
enter(env.CORE)
commands = actions("wrench")
check(includes(commands, " in cold archive"), "Wrong archive item retains its authored rejection")
local file = assert(io.open("books/silent-vector/dungeon.zil", "r"))
local source = file:read("*a") file:close()
local objects, metadata = 0, 0
for _ in source:gmatch("<OBJECT%s+[%w%-]+") do objects = objects + 1 end
for _ in source:gmatch("%(INTERACTIONS%s+\"") do metadata = metadata + 1 end
check(objects == metadata, "Every authored object must explicitly declare binary interaction policy")
assert(#failures == 0, table.concat(failures, "\n"))
print("Silent Vector: " .. objects .. " explicit object interaction policies preserve useful menus")
