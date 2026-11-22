-- Regressions from a links-only QA playthrough: what a reader saw that was
-- wrong for the state, pointed at nothing, or asked them to type.
local Walk = require("tests.link_walk")
local walk = Walk.new("books.pocket-weather.pocket-weather")
local env = walk.env
local checks = 0

local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end
local function says(command, text)
	local output = walk:choose(command)
	check(output:find(text, 1, true), command .. " should print \"" .. text .. "\" but printed:\n" .. output)
	return output
end
local function lacks(output, text)
	check(not output:find(text, 1, true), "\"" .. text .. "\" should not appear in:\n" .. output)
end
-- Every object link in the last output must open a menu, or it is a dead link.
local function linksLive()
	for label, target in walk.output:gmatch("%[%[([^%]]-)%->([^%]]-)%]%]") do
		local found = false
		for _, action in ipairs(walk:menu()) do
			if action.target == target then found = true break end
		end
		check(found, "link [[" .. label .. "->" .. target .. "]] offers nothing in:\n" .. walk.output)
	end
end

-- The card has one name: the opening called it a forecast card, everything else a weather card.
lacks(walk.output, "weather card")
says("examine dispatch bell", "blank weather card")
check(walk.output:find("[[weather card->card]]", 1, true), "the card under the bell is linked")
lacks(walk.output, "forecast card")

-- PULL is spelled V-MOVE, so the bell's Pull entry answered "You can't move the dispatch bell".
check(not walk:offers("pull dispatch bell"), "bell offers no Pull")
says("ring dispatch bell", "Ting!")

-- No reply tells a link reader what to type.
lacks(says("examine weather card", "write on it once you and Nimbus have agreed"), "WRITE CARD")
walk:choose("take weather card")
check(walk.game:resume("examine forecast"):find("orders continuous rain", 1, true),
	"the official forecast is distinct from the card in hand")
check(walk.game:resume("examine forecast card"):find("blank weather card", 1, true),
	"the full card name still reaches the actual card")
lacks(says("show weather card to postmaster mica", "write it on the card"), "WRITE CARD")

walk:play({ "south", "search brass weatherbox", "take folded report" })
lacks(says("examine folded report", "hold the report over the kettle"), "STEAM REPORT")
walk:play({ "north", "west" })

-- The kitchen puts the report's Steam action on screen without an inventory detour.
check(not walk:offers("steam folded report over steaming kettle"), "report is not linked on entering the kitchen")
says("examine steaming kettle", "Your folded report could be held over it")
check(walk:offers("steam folded report over steaming kettle"), "kettle links the report in hand")
walk:choose("look")
lacks(says("show folded report to baker pip", "Hold your report over it"), "STEAM REPORT")
check(walk:offers("steam folded report over steaming kettle"), "Pip links the report in hand")
says("examine baker pip", "You may borrow the spoon")
walk:choose("take narrow spoon")
lacks(walk:choose("examine baker pip"), "borrow the spoon")
-- Asking Pip about the pause answered about the forecast.
walk:choose("tell baker pip about promise")
says("tell baker pip about pause rule", "isn't a broken promise")
walk:choose("steam folded report over steaming kettle")
lacks(walk:choose("examine steaming kettle"), "could be held over it")
walk:choose("read folded report")
says("examine yesterday", "Ludo asked for a pause")

-- The trade no longer links a vane in another room or a button Aster now keeps.
walk:play({ "west", "examine laundry apron", "take brass button", "take soft ribbon", "north" })
local trade = says("give brass button to aster rook", "You may turn the vane now")
lacks(walk.output, "->vane")
lacks(walk.output, "->button")
linksLive()
check(trade:find("east", 1, true), "trade still points east")
walk:choose("east")
says("examine aster rook", "turns the brass button")
linksLive()
check(walk.game:resume("examine counterweight"):find("counterweight is free", 1, true), "the counterweight the prose names is the vane's")

