#!/usr/bin/env lua
-- Follow each room link and the links its EXAMINE reply introduces, as a reader and by typing.
-- Usage: lua5.4 scripts/check-link-targets.lua books/en/blackwood-horror
package.path = "./?.lua;./?/init.lua;" .. package.path
local Walk = require("tests.link_walk")
local Text = require("zilscript.text")

local failures = {
	"can't see any", "don't know the word", "noun missing", "verb missing",
	"not recognized", "which .- do you mean", "used the word",
	"sentence isn't one I recognize", "nothing special about",
	"das hier nicht sehen", "welche.-meinst du", "substantiv zu fehlen",
	"verstehe das wort", "ich kenne das wort",
}

local problems, checked, discoveries = 0, 0, 0
local function checkLinks(story, walk, text, snapshot, parent, nextSnapshot)
	local env, seen = walk.env, {}
	local language = walk.session.language
	local examine = language.examine .. " "
	walk.session.entries = {}
	walk:record(text)
	assert(env.SAVE(snapshot))
	for link in text:gmatch("%[%[(.-)%]%]") do
		local label, target = link:match("^(.-)%->(.*)$")
		target, label = Text.lower(target or link), Text.lower(label or link)
		if not language.directions[target] and not seen[link] then
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
			local commands = { [examine .. target] = true }
			-- A German label can be an inflected phrase. The authored target
			-- is the command noun, even when the visible label differs.
			if language.examine == "examine" then commands[examine .. label] = true end
			local menu
			for _, action in ipairs(walk.session:linkActions(target)) do
				if action.command:sub(1, #examine) == examine then menu = action.command; break end
			end
			if menu then commands[menu] = true else report("no EXAMINE action in the reader menu") end
			local object
			for command in pairs(commands) do
				assert(env.RESTORE(snapshot))
				local reply = tostring(walk.game:resume(command) or "")
				if not reply:match("%S") then report(command .. " gave an empty reply") end
				for _, pattern in ipairs(failures) do
					if reply:lower():find(pattern) then report(command .. ": " .. reply); break end
				end
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
	local walk = Walk.new(story:gsub("/", ".") .. "." .. story:match("([^/]+)$"))
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
