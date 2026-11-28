-- Story and companion regressions.
local English = require("books.en.blackout-at-meridian.test.hero")
local German = require("books.de.blackout-at-meridian.test.hero")

local function same(a, b, label)
	for k, v in pairs(a) do assert(b[k] == v, string.format("%s: %s is %s in English and %s in German", label, k, tostring(v), tostring(b[k]))) end
end

-- Command pairs for one step of the route.
local steps = {
	rescue = { "rescue passengers", "rette die fahrgäste" },
	strike = { "strike drone", "schlag die drohne" },
	kit = { "use kit", "benutze den notfallkasten" },
	lever = { "disable console", "deaktiviere das schaltpult" },
}
local profiles = { { "bulwark", "fels" }, { "arc", "blitz" }, { "lens", "luchs" } }

local function play(profile, seed)
	local en, de = English.new(seed), German.new(seed)
	en:start(profile[1])
	de:start(profile[2])
	same(en:state(), de:state(), profile[1] .. " after the profile")
	local function both(step)
		en:send(steps[step][1])
		de:send(steps[step][2])
		same(en:state(), de:state(), profile[1] .. " seed " .. seed .. " " .. step)
		assert(#en.reports == #de.reports, step .. " rolled a different number of dice")
		for i, report in ipairs(en.reports) do same(report, de.reports[i], step .. " roll " .. i) end
		assert(en:running() == de:running(), step .. " ended in one edition only")
	end
	local count = 0
	while en:running() and not en:state().rescued do both("rescue"); count = count + 1; assert(count < 40) end
	if en:running() then
		en:send("east"); de:send("ost")
		same(en:state(), de:state(), "arriving")
	end
	while en:running() do
		local s = en:state()
		if not s.boosted and s.health <= s.max - 20 then both("kit")
		elseif not s.disabled then both("strike")
		else both("lever") end
		count = count + 1
		assert(count < 120, "the route did not end")
	end
	assert(en.w.finishes == 1 and de.w.finishes == 1, "both editions end through FINISH")
end

for _, profile in ipairs(profiles) do
	for _, seed in ipairs({ 3, 11, 29, 97, 1234 }) do play(profile, seed) end
end
print("ok - English and German editions play the same route to the same endings")


local Walk = require("tests.story_walk")
for _, c in ipairs({
	{ "en", "choose lens", "help", "north", "go north to the bridge", "You are on the bridge" },
	{ "de", "wähle luchs", "hilfe", "nord", "Geh nach Norden zur Brücke", "Du bist auf der Brücke" },
	{ "ru", "выбрать призму", "помощь", "север", "идите на север к мосту", "Вы уже на мосту" },
}) do
	local walk = Walk.new("books." .. c[1] .. ".blackout-at-meridian.blackout-at-meridian")
	walk:command(c[2])
	assert(walk:command(c[3]):find(c[5], 1, true))
	walk:command(c[4])
	local help = walk:command(c[3])
	assert(help:find(c[6], 1, true) and not help:find(c[5], 1, true), help)
end
print("ok - Meridian rescue help follows the hero in all three editions")
