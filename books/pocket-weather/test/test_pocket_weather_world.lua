-- Headless topology and vocabulary audit; parser traversal, never GUI or waits.
local runtime = require("zilscript.runtime")
local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, { "books.pocket-weather.pocket-weather" }, { silent = true }))
local game = runtime.create_game(env, true)
game:start()
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function enter(room)
	env.HERE = env[room]
	env.MOVE(env.WINNER, env.HERE)
end
local edges = {
	{ "DISPATCH", "north", "TERRACE", "south" },
	{ "DISPATCH", "west", "KITCHEN", "east" },
	{ "DISPATCH", "east", "BROADCAST", "west" },
	{ "DISPATCH", "south", "ARCHIVE", "north" },
	{ "TERRACE", "up", "VANE_DECK", "down" },
	{ "TERRACE", "east", "GARDEN", "west" },
	{ "TERRACE", "north", "ARCH", "south" },
	{ "GARDEN", "east", "SHED", "west" },
	{ "KITCHEN", "west", "LAUNDRY", "east" },
	{ "LAUNDRY", "north", "ROOKERY", "south" },
	{ "ROOKERY", "east", "VANE_DECK", "west" },
	{ "ARCH", "east", "HOLLOW", "west" },
}
for _, edge in ipairs(edges) do
	enter(edge[1])
	game:resume(edge[2])
	check(env.HERE == env[edge[3]], edge[1] .. " " .. edge[2])
	game:resume(edge[4])
	check(env.HERE == env[edge[1]], edge[3] .. " " .. edge[4])
end
local scenes = {
	DISPATCH = { "bell", "mica", "forecast", "card" },
	TERRACE = {}, VANE_DECK = { "vane" },
	ROOKERY = { "rook", "joke" }, LAUNDRY = { "apron" },
	KITCHEN = { "pip", "kettle", "spoon" },
	GARDEN = { "gutter", "seedlings" }, SHED = { "chart" },
	ARCH = { "chime" }, HOLLOW = { "cloud" },
	ARCHIVE = { "weatherbox" }, BROADCAST = { "slot" },
}
local failures = { "can't see any", "don't know the word", "which .- do you mean", "noun missing" }
local function understood(command)
	local output = tostring(game:resume(command)):lower()
	check(output ~= "", command .. " must print")
	for _, failure in ipairs(failures) do
		check(not output:find(failure), command .. " must resolve: " .. output)
	end
end
for room, nouns in pairs(scenes) do
	enter(room)
	local first = tostring(game:resume("look"))
	local repeatLook = tostring(game:resume("look"))
	check(#first > 40 and #repeatLook > 40, room .. " revisits stay descriptive")
	for _, noun in ipairs(nouns) do understood("examine " .. noun) end
end
for _, actor in ipairs({
	{ "DISPATCH", "mica" }, { "KITCHEN", "pip" }, { "ROOKERY", "rook" }, { "HOLLOW", "cloud" },
}) do
	enter(actor[1])
	for _, topic in ipairs({ "forecast", "promise", "pause", "yesterday", "joke" }) do
		understood("ask " .. actor[2] .. " about " .. topic)
	end
end
print("Pocket Weather world audit: " .. checks .. " topology, revisit, noun and topic checks")
