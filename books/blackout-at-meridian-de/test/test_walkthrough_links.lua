-- Wins Stromausfall in Meridian with every profile by prose-link menus only,
-- then by always taking the companion's first card. Real seeded dice: a check
-- is repeated through the same link until it succeeds.
local Walk = require("tests.link_walk")
local module = "books.blackout-at-meridian-de.blackout-at-meridian-de"

local function until_text(w, command, text)
	for _ = 1, 20 do
		if w:choose(command):find(text, 1, true) then return end
		assert(w:running(), command .. " ended the story")
	end
	error(command .. " never printed " .. text)
end

for i, profile in ipairs({ "fels", "blitz", "luchs" }) do
	local w = Walk.new(module, 97 + i, "de")
	assert(w.output:find("Stromausfall in Meridian", 1, true), w.output)
	w:play({
		{ "untersuch " .. profile, expect = "Um dieses Profil zu übernehmen, wähle es." },
		{ "waehl " .. profile, expect = "Die Leitstelle meldet dich als" },
		{ "lies heldenbogen", expect = "Held: Meridian" },
		{ "nord", expect = "Es sind noch Menschen darin." },
		{ "untersuch straßenbahn", expect = "mit der Nase nach unten" },
	})
	until_text(w, "rett straßenbahn", "reichst die Fahrgäste")
	w:play({ { "ost", expect = "Wachdrohne" }, { "untersuch schaltpult", expect = "Handhebel" } })
	-- Blitz downs the drone first; the others go for the lever.
	if profile == "blitz" then until_text(w, "schlag wachdrohne", "kracht auf den Boden") end
	while w:running() do
		assert(w:offers("deaktivier schaltpult"), "the console offers its bypass:\n" .. w:describeMenu())
		w:choose("deaktivier schaltpult")
	end
	assert(w.finishes == 1 and #w:menu() == 0, profile .. " ends through FINISH")
	assert(w.output:find("ENDE: ", 1, true), w.output)
end

-- The companion's first card always leads to an ending.
for seed = 1, 6 do
	local w = Walk.new(module, seed * 31, "de")
	assert(w.env.SUGGEST_ACTIONS, "authored companion loaded")
	local steps = 0
	while w:running() do
		steps = steps + 1
		assert(steps < 60, "the companion route did not end")
		local choices = w.env.COMPANION_QUERY()
		assert(choices.ok and #choices.choices > 0, "no companion card in " .. w:room())
		local card = choices.choices[1]
		assert(not card.id:match("^fallback"), "fallback card in " .. w:room())
		local choice = w.env.COMPANION_SELECT(card.id)
		assert(choice.ok, card.id)
		local output = w.game:resume(choice.command)
		assert(type(output) == "string" and output:match("%S"), choice.command .. " printed nothing")
		w:record(output)
	end
	assert(w.finishes == 1 and w.output:find("ENDE: ", 1, true), "the companion reaches an ending")
end
print("ok - Stromausfall in Meridian by prose links and companion cards")
