-- Real dice on the seeded generator: each profile plays several seeds by two
-- plans (lever only; strike until the drone falls, with the kit when hurt).
-- Every reported roll is checked against the percentile table, and every
-- check costs and pays exactly what the rules say.
local Hero = require("books.de.blackout-at-meridian.test.hero")

local outcomes = { victory = 0, defeat = 0 }

local function play(key, seed, plan)
	local p = Hero.profiles[key]
	local h = Hero.new(seed)
	h:start(key)
	local steps = 0
	local function step(command)
		steps = steps + 1
		assert(steps < 80, key .. " seed " .. seed .. " did not end")
		local before = h:state()
		local out = h:send(command)
		local after = h:state()
		local report = h.reports[1]
		return out, before, after, report
	end
	while not h:state().rescued and h:running() do
		local out, before, after, report = step("rette die fahrgäste")
		assert(report and report.rank == p.rescue, "the rescue rolls the profile's rescue rank")
		if report.tier >= 1 then
			assert(after.rescued and after.karma == before.karma + 10 and after.health == before.health, out)
		else
			assert(not after.rescued and after.health == math.max(0, before.health - 5) and after.karma == before.karma, out)
		end
	end
	if h:running() then h:expect("ost", "Betonhalle") end
	while h:running() do
		local s = h:state()
		if plan == "strike" and not s.boosted and s.health <= s.max - 20 then
			local out, before, after = step("benutze den kasten")
			assert(after.health == before.health + 20 and after.karma == before.karma - 10 and after.boosted, out)
		elseif plan == "strike" and not s.disabled then
			local out, before, after, report = step("schlag die drohne")
			assert(report and report.rank == p.fighting, "a strike rolls Kampf")
			if report.tier >= 1 then
				assert(after.drone == math.max(0, before.drone - p.power), "a landed strike removes Power from the drone")
			else
				assert(after.drone == before.drone, "a miss leaves the drone as it was")
			end
			if after.disabled then
				assert(after.health == before.health and after.karma == before.karma + 10, out)
			else
				assert(after.health == math.max(0, before.health - 10) and after.karma == before.karma, out)
			end
		else
			local out, before, after, report = step("deaktiviere das pult")
			if before.disabled then
				assert(not report, "an unguarded lever needs no check")
			else
				assert(report and report.rank == p.reason, "the lever rolls Verstand")
			end
			local required = p.reason < 20 and 3 or (p.reason == 20 and 2 or 1)
			if not before.disabled and report.tier < required then
				assert(after.health == math.max(0, before.health - 10) and after.karma == before.karma, out)
			else
				assert(out:find("ENDE: DIE LICHTER VON MERIDIAN", 1, true) and after.karma == before.karma + 20, out)
			end
		end
	end
	assert(h.w.finishes == 1, "every game ends through FINISH")
	if h.output:find("DIE LICHTER VON MERIDIAN", 1, true) then
		outcomes.victory = outcomes.victory + 1
	else
		assert(h.output:find("ENDE: AUS DEM STURM GETRAGEN", 1, true) and h:state().health == 0, h.output)
		outcomes.defeat = outcomes.defeat + 1
	end
end

for _, key in ipairs({ "fels", "blitz", "luchs" }) do
	for seed = 1, 4 do
		play(key, seed * 7919, "lever")
		play(key, seed * 104729, "strike")
	end
end
assert(outcomes.victory > 0, "some seeds win")
print(string.format("ok - Stromausfall in Meridian seeded dice (%d victories, %d defeats)", outcomes.victory, outcomes.defeat))
