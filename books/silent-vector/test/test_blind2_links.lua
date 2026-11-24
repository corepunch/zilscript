-- Reader-menu regression from the second blind completion. Parser and state
-- checks live in test-blind2-state.zil.
local runtime = require("zilscript.runtime")
local Session = require("zilscript.reader.Session")
local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, { "books.silent-vector.silent-vector" }, { silent = true }))
env.PROSE_LINKS = true
local game = runtime.create_game(env, true)
game:start()
local failures = {}
local function check(ok, message)
	if not ok then table.insert(failures, message) end
end
local function enter(room)
	env.HERE = room
	env.MOVE(env.WINNER, room)
end
enter(env.WORKSHOP)
game:resume("take wrench")
enter(env.CLINIC)
game:resume("take shears")
enter(env.COOLANT)
local session = Session.new()
session.engine = { items = function()
	local items = game:resume("room-items")
	for _, item in ipairs(game:resume("inventory-items")) do table.insert(items, item) end
	return items
end }
session:refreshEngineState()
local correct, wrong, count = nil, nil, 0
for _, action in ipairs(session:linkActions("pump")) do
	local command = action.command
	check(not command:match("^plug "), "The pump menu must not retain the obsolete Plug operation")
	check(not command:match("^turn .- to ") and not command:match("^turn .- for "),
		"A torque tool is offered only through the instrument preposition WITH")
	if command:match("^turn .- with ") then
		count = count + 1
		if command:find("wrench", 1, true) then correct = command end
		if command:find("shears", 1, true) then wrong = command end
	end
end
check(count == 2 and correct and wrong, "Exactly the correct and informative wrong torque tools remain")
env.COOLING = false
if wrong then
	local output = game:resume(wrong)
	check(output:find("calibrated torque wrench", 1, true) and not env.COOLING,
		"The actual wrong-tool menu command preserves the seal state")
end
if correct then
	local output = game:resume(correct)
	check(output:find("calibrated click", 1, true) and env.COOLING,
		"The actual correct menu command repairs the seal")
end
assert(#failures == 0, table.concat(failures, "\n"))
print("Silent Vector blind round 2 menu regressions: ok")
