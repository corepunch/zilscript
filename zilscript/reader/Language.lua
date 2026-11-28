-- The words the reader itself says and sends, by story language. A story
-- names its language in game.json ("language": "de"); English is the default.
-- Commands are what that language's parser understands, never English words.
local Language = {}

local CODES = { en = "en", english = "en", de = "de", german = "de", deutsch = "de", ru = "ru", russian = "ru" }

local en = {
	code = "en",
	look = "look", inventory = "inventory", wait = "wait", take = "take", examine = "examine", go = "go",
	lookTitle = "Look around", inventoryTitle = "Inventory",
	-- Words that are already complete menu entries elsewhere ("examine" is always first).
	skip = { look = true, examine = true },
	verbs = {
		"look", "examine", "open", "take", "inventory", "read", "go", "drop",
		"close", "enter", "turn on", "turn off", "push", "pull", "move", "put",
		"give", "unlock", "lock", "climb", "light", "search", "listen", "smell",
		"wait", "attack", "eat", "drink", "wear", "remove", "throw", "tie",
		"knock", "jump", "exit", "turn", "ask", "tell", "say", "touch",
	},
	needsSecond = { put = true, give = true, tie = true, throw = true, show = true, unlock = true, lock = true },
	titles = {},
	ask = "Ask",
	goTitle = "Go %s",
	-- Compass words the parser reads, by the engine's direction names.
	directions = {},
	-- "moves" and "score" status line pieces.
	score = "Score %d of %d", scoreOnly = "Score %d", time = "Time %d",
	move = "move", moves = "moves", movesOnly = "%d moves",
	-- What the parser says when it cannot use a command (lower case, Lua patterns).
	-- Commands played on every object to prove each gets an answer.
	probes = {
		"take %s", "drop %s", "climb %s", "push %s", "pull %s", "open %s", "close %s",
		"read %s", "touch %s", "search %s", "move %s", "kick %s", "eat %s", "smell %s",
		"listen to %s", "look under %s", "look behind %s", "look in %s", "turn %s",
		"enter %s", "sit on %s", "break %s", "wear %s", "knock on %s", "light %s",
	},
	-- Printed when a command ends the game and the tool must restart.
	ended = "RESTART, RESTORE, or QUIT", restart = "restart",
	failures = {
		"can't see any", "don't know the word", "noun missing", "verb missing",
		"not recognized", "which .- do you mean", "used the word",
		"sentence isn't one I recognize", "nothing special about",
	},
	-- The compass words the engine reads, for checking link targets.
	compass = { "north", "south", "east", "west", "northeast", "northwest", "southeast", "southwest",
		"ne", "nw", "se", "sw", "up", "down", "in", "out", "n", "s", "e", "w", "u", "d" },
	smallWords = { "a", "an", "and", "at", "by", "for", "in", "of", "on", "the", "to", "under", "with" },
}

