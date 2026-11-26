#!/usr/bin/env lua
-- Follow each room link and the links its EXAMINE reply introduces, as a reader and by typing.
-- Usage: lua5.4 scripts/check-link-targets.lua books/blackwood-horror
package.path = "./?.lua;./?/init.lua;" .. package.path
local Walk = require("tests.link_walk")

local Language = require("zilscript.reader.Language")
-- Set per story from its game.json: compass words, examine verb, failure replies.
local lang, directions = Language.of(nil), {}

local problems, checked, discoveries = 0, 0, 0
local function checkLinks(story, walk, text, snapshot, parent, nextSnapshot)
	local env, seen = walk.env, {}
	walk.session.entries = {}
	walk:record(text)
	assert(env.SAVE(snapshot))
	for link in text:gmatch("%[%[(.-)%]%]") do
		local label, target = link:match("^(.-)%->(.*)$")
		target, label = (target or link):lower(), (label or link):lower()
		if not directions[target] and not seen[link] then
			seen[link] = true
			if parent then discoveries = discoveries + 1 else checked = checked + 1 end
			-- A previous link may have revealed an item or changed the reader's menus.
			assert(env.RESTORE(snapshot))
			walk.session.entries = {}
			walk:record(text)
			local function report(reason)
				problems = problems + 1
				print(string.format("%s / %s / %s[[%s]]: %s", story, env.GETP(env.HERE, env.PQDESC),
					parent and (parent .. " / ") or "", link, reason))
			end
			local commands = { [lang.examine .. " " .. label] = true, [lang.examine .. " " .. target] = true }
			local menu
			for _, action in ipairs(walk.session:linkActions(target)) do
				if action.command:sub(1, #lang.examine + 1) == lang.examine .. " " then menu = action.command; break end
			end
			if menu then commands[menu] = true else report("no examine action in the reader menu") end
			local object
			for command in pairs(commands) do
				assert(env.RESTORE(snapshot))
				local reply = tostring(walk.game:resume(command) or "")
				if not reply:match("%S") then report(command .. " gave an empty reply") end
				if Language.failed(lang, reply) then report(command .. ": " .. reply) end
				if object and env.PRSO ~= object then report(command .. " resolved to a different object") end
				object = env.PRSO
				-- Follow each first reply once, starting immediately after its side effects.
				if nextSnapshot and command == menu and reply:find("[[", 1, true) then
					checkLinks(story, walk, reply, nextSnapshot, command)
				end
			end
		end
	end
end

for _, story in ipairs(arg) do
	lang = Language.ofBook(story)
	directions = Language.compassSet(lang)
	local walk = Walk.new(story:gsub("/", ".") .. "." .. story:match("([^/]+)$"), nil, lang.code)
	local env = walk.env
	local initial, snapshot, followup = os.tmpname(), os.tmpname(), os.tmpname()
	assert(env.SAVE(initial))
	for room = 1, 255 do
		assert(env.RESTORE(initial))
		if env.LOC(room) == env.ROOMS and env.FSETQ(room, env.RLANDBIT) then
			env.MOVE(env.WINNER, room)
			env.HERE, env.LIT = room, true
			env.FSET(room, env.ONBIT)
			env.V_LOOK()
			checkLinks(story, walk, env.TAKE_OUTPUT(), snapshot, nil, followup)
		end
	end
	os.remove(initial)
	os.remove(snapshot)
	os.remove(followup)
end

print(string.format("%d room links and %d follow-up links examined, %d failures", checked, discoveries, problems))
if problems > 0 then os.exit(1) end
