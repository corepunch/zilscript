local namespace = (...):match("^(.*)%.Session$")
local Suggestions = require(namespace .. ".Suggestions")
local Language = require(namespace .. ".Language")
local Text = require(namespace:match("^(.*)%.reader$") .. ".text")

local Session = {}
Session.__index = Session

local DIRECTIONS = {
	n = "north", north = "north",
	ne = "northeast", northeast = "northeast",
	e = "east", east = "east",
	se = "southeast", southeast = "southeast",
	s = "south", south = "south",
	sw = "southwest", southwest = "southwest",
	w = "west", west = "west",
	nw = "northwest", northwest = "northwest",
	u = "up", up = "up", d = "down", down = "down",
	["in"] = "in", out = "out",
	-- The German language package names its exits by German compass words.
	nord = "north", norden = "north", sued = "south", suden = "south", ost = "east", osten = "east", o = "east",
	no = "northeast", nordost = "northeast", nw = "northwest", nordwest = "northwest",
	so = "southeast", suedost = "southeast", sw = "southwest", suedwest = "southwest",
	rauf = "up", ra = "up", runter = "down", ru = "down", rein = "in", hinein = "in", raus = "out",
}
for direction, command in pairs(Language.of("ru").directions) do DIRECTIONS[command] = direction end

-- Re-rendering a transcript costs time proportional to its length, so the
-- reader keeps the most recent entries; the story itself is unaffected.
local TRANSCRIPT = { limit = 120 }

function Session.new(options)
	options = options or {}
	local self = setmetatable({
		language = Language.of(nil),
		engineFactory = options.engineFactory,
		-- A saved game replays its commands against the same random sequence.
		newSeed = options.newSeed or function() return os.time() end,
	}, Session)
	self:reset()
	return self
end

function Session:reset()
	self.entries, self.history = {}, {}
	self.moves, self.score, self.maxScore, self.scoreChange = 0, 0, 0, 0
	self.availableDirections, self.exitList = {}, {}
	self.items = {}
	self.roomTitle, self.scene, self.openEntry = nil, nil, nil
	self.running = true
end

function Session:refreshEngineState()
	if type(self.engine.progress) == "function" then
		local ok, progress = pcall(self.engine.progress, self.engine)
		if ok and type(progress) == "table" then
			self.score = tonumber(progress.score) or 0
			self.moves = tonumber(progress.moves) or 0
			self.maxScore = tonumber(progress.maxScore) or 0
		end
	end
	if type(self.engine.isRunning) == "function" then
		self.running = self.engine:isRunning()
		if not self.running then
			self.items, self.availableDirections, self.exitList = {}, {}, {}
			return
		end
	end
	if type(self.engine.exits) == "function" then
		local ok, directions = pcall(self.engine.exits, self.engine)
		if ok and type(directions) == "table" then
			self.availableDirections, self.exitList = {}, {}
			for _, direction in ipairs(directions) do
				local normalized = DIRECTIONS[tostring(direction):lower()]
				if normalized and not self.availableDirections[normalized] then
					self.availableDirections[normalized] = true
					table.insert(self.exitList, normalized)
				end
			end
			-- The engine walks exits in hash order; players expect a compass.
			local order = {}
			for index, direction in ipairs(Suggestions.DIRECTIONS) do order[direction] = index end
			table.sort(self.exitList, function(a, b) return order[a] < order[b] end)
		end
	end
	if type(self.engine.roomName) == "function" then
		local ok, name = pcall(self.engine.roomName, self.engine)
		if ok and type(name) == "string" and name:match("%S") then
			self.roomTitle = name
		end
	end
	if type(self.engine.items) == "function" then
		local ok, raw = pcall(self.engine.items, self.engine)
		if ok and type(raw) == "table" then
			self.items = Suggestions.items(raw)
		end
	end
end

function Session:hasExit(direction)
	local normalized = DIRECTIONS[tostring(direction or ""):lower()]
	return normalized ~= nil and self.availableDirections[normalized] == true
end

