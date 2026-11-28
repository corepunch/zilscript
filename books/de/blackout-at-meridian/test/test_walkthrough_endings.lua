-- Story and companion regressions.
local Hero = require("books.de.blackout-at-meridian.test.hero")

local function ended(h, title)
	assert(h.output:find("ENDE: " .. title, 1, true), "ending should be " .. title .. ":\n" .. h.output)
	assert(h.w.finishes == 1 and not h:running(), title .. " ends the story through FINISH")
end

for key, p in pairs(Hero.profiles) do
	-- Victory by the lever: one exceptional rescue, one exceptional bypass.
	local h = Hero.new()
	h:force(100)
	h:start(key)
	local s = h:state()
	assert(s.health == p.health and s.max == p.health and s.karma == p.karma, key .. " starts with its profile's Health and Karma")
	h:expect("rette die fahrgäste", "reichst die Fahrgäste")
	assert(h.reports[1].rank == p.rescue and h.reports[1].tier == 3, key .. " rescues with its rescue rank")
	assert(h:state().karma == p.karma + 10 and h:state().health == p.health, "a rescue earns 10 Karma and costs nothing")
	h:expect("ost", "schwebt davor")
	h:expect("deaktiviere das pult", "ruft deinen Namen: Meridian. Meridian ist gerettet.")
	assert(h.reports[1].rank == p.reason, key .. " works the lever with Verstand")
	assert(h:state().karma == p.karma + 30, "the bypass earns 20 Karma")
	ended(h, "DIE LICHTER VON MERIDIAN")
	assert(h.output:find("Held: Meridian (" .. p.name .. ")", 1, true), "the ending prints the hero")

	-- Victory by the drone: every strike lands; the drone counters while it flies.
	h = Hero.new()
	h:force(100)
	h:start(key)
	h:send("rette die bahn")
	h:send("ost")
	local strikes = math.ceil(40 / p.power)
	for i = 1, strikes do
		local out = h:send("schlag die drohne")
		assert(h.reports[1].rank == p.fighting, key .. " strikes with Kampf")
		if i < strikes then
			assert(out:find("Panzerung " .. (40 - i * p.power) .. " von 40", 1, true) and out:find("Betäubungsstrahl", 1, true), out)
		else
			assert(out:find("kracht auf den Boden", 1, true) and not out:find("Betäubungsstrahl", 1, true), out)
		end
	end
	s = h:state()
	assert(s.disabled and s.drone == 0, "the drone is down")
	assert(s.health == p.health - 10 * (strikes - 1), key .. " takes one counter for each strike that does not finish the drone")
	assert(s.karma == p.karma + 20, "downing the drone earns 10 Karma")
	h:expect("schau", "liegt dunkel davor am Boden")
	h:expect("untersuche die drohne", "erloschen")
	h:expect("schlage sie", "schon außer Gefecht")
	h:expect("hallo drohne", "Sie sagt gar nichts.")
	h:expect("ziehe den hebel", "Meridian ist gerettet.")
	assert(#h.reports == 0, "an unguarded lever needs no check")
	ended(h, "DIE LICHTER VON MERIDIAN")

	-- Defeat on the bridge: every rescue fails for 5 Health.
	h = Hero.new()
	h:force(1)
	h:start(key)
	local out
	for i = 1, p.health / 5 do
		out = h:send("rette die fahrgaeste")
		assert(h.reports[1].tier == 0, "roll 1 always fails")
		assert(h:state().health == p.health - 5 * i, "a failed rescue costs 5 Health")
		assert(not h:state().rescued, "a failed rescue saves nobody")
		if i < p.health / 5 then assert(h:running(), "the story continues above 0 Health") end
	end
	assert(h:state().health == 0, "Health stops at 0")
	assert(out:find("Dein Griff löst sich", 1, true), out)
	ended(h, "AUS DEM STURM GETRAGEN")
	assert(out:find("Gesundheit: 0/" .. p.health, 1, true), "the defeat prints the sheet")

	-- Defeat in the relay: the rescue succeeds, then every action fails for
	-- 10 Health. The kit restores only what was lost, once.
	h = Hero.new()
	h:force(100)
	h:start(key)
	h:send("rette die bahn")
	h:send("ost")
	h:expect("benutze den kasten", "Du bist unverletzt.")
	assert(not h:state().boosted and h:state().karma == p.karma + 10, "an unhurt hero keeps the kit and the Karma")
	h:force(1)
	h:expect("deaktiviere das pult", "bevor du den Hebel erreichst")
	assert(h:state().health == p.health - 10, "a failed bypass costs 10 Health")
	h:expect("benutze ihn", "Du erholst dich um 10 Gesundheit.")
	s = h:state()
	assert(s.health == p.health and s.boosted and s.karma == p.karma, "the kit heals up to the maximum for 10 Karma")
	h:expect("benutze den kasten", "Der Kasten ist leer.")
	assert(h:state().karma == p.karma, "an empty kit costs nothing")
	h:expect("schau", "hängt offen und leer")
	local turns = 0
	while h:running() do
		turns = turns + 1
		out = h:send(turns % 2 == 0 and "schlag die drohne" or "deaktiviere das pult")
		assert(h.reports[1].tier == 0, "roll 1 always fails")
	end
	assert(turns == p.health / 10, key .. " falls after Health / 10 failures")
	assert(out:find("deine Knie nach", 1, true), out)
	ended(h, "AUS DEM STURM GETRAGEN")
end

print("ok - Stromausfall in Meridian endings for every profile")
