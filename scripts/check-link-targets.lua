#!/usr/bin/env lua
-- check-link-targets.lua: Play each prose link through the parser.
--
-- Usage:
--   lua5.4 scripts/check-link-targets.lua books/blackwood-horror
--
-- check-links.lua proves a link's words exist; this proves the parser takes
-- them. The story is started with PROSE_LINKS set, every room is lit and
-- looked at, and each object link in the description is examined in a fresh
-- game, as a reader's tap would. A reply that the parser did not understand
-- the words, or cannot see the thing, is a broken link. Directions are
-- skipped: exits are the map's business.

package.path = "./?.lua;./?/init.lua;" .. package.path
local runtime = require("zilscript.runtime")

local DIRECTIONS = {
	north = true, south = true, east = true, west = true, up = true, down = true,
	northeast = true, northwest = true, southeast = true, southwest = true,
	ne = true, nw = true, se = true, sw = true, ["in"] = true, out = true,
}

-- Replies that mean the tap did nothing the reader asked for.
local FAILURES = {
	"can't see any", "don't know the word", "noun missing", "verb missing",
	"not recognized", "which .- do you mean", "used the word",
}

local function new_game(story)
	local env = runtime.create_game_env()
	env.PROSE_LINKS = true
	assert(runtime.init(env, true))
	env.require("zilscript")
	assert(runtime.load_modules(env, { story:gsub("/", ".") .. "." .. story:match("([^/]+)$") }, { silent = true }))
	local game = runtime.create_game(env, true)
	game:start()
	return env, game
end

local function rooms(env)
	local list = {}
	-- Object numbers are bytes in the story's tables.
	for id = 1, 255 do
		local ok, location = pcall(env.LOC, id)
		-- Unused numbers can read as ROOMS too; real rooms are land.
		local land, isLand = pcall(env.FSETQ, id, env.RLANDBIT)
		if ok and location == env.ROOMS and land and isLand then table.insert(list, id) end
	end
	return list
end

local function enter(env, room)
	env.MOVE(env.WINNER, room)
	env.HERE = room
	env.FSET(room, env.ONBIT)
end

local problems, checked = 0, 0
for _, story in ipairs({ ... }) do
	local env, game = new_game(story)
	for _, room in ipairs(rooms(env)) do
		enter(env, room)
		local look = tostring(game:resume("look") or "")
		local seen = {}
		for inner in look:gmatch("%[%[(.-)%]%]") do
			local label, target = inner:match("^(.-)%->(.*)$")
			target = (target or inner):lower()
			if not DIRECTIONS[target] and not seen[target] then
				seen[target] = true
				checked = checked + 1
				local probe_env, probe = new_game(story)
				enter(probe_env, room)
				probe:resume("look")
				local reply = tostring(probe:resume("examine " .. target) or ""):lower()
				for _, failure in ipairs(FAILURES) do
					if reply:find(failure) then
						problems = problems + 1
						print(string.format("%s: room %d: [[%s]] -> examine %s: %s", story, room,
							label or inner, target, reply:gsub("%s+$", "")))
						break
					end
				end
			end
		end
	end
end

print(string.format("%d link targets examined", checked))
if problems > 0 then
	print(string.format("%d broken link(s)", problems))
	os.exit(1)
end
