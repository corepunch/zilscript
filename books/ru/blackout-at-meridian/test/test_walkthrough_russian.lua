local Runtime = require("zilscript.runtime")
local Walk = require("tests.story_walk")

local function new()
	return Walk.new("books.ru.blackout-at-meridian.blackout-at-meridian", 97)
end

local function contains(output, text)
	assert(output:find(text, 1, true), text .. " missing from " .. output)
end

local function submit(walk, command, expected)
	local output = walk.game:resume(command)
	if expected then contains(output, expected) end
	assert(utf8.len(output), "invalid UTF-8 after " .. command)
	walk:record(output)
	return output
end

local function roll(walk, value)
	walk.env.math.random = function(_, maximum) return math.min(value, maximum or value) end
end

local profiles = {
	{ noun = "бастиона", health = 120, karma = 26 },
	{ noun = "искру", health = 90, karma = 50 },
	{ noun = "призму", health = 60, karma = 90 },
}

for index, hero in ipairs(profiles) do
	local walk = new()
	local env = walk.env
	contains(walk.output, "Выберите героя")
	assert(not walk.output:find("обесточила", 1, true))
	contains(walk:command("осмотреть " .. hero.noun), "Здоровье " .. hero.health)
	assert(env.MOVES == 0 and not env.ZIL_TRUE(env.RPG_STARTED))
	contains(walk:command("выбрать " .. hero.noun), "обесточила")
	assert(env.ZIL_TRUE(env.RPG_STARTED) and env.MOVES == 0)
	assert(env.HERO_CLASS == index and env.STAT(env.HERO, env.A_HEALTH) == hero.health)
	assert(env.STAT(env.HERO, env.A_KARMA) == hero.karma)
	walk:command("север")
	roll(walk, 1)
	submit(walk, "взять трамвай", "Спасите пассажиров")
	submit(walk, "взять трос", "На нём висит весь вагон")
	assert(env.STAT(env.HERO, env.A_HEALTH) == hero.health and not env.ZIL_TRUE(env.RESCUED))
	contains(walk:command("спасти трамвай"), "провал")
	assert(env.STAT(env.HERO, env.A_HEALTH) == hero.health - 5)
	roll(walk, 100)
	contains(walk:command("спасти трамвай"), "Путь на восток")
	assert(env.ZIL_TRUE(env.RESCUED))
	walk:command("восток")
	submit(walk, "открыть пульт", "переключатель")
	submit(walk, "открыть аптечку", "Пломба цела")
	assert(env.STAT(env.HERO, env.A_HEALTH) == hero.health - 5 and not env.ZIL_TRUE(env.BOOSTED))
	contains(walk:command("применить аптечку"), "Восстановлено очков здоровья: 5")
	contains(walk:command("применить аптечку"), "Аптечка пуста")
	assert(env.STAT(env.HERO, env.A_KARMA) == hero.karma)
	if index ~= 3 then
		for _ = 1, 2 do
			if env.DISABLED then break end
			contains(walk:command("ударить дрон"), "Проверка боевого навыка")
		end
		assert(env.ZIL_TRUE(env.DISABLED))
	end
	local ending = walk:command("отключить пульт")
	contains(ending, "Меридиан в безопасности.")
	contains(ending, "мальчик в жёлтом дождевике")
	assert(not walk:running())
end

local walk = new()
submit(walk, "восток", "прохода нет")
submit(walk, "север", "Выберите Бастиона")
submit(walk, "СЧЁТ", "не выбран")
submit(walk, "Счет", "не выбран")
submit(walk, "осмотреться", "Выберите героя")
submit(walk, "ОСМОТРИ ИСКРУ", "электрическими разрядами")
submit(walk, "назови карточку героя", "Введите имя героя")
submit(walk, "Алёна Гром", "Имя героя: Алёна Гром")
submit(walk, "прочитай карточку героя", "Алёна Гром")
submit(walk, "назови карточку", "Введите имя героя")
submit(walk, " ", "Имя не введено")
submit(walk, "назови карточку", "Введите имя героя")
local long = ("Я"):rep(32)
local result = submit(walk, long .. "Н", long)
assert(not result:find(long .. "Н", 1, true))
submit(walk, "неизвестная команда", "Неизвестное слово")
submit(walk, ("яя"):rep(250), "Неизвестное слово")
submit(walk, "ВЫБЕРИ ИСКРУ", "В девять вечера")
submit(walk, "выбрать призму", "уже зарегистрирован")
submit(walk, "Иди на север!", "Вы на мосту")
submit(walk, "на восток", "Сначала спасите")
roll(walk, 100)
submit(walk, "спаси пассажиров", "Путь на")
submit(walk, "на восток", "Вы на релейной станции")
submit(walk, "осмотри сторожевого дрона", "Прочность: 40")
submit(walk, "осмотри пульт управления", "переключатель")
roll(walk, 1)
for _ = 1, 10 do
	if not walk:running() then break end
	result = submit(walk, "отключить пульт")
end
contains(result, "КОНЕЦ. СПАСЕНИЕ ИЗ БУРИ")
assert(not walk:running())

-- Check ordinary and nonsensical verbs against all objects in varied states.
-- Each case gets an isolated copy of the same world and an independent prompt,
-- including actions that quit the story.
walk = new()
roll(walk, 100)
local verbs = { "осмотреть", "прочитать", "открыть", "закрыть", "взять", "потрогать", "потереть", "понюхать",
	"послушать", "говорить", "толкнуть", "потянуть", "залезть", "войти", "бросить", "постучать" }
local rooms = {
	{ reach = {}, objects = { "бастиона", "искру", "призму", "карточку", "окно", "стенд", "дождь", "город", "реку", "мост", "трамвай" } },
	{ reach = { "выбрать искру", "север" }, objects = { "трамвай", "пассажиров", "рельсы", "трос", "реку", "команду", "станцию", "дверь", "карточку" } },
	{ reach = { "спасти трамвай", "восток" }, objects = { "дрон", "дрона", "аптечку", "пульт", "переключатель", "дверь", "карточку", "станцию", "дождь", "мост" } },
}
local checked = 0
for _, room in ipairs(rooms) do
	for _, command in ipairs(room.reach) do submit(walk, command) end
	local snapshot = os.tmpname()
	assert(walk.env.SAVE(snapshot))
	for _, noun in ipairs(room.objects) do
		for _, verb in ipairs(verbs) do
			assert(walk.env.RESTORE(snapshot))
			local game = Runtime.create_game(walk.env, true)
			_LLM_RESTORED = true
			game:start()
			_LLM_RESTORED = nil
			local command = verb .. " " .. noun
			local output = game:resume(command)
			checked = checked + 1
			assert(utf8.len(output) and output:find("%S"), "empty or invalid reply to " .. command)
			assert(not output:find("[a-zA-Z][a-z][a-z]"), "untranslated reply to " .. command .. ": " .. output)
		end
	end
	assert(walk.env.RESTORE(snapshot))
	os.remove(snapshot)
end
print(string.format("Russian Meridian: all profiles, both endings, and %d adversarial commands passed", checked))
