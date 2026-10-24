-- Source-informed numeric-reader regression. No command is sent unless an
-- actual Session link menu emits it. Independent blind QA is a separate pass.
package.path = "../../../?.lua;../../../lua/?.lua;" .. package.path
local runtime = require("zilscript.runtime")
local Session = require("apps.adventure-arena.models.Session")
local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, { "books.last-broadcast.last-broadcast" }, { silent = true }))
env.PROSE_LINKS = true
local finishes, finish = 0, env.FINISH
env.FINISH = function(...) finishes = finishes + 1; return finish(...) end
local game = runtime.create_game(env, true)
local session = Session.new()
session.engine = {
	roomName = function() return tostring(env.HERE) end,
	items = function()
		local items = game:resume("room-items")
		for _, item in ipairs(game:resume("inventory-items")) do table.insert(items, item) end
		return items
	end,
}
local function record(output)
	if finishes == 0 then session:refreshEngineState() end
	session.openEntry = nil
	session:appendOutput(output, tostring(env.HERE))
end
local function choices()
	local result, seen = {}, {}
	local function add(command)
		if not seen[command] then seen[command] = true; table.insert(result, command) end
	end
	for _, command in ipairs({ "look", "inventory", "wait" }) do add(command) end
	local active = false
	for _, entry in ipairs(session.entries) do
		if entry == session.scene then active = true end
		if active then
			for _, links in ipairs(entry.links or {}) do
				for _, link in ipairs(links) do
					for _, action in ipairs(session:linkActions(link.target)) do add(action.command) end
				end
			end
		end
	end
	return result
end
local names = {
	{ "office clock", "clock" }, { "julian body", "body" }, { "julian vane", "vane" },
	{ "appeal board", "board" }, { "ruth bell", "ruth" },
	{ "ada mercer", "ada" }, { "edith shaw", "edith" }, { "tomas vale", "tomas" },
	{ "routing switch", "switch" }, { "red microphone", "microphone" }, { "disc cutter", "cutter" },
	{ "cutter register", "register" }, { "cardboard sleeve", "sleeve" },
	{ "lacquer disc", "disc" }, { "brass counterweight", "counterweight" },
	{ "wage ledger", "ledger" }, { "playback stylus", "stylus" },
	{ "service spanner", "spanner" }, { "voltage chart", "chart" },
	{ "passage stain", "stain" }, { "service hatch", "hatch" },
	{ "leather boots", "boots" }, { "maintenance roster", "roster" },
	{ "record gramophone", "gramophone" }, { "medical bag", "bag" },
	{ "bloodied dressing", "dressing" }, { "telegraph receipt", "receipt" },
}
local function canonical(command)
	command = command:gsub("^ask ", "tell ")
	for _, pair in ipairs(names) do command = command:gsub(pair[1], pair[2]) end
	return command
end
record(game:start())
local route = {
	"examine station clock",
	"examine casebook",
	"north",
	"read board",
	"north",
	"examine body",
	"examine office clock",
	"down",
	"south",
	"east",
	"examine ruth",
	"ask ruth about microphone",
	"ask ruth about vane",
	"east",
	"examine switch",
	"north",
	"examine cutter",
	"take counterweight",
	"read register",
	"east",
	"examine sleeve",
	"open sleeve",
	"examine disc",
	"take disc",
	"read ledger",
	"west",
	"south",
	"south",
	"take stylus",
	"take spanner",
	"down",
	"read chart",
	"north",
	"examine stain",
	"use hatch with spanner",
	"up",
	"compare clock with chart",
	"compare body with counterweight",
	"south",
	"up",
	"examine boots",
	"take boots",
	"read roster",
	"show ledger to ada",
	"down",
	"north",
	"down",
	"compare stain with boots",
	"south",
	"up",
	"north",
	"use gramophone with stylus",
	"put disc in gramophone",
	"play gramophone",
	"take disc",
	"north",
	"compare register with disc",
	"south",
	"west",
	"show disc to ruth",
	"west",
	"west",
	"open bag",
	"examine dressing",
	"take dressing",
	"show dressing to edith",
	"west",
	"read receipt",
	"show receipt to tomas",
	"accuse tomas",
	"up",
	"examine aerial",
	"examine signal lamp",
	"east",
	"show disc to ada",
	"show boots to ada",
	"show counterweight to ada",
	"reconstruct casebook",
	"ask ada about ledger",
	"accuse ada",
}
local count, output = 0, ""
local function select(index, menu)
	assert(menu[index], "Numeric selection must exist")
	output = game:resume(menu[index])
	assert(type(output) == "string" and output ~= "", "Choice must print a response")
	count = count + 1
	if os.getenv("LB_LINK_TRACE") then print(count, index, menu[index], output) end
	record(output)
end
for step, wanted in ipairs(route) do
	local index, menu
	for attempt = 1, 3 do
		menu = choices()
		for number, command in ipairs(menu) do
			if canonical(command) == canonical(wanted) then index = number; break end
		end
		if index then break end
		if attempt < 3 then select(attempt == 1 and 2 or 1, menu) end
	end
	assert(index, "Missing numeric menu step " .. step .. ": " .. wanted .. "\n" .. table.concat(menu, "\n"))
	select(index, menu)
end
assert(finishes == 1, "Solved ending must call FINISH exactly once")
assert(env.LB_WON and env.LB_RECONSTRUCTED, "Real detective state must be complete")
assert(output:find("CASE SOLVED", 1, true), "Solved ending must be visible")
print("Last Broadcast: " .. count .. " source-informed numbered selections reach FINISH")
