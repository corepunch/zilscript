local Walk = require("tests.story_walk")

local cases = {
	en = {
		choose = "choose spider-man", limit = 68, help = "cries for help", coil = "copper coil",
		lore = "Beyonder", magneto = "talk to magneto", wreck = "examine wreck", origin = "Galactus",
		take = "take coil", north = "north", ridgeBlock = "Fix the shield relay",
		repair = "put coil in relay", spanBlock = "rescue boat", handle = "pull handle",
		tags = "read tags", joke = "LEFT SOCK", doom = "talk to doctor doom", doomText = "nobody gets lost",
		door = "examine last door", home = "kitchen table",
		sign = "read sign", terms = "always obey me", lever = "turn lever", plans = "read plans",
		converterBlock = "Read Doom's plans first", returnPower = "send it back",
	},
	ru = {
		choose = "выбрать паука", limit = 59, help = "крики о помощи", coil = "медная катушка",
		lore = "Потусторонний", magneto = "поговорить с магнето", wreck = "осмотреть обломки", origin = "Галактус",
		take = "взять катушку", north = "север", ridgeBlock = "Почините передатчик",
		repair = "вставить катушку в передатчик", spanBlock = "спасти лодку", handle = "крутить лебёдку",
		tags = "читать ярлыки", joke = "Эхо, почти новое", doom = "поговорить с доктором думом", doomText = "Я навожу порядок",
		door = "осмотреть последнюю дверь", home = "кухонный стол",
		sign = "читать табличку", terms = "всегда будете меня слушаться", lever = "повернуть рычаг", plans = "читать планы",
		converterBlock = "Сначала прочитайте планы Дума", returnPower = "как её вернуть",
	},
}

local function includes(output, fragment)
	assert(output:find(fragment, 1, true), output)
end

for language, c in pairs(cases) do
	local walk = Walk.new("books." .. language .. ".last-door-of-battleworld.last-door-of-battleworld", 97)
	local env = walk.env
	local setup = walk.output
	local opening = walk:command(c.choose)
	local _, words = opening:gsub("%S+", "")
	assert(words <= c.limit, string.format("%s opening: %d words, limit %d", language, words, c.limit))
	includes(setup, c.choose)
	includes(opening, c.help)
	includes(opening, c.coil)
	assert(not opening:find(c.lore, 1, true) and not opening:find(c.origin, 1, true))
	includes(walk:command(c.magneto), c.lore)
	includes(walk:command(c.wreck), c.origin)
	walk:play({c.take, c.north})
	includes(walk:command(c.north), c.ridgeBlock)
	assert(env.HERE == env.RIDGE)

	walk:play({c.repair, c.north, c.north})
	includes(walk:command(c.north), c.spanBlock)
	assert(env.HERE == env.SPAN)
	walk:command(c.handle)
	assert(env.EVACUATED)

	walk:command(c.north)
	includes(walk:command(c.tags), c.joke)
	walk:command(c.north)
	includes(walk:command(c.doom), c.doomText)
	includes(walk:command(c.door), c.home)
	assert(not env.BW_OFFER_SEEN, "Doom's conversation is separate from his written offer")
	includes(walk:command(c.sign), c.terms)
	assert(env.BW_OFFER_SEEN and not env.BW_WON)

	walk:play({c.north, c.north})
	includes(walk:command(c.lever), c.converterBlock)
	includes(walk:command(c.plans), c.returnPower)
	walk:command(c.lever)
	assert(env.BW_WON == 3 and not walk:running())
end

print("ok - Battleworld opening is at most half as long, with optional lore and actionable clues in both editions")
