-- Plays a book the way a reader does: only through the prose links and
-- object menus the portable reader offers. A command that no menu currently
-- offers is refused, so a route that passes is a route a player can tap.
local runtime = require("zilscript.runtime")
local Session = require("zilscript.reader.Session")
local Language = require("zilscript.reader.Language")

local Walk = {}
Walk.__index = Walk

function Walk.new(module, seed)
	local language = module:match("^books%.([^.]+)%.")
	local env = runtime.create_game_env()
	assert(runtime.init(env, true))
	env.require("zilscript")
	assert(runtime.load_modules(env, { module }, { silent = true }), "Could not load " .. module)
	env.PROSE_LINKS = true
	-- The same generator link_play.lua saves with the VM, so a route replays.
	local state = seed or 97
	env.math = setmetatable({ random = function(m, n)
		state = state * 48271 % 2147483647
		local unit = (state - 1) / 2147483646
		if m == nil then return unit end
		if n == nil then m, n = 1, m end
		return m + math.floor(unit * (n - m + 1))
	end }, { __index = math })
	local self = setmetatable({ env = env, finishes = 0, steps = 0, output = "" }, Walk)
	local finish = env.FINISH
	env.FINISH = function(...)
		self.finishes = self.finishes + 1
		return finish(...)
	end
	self.game = runtime.create_game(env, true)
	self.session = Session.new { language = language }
	self.controls = Language.controls(language)
	self.items = {}
	self.session.engine = {
		roomName = function() return self:room() end,
		items = function() return self.items end,
	}
	self:record(self.game:start())
	return self
end

function Walk:room()
	return tostring(self.env.HERE)
end

function Walk:running()
	return self.finishes == 0 and self.game:is_running()
end

function Walk:record(output)
	self.output = output
	if self:running() then
		local items = self.game:resume("room-items")
		for _, item in ipairs(self.game:resume("inventory-items")) do table.insert(items, item) end
		self.items = items
	else
		self.items = {}
	end
	self.session:refreshEngineState()
	self.session.openEntry = nil
	self.session:appendOutput(output, self:room())
end

-- Every action the reader offers now: { label, command, target }.
function Walk:menu()
	local actions, seen = {}, {}
	local function add(label, command, target)
		if seen[command] then return end
		seen[command] = true
		table.insert(actions, { label = label, command = command, target = target or "" })
	end
	if not self:running() then return actions end
	for _, control in ipairs(self.controls) do add(control, control) end
	local active = false
	for _, entry in ipairs(self.session.entries) do
		if entry == self.session.scene then active = true end
		if active then
			for _, links in ipairs(entry.links or {}) do
				for _, link in ipairs(links) do
					for _, action in ipairs(self.session:linkActions(link.target)) do
						add(link.label .. ": " .. action.title, action.command, link.target)
					end
				end
			end
		end
	end
	return actions
end

function Walk:offers(command)
	for _, action in ipairs(self:menu()) do
		if action.command == command then return true end
	end
	return false
end

function Walk:describeMenu()
	local lines = {}
	for _, action in ipairs(self:menu()) do
		table.insert(lines, string.format("  %-40s [%s]", action.command, action.label))
	end
	return table.concat(lines, "\n")
end

-- Chooses one offered command and returns the plain prose it printed.
function Walk:choose(command)
	if not self:offers(command) then
		error(string.format("Step %d: no link offers \"%s\" in %s.\nLast output:\n%s\nOffered:\n%s",
			self.steps + 1, command, self:room(), (Session.parseLinks(self.output)), self:describeMenu()), 0)
	end
	local output = self.game:resume(command)
	self.steps = self.steps + 1
	if type(output) ~= "string" or output:gsub("%s", "") == "" then
		error(string.format("Step %d: \"%s\" printed nothing", self.steps, command), 0)
	end
	self:record(output)
	return (Session.parseLinks(output))
end

-- Plays a route of commands; a step may be { command, expect = "text" }.
function Walk:play(route)
	for _, step in ipairs(route) do
		local command = type(step) == "table" and step[1] or step
		local text = self:choose(command)
		local expect = type(step) == "table" and step.expect
		if expect and not text:lower():find(expect:lower(), 1, true) then
			error(string.format("Step %d: \"%s\" should print \"%s\" but printed:\n%s",
				self.steps, command, expect, text), 0)
		end
	end
	return self
end

return Walk
