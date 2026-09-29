#!/usr/bin/env lua
-- check-links.lua: Validate prose links ([[label]] and [[label->target]]).
--
-- Usage:
--   lua scripts/check-links.lua books/blackwood-horror
--   lua scripts/check-links.lua books/wondertown books/limehouse-killings
--
-- Every .zil file in each story folder is read (tests excepted). A link's
-- target is what the reader's tap gives the parser, so it must be words the
-- story knows: a direction, or a noun from some object's SYNONYM, optionally
-- preceded by words from ADJECTIVE or SYNONYM lists.
--
-- It also reports a link in a DESC (hosts match room names exactly) and
-- unbalanced "[[" or "]]" in a string.
-- Exits non-zero when any problem is found.

local DIRECTIONS = {
	north = true, south = true, east = true, west = true, up = true, down = true,
	northeast = true, northwest = true, southeast = true, southwest = true,
	ne = true, nw = true, se = true, sw = true, ["in"] = true, out = true,
	n = true, s = true, e = true, w = true, u = true, d = true,
}

local function read(path)
	local file = io.open(path, "r")
	if not file then return nil end
	local body = file:read("*a")
	file:close()
	return body
end

local function zil_files(dir)
	local files = {}
	local pipe = io.popen('find "' .. dir .. '" -name "*.zil" -not -path "*/test/*" 2>/dev/null')
	for line in pipe:lines() do table.insert(files, line) end
	pipe:close()
	table.sort(files)
	return files
end

-- Words from every SYNONYM and ADJECTIVE property, lower-cased.
local function vocabulary(sources)
	local nouns, adjectives = {}, {}
	for _, body in ipairs(sources) do
		for kind, list in body:gmatch("%((%u+)%s+([^%)]*)%)") do
			local target = kind == "SYNONYM" and nouns or kind == "ADJECTIVE" and adjectives or nil
			if target then
				for word in list:gmatch("[^%s]+") do target[word:lower()] = true end
			end
		end
	end
	return nouns, adjectives
end

local function line_of(body, position)
	local line = 1
	for _ in body:sub(1, position):gmatch("\n") do line = line + 1 end
	return line
end

local problems = 0
local function report(path, body, position, message)
	problems = problems + 1
	print(string.format("%s:%d: %s", path, line_of(body, position), message))
end

local function check_target(path, body, position, label, target, nouns, adjectives)
	local words = {}
	for word in target:lower():gmatch("[%w'%-]+") do table.insert(words, word) end
	if #words == 0 then
		report(path, body, position, "link [[" .. label .. "]] has no target")
		return
	end
	if #words == 1 and DIRECTIONS[words[1]] then return end
	local noun = words[#words]
	if not nouns[noun] then
		report(path, body, position, string.format("link [[%s]] targets '%s', which no SYNONYM names", label, target))
		return
	end
	for index = 1, #words - 1 do
		if not adjectives[words[index]] and not nouns[words[index]] then
			report(path, body, position, string.format("link [[%s]] targets '%s'; '%s' is no ADJECTIVE or SYNONYM",
				label, target, words[index]))
		end
	end
end

local dirs = { ... }
if #dirs == 0 then
	io.stderr:write("usage: lua scripts/check-links.lua <story-folder> [...]\n")
	os.exit(2)
end

for _, dir in ipairs(dirs) do
	local files, sources = zil_files(dir), {}
	for _, path in ipairs(files) do table.insert(sources, read(path) or "") end
	local nouns, adjectives = vocabulary(sources)
	local links = 0
	for index, path in ipairs(files) do
		local body = sources[index]
		-- Each ZIL string, with its position; ZIL escapes quotes as \".
		local position = 1
		while true do
			local first, last = body:find('"[^"]*"', position)
			if not first then break end
			local text = body:sub(first + 1, last - 1)
			local opens, closes = select(2, text:gsub("%[%[", "")), select(2, text:gsub("%]%]", ""))
			if opens ~= closes then
				report(path, body, first, "unbalanced link markup in \"" .. text:sub(1, 60) .. "\"")
			end
			local context = body:sub(math.max(1, first - 12), first - 1)
			if text:find("[[", 1, true) and context:match("%(DESC%s*$") then
				report(path, body, first, "link in a DESC: \"" .. text .. "\"")
			end
			for inner in text:gmatch("%[%[(.-)%]%]") do
				links = links + 1
				local label, target = inner:match("^(.-)%->(.*)$")
				label, target = label or inner, target or inner
				check_target(path, body, first, label, target, nouns, adjectives)
			end
			position = last + 1
		end
	end
	print(string.format("%s: %d links checked", dir, links))
end

if problems > 0 then
	print(string.format("%d problem(s)", problems))
	os.exit(1)
end
