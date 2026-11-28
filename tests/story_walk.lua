local runtime = require("zilscript.runtime")
local Walk = {}
Walk.__index = Walk

function Walk.new(module, seed)
	local env = runtime.create_game_env()
	assert(runtime.init(env, true))
	env.require("zilscript")
	assert(runtime.load_modules(env, { module }, { silent = true }), "Could not load " .. module)
	env.END_WITHOUT_PROMPT = true
	local state = seed or 97
	env.math = setmetatable({ random = function(m, n)
		state = state * 48271 % 2147483647
		local unit = (state - 1) / 2147483646
		if m == nil then return unit end
		if n == nil then m, n = 1, m end
		return m + math.floor(unit * (n - m + 1))
	end }, { __index = math })

	local self = setmetatable({ env = env, finishes = 0, steps = 0 }, Walk)
	local finish = env.FINISH
	env.FINISH = function(...)
		self.finishes = self.finishes + 1
		return finish(...)
	end
	self.game = runtime.create_game(env, true)
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
end

function Walk:command(command)
	assert(self:running(), "The story has ended")
	local output = self.game:resume(command)
	self.steps = self.steps + 1
	assert(type(output) == "string" and output:find("%S"),
		string.format('Step %d: "%s" printed nothing', self.steps, command))
	self:record(output)
	return output
end

function Walk:play(route)
	for _, step in ipairs(route) do
		local command = type(step) == "table" and step[1] or step
		local output = self:command(command)
		local expect = type(step) == "table" and step.expect
		if expect and not output:lower():find(expect:lower(), 1, true) then
			error(string.format('Step %d: "%s" should print "%s" but printed:\n%s',
				self.steps, command, expect, output), 0)
		end
	end
	return self
end

return Walk
