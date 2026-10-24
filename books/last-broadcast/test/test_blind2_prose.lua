-- Regression for the first-impression referent and reciprocal reader captions.
package.path = "../../../?.lua;../../../lua/?.lua;" .. package.path
local runtime = require("zilscript.runtime")
local Session = require("apps.adventure-arena.models.Session")
local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, { "books.last-broadcast.last-broadcast" }, { silent = true }))
env.PROSE_LINKS = true
local game = runtime.create_game(env, true)
local failures = {}
local function check(value, message)
	if not value then table.insert(failures, message) end
end
local opening = game:start()
check(opening:find("the station's owner, Julian Vane, was dead", 1, true), "Opening must distinguish the station owner from the living voice's owner")
local function enter(room)
	env.HERE = room
	env.MOVE(env.WINNER, room)
	return game:resume("look")
end
local function hasLink(output, label, target)
	local _, links = Session.parseLinks(output)
	for _, link in ipairs(links) do
		if link.label == label and link.target == target then return true end
	end
	return false
end
check(hasLink(enter(env.LB_PLATFORM), "bunkroom", "east"), "Upper walk east caption must name the bunkroom")
game:resume("east")
check(env.HERE == env.LB_BUNKROOM, "Destination caption must retain its actual east exit")
check(hasLink(game:resume("look"), "aerial platform", "west"), "Upper walk west caption must name the aerial platform")
game:resume("west")
check(env.HERE == env.LB_PLATFORM, "Return caption must retain its actual west exit")
assert(#failures == 0, table.concat(failures, "\n"))
print("Last Broadcast: explicit opening victim and reciprocal destination captions pass")
