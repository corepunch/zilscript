-- The debug reader uses the application's actual link parser and menus.
-- Only presentation records live beside the world in SAVE's scalar globals;
-- resuming never replays actions or inspects story routines for a solution.
local Session = require("apps.adventure-arena.models.Session")
local M = {}

local function json(value)
	if type(value) == "string" then
		return '"' .. value:gsub('[%z\1-\31\\"]', function(c)
			return string.format("\\u%04x", c:byte())
		end) .. '"'
	elseif type(value) == "number" or type(value) == "boolean" then
		return tostring(value)
	elseif type(value) == "table" then
		local parts = {}
		for _, item in ipairs(value) do table.insert(parts, json(item)) end
		return "[" .. table.concat(parts, ",") .. "]"
	end
	return "null"
end

local function field(value)
	return string.pack(">s4", tostring(value or ""))
end

function M.run(options)
	local args, env, game = options.args, options.env, options.game
	assert(not args.action, "Link play accepts --choose, not --action")
	assert(not (args.new_game and args.choose), "Start a game before choosing an action")
	if not args.new_game then
		assert(options.restored, "Link play requires a VM snapshot; start with --new-game --links")
		assert(env.PLAY_GAME == options.gameName, "Snapshot belongs to another game or mode")
	end
	-- Randomness belongs to the saved VM too. A fresh OS process must not
	-- start a new host PRNG sequence every time the player chooses an action.
	if args.new_game then
		env.PLAY_RANDOM = math.floor(tonumber(args.seed) or 1) % 2147483647
		if env.PLAY_RANDOM <= 0 then env.PLAY_RANDOM = env.PLAY_RANDOM + 2147483646 end
	end
	env.math = setmetatable({ random = function(m, n)
		env.PLAY_RANDOM = env.PLAY_RANDOM * 48271 % 2147483647
		local unit = (env.PLAY_RANDOM - 1) / 2147483646
		if m == nil then return unit end
		if n == nil then m, n = 1, m end
		return m + math.floor(unit * (n - m + 1))
	end }, { __index = math })
	local finish = env.FINISH
	if finish then
		env.FINISH = function(...)
			env.PLAY_ENDED = true
			return finish(...)
		end
	end
	local session = Session.new()
	local currentRoom, currentItems = "", {}
	session.engine = {
		roomName = function() return currentRoom end,
		items = function() return currentItems end,
	}
	local function addRecord(room, output, items)
		currentRoom, currentItems = room, items
		session:refreshEngineState()
		session.openEntry = nil
		session:appendOutput(output, room)
	end
	local records = args.new_game and "" or env.PLAY_READER
	assert(type(records) == "string", "Snapshot has no reader state")
	local position = 1
	local function read()
		local value
		value, position = string.unpack(">s4", records, position)
		return value
	end
	while position <= #records do
		local room, output, count = read(), read(), tonumber(read())
		local items = {}
		for _ = 1, count do
			local name, verbs = read(), {}
			for verb in read():gmatch("[^,]+") do table.insert(verbs, verb) end
			table.insert(items, { name, verbs, {} })
		end
		addRecord(room, output, items)
	end
	local running = not env.PLAY_ENDED
	local function refreshItems()
		local raw = running and game:resume("room-items") or {}
		if running then
			for _, item in ipairs(game:resume("inventory-items")) do table.insert(raw, item) end
		end
		currentItems = raw
		session:refreshEngineState()
	end
	local function choices()
		local actions, seen = {}, {}
		local function add(label, command, target)
			if seen[command] then return end
			seen[command] = true
			table.insert(actions, { label, command, target or "" })
		end
		if not running then return actions end
		for _, control in ipairs({ "look", "inventory", "wait" }) do
			add(control, control)
		end
		local active = false
		for _, entry in ipairs(session.entries) do
			if entry == session.scene then active = true end
			if active then
				for _, links in ipairs(entry.links or {}) do
					for _, link in ipairs(links) do
						for _, action in ipairs(session:linkActions(link.target)) do
							add(link.label .. ": " .. action.title, action.command, link.target)
						end
					end
				end
			end
		end
		return actions
	end
	local output, command
	if args.new_game then
		output = options.start()
	else
		if running then options.start() refreshItems() end
		if args.choose then
			local index = tonumber(args.choose)
			local selected = index and choices()[index]
			assert(selected, "Choose a numbered action from --links")
			command = selected[2]
			output = options.act(command)
		end
	end
	running = game:is_running() and not env.PLAY_ENDED
	if output then
		refreshItems()
		currentItems = require("apps.adventure-arena.helpers.Suggestions").items(currentItems)
		local items, encoded = {}, { field(options.room()), field(output), field(#currentItems) }
		for _, item in ipairs(currentItems) do
			table.insert(items, { item.name, item.verbs, {} })
			table.insert(encoded, field(item.name))
			table.insert(encoded, field(table.concat(item.verbs, ",")))
		end
		records = records .. table.concat(encoded)
		addRecord(options.room(), output, items)
		-- Restore fresh pattern metadata after rebuilding the transcript record.
		refreshItems()
		env.PLAY_GAME, env.PLAY_READER, env.PLAY_ENDED = options.gameName, records, not running
		local nextSave = options.savefile .. ".next"
		local saved, saveError = pcall(function()
			assert(env.SAVE(nextSave), "Could not save VM snapshot")
			assert(os.rename(nextSave, options.savefile))
		end)
		if not saved then os.remove(nextSave) error(saveError, 0) end
		local log = assert(io.open(options.savefile .. ".transcript", args.new_game and "w" or "a"))
		if command then log:write("\n> " .. command .. "\n") end
		log:write(output)
		assert(log:close())
	end
	local plain = Session.parseLinks(output or "")
	return '{"output":' .. json(plain) .. ',"room":' .. json(options.room())
		.. ',"running":' .. json(running) .. ',"actions":' .. json(choices()) .. '}'
end

return M
