-- A reader's complete playthrough: every step is a command the prose links
-- and object menus offer at that moment (tests/link_walk.lua refuses others).
local Walk = require("tests.link_walk")
local walk = Walk.new("books.pocket-weather.pocket-weather")
local env = walk.env

walk:play({
	{ "examine official forecast", expect = "continuous rain over the parade" },
	{ "examine postmaster mica", expect = "yesterday" },
	{ "tell postmaster mica about yesterday", expect = "archive south of the dispatch post" },
	"examine dispatch bell",
	{ "take weather card", expect = "Taken" },
	-- Yesterday's report is folded shut in the archive.
	{ "south", expect = "weatherbox" },
	{ "search brass weatherbox", expect = "folded report" },
	{ "take folded report", expect = "Taken" },
	{ "read folded report", expect = "fold resists" },
	"north",
	{ "west", expect = "steaming kettle" },
	"examine steaming kettle",
	{ "take narrow spoon", expect = "Taken" },
	-- The kettle names the report in hand, which puts its Steam action on screen.
	{ "examine steaming kettle", expect = "folded report could be held over it" },
	{ "steam folded report over steaming kettle", expect = "fold uncurls" },
	{ "read folded report", expect = "Ludo asked Nimbus to stop" },
	{ "show folded report to baker pip", expect = "Show Nimbus" },
	-- A fair trade frees the vane.
	"west",
	{ "examine laundry apron", expect = "brass button" },
	"take brass button",
	"take soft ribbon",
	{ "north", expect = "Aster the rook" },
	{ "give brass button to aster rook", expect = "A fair exchange" },
	{ "east", expect = "weather vane" },
	{ "spin weather vane", expect = "measured a safe route" },
	"down",
	-- The garden gutter.
	{ "east", expect = "crust of soil" },
	{ "dig garden gutter with narrow spoon", expect = "No roots break" },
	"west",
	-- Room for words, then listening, understanding and the promise.
	{ "north", expect = "clangs so hard" },
	{ "tie wind chime to soft ribbon", expect = "CLANG becomes tok" },
	{ "east", expect = "Nimbus the cloud" },
	{ "listen to nimbus cloud", expect = "You let Nimbus finish" },
	{ "show folded report to nimbus cloud", expect = "stops apologizing" },
	{ "tell nimbus cloud about pause rule", expect = "Including me" },
	{ "tell nimbus cloud about promise", expect = "like to come back" },
	"west",
	{ "south", expect = "ready to choose the rain together" },
	-- Nimbus names the card in hand, which puts its Write action on screen.
	{ "tell nimbus cloud", expect = "Write our forecast on your weather card" },
	{ "write weather card", expect = "PAUSE WHEN ANYONE ASKS" },
	"south",
	{ "show weather card to postmaster mica", expect = "hands it back" },
	{ "east", expect = "broadcast slot" },
	{ "put weather card in broadcast slot", expect = "quiet hum carries" },
	"west",
	{ "north", expect = "revised forecast hums" },
	{ "examine nimbus cloud", expect = "puddle-sized" },
	{ "examine light drizzle", expect = "drops hang far apart" },
	{ "examine short shower", expect = "drops crowd together" },
	{ "drizzle nimbus cloud", expect = "THE END -- A FORECAST YOU CAN KEEP" },
})

assert(walk.finishes == 1, "the ending enters FINISH exactly once")
assert(not walk:running(), "the story is over after the ending")
assert(#walk:menu() == 0, "nothing is offered after the ending")
for _, flag in ipairs({ "WIND_KNOWN", "GUTTER_READY", "REPORT_SOFT", "REPORT_READ", "LISTENED", "APOLOGY",
		"PAUSE_KNOWN", "AGREED", "CARD_WRITTEN", "CARD_APPROVED", "PUBLISHED" }) do
	assert(env[flag], flag .. " is set at the ending")
end
print("ok - pocket-weather links-only walkthrough: " .. walk.steps .. " steps to A FORECAST YOU CAN KEEP")
