local Text = require((...):match("^(.*)%.reader%.Suggestions$") .. ".text")
-- Command completion and vocabulary from the running story.
local namespace = (...):match("^(.*)%.Suggestions$")
local Language = require(namespace .. ".Language")

local Suggestions = {}

local LIMIT = 3

local DIRECTIONS = {
	"north", "south", "east", "west", "northeast", "northwest",
	"southeast", "southwest", "up", "down", "in", "out",
}


local function startsWith(text, prefix)
	return prefix == "" or text:sub(1, #prefix) == prefix
end

-- Engine action names are ZIL identifiers such as LOOK-BEHIND.
local function playerVerb(action)
	return (tostring(action):lower():gsub("-", " "))
end

-- "small mailbox" is typed as "mailbox": ZIL parsers match the final noun.
function Suggestions.noun(name)
	local words = {}
	for word in Text.lower(tostring(name or "")):gmatch("[%w'\128-\255]+") do table.insert(words, word) end
	return words[#words]
end

-- Flatten engine room items ({ name, verbs, children }) into nouns the
-- parser understands, keeping nested contents such as a leaflet in a mailbox.
function Suggestions.items(raw)
	local items, seen = {}, {}
	local function visit(list)
		for _, entry in ipairs(type(list) == "table" and list or {}) do
			local name = type(entry) == "table" and entry[1] or entry
			local noun = Suggestions.noun(name)
			local identity = type(entry) == "table" and (entry[9] or entry[5]) or noun
			identity = identity or noun
			if noun and not seen[identity] then
				seen[identity] = true
				local verbs = {}
				for _, action in ipairs(type(entry) == "table" and entry[2] or {}) do
					table.insert(verbs, playerVerb(action))
				end
				table.insert(items, { name = tostring(name), noun = noun, verbs = verbs,
					patterns = type(entry) == "table" and entry[4] or nil,
					target = type(entry) == "table" and entry[5] or nil,
					carried = type(entry) == "table" and entry[6] or false,
					aliases = type(entry) == "table" and entry[7] or nil,
					traits = type(entry) == "table" and entry[8] or nil,
					identity = identity })
			end
			if type(entry) == "table" then visit(entry[3]) end
		end
	end
	visit(raw)
	return items
end

-- The verbs the story accepts for an item that make whole commands on
-- their own, best known first; verbs outside the common set keep the
-- story's order after them.
-- A syntax that needs its object in hand (HAVE) fails with "You don't have
-- the reed wick." until the reader holds it, unless TAKE lets the parser
-- pick it up first. A reversed gift names the actor first; its HAVE object
-- is the partner, which the caller checks.
function Suggestions.inHand(item, pattern)
	return not pattern.have or pattern.reverse or item.carried
		or (pattern.take and item.traits ~= nil and item.traits.pickable) or false
end

-- `language` is a Language table (English when omitted).
function Suggestions.oneTapVerbs(item, language)
	language = Language.of(language)
	local VERB_RANK, VERBS = language.rank, language.verbs
	local verbs = {}
	if item.patterns then
		local seen = {}
		for _, pattern in ipairs(item.patterns) do
			if pattern.join == nil and Suggestions.inHand(item, pattern) then
				local verb = pattern.verb .. (pattern.prefix ~= "" and " " .. pattern.prefix or "")
				if not seen[verb] then
					seen[verb] = true
					table.insert(verbs, { verb = verb, rank = VERB_RANK[verb] or (#VERBS + #verbs) })
				end
			end
		end
		table.sort(verbs, function(a, b) return a.rank < b.rank end)
		local names = {}
		for _, entry in ipairs(verbs) do table.insert(names, entry.verb) end
		return names
	end
	for index, verb in ipairs(item.verbs or {}) do
		if not language.needsSecond[verb] then
			table.insert(verbs, { verb = verb, rank = VERB_RANK[verb] or (#VERBS + index) })
		end
	end
	table.sort(verbs, function(a, b) return a.rank < b.rank end)
	local names = {}
	for _, entry in ipairs(verbs) do table.insert(names, entry.verb) end
	return names
end

-- Use a short parser noun when it identifies just one object. Two keys
-- stay "brass key" and "iron key", including when the player starts with k.
local function nounCounts(items)
	local counts = {}
	for _, item in ipairs(items) do
		if not item.patterns or #item.patterns > 0 then
			local seen = {}
			for _, alias in ipairs(item.aliases or {}) do seen[alias] = true end
			seen[Suggestions.noun(item.target or item.noun)] = true
			for word in pairs(seen) do counts[word] = (counts[word] or 0) + 1 end
		end
	end
	return counts
end

-- Walk the grammatical slots of a single available command against the
-- draft. A slot may be an entire noun phrase, such as "brass key".
function Suggestions.forInput(input, items, visit, language)
	language = Language.of(language)
	local VERB_RANK = language.rank
	local draft = Text.lower(input):gsub("^%s+", ""):gsub("%s+", " ")
	local choices, seen, counts = {}, {}, nounCounts(items)
	local function offer(verb, first, join, second)
		if verb == language.take and first and first.traits and first.traits.takeable == false then return end
		local rest = draft
		local function match(slot)
			local name, short
			if type(slot) == "table" then
				name = slot.target or slot.noun
				short = Suggestions.noun(name)
			else
				name = slot
			end
			if not name or name == "" then return true end
			local preferred = short and counts[short] == 1 and short or name
			local spellings = { name, preferred }
			-- A player may already have named an object by any synonym the
			-- parser knows. Continue to the next slot only when that synonym
			-- identifies one visible object, just as for the short noun.
			if type(slot) == "table" then
				for _, alias in ipairs(slot.aliases or {}) do
					if counts[alias] == 1 then table.insert(spellings, alias) end
				end
			end
			for _, spelling in ipairs(spellings) do
				if startsWith(rest, spelling .. " ") then
					rest = rest:sub(#spelling + 2)
					return true
				end
			end
			local title
			if startsWith(preferred, rest) then title = preferred
			elseif startsWith(name, rest) or (short and startsWith(short, rest)) then title = name end
			if title and not seen[title] then
				seen[title] = true
				table.insert(choices, { title = title, text = draft:sub(1, #draft - #rest) .. title .. " ",
					rank = rest == draft and VERB_RANK[verb] or nil, order = #choices + 1 })
			end
			return false
		end
		if match(verb) and match(first) and match(join) then match(second) end
	end
	visit(offer)
	table.sort(choices, function(a, b)
		local ar, br = a.rank or math.huge, b.rank or math.huge
		if ar ~= br then return ar < br end
		return a.order < b.order
	end)
	local result = {}
	for i = 1, math.min(LIMIT, #choices) do
		table.insert(result, { title = choices[i].title, text = choices[i].text })
	end
	return result
end

Suggestions.DIRECTIONS = DIRECTIONS

return Suggestions
