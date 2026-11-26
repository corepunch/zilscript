#!/usr/bin/env lua
-- check-responses.lua: Every command gets an answer, and every visit a room.
--
-- Usage:
--   lua5.4 scripts/check-responses.lua books/en/blackwood-horror
--
-- A reader who types a command and sees nothing believes the app is broken.
-- Two story defects produce that silence:
--
--   * BRIEF mode. The substrate starts Infocom-style: VERBOSE is off, so a
--     revisited room prints only its name, and a reader that shows room names
--     as headings shows nothing at all. GO must set VERBOSE.
--   * An action routine that ends with an unconditional <RTRUE> after its
--     COND claims every verb it did not handle, so CLIMB, PUSH or TAKE on
--     that object prints nothing instead of the parser's default reply.
--
-- The story is started, every object that sits in a room is visited in a lit
-- room, and a set of common verbs is played on it. An empty reply is a defect.

package.path = "./?.lua;./?/init.lua;" .. package.path
local runtime = require("zilscript.runtime")

local Language = require("zilscript.reader.Language")
local Story = require("zilscript.reader.Story")
local lang -- the story's language, from its game.json

local function new_game(story)
	local env = runtime.create_game_env()
	assert(runtime.init(env, true))
	env.require("zilscript")
	assert(runtime.load_modules(env, { Story.of(story).module }, { silent = true }))
	local game = runtime.create_game(env, true)
	game:start()
	return env, game
end

-- The words a reader would use for each object, from its definition.
local function nouns(story)
	local source = ""
	for _, path in ipairs(Story.of(story).words) do
		local file = assert(io.open(path))
		source = source .. file:read("a") .. "\n"
		file:close()
	end
	local list = {}
	for name, body in source:gmatch("<OBJECT%s+([%w%-]+)(.-)\n\n") do
		local noun = body:match("%(SYNONYM%s+([%w%-\\%%]+)")
		local adjective = body:match("%(ADJECTIVE%s+([%w%-\\%%]+)")
		if noun then
			table.insert(list, {
				name = name,
				words = Language.word(lang, (adjective and adjective .. " " or "") .. noun):lower(),
			})
		end
	end
	return list
end

-- The room an object stands in, through any containers; nil for global
-- objects and for things held nowhere yet.
local function room_of(env, object)
	local location = env.LOC(object)
	for _ = 1, 8 do
		if not location or location == 0 then return nil end
		if env.LOC(location) == env.ROOMS then return location end
		location = env.LOC(location)
	end
end

local problems, checked = 0, 0
for _, story in ipairs({ ... }) do
	lang = Story.of(story).language
	local env, game = new_game(story)
	if not env.VERBOSE then
		problems = problems + 1
		print(story .. ": GO does not set VERBOSE; revisited rooms print only their names")
	end
	for _, entry in ipairs(nouns(story)) do
		local object = env[entry.name:gsub("%-", "_")]
		local room = object and room_of(env, object)
		if room then
			for _, verb in ipairs(lang.probes) do
				env.MOVE(env.WINNER, room)
				env.HERE = room
				env.LIT = true
				local command = verb:format(entry.words)
				checked = checked + 1
				local reply = tostring(game:resume(command) or "")
				if not reply:find("%S") then
					problems = problems + 1
					print(string.format("%s: %s: %q printed nothing", story, entry.name, command))
				elseif reply:find(lang.ended, 1, true) then
					game:resume(lang.restart)
				end
			end
		end
	end
end

print(string.format("%d commands played", checked))
if problems > 0 then
	print(string.format("%d silent response(s)", problems))
	os.exit(1)
end
