-- The words the reader itself says and sends, by story language. A story
-- names its language in game.json ("language": "de"); English is the default.
-- Commands are what that language's parser understands, never English words.
local Language = {}

local CODES = { en = "en", english = "en", de = "de", german = "de", deutsch = "de", ru = "ru", russian = "ru" }

local en = {
	code = "en",
	companion = { controls = "Use ↑ or ↓ to pick an action and Enter to play it. You can also type a command.",
		question = "What will you do?", scene = "In this scene", move = "Go somewhere",
		prompt = "Choose a number, or type any command: " },
	look = "look", inventory = "inventory", wait = "wait", take = "take", examine = "examine", go = "go",
	lookTitle = "Look around", inventoryTitle = "Inventory",
	-- Commands handled separately by the completion generator.
	skip = { look = true, examine = true },
	verbs = {
		"look", "examine", "open", "take", "inventory", "read", "go", "drop",
		"close", "enter", "turn on", "turn off", "push", "pull", "move", "put",
		"give", "unlock", "lock", "climb", "light", "search", "listen", "smell",
		"wait", "attack", "eat", "drink", "wear", "remove", "throw", "tie",
		"knock", "jump", "exit", "turn", "ask", "tell", "say", "touch",
	},
	needsSecond = { put = true, give = true, tie = true, throw = true, show = true, unlock = true, lock = true },
	-- Compass words the parser reads, by the engine's direction names.
	directions = {},
	-- "moves" and "score" status line pieces.
	score = "Score %d of %d", scoreOnly = "Score %d", time = "Time %d",
	move = "move", moves = "moves", movesOnly = "%d moves",
	-- Commands played on every object to prove each gets an answer.
	probes = {
		"take %s", "drop %s", "climb %s", "push %s", "pull %s", "open %s", "close %s",
		"read %s", "touch %s", "search %s", "move %s", "kick %s", "eat %s", "smell %s",
		"listen to %s", "look under %s", "look behind %s", "look in %s", "turn %s",
		"enter %s", "sit on %s", "break %s", "wear %s", "knock on %s", "light %s",
	},
	-- Printed when a command ends the game and the tool must restart.
	ended = "RESTART, RESTORE, or QUIT", restart = "restart",
	smallWords = { "a", "an", "and", "at", "by", "for", "in", "of", "on", "the", "to", "under", "with" },
}

local de = {
	code = "de",
	companion = { controls = "Wähle mit ↑ oder ↓ eine Aktion und bestätige mit Enter. Du kannst auch einen Befehl eingeben.",
		question = "Was möchtest du tun?", scene = "An diesem Ort", move = "Weitergehen",
		prompt = "Wähle eine Nummer oder gib einen Befehl ein: " },
	charset = "GERMAN",
	look = "schau", inventory = "inventar", wait = "warte", take = "nimm", examine = "untersuch", go = "geh",
	lookTitle = "Umsehen", inventoryTitle = "Inventar",
	skip = { schau = true, untersuch = true, ["schau an"] = true },
	-- The parser's own stems (ASCII, no ending), best known first.
	verbs = {
		"schau", "untersuch", "oeffn", "nimm", "inventar", "lies", "geh", "lass",
		"schliess", "such", "heb auf", "steig", "klettere", "mach an", "mach aus",
		"schieb", "stoss", "zieh", "dreh", "leg", "gib", "wirf", "hoer", "riech",
		"warte", "trink", "ess", "iss", "frag", "sag", "spring", "schwimm",
		"zerstoer", "toet", "mach auf", "mach zu", "benutz", "reib", "press", "roll",
	},
	needsSecond = { leg = true, gib = true, wirf = true, ["schliess auf"] = true, schenk = true, fuell = true },
	-- German direction commands use the local compass words.
	directions = {
		north = "nord", south = "sued", east = "ost", west = "west",
		northeast = "nordost", northwest = "nordwest", southeast = "suedost", southwest = "suedwest",
		up = "rauf", down = "runter", ["in"] = "hinein", out = "raus",
	},
	score = "Punkte %d von %d", scoreOnly = "Punkte %d", time = "Zeit %d",
	move = "Zug", moves = "Züge", movesOnly = "%d Züge",
	probes = {
		"nimm %s", "lass %s", "klettere auf %s", "schieb %s", "zieh %s", "oeffn %s", "schliess %s",
		"lies %s", "beruehr %s", "durchsuch %s", "beweg %s", "tritt %s", "iss %s", "riech %s",
		"hoer zu %s", "schau unter %s", "schau hinter %s", "schau in %s", "dreh %s",
		"betritt %s", "setz dich auf %s", "zerbrich %s", "zieh an %s", "klopf an %s", "zuend %s an",
	},
	ended = "NEUBEGINN", restart = "neubeginn",
	smallWords = { "der", "die", "das", "den", "dem", "des", "und", "im", "am", "in", "vom", "zum", "zur",
		"mit", "von", "an", "auf", "bei", "unter", "ohne", "zu", "nach", "ein", "eine" },
}