-- ── Transcript structure ────────────────────────────────────────────────
-- The engine prints plain text. Books give the reader structure, so the
-- transcript is parsed into a title-page banner, scenes (a new room opens
-- one under the room's name), the player's own commands, and narration.
-- Stories mark the words a reader can act on as "[[label]]" or
-- "[[label->target]]"; paragraphs keep the label and carry the links apart.

local function trim(text)
	return (tostring(text or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function paragraphsOf(text)
	local paragraphs = {}
	text = tostring(text or ""):gsub("\r\n", "\n")
	for block in (text .. "\n\n"):gmatch("(.-)\n%s*\n") do
		local paragraph = trim(block)
		if paragraph ~= "" then table.insert(paragraphs, paragraph) end
	end
	return paragraphs
end

local function isBanner(paragraph, language)
	local release = paragraph:match("\n" .. (language.release or "Release") .. " ([^\n]+)$")
	return release and (release:match("^%d+$") or release:match("^%d+ / Serial"))
end

-- Without an engine room name, a heading is a short title-cased line.
local function looksLikeHeading(line, language)
	local small = language.small
	if #line > 48 or not line:match("%a") or line:match("[.!?,;:]") then return false end
	for word in line:gmatch("%S+") do
		if not small[word:lower()] and not word:match("^[%u\128-\255][%w'/\128-\255-]*$") then return false end
	end
	return true
end

local function splitFirstLine(paragraph)
	local first, rest = paragraph:match("^([^\n]+)\n(.*)$")
	if not first then return paragraph, nil end
	rest = trim(rest)
	return trim(first), rest ~= "" and rest or nil
end

-- Splits link markup from prose. Returns the text as the reader sees it and
-- its links, each { location, length, label, target }: `location` counts
-- characters from 0 as `utf8.len` does, and `target` is the parser's word
-- for the thing (the label itself when the story names no other).
function Session.parseLinks(text)
	text = tostring(text or "")
	local plain, links, position = {}, {}, 1
	local length = 0
	local function keep(piece)
		table.insert(plain, piece)
		length = length + (utf8.len(piece) or #piece)
	end
	while true do
		local first, last, body = text:find("%[%[(.-)%]%]", position)
		if not first then break end
		keep(text:sub(position, first - 1))
		local label, target = body:match("^(.-)%->(.*)$")
		label, target = trim(label or body), trim(target or body)
		if label ~= "" and target ~= "" then
			table.insert(links, {
				location = length, length = utf8.len(label) or #label,
				label = label, target = Text.lower(target),
			})
		end
		keep(label)
		position = last + 1
	end
	keep(text:sub(position))
	return table.concat(plain), links
end

function Session:beginScene(title)
	local scene = { kind = "scene", title = title, paragraphs = {}, links = {} }
	table.insert(self.entries, scene)
	self.scene, self.openEntry = scene, scene
	return scene
end

function Session:appendParagraph(paragraph)
	if not self.openEntry then
		self.openEntry = { kind = "narration", paragraphs = {}, links = {} }
		table.insert(self.entries, self.openEntry)
	end
	-- A story's CR ends a prose paragraph, including the object descriptions
	-- printed after a room. Keep each in its own reveal queue item so the
	-- paragraph gap applies to single newlines too.
	for raw in tostring(paragraph):gmatch("[^\r\n]+") do
		local line = trim(raw)
		if line ~= "" then
			local text, links = Session.parseLinks(line)
			table.insert(self.openEntry.paragraphs, text)
			self.openEntry.links[#self.openEntry.paragraphs] = links
		end
	end
end

-- A second object must be something the prose has introduced or the player
-- carries. This keeps menus from leaking undiscovered puzzle solutions.
function Session:interactionTargets(includePast)
	local targets, seen = {}, {}
	local function add(target, label)
		if not target or DIRECTIONS[target] or seen[target] then return end
		seen[target] = true
		table.insert(targets, { target = target, label = label })
	end
	-- Prefer the current scene's labels when a remembered target also resolves
	-- to a different local object (for example, two rooms' tables).
	local active = false
	for _, entry in ipairs(self.entries) do
		if entry == self.scene then active = true end
		if active then
			for _, links in ipairs(entry.links or {}) do
				for _, link in ipairs(links) do add(link.target, link.label) end
			end
		end
	end
	if includePast then
		for _, entry in ipairs(self.entries) do
			if entry == self.scene then break end
			for _, links in ipairs(entry.links or {}) do
				for _, link in ipairs(links) do add(link.target, link.label) end
			end
		end
	end
	for _, item in ipairs(self.items) do
		if item.carried then add(item.target or item.noun, item.name) end
	end
	return targets
end

-- What a reader can do with a linked word, as { title, command } in the
-- order they are likeliest to want. A direction walks; an object offers
-- "examine" and the verbs the story accepts, including complete two-object
-- commands using things the reader has discovered.
local function linkedItem(items, target)
	local words = {}
	for word in target:gmatch("[%w'\128-\255]+") do words[word] = true end
	local noun = Suggestions.noun(target)
	local best, bestScore = nil, 0
	for _, item in ipairs(items) do
		local score = item.target == target and 100 or (item.noun == noun and 80 or 0)
		for _, alias in ipairs(item.aliases or {}) do
			if alias == noun then score = math.max(score, 60) end
		end
		for word in item.name:lower():gmatch("[%w'\128-\255]+") do
			if words[word] and word ~= "the" and word ~= "a" and word ~= "of" and word ~= "to" then
				score = math.max(score, 20)
			end
		end
		-- Vocabulary-only topics must not mask a real actor or object
		-- with the same noun ("fox" as a topic versus Nutmeg herself).
		if item.patterns and #item.patterns == 0 then score = score - 100 end
		if score > bestScore then best, bestScore = item, score end
	end
	return best
end

-- Both link-play tools and typed completion consume the same parser actions.
-- Keep the operands separate so completing a noun never has to parse a label.
local function visitItemActions(item, partners, visit, language)
	visit(language.examine, item)
	for _, verb in ipairs(Suggestions.oneTapVerbs(item, language)) do
		if not language.skip[verb] then visit(verb, item) end
	end
	for _, pattern in ipairs(item.patterns or {}) do
		if pattern.join ~= nil and Suggestions.inHand(item, pattern) then
			local prefix = pattern.verb .. (pattern.prefix ~= "" and " " .. pattern.prefix or "")
			local paired = {}
			for _, other in ipairs(partners(pattern.join == "about")) do
				local second = other.item
				local tool = pattern.join == "with"
				local traits = second and second.traits or {}
				-- These checks name the action, not the verb word: a story's
				-- synonym ("FIT OBJECT ON OBJECT = V-PUT-ON") puts all the same.
				-- A pattern built without its action is read by its verb word.
				local action = pattern.action or (pattern.verb or ""):upper()
				local standardGift = action == "GIVE" or action == "SHOW"
				local recipient = standardGift and not pattern.reverse
				local container = action:match("^[^-]+") == "PUT"
				-- Handing over or putting away needs the thing in hand first.
				local handed = not pattern.reverse and (action == "PUT" or standardGift)
				local identity = second and (second.identity or second.target or second.noun)
				if second and identity and not paired[identity]
						and (not pattern.partners or pattern.partners[identity])
						and second ~= item
						and (not recipient or traits.actor)
						and (not container or traits.container or traits.surface)
						and (not handed or item.carried)
						and (not (pattern.held or tool or pattern.reverse) or (second and second.carried)) then
					paired[identity] = true
					if pattern.reverse then
						visit(prefix, second, pattern.join, item, pattern, other.label)
					else
						visit(prefix, item, pattern.join, second, pattern, other.label)
					end
				end
			end
		end
	end
end

-- Resolve discovered partners once per query, even if several actions use them.
local function partnersFor(session)
	local lists = {}
	return function(includePast)
		if not lists[includePast] then
			local list = session:interactionTargets(includePast)
			for _, other in ipairs(list) do other.item = linkedItem(session.items, other.target) end
			lists[includePast] = list
		end
		return lists[includePast]
	end
end

function Session:linkActions(target)
	if not self.running then return {} end
	target = Text.lower(trim(target))
	if target == "" then return {} end
	local direction = DIRECTIONS[target]
	local lang = self.language
	if direction then
		return { { title = string.format(lang.goTitle, lang.directionNames and lang.directionNames[direction] or direction),
			command = Language.direction(lang, direction) } }
	end
	local item = linkedItem(self.items, target)
	if not item then return {} end
	local actions, seen = {}, {}
	-- The words that name a thing to the parser. The German parser reads a
	-- single synonym ("Tafel") where the story's phrase adds an adjective
	-- ("Einsatz Tafel"), so a language that says so sends the first synonym
	-- no other visible thing answers to, and the story's phrase otherwise.
	local uses = {}
	for _, other in ipairs(self.items) do
		local words = { [other.noun] = true }
		for _, alias in ipairs(other.aliases or {}) do words[alias] = true end
		for word in pairs(words) do uses[word] = (uses[word] or 0) + 1 end
	end
	local function name(thing, spoken)
		if lang.bareNouns and thing.noun then
			if uses[thing.noun] == 1 then return thing.noun end
			for _, alias in ipairs(thing.aliases or {}) do
				if uses[alias] == 1 then return alias end
			end
		end
		return thing.target or spoken or thing.noun
	end
	visitItemActions(item, partnersFor(self), function(verb, first, join, second, pattern, label)
		local title = Language.title(lang, verb)
		local command = verb .. " " .. name(first, first == item and target or nil)
		if second then
			local glue = join ~= "" and " " .. join or ""
			command = command .. glue .. " " .. name(second, second == item and target or nil)
			title = (join == "about" and lang.ask or title) .. (pattern.reverse and "" or glue) .. " " .. label
		end
		if not seen[command] then
			seen[command] = true
			table.insert(actions, { title = title, command = command })
		end
	end, lang)
	return actions
end

function Session:appendOutput(text, openingTitle)
	local paragraphs = paragraphsOf(text)
	local room = self.roomTitle
	local headingFound = false
	for _, paragraph in ipairs(paragraphs) do
		local first = splitFirstLine(paragraph)
		if (room and first == room) or (not room and looksLikeHeading(first, self.language) and first ~= paragraph) then
			headingFound = true
		end
	end
	-- A move without a printed heading still enters a new room: the scene
	-- opens at the first paragraph that is not the title page.
	-- The opening always starts a scene, even when the engine names no room.
	local pendingRoom = not headingFound and (room or openingTitle)
		and (not self.scene or self.scene.title ~= (room or openingTitle)) and (room or openingTitle) or nil

	for _, paragraph in ipairs(paragraphs) do
		if isBanner(paragraph, self.language) then
			local title, rest = splitFirstLine(paragraph)
			local lines = {}
			for line in (rest or ""):gmatch("[^\n]+") do table.insert(lines, trim(line)) end
			table.insert(self.entries, { kind = "banner", title = title, lines = lines })
			self.openEntry = nil
		else
			local first, rest = splitFirstLine(paragraph)
			local heading = (room and first == room) or (not room and rest and looksLikeHeading(first, self.language))
			if heading then
				if not self.scene or self.scene.title ~= first then
					self:beginScene(first)
				end
				if rest then self:appendParagraph(rest) end
			else
				if pendingRoom then
					self:beginScene(pendingRoom)
					pendingRoom = nil
				end
				self:appendParagraph(paragraph)
			end
		end
	end
end

-- `saved` is a snapshot from `Session:snapshot()`. The story is restored by
-- replaying its commands against an engine seeded as before, which rebuilds
-- the transcript exactly as the reader first saw it.
-- Build the fresh VM and inspect its book-defined setup without entering GO.
-- A normal adventure offers no profiles and uses the same prepared VM.
function Session:prepare(game)
	if not self.engineFactory then return nil, "No session engine configured." end
	local ok, prepared = pcall(function()
		local seed = self.newSeed()
		local builder = self.engineFactory(game, seed)
		local profiles = type(builder.setupProfiles) == "function" and builder:setupProfiles() or {}
		return { gameId = game.id, seed = seed, builder = builder, profiles = profiles }
	end)
	if not ok then return nil, tostring(prepared) end
	return prepared
end

function Session:start(game, saved, setup, prepared)
	if not game then return false, "Adventure not found." end
	if not self.engineFactory then return false, "No session engine configured." end
	local reuse = not saved and prepared and prepared.gameId == game.id and prepared
	local seed = saved and tonumber(saved.seed) or (reuse and reuse.seed) or self.newSeed()
	if saved then setup = saved.setup end
	local ok, engine, opening = pcall(function()
		local builder = reuse and reuse.builder or self.engineFactory(game, seed)
		return builder:start(setup)
	end)
	if not ok then return false, tostring(engine) end
	self:reset()
	self.engine, self.currentGame, self.seed = engine, game, seed
	self.setup = setup and { id = setup.id, name = setup.name } or nil
	-- The story names its language in game.json; English otherwise.
	self.language = Language.of(game.language)
	self:refreshEngineState()
	self:appendOutput(opening, game.title)
	-- Some stories print a cold open. The reader starts with the title page.
	for index, entry in ipairs(self.entries) do
		if entry.kind == "banner" then
			if index > 1 then
				table.remove(self.entries, index)
				table.insert(self.entries, 1, entry)
			end
			break
		end
	end
	for _, command in ipairs(saved and saved.commands or {}) do
		self:submit(command)
	end
	self.scoreChange = 0
	return true
end

function Session:submit(command)
	command = tostring(command or ""):match("^%s*(.-)%s*$")
	if command == "" or not self.engine or not self.running then return false end
	local ok, response = pcall(function() return self.engine:resume(command) end)
	table.insert(self.history, command)
	table.insert(self.entries, { kind = "command", text = command })
	self.openEntry = nil
	local movesBefore, scoreBefore = self.moves, self.score
	self:refreshEngineState()
	if type(self.engine.progress) ~= "function" then
		self.moves = movesBefore + 1
	end
	self.scoreChange = self.score - scoreBefore
	self:appendOutput(response)
	return ok, response
end

-- Everything needed to resume, as plain values for the save store.
function Session:snapshot()
	local game = self.currentGame
	if not game or not self.engine then return nil end
	local commands = {}
	for _, command in ipairs(self.history) do table.insert(commands, command) end
	return {
		gameId = game.id, seed = self.seed, commands = commands,
		setup = self.setup and { id = self.setup.id, name = self.setup.name } or nil,
		room = self.roomTitle or (self.scene and self.scene.title) or game.title,
		score = self.score, maxScore = self.maxScore, moves = self.moves,
	}
end

function Session:suggestions(input)
	if not self.running then return {} end
	if not input or not input:find("%S") then
		return {
			{ title = self.language.lookTitle, command = self.language.look },
			{ title = self.language.inventoryTitle, command = self.language.inventory },
		}
	end
	local partners = partnersFor(self)
	return Suggestions.forInput(input, self.items, function(offer)
		-- Complete the verb even in an empty room. After "take " only
		-- eligible objects from the live parser scope are offered.
		local lang = self.language
		for _, verb in ipairs({ lang.look, lang.inventory, lang.wait, lang.take }) do offer(verb) end
		-- English walks with "go north"; a language with bare compass words offers them.
		for _, exit in ipairs(self.exitList) do
			if next(lang.directions) then offer(Language.direction(lang, exit)) else offer(lang.go, exit) end
		end
		for _, item in ipairs(self.items) do
			if not item.patterns or #item.patterns > 0 then
				visitItemActions(item, partners, offer, lang)
			end
		end
	end, lang)
end

function Session:entryCount()
	return #self.entries
end

-- The prose paragraphs of entries from `first` on, in reading order: what a
-- reader has not seen yet after a command. `entry` is the absolute index.
function Session:paragraphsSince(first)
	local paragraphs = {}
	for index = math.max(1, first), #self.entries do
		for paragraphIndex, text in ipairs(self.entries[index].paragraphs or {}) do
			table.insert(paragraphs, { entry = index, paragraph = paragraphIndex, text = text })
		end
	end
	return paragraphs
end

function Session:transcript(limit)
	limit = limit or TRANSCRIPT.limit
	local entries = {}
	for index = math.max(1, #self.entries - limit + 1), #self.entries do
		table.insert(entries, self.entries[index])
	end
	return entries, math.max(0, #self.entries - limit)
end

-- Infocom status lines: "Score 12 of 350 · 41 moves". Planetfall's MOVES is
-- the ship's chronometer, so its line reads "Time 4602" as the game's does.
function Session.statusLine(game, score, maxScore, moves)
	local lang = Language.of(game and game.language)
	if game and game.statusLine == "moves" then
		return string.format(lang.movesOnly, moves)
	end
	local scoreText = maxScore > 0
		and string.format(lang.score, score, maxScore)
		or string.format(lang.scoreOnly, score)
	if game and game.statusLine == "time" then
		return string.format("%s · " .. lang.time, scoreText, moves)
	end
	return string.format("%s · %d %s", scoreText, moves, moves == 1 and lang.move or lang.moves)
end

function Session:presentation()
	local game = self.currentGame or {}
	local directions = {}
	for direction in pairs(self.availableDirections) do table.insert(directions, direction) end
	table.sort(directions)
	local entries, earlier = self:transcript()
	local scene = self.scene
	return {
		roomTitle = self.roomTitle or (scene and scene.title) or game.title or "",
		entries = entries,
		earlierEntries = earlier,
		score = self.score,
		maxScore = self.maxScore,
		moves = self.moves,
		scoreChange = self.scoreChange,
		progressFraction = self.maxScore > 0 and math.max(0, math.min(1, self.score / self.maxScore)) or 0,
		progress = Session.statusLine(game, self.score, self.maxScore, self.moves),
		availableDirections = directions,
		language = self.language.code,
	}
end

return Session