local de = {
	code = "de",
	charset = "GERMAN",
	bareNouns = true,
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
	-- Menu entries name the action, as an infinitive reads best on a button.
	titles = {
		untersuch = "Untersuchen", nimm = "Nehmen", lies = "Lesen", oeffn = "Öffnen",
		schliess = "Schließen", lass = "Fallen lassen", leg = "Hinlegen", gib = "Geben",
		schieb = "Schieben", zieh = "Ziehen", dreh = "Drehen", stoss = "Drücken",
		klettere = "Klettern", steig = "Steigen", such = "Suchen", hoer = "Hören",
		["hoer zu"] = "Zuhören", riech = "Riechen", iss = "Essen", ess = "Essen", trink = "Trinken",
		wirf = "Werfen", frag = "Fragen", sag = "Sagen", klopf = "Klopfen", spring = "Springen",
		betritt = "Betreten", schau = "Ansehen", ["schau an"] = "Ansehen",
		["schliess auf"] = "Aufschließen", ["heb auf"] = "Aufheben", find = "Finden",
		["geh um"] = "Herumgehen", ["steig durch"] = "Hindurchsteigen", ["steig aus"] = "Aussteigen",
		["steig in"] = "Einsteigen", ["steig auf"] = "Hinaufsteigen", zerstoer = "Zerstören",
		["mach an"] = "Anmachen", ["mach aus"] = "Ausmachen", ["mach auf"] = "Aufmachen",
		["mach zu"] = "Zumachen", toet = "Töten", benutz = "Benutzen", reib = "Reiben",
		press = "Drücken", roll = "Rollen", schwimm = "Schwimmen", warte = "Warten",
		["zieh an"] = "Anziehen", ["zieh hoch"] = "Hochziehen", ["wirf hoch"] = "Hochwerfen",
		waehl = "Wählen", nenn = "Benennen", werf = "Werfen", rett = "Retten", ["werf auf"] = "Werfen auf",
		verlass = "Verlassen", beweg = "Bewegen", greif = "Greifen", angreif = "Angreifen",
		["untersuch in"] = "Hineinschauen", ["untersuch auf"] = "Obenauf schauen", ["schau unter"] = "Darunter schauen",
		["schau hinter"] = "Dahinter schauen", ["schau in"] = "Hineinschauen", ["such in"] = "Darin suchen", ["such nach"] = "Suchen",
		betritt = "Betreten", ["steig auf"] = "Hinaufsteigen", trag = "Tragen", ["lass fallen"] = "Fallen lassen",
	},
	ask = "Frag",
	goTitle = "Geh nach %s",
	directions = {
		north = "nord", south = "sued", east = "ost", west = "west",
		northeast = "nordost", northwest = "nordwest", southeast = "suedost", southwest = "suedwest",
		up = "rauf", down = "runter", ["in"] = "hinein", out = "raus",
	},
	directionNames = {
		north = "Norden", south = "Süden", east = "Osten", west = "Westen",
		northeast = "Nordosten", northwest = "Nordwesten", southeast = "Südosten", southwest = "Südwesten",
		up = "oben", down = "unten", ["in"] = "hinein", out = "hinaus",
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
	failures = {
		"kann nicht von dem spielvokabular", "du kannst das hier nicht sehen", "nicht verstehen kann",
		"fehlt das verb", "substantiv zu fehlen", "ich verstehe das nicht", "nicht klar, worauf",
		"nichts besonderes", "welche[rs]? .- meinst du", "erkennt diesen satz nicht",
		"satz ist nicht verstanden", "hast das wort",
	},
	compass = { "nord", "sued", "ost", "west", "nordost", "nordwest", "suedost", "suedwest",
		"norden", "sueden", "osten", "no", "so", "o", "rauf", "runter", "ra", "ru", "hinein", "rein", "raus",
		"hinaus", "oben", "unten" },
	smallWords = { "der", "die", "das", "den", "dem", "des", "und", "im", "am", "in", "vom", "zum", "zur",
		"mit", "von", "an", "auf", "bei", "unter", "ohne", "zu", "nach", "ein", "eine" },
}

local ru = {
	code = "ru",
	look = "осмотреться", inventory = "инвентарь", wait = "ждать", take = "взять",
	examine = "осмотреть", go = "идти",
	lookTitle = "Осмотреться", inventoryTitle = "Инвентарь",
	skip = { ["осмотреться"] = true, ["осмотреть"] = true },
	verbs = { "осмотреться", "осмотреть", "прочитать", "выбрать", "взять", "открыть", "послушать" },
	needsSecond = {},
	titles = {
		["осмотреть"] = "Осмотреть", ["прочитать"] = "Прочитать", ["выбрать"] = "Выбрать",
		["назвать"] = "Дать имя герою", ["спасти"] = "Спасти пассажиров",
		["ударить"] = "Ударить", ["отключить"] = "Отключить", ["применить"] = "Применить",
		["открыть"] = "Открыть", ["закрыть"] = "Закрыть", ["взять"] = "Взять",
		["послушать"] = "Послушать", ["потереть"] = "Потереть", ["потрогать"] = "Потрогать",
		["толкнуть"] = "Толкнуть", ["потянуть"] = "Потянуть", ["говорить"] = "Поговорить",
		["залезть"] = "Залезть", ["войти"] = "Войти", ["плыть"] = "Плыть",
		["постучать"] = "Постучать", ["понюхать"] = "Понюхать", ["бросить"] = "Бросить",
		["использовать"] = "Использовать",
	},
	ask = "Спросить",
	goTitle = "Идти %s",
	directions = {
		north = "север", south = "юг", east = "восток", west = "запад",
		northeast = "северо-восток", northwest = "северо-запад",
		southeast = "юго-восток", southwest = "юго-запад",
		up = "вверх", down = "вниз", ["in"] = "внутрь", out = "наружу",
	},
	directionNames = {
		north = "на север", south = "на юг", east = "на восток", west = "на запад",
		northeast = "на северо-восток", northwest = "на северо-запад",
		southeast = "на юго-восток", southwest = "на юго-запад",
		up = "вверх", down = "вниз", ["in"] = "внутрь", out = "наружу",
	},
	score = "Очки: %d из %d", scoreOnly = "Очки: %d", time = "Время: %d",
	move = "ход", moves = "ходов", movesOnly = "Ходы: %d",
	probes = { "взять %s", "прочитать %s", "осмотреть %s", "послушать %s",
		"открыть %s", "толкнуть %s", "потянуть %s", "потрогать %s" },
	ended = "Начать заново", restart = "начать",
	failures = { "неизвестное слово", "не удалось разобрать", "здесь нет такого предмета", "неясно, о каком предмете" },
	compass = { "север", "юг", "восток", "запад", "северо-восток", "северо-запад",
		"юго-восток", "юго-запад", "вверх", "вниз", "внутрь", "наружу" },
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

-- A set of the language's compass words (what a link target may name).
function Language.compassSet(lang)
	local set = {}
	for _, word in ipairs(lang.compass) do set[word] = true end
	return set
end

-- True when a parser reply says the command was not understood.
function Language.failed(lang, reply)
	reply = reply:lower()
	for _, pattern in ipairs(lang.failures) do
		if reply:find(pattern) then return true, pattern end
	end
	return false
end

-- The command word that walks a direction (the engine's English name).
function Language.direction(lang, direction)
	return lang.directions[direction] or direction
end

function Language.title(lang, verb)
	return lang.titles[verb] or (verb:gsub("^%l", string.upper))
end

return Language
