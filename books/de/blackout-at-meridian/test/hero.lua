-- Shared helpers for the German Blackout at Meridian tests: a typed session on
-- the seeded reader walk, forced dice, and an independent copy of the
-- percentile table in rulesets/superhero/system.zil to check every
-- reported roll.
local Walk = require("tests.link_walk")

local Hero = {}
Hero.module = "books.de.blackout-at-meridian.blackout-at-meridian"

-- { lowest rank, green, yellow, red }: a roll at or above a cutoff reaches
-- that tier. Kept apart from the ZIL so a changed cutoff fails here.
Hero.cutoffs = {
	{ 10000, 2, 21, 61 }, { 5000, 2, 26, 66 }, { 3000, 2, 31, 71 }, { 1000, 2, 36, 76 },
	{ 351, 4, 36, 76 }, { 176, 7, 41, 81 }, { 126, 11, 41, 81 }, { 88, 16, 46, 86 },
	{ 63, 21, 51, 86 }, { 46, 26, 56, 91 }, { 37, 31, 61, 91 }, { 26, 36, 66, 95 },
	{ 16, 41, 71, 95 }, { 8, 46, 76, 98 }, { 5, 51, 81, 98 }, { 3, 56, 86, 100 },
	{ 1, 61, 91, 100 }, { 0, 66, 95, 100 },
}
Hero.tierNames = { [0] = "Fehlschlag", "Erfolg", "starker Erfolg", "außerordentlicher Erfolg" }

function Hero.tier(rank, roll)
	for _, row in ipairs(Hero.cutoffs) do
		if rank >= row[1] then
			if roll >= row[4] then return 3 elseif roll >= row[3] then return 2
			elseif roll >= row[2] then return 1 else return 0 end
		end
	end
end

-- Profiles as the duty board describes them.
Hero.profiles = {
	fels = { class = 1, health = 120, karma = 26, rescue = 40, fighting = 30, power = 30, reason = 6, name = "Fels" },
	blitz = { class = 2, health = 90, karma = 50, rescue = 40, fighting = 20, power = 40, reason = 20, name = "Blitz" },
	luchs = { class = 3, health = 60, karma = 90, rescue = 30, fighting = 10, power = 30, reason = 40, name = "Luchs" },
}

local Session = {}
Session.__index = Session

function Hero.new(seed)
	local w = Walk.new(Hero.module, seed, "de")
	return setmetatable({ w = w, env = w.env, reports = {} }, Session)
end

-- Every d100 roll (and every other random choice) returns this value.
function Session:force(roll)
	self.env.math = setmetatable({ random = function(m, n)
		if m == nil then return 0.5 end
		if n == nil then m, n = 1, m end
		return math.max(m, math.min(n, roll))
	end }, { __index = math })
end

local function truthy(v) return v ~= nil and v ~= false and v ~= 0 end

function Session:state()
	local e = self.env
	local function stat(character, attribute) return e.STAT(character, attribute) end
	return { health = stat(e.HERO, e.A_HEALTH), max = e.MAX_STAT(e.HERO, e.A_HEALTH), karma = stat(e.HERO, e.A_KARMA), drone = stat(e.DRONE_STATS, e.A_HEALTH),
		rescued = truthy(e.RESCUED), disabled = truthy(e.DISABLED), boosted = truthy(e.BOOSTED), class = e.HERO_CLASS }
end

function Session:running() return self.w:running() end

-- A German text must never show an undecoded escape, a nil or English words
-- of the English book.
local ENGLISH = { "Rank ", "d100", "Health ", "THE END", "Dispatch ", "the drone", "The drone", "You are", "You can" }
function Session:clean(command, out)
	assert(not out:find("%f[%a]nil%f[%A]"), command .. " printed nil:\n" .. out)
	assert(not out:find("%a%%[aouAOUs<>]"), command .. " printed an undecoded escape:\n" .. out)
	for _, word in ipairs(ENGLISH) do
		assert(not out:find(word, 1, true), command .. " printed English " .. word .. ":\n" .. out)
	end
end

-- Sends a typed command, checks every reported roll against the table and
-- the invariants that hold after any command: Health in 0..max, Karma >= 0.
function Session:send(command)
	assert(self:running(), "story already ended before " .. command)
	local out = self.w.game:resume(command)
	assert(type(out) == "string" and out:match("%S"), command .. " printed nothing")
	self:clean(command, out)
	self.reports = {}
	for rankText, rollText, name in out:gmatch("Rang (%d+); W100 (%d+); ([^%.\n]-)%.") do
		local rank, roll = tonumber(rankText), tonumber(rollText)
		assert(roll >= 1 and roll <= 100, "roll out of range: " .. roll)
		local tier = Hero.tier(rank, roll)
		assert(name == Hero.tierNames[tier], string.format("rank %d roll %d should be %s, printed %s", rank, roll, Hero.tierNames[tier], name))
		table.insert(self.reports, { rank = rank, roll = roll, tier = tier })
	end
	local s = self:state()
	assert(s.health >= 0 and s.health <= s.max, string.format("Health %d outside 0..%d after %s", s.health, s.max, command))
	assert(s.karma >= 0, "Karma below zero after " .. command)
	self.output = out
	return out
end

function Session:expect(command, text)
	local out = self:send(command)
	assert(out:find(text, 1, true), string.format("%q should print %q but printed:\n%s", command, text, out))
	return out
end

-- Registers a profile and walks to the bridge.
function Session:start(profile)
	self:expect("wähle " .. profile, "Die Leitstelle meldet dich als " .. Hero.profiles[profile].name .. " an")
	self:expect("nord", "Meridian-Brücke")
	return self
end

Hero.truthy = truthy
return Hero
