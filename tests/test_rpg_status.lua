-- Exercise typed status through the real parser, not just the sheet renderer.
local Walk = require("tests.story_walk")

local function expect(walk, command, expected, absent)
	local output = assert(walk.game:resume(command))
	assert(output:find(expected, 1, true), command .. ": expected " .. expected .. "\n" .. output)
	if absent then
		assert(not output:find(absent, 1, true), command .. ": unexpectedly printed " .. absent .. "\n" .. output)
	end
	return output
end

local editions = {
	{ lang = "en", choose = "choose arc", name = "name sheet", hero = "Ada Storm", named = "Ada Storm",
	  full = { "STATUS", "STAT", "STATS" }, compact = { "DIAGNOSE", "HEALTH" },
	  noHero = "Choose a character first.", noDiagnosis = "You have no ranks yet", profile = "Profile: Arc", rank = "Fighting: 20",
	  north = "north", saveTram = "rescue tram", failure = "failure",
	  resources = "Health: 85/90, Karma: 50", summary = "Health 85 of 90, Karma 50." },
	{ lang = "de", choose = "wähle blitz", name = "nenne bogen", hero = "Ada Sturm", named = "Ada Sturm",
	  full = { "STATUS", "STAT", "WERTE", "CHARAKTERWERTE" }, compact = { "ZUSTAND", "GESUNDHEIT", "DIAGNOSE" },
	  noHero = "Wähle zuerst eine Figur.", noDiagnosis = "Du hast noch keine Ränge", profile = "Profil: Blitz", rank = "Kampf: 20",
	  north = "nord", saveTram = "rette bahn", failure = "Fehlschlag",
	  resources = "Gesundheit: 85/90, Karma: 50", summary = "Gesundheit 85 von 90, Karma 50." },
	{ lang = "ru", choose = "выбери искру", name = "назови карточку", hero = "Алёна Гром", named = "Алёна Гром",
	  full = { "СТАТУС", "СТАТЫ", "ХАРАКТЕРИСТИКИ", "STAT" }, compact = { "СОСТОЯНИЕ", "ЗДОРОВЬЕ", "ДИАГНОЗ" },
	  noHero = "Сначала выберите героя.", profile = "Профиль: Искра", rank = "Бой: 20",
	  north = "север", saveTram = "спасти трамвай", failure = "провал",
	  resources = "Здоровье: 85/90, Карма: 50", summary = "Здоровье 85 из 90, Карма 50." },
}

for _, edition in ipairs(editions) do
	local walk = Walk.new("books." .. edition.lang .. ".blackout-at-meridian.blackout-at-meridian", 97)
	local env, rolls, events = walk.env, 0, 0
	env.math.random = function()
		rolls = rolls + 1
		return 1
	end
	expect(walk, edition.full[1], edition.noHero)
	expect(walk, edition.compact[1], edition.noDiagnosis or edition.noHero)
	assert(env.MOVES == 0 and rolls == 0 and not env.ZIL_TRUE(env.CLOCK_WAIT))
	assert(walk.game:resume(edition.name))
	expect(walk, edition.hero, edition.named)
	expect(walk, edition.choose, edition.rank)
	assert(env.MOVES == 0 and rolls == 0)
	assert(walk.game:resume(edition.north))
	expect(walk, edition.saveTram, edition.failure)
	assert(env.MOVES == 2 and rolls == 1)

	env.ENABLE(env.QUEUE(function() events = events + 1 end, 1))
	for _, command in ipairs(edition.full) do
		local output = expect(walk, command, edition.resources)
		assert(output:find(edition.named .. "\n" .. edition.profile, 1, true), output)
		assert(output:find(edition.rank, 1, true), output)
	end
	for _, command in ipairs(edition.compact) do
		expect(walk, command, edition.summary, edition.rank)
	end
	assert(env.MOVES == 2 and rolls == 1 and events == 0 and not env.ZIL_TRUE(env.CLOCK_WAIT))
	expect(walk, edition.saveTram, edition.failure)
	assert(env.MOVES == 3 and rolls == 2 and events == 1, edition.lang .. ": status stole a real turn")
end

do
	local walk = Walk.new("books.en.the-water-that-answers.the-water-that-answers", 97)
	local env = walk.env
	expect(walk, "status", "Choose a character first.")
	expect(walk, "choose doctor", "old pumping station")
	local output = expect(walk, "status", "Profile: Doctor", "Karma")
	assert(output:find("Composure:", 1, true) and output:find("Medicine: 80", 1, true), output)
	expect(walk, "diagnose", "Composure ", "Medicine")
	expect(walk, "score", "Composure ", "Medicine")
	assert(env.MOVES == 0 and not env.ZIL_TRUE(env.CLOCK_WAIT))
	expect(walk, "east", "telephone")
	assert(env.MOVES == 1, "investigator SCORE must not stop the following turn")
end

print("RPG status: localized full and compact commands are live and free of turns, interrupts and dice")