-- The chart no longer asks for a measurement already taken.
walk:play({ "spin weather vane", "down", "east" })
lacks(says("dig in garden gutter", "Dig with the narrow spoon you are carrying"), "DIG GUTTER")
walk:play({ "dig garden gutter with narrow spoon", "east" })
lacks(says("examine rain chart", "The vane agrees with the picture"), "You will need to measure")
walk:play({ "west", "west", "north" })

-- The chime is not a box: no Open entry, no "contains" listing; the room tells of the ribbon.
check(not walk:offers("open wind chime"), "chime offers no Open")
walk:choose("tie wind chime to soft ribbon")
local arch = says("look", "its clapper wrapped in the soft ribbon")
lacks(arch, "contains")
check(not walk:offers("open wind chime"), "padded chime offers no Open")
says("take soft ribbon", "You untie the ribbon")
check(env.INQ(env.RIBBON, env.ADVENTURER), "taking the tied ribbon unties it")
lacks(says("look", "clangs so hard"), "ribbon")
walk:choose("inventory")
walk:choose("tie soft ribbon to wind chime")
check(env.INQ(env.RIBBON, env.CHIME), "ribbon tied again")

-- Nimbus follows the story instead of repeating early advice.
walk:play({ "east", "listen to nimbus cloud" })
says("tell nimbus cloud about yesterday", "The old report may help you understand")
walk:choose("show folded report to nimbus cloud")
lacks(says("tell nimbus cloud about yesterday", "without shrinking"), "old report may help")
says("tell nimbus cloud about pause rule", "Could that be part of the promise?")
walk:choose("tell nimbus cloud about promise")
check(env.AGREED, "promise made")
says("examine promise", "You and Nimbus promised rain for the garden")
says("examine pause rule", "the rain stops")
walk:play({ "west", "south" })
lacks(says("tell nimbus cloud about pause rule", "That is our promise now"), "Could that be")
says("examine nimbus cloud", "let the whole town hear it")
says("examine official forecast", "must replace it")

-- Nimbus links the card in hand; later steps are not sent back to earlier ones.
says("tell nimbus cloud", "Write our forecast on your weather card")
check(walk:offers("write weather card"), "Nimbus links the card to write")
says("shower nimbus cloud", "Write your card, let Mica approve it")
walk:choose("write weather card")
lacks(says("drizzle nimbus cloud", "Let Mica approve the card"), "Write your card")
lacks(says("tell nimbus cloud about promise", "Let Mica read the card"), "Now give it public words")
walk:choose("south")
says("examine postmaster mica", "Show me the card")
walk:choose("inventory")
walk:choose("show weather card to postmaster mica")
lacks(says("examine postmaster mica", "Approved"), "Write the")
lacks(says("tell postmaster mica", "Yours is approved"), "says continuous rain")
lacks(says("tell postmaster mica about promise", "I have signed it"), "Bring me the written")
lacks(says("show folded report to postmaster mica", "looked this carefully yesterday"), "For publication")
walk:play({ "north" })
lacks(says("shower nimbus cloud", "Mica has approved the card"), "Write your card")
walk:play({ "south", "east" })

-- The slot answers Open in the fiction.
check(not walk:offers("open broadcast slot"), "An always-open slot offers no Open")
check(walk.game:resume("open broadcast slot"):find("The slot has no door", 1, true), "A typed Open is answered in the fiction")
walk:choose("put weather card in broadcast slot")
lacks(says("tell postmaster mica", "Nimbus is waiting for you on the terrace"), "says continuous rain")
lacks(says("tell postmaster mica about promise", "The whole town has heard that now"), "Bring me the written")
walk:play({ "west", "north" })
lacks(says("tell nimbus cloud about promise", "choose a drizzle or a shower"), "let Mica approve it")
says("shower nimbus cloud", "THE END -- A FORECAST YOU CAN KEEP")
check(walk.finishes == 1 and not walk:running(), "the shower ending is terminal")

print("ok - pocket-weather walkthrough regressions: " .. checks .. " checks")
