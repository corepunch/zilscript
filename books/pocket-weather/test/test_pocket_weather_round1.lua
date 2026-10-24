-- Regressions from independent blind round 1. Runs through the actual parser.
local runtime = require("zilscript.runtime")
local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, { "books.pocket-weather.pocket-weather" }, { silent = true }))
local finished = 0
local finish = env.FINISH
env.FINISH = function(...) finished = finished + 1; return finish(...) end
local game = runtime.create_game(env, true)
game:start()
local failures, checks = {}, 0
local function check(value, message)
	checks = checks + 1
	if not value then table.insert(failures, message) end
end
local function command(text)
	local output = tostring(game:resume(text))
	check(output ~= "", "Nonempty response: " .. text)
	return output
end
local function path(...)
	for _, text in ipairs({ ... }) do command(text) end
end
path("take card", "west", "take spoon", "west")
check(command("look"):find("pockets bulge", 1, true), "Unsearched apron hints at contents")
path("search apron", "take button", "take ribbon")
check(not command("look"):find("pockets bulge", 1, true), "Emptied apron cannot bulge")
check(command("look"):find("empty pockets", 1, true), "Emptied apron has honest presence text")
path("north", "give button to rook", "east", "turn vane", "down", "north", "east")
local loudRain = command("drizzle cloud")
check(loudRain:lower():find("chime", 1, true), "Premature drizzle respects noise")
check(not loudRain:find("Our promise", 1, true), "No invented promise before conversation")
check(not loudRain:find("Write your card", 1, true), "Premature rain does not spoil publication workflow")
check(command("shower cloud"):lower():find("chime", 1, true), "Premature shower also respects noise")
check(not env.LISTENED and not env.AGREED, "Rain requests cannot bypass listening or consent")
path("west", "tie ribbon to chime", "east")
check(command("drizzle cloud"):find("Listen to Nimbus first", 1, true), "Quiet cloud still needs listening")
path("listen to cloud")
check(command("drizzle cloud"):lower():find("yesterday", 1, true), "After listening, rain feedback asks for understanding")
path("west", "south", "south", "south", "open weatherbox", "take report", "north", "west",
	"steam report over kettle", "read report", "take flower", "east", "north", "north", "untie chime", "east")
local loudFlower = command("show flower to cloud")
check(loudFlower:lower():find("chime", 1, true), "Flower cannot create clear dialogue through noise")
check(not loudFlower:find("Ludo kept", 1, true), "No fabricated flower speech before quiet")
path("west", "tie ribbon to chime", "east", "show report to cloud", "ask cloud about pause")
check(command("drizzle cloud"):find("not agreed", 1, true), "Understanding alone is not consent")
check(not env.AGREED and not env.PUBLISHED, "Intermediate drizzle changes no agreement state")
path("west", "south", "east", "dig gutter with spoon", "west", "north", "east", "tell cloud about promise")
check(env.LOC(env.CLOUD) == env.TERRACE, "Agreement moves the actual cloud to terrace")
check(not command("look"):find("Nimbus the cloud", 1, true), "Hollow does not claim cloud remains")
path("west", "south")
check(command("look"):find("Nimbus the cloud", 1, true), "Terrace describes relocated cloud")
check(command("drizzle cloud"):find("Our promise", 1, true), "Only a real agreement earns shared-promise dialogue")
path("south", "write card", "give card to mica", "east", "put card in slot", "take card")
local emptySlot = command("examine slot")
check(not emptySlot:find("card]] rests", 1, true) and not emptySlot:find("card rests", 1, true), "Retrieved card is not described inside slot")
check(env.PUBLISHED and env.HELDQ(env.CARD), "Taking transmitted card preserves publication")
path("west")
local emptyPost = command("ring bell")
check(not emptyPost:find("Mica bows", 1, true), "Absent Mica cannot answer bell in person")
check(env.LOC(env.MICA) == env.BROADCAST, "Bell does not teleport Mica into dialogue")
path("north")
local ending = command("drizzle cloud")
check(ending:find("Ludo calls", 1, true), "Named final pause closes yesterday's child-voice thread")
check(finished == 1, "Revised ending enters FINISH exactly once")
for _, failure in ipairs(failures) do print("FAIL: " .. failure) end
assert(#failures == 0, #failures .. " round 1 regressions failed")
print("Pocket Weather blind-round-1 regressions: " .. checks .. " checks")
