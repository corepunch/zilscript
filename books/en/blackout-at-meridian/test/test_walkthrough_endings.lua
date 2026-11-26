-- Every profile reaches every ending with forced dice: victory by the bypass
-- lever, victory by downing the drone first, defeat on the bridge and defeat
-- in the relay station. Each ending goes through FINISH and leaves no menu.
local Hero = require("books.en.blackout-at-meridian.test.hero")

local function ended(h, title)
	assert(h.output:find("THE END: " .. title, 1, true), "ending should be " .. title .. ":\n" .. h.output)
	assert(h.w.finishes == 1 and not h:running() and #h.w:menu() == 0, title .. " ends the story through FINISH")
end

for key, p in pairs(Hero.profiles) do
	-- Victory by the lever: one exceptional rescue, one exceptional bypass.
	local h = Hero.new()
	h:force(100)
	h:start(key)
	local s = h:state()
	assert(s.health == p.health and s.max == p.health and s.karma == p.karma, key .. " starts with its profile's Health and Karma")
	h:expect("rescue passengers", "pass the passengers down")
	assert(h.reports[1].rank == p.rescue and h.reports[1].tier == 3, key .. " rescues with its rescue rank")
	assert(h:state().karma == p.karma + 10 and h:state().health == p.health, "a rescue earns 10 Karma and costs nothing")
	h:expect("east", "hovers in front of it")
	h:expect("disable console", "dispatch calls your name: Meridian. Meridian is safe.")
	assert(h.reports[1].rank == p.reason, key .. " works the lever with Reason")
	assert(h:state().karma == p.karma + 30, "the bypass earns 20 Karma")
	ended(h, "THE LIGHTS OF MERIDIAN")
	assert(h.output:find("Hero: Meridian (" .. p.name .. ")", 1, true), "the ending prints the hero")

	-- Victory by the drone: every strike lands; the drone counters while it flies.
	h = Hero.new()
	h:force(100)
	h:start(key)
	h:send("rescue tram")
	h:send("east")
	local strikes = math.ceil(40 / p.power)
	for i = 1, strikes do
		local out = h:send("strike drone")
		assert(h.reports[1].rank == p.fighting, key .. " strikes with Fighting")
		if i < strikes then
			assert(out:find("Integrity " .. (40 - i * p.power) .. " of 40", 1, true) and out:find("stun beam", 1, true), out)
		else
			assert(out:find("crashes to the floor", 1, true) and not out:find("stun beam", 1, true), out)
		end
	end
	s = h:state()
	assert(s.disabled and s.drone == 0, "the drone is down")
	assert(s.health == p.health - 10 * (strikes - 1), key .. " takes one counter for each strike that does not finish the drone")
	assert(s.karma == p.karma + 20, "downing the drone earns 10 Karma")
	h:expect("look", "lies dark on the floor")
	h:expect("examine drone", "gone dark")
	h:expect("strike drone", "already out of action")
	h:expect("talk to drone", "says nothing")
	local out = h:expect("pull lever", "Meridian is safe.")
	assert(#h.reports == 0, "an unguarded lever needs no check")
	ended(h, "THE LIGHTS OF MERIDIAN")

	-- Defeat on the bridge: every rescue fails for 5 Health.
	h = Hero.new()
	h:force(1)
	h:start(key)
	for i = 1, p.health / 5 do
		out = h:send("rescue passengers")
		assert(h.reports[1].tier == 0, "roll 1 always fails")
		assert(h:state().health == p.health - 5 * i, "a failed rescue costs 5 Health")
		assert(not h:state().rescued, "a failed rescue saves nobody")
		if i < p.health / 5 then assert(h:running(), "the story continues above 0 Health") end
	end
	assert(h:state().health == 0, "Health stops at 0")
	assert(out:find("Your grip fails", 1, true), out)
	ended(h, "CARRIED FROM THE STORM")
	assert(out:find("Health: 0/" .. p.health, 1, true), "the defeat prints the sheet")

	-- Defeat in the relay: the rescue succeeds, then every action fails for
	-- 10 Health. The kit restores only what was lost, once.
	h = Hero.new()
	h:force(100)
	h:start(key)
	h:send("rescue tram")
	h:send("east")
	h:expect("use kit", "You are unhurt.")
	assert(not h:state().boosted and h:state().karma == p.karma + 10, "an unhurt hero keeps the kit and the Karma")
	h:force(1)
	h:expect("disable console", "before you reach the lever")
	assert(h:state().health == p.health - 10, "a failed bypass costs 10 Health")
	h:expect("use kit", "You recover 10 Health.")
	s = h:state()
	assert(s.health == p.health and s.boosted and s.karma == p.karma, "the kit heals up to the maximum for 10 Karma")
	h:expect("use kit", "The kit is empty.")
	assert(h:state().karma == p.karma, "an empty kit costs nothing")
	h:expect("look", "hangs open and empty")
	local turns = 0
	while h:running() do
		turns = turns + 1
		out = h:send(turns % 2 == 0 and "strike drone" or "disable console")
		assert(h.reports[1].tier == 0, "roll 1 always fails")
	end
	assert(turns == p.health / 10, key .. " falls after Health / 10 failures")
	assert(out:find("Your knees give way", 1, true), out)
	ended(h, "CARRIED FROM THE STORM")
end

print("ok - Blackout at Meridian endings for every profile")
