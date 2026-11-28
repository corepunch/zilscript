-- Story and companion regressions.
local Walk = require("tests.story_walk")
local walk = Walk.new("books.en.pocket-weather.pocket-weather")
local env = walk.env
local checks = 0

local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end
local function says(command, text)
	local output = walk:command(command)
	check(output:find(text, 1, true), command .. " should print \"" .. text .. "\" but printed:\n" .. output)
	return output
end
local function lacks(output, text)
	check(not output:find(text, 1, true), "\"" .. text .. "\" should not appear in:\n" .. output)
end

-- The card has one name: the opening called it a forecast card, everything else a weather card.
lacks(walk.output, "weather card")
says("examine dispatch bell", "blank weather card")
lacks(walk.output, "forecast card")

-- PULL is spelled V-MOVE, so the bell's Pull entry answered "You can't move the dispatch bell".

says("ring dispatch bell", "Ting!")

-- No reply tells a reader what to type.
lacks(says("examine weather card", "write on it once you and Nimbus have agreed"), "WRITE CARD")
walk:command("take weather card")
check(walk.game:resume("examine forecast"):find("orders continuous rain", 1, true),
	"the official forecast is distinct from the card in hand")
check(walk.game:resume("examine forecast card"):find("blank weather card", 1, true),
	"the full card name still reaches the actual card")
lacks(says("show weather card to postmaster mica", "write it on the card"), "WRITE CARD")

walk:play({ "south", "search brass weatherbox", "take folded report" })
lacks(says("examine folded report", "hold the report over the kettle"), "STEAM REPORT")
walk:play({ "north", "west" })

-- The kitchen puts the report's Steam action on screen without an inventory detour.

says("examine steaming kettle", "Your folded report could be held over it")

walk:command("look")
lacks(says("show folded report to baker pip", "Hold your report over it"), "STEAM REPORT")

says("examine baker pip", "You may borrow the spoon")
walk:command("take narrow spoon")
lacks(walk:command("examine baker pip"), "borrow the spoon")
-- Asking Pip about the pause answered about the forecast.
walk:command("tell baker pip about promise")
says("tell baker pip about pause rule", "isn't a broken promise")
walk:command("steam folded report over steaming kettle")
lacks(walk:command("examine steaming kettle"), "could be held over it")
walk:command("read folded report")
says("examine yesterday", "Ludo asked for a pause")

-- The completed trade gives the correct directions and moves Aster.
walk:play({ "west", "examine laundry apron", "take brass button", "take soft ribbon", "north" })
local trade = says("give brass button to aster rook", "You may turn the vane now")
check(trade:find("east", 1, true), "trade still points east")
walk:command("east")
says("examine aster rook", "turns the brass button")
check(walk.game:resume("examine counterweight"):find("counterweight is free", 1, true), "the counterweight the prose names is the vane's")

-- The chart no longer asks for a measurement already taken.
walk:play({ "spin weather vane", "down", "east" })
lacks(says("dig in garden gutter", "Dig with the narrow spoon you are carrying"), "DIG GUTTER")
walk:play({ "dig garden gutter with narrow spoon", "east" })
lacks(says("examine rain chart", "The vane agrees with the picture"), "You will need to measure")
walk:play({ "west", "west", "north" })

-- The chime is not a box: no Open entry, no "contains" listing; the room tells of the ribbon.

walk:command("tie wind chime to soft ribbon")
local arch = says("look", "its clapper wrapped in the soft ribbon")
lacks(arch, "contains")

says("take soft ribbon", "You untie the ribbon")
check(env.INQ(env.RIBBON, env.ADVENTURER), "taking the tied ribbon unties it")
lacks(says("look", "clangs so hard"), "ribbon")
walk:command("inventory")
walk:command("tie soft ribbon to wind chime")
check(env.INQ(env.RIBBON, env.CHIME), "ribbon tied again")

-- Nimbus follows the story instead of repeating early advice.
walk:play({ "east", "listen to nimbus cloud" })
says("tell nimbus cloud about yesterday", "The old report may help you understand")
walk:command("show folded report to nimbus cloud")
lacks(says("tell nimbus cloud about yesterday", "without shrinking"), "old report may help")
says("tell nimbus cloud about pause rule", "Could that be part of the promise?")
walk:command("tell nimbus cloud about promise")
check(env.AGREED, "promise made")
says("examine promise", "You and Nimbus promised rain for the garden")
says("examine pause rule", "the rain stops")
walk:play({ "west", "south" })
lacks(says("tell nimbus cloud about pause rule", "That is our promise now"), "Could that be")
says("examine nimbus cloud", "let the whole town hear it")
says("examine official forecast", "must replace it")

-- Nimbus points the player to the next unfinished step.
says("tell nimbus cloud", "Write our forecast on your weather card")

says("shower nimbus cloud", "Write your card, let Mica approve it")
walk:command("write weather card")
lacks(says("drizzle nimbus cloud", "Let Mica approve the card"), "Write your card")
lacks(says("tell nimbus cloud about promise", "Let Mica read the card"), "Now give it public words")
walk:command("south")
says("examine postmaster mica", "Show me the card")
walk:command("inventory")
walk:command("show weather card to postmaster mica")
lacks(says("examine postmaster mica", "Approved"), "Write the")
lacks(says("tell postmaster mica", "Yours is approved"), "says continuous rain")
lacks(says("tell postmaster mica about promise", "I have signed it"), "Bring me the written")
lacks(says("show folded report to postmaster mica", "looked this carefully yesterday"), "For publication")
walk:play({ "north" })
lacks(says("shower nimbus cloud", "Mica has approved the card"), "Write your card")
walk:play({ "south", "east" })

-- The slot answers Open in the fiction.

check(walk.game:resume("open broadcast slot"):find("The slot has no door", 1, true), "A typed Open is answered in the fiction")
walk:command("put weather card in broadcast slot")
lacks(says("tell postmaster mica", "Nimbus is waiting for you on the terrace"), "says continuous rain")
lacks(says("tell postmaster mica about promise", "The whole town has heard that now"), "Bring me the written")
walk:play({ "west", "north" })
lacks(says("tell nimbus cloud about promise", "choose a drizzle or a shower"), "let Mica approve it")
says("shower nimbus cloud", "THE END -- A FORECAST YOU CAN KEEP")
check(walk.finishes == 1 and not walk:running(), "the shower ending is terminal")

print("ok - pocket-weather walkthrough regressions: " .. checks .. " checks")
