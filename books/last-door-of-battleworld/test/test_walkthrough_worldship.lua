local Walk = require("tests.story_walk")
local cases = {
		choose = "choose storm",
		coil = "take coil",
		relay = "put coil in relay",
		scales = "examine scales",
		clapper = "take clapper",
		west = "west",
		fit = "put clapper in bell",
		bell = "pull bell",
		east = "east",
		farewell = "From the village",
		north = "north",
		winch = "pull winch",
		prism = "push catch",
		klaw = "examine klaw",
		control = "reverse control",
		plans = "read plans",
		offer = "read inscription",
		offerText = "accept offer",
		refuse = "refuse offer",
		accept = "accept offer",
		returnSouth = "south",
		freeText = "stands beside",
		acceptEnd = "DOOM'S BARGAIN",
		ending = "THE LAST DOOR STAYS OPEN",
	}

local function play(walk, command)
	local output = walk.game:resume(command)
	assert(type(output) == "string" and output:find("%S"), command)
	walk:record(output)
	return output
end

local function reachMarket(c)
	local walk = Walk.new("books.last-door-of-battleworld.last-door-of-battleworld", 97)
	for _, command in ipairs({c.choose, c.coil, c.north}) do
		play(walk, command)
	end
	for _, command in ipairs({c.relay, c.north, c.north, c.winch, c.north}) do
		play(walk, command)
	end
	assert(walk.env.HERE == walk.env.MARKET)
	return walk
end

local c = cases
do
	local walk = reachMarket(c)
	local e = walk.env
	for _, command in ipairs({c.scales, c.clapper, c.west, c.fit, c.bell, c.east, c.north}) do
		play(walk, command)
	end
	assert(e.BW_BELL_RUNG and e.HERE == e.TOWER)
	play(walk, c.accept)
	assert(not e.BW_WON and not e.BW_OFFER_SEEN, "Doom must explain the bargain first")
	play(walk, c.offer)
	local karma = e.STAT(e.HERO, e.A_KARMA)
	play(walk, c.refuse)
	play(walk, c.refuse)
	play(walk, c.accept)
	assert(e.BW_OFFER_REFUSED and not e.BW_WON and e.STAT(e.HERO, e.A_KARMA) == karma + 5)
	play(walk, c.north)
	assert(e.HERE == e.BW_WORLDSHIP)
	play(walk, c.klaw)
	play(walk, c.prism)
	play(walk, c.prism)
	assert(e.BW_KLAW_FREE and e.STAT(e.HERO, e.A_KARMA) == karma + 10)
	play(walk, c.north)
	assert(play(walk, c.returnSouth):find(c.freeText, 1, true), "Klaw should now be outside the prism")
	play(walk, c.north)
	play(walk, c.control)
	assert(not e.BW_WON and walk:running(), "The plan explains how to reverse the converter")
	play(walk, c.plans)
	assert(e.BW_PLAN_READ)
	local ending = play(walk, c.control)
	assert(e.BW_WON == 3 and not walk:running() and walk.finishes == 1)
	assert(ending:find(c.ending, 1, true) and ending:find(c.farewell, 1, true), ending)
	assert(e.STAT(e.HERO, e.A_KARMA) == karma + 30)

	local bargain = reachMarket(c)
	play(bargain, c.north)
	local earlyOffer = play(bargain, c.accept)
	assert(bargain:running() and earlyOffer:find("READ INSCRIPTION", 1, true))
	assert(play(bargain, c.offer):find(c.offerText, 1, true))
	local surrender = play(bargain, c.accept)
	assert(bargain.env.BW_WON == 4 and not bargain:running() and bargain.finishes == 1)
	assert(surrender:find(c.acceptEnd, 1, true), surrender)
end

local mirror = reachMarket(cases)
play(mirror, "east")
assert(play(mirror, "examine socket"):find("emergency socket", 1, true))
assert(not mirror.env.BW_CHARGED and not mirror.env.BW_PLAN_READ)
play(mirror, "west")
play(mirror, "examine mirror")
play(mirror, "turn mirror")
play(mirror, "north")
local reflected = play(mirror, "use loom")
assert(reflected:find("bar of daylight", 1, true), reflected)
assert(mirror.env.BW_WON == 1 and not mirror:running())

print("ok - Doom's bargain and reverse-converter endings from the opening menu")
