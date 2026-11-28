local Session = require("zilscript.reader.Session")
local Walk = require("tests.story_walk")

local walk = Walk.new("tests.completion-verbs.completion-verbs")
local session = Session.new()
session.engine = {
	items = function()
		local items = walk.game:resume("room-items")
		for _, item in ipairs(walk.game:resume("inventory-items")) do table.insert(items, item) end
		return items
	end,
}
local function completes(input, text)
	session:refreshEngineState()
	for _, choice in ipairs(session:suggestions(input)) do
		if choice.text == text then return true end
	end
	return false
end

assert(not completes("shake peb", "shake pebble "), "shaking needs the pebble in hand")
assert(completes("twirl peb", "twirl pebble "), "the parser can pick up the pebble first")
assert(not completes("twirl boul", "twirl boulder "), "the boulder cannot be picked up")
walk:command("twirl pebble")
assert(completes("shake peb", "shake pebble "))
assert(completes("put pebble on sh", "put pebble on shelf "))
assert(not completes("put pebble on boul", "put pebble on boulder "), "the boulder is not a surface")
walk:command("put pebble on shelf")
assert(not completes("shake peb", "shake pebble "))
print("ok - typed completion follows parser and object state")
