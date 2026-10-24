-- Frozen blind-round-2 findings: responses must respect inventory and milestones.
local runtime = require("zilscript.runtime")
local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, { "books.pocket-weather.pocket-weather" }, { silent = true }))
local game = runtime.create_game(env, true)
game:start()
local failures, checks = {}, 0
local function check(value, message)
	checks = checks + 1
	if not value then table.insert(failures, message) end
end
local function command(text)
	local output = tostring(game:resume(text))
	check(output ~= "", "Nonempty parser response: " .. text)
	return output
end
local function path(...)
	for _, text in ipairs({ ... }) do command(text) end
end
path("take card", "west", "take spoon", "west", "search apron", "take button", "take ribbon", "north",
	"give button to rook", "east", "turn vane", "down", "east")
local bare = command("dig in gutter")
check(bare:find("spoon you are carrying", 1, true), "Bare Dig acknowledges the held spoon")
check(not bare:find("if you brought", 1, true), "Held tool is not falsely absent")
check(not env.GUTTER_READY, "Bare Dig still requests an explicit tool")
local wrong = command("dig gutter with ribbon")
check(wrong:find("spoon you are carrying", 1, true), "Wrong explicit tool points to carried correct tool")
check(not env.GUTTER_READY, "Wrong explicit tool never silently borrows the spoon")
path("dig gutter with spoon", "west", "south", "south", "open weatherbox", "take report", "north", "west",
	"steam report over kettle", "read report", "east", "north", "north", "tie ribbon to chime", "east", "listen to cloud")
local understoodNext = command("ask cloud about forecast")
check(understoodNext:find("yesterday", 1, true), "After listening the next missing stage is understanding")
check(not understoodNext:find("Could you listen to me", 1, true), "Completed listening is not requested again")
path("show report to cloud", "ask cloud about pause", "tell cloud about promise", "west", "south")
local agreed = command("ask cloud about forecast")
check(agreed:find("We have agreed", 1, true), "Forecast topic acknowledges agreement")
check(agreed:find("Write", 1, true), "Unwritten agreement points to writing")
check(not agreed:find("Could you listen to me", 1, true), "Agreement cannot regress to listening")
path("south", "write card", "north")
check(command("ask cloud about forecast"):find("Mica", 1, true), "Written forecast points to review")
path("south", "give card to mica", "north")
check(command("ask cloud about forecast"):find("broadcast slot", 1, true), "Approved forecast points to publication")
path("south", "east", "put card in slot", "west", "north")
local published = command("ask cloud about forecast")
check(published:find("town has heard", 1, true), "Published forecast acknowledged")
check(not published:find("Write", 1, true), "Publication cannot regress to writing")
check(env.AGREED and env.PUBLISHED, "Conversation does not alter completed milestones")
check(command("shower cloud"):find("A FORECAST YOU CAN KEEP", 1, true), "State-aware route still reaches actual shower ending")
for _, failure in ipairs(failures) do print("FAIL: " .. failure) end
assert(#failures == 0, #failures .. " blind-round-2 regressions failed")
print("Pocket Weather blind-round-2 regressions: " .. checks .. " checks")