local ru = {
	code = "ru",
	companion = { controls = "Выберите действие стрелками ↑ или ↓ и нажмите Enter. Можно также ввести команду.",
		question = "Что вы будете делать?", scene = "Здесь", move = "Отправиться дальше",
		prompt = "Выберите номер или введите команду: " },
	look = "осмотреться", inventory = "инвентарь", wait = "ждать", take = "взять",
	examine = "осмотреть", go = "идти",
	lookTitle = "Осмотреться", inventoryTitle = "Инвентарь",
	skip = { ["осмотреться"] = true, ["осмотреть"] = true },
	verbs = { "осмотреться", "осмотреть", "прочитать", "выбрать", "взять", "открыть", "послушать" },
	needsSecond = {},
	directions = {
		north = "север", south = "юг", east = "восток", west = "запад",
		northeast = "северо-восток", northwest = "северо-запад",
		southeast = "юго-восток", southwest = "юго-запад",
		up = "вверх", down = "вниз", ["in"] = "внутрь", out = "наружу",
	},
	score = "Очки: %d из %d", scoreOnly = "Очки: %d", time = "Время: %d",
	move = "ход", moves = "ходов", movesOnly = "Ходы: %d",
	probes = { "взять %s", "прочитать %s", "осмотреть %s", "послушать %s",
		"открыть %s", "толкнуть %s", "потянуть %s", "потрогать %s" },
	ended = "Начать заново", restart = "начать",
	smallWords = {},
	release = "Выпуск",
}

local LANGUAGES = { en = en, de = de, ru = ru }

for _, lang in pairs(LANGUAGES) do
	lang.rank = {}
	for index, verb in ipairs(lang.verbs) do lang.rank[verb] = index end
	lang.small = {}
	for _, word in ipairs(lang.smallWords) do lang.small[word] = true end
end

-- A language by code or name ("de", "German"); anything unknown is English.
function Language.of(name)
	if type(name) == "table" then return name end
	return LANGUAGES[CODES[tostring(name or ""):lower()] or "en"]
end

-- The story language of a book: its edition folder, books/<lang>/<book>.
-- Accepts "books/de/x", "books.de.x", "de/x" or a path inside the book.
function Language.ofBook(name)
	local code = tostring(name or ""):gsub("^.-books[/.]", ""):match("^(%a%a)[/.]")
	return LANGUAGES[code] or LANGUAGES.en
end

-- A vocabulary word as the reader types it: the story source writes
-- non-ASCII letters as %-escapes (T\%UR), which the parser decodes to UTF-8.
function Language.word(lang, word)
	local charset = lang.charset and require("zilscript.charsets").find(lang.charset)
	word = word:gsub("\\", "")
	if not charset then return word end
	return (word:gsub("%%(.)", function(ch) return charset.atoms[ch] end))
end

-- The command word that walks a direction (the engine's English name).
function Language.direction(lang, direction)
	return lang.directions[direction] or direction
end

return Language
