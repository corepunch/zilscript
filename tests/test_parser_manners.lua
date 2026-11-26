-- Shared parser and world-verb behavior on a two-room fixture story:
-- ALL never reaches the global objects, an empty ALL says why, names keep
-- no article, break characters are words, and a bare verb asks the right
-- question; plural things take "some" and a plural verb, and the topic of
-- ASK ... ABOUT may be anywhere.
local test = require 'tests.test_framework'
local runtime = require 'zilscript.runtime'

local function story()
	local env = runtime.create_game_env()
	assert(runtime.init(env, true))
	env.require("zilscript")
	assert(runtime.load_modules(env, { "tests.fixtures.parser-manners.parser-manners" }, { silent = true }))
	local game = runtime.create_game(env, true)
	game:start()
	return game
end

test.describe("Parser manners", function(t)
	t.it("keeps ALL to what is here and carried", function(assert)
		local game = story()
		local out = game:resume("drop all")
		assert.assert_match(out, "You aren't carrying anything%.")
		assert.assert_false(out:find("zorkmid", 1, true) ~= nil, out)
		out = game:resume("examine all")
		assert.assert_false(out:find("number", 1, true) ~= nil or out:find("blessings", 1, true) ~= nil, out)
		out = game:resume("take all")
		assert.assert_match(out, "tin box")
		assert.assert_match(game:resume("drop all"), "Dropped")
	end)

	t.it("prints names without an article", function(assert)
		local game = story()
		local out = game:resume("hello ruth")
		assert.assert_match(out, "^Ruth Bell nods to you in greeting%.")
		assert.assert_match(game:resume("hello guard"), "^The night guard nods to you in greeting%.")
		game:resume("take box")
		assert.assert_match(game:resume("give box to ruth"), "^Ruth Bell refuses it politely%.")
	end)

	t.it("reads break characters as words", function(assert)
		local game = story()
		local out = game:resume("look. inventory")
		assert.assert_match(out, "small parlour")
		assert.assert_match(out, "empty%-handed")
		assert.assert_false(game:resume("ruth, hello"):find("I don't know the word", 1, true) ~= nil)
	end)

	t.it("reads him and her as the last person, it as the last thing", function(assert)
		local game = story()
		game:resume("take box")
		game:resume("hello ruth")
		game:resume("examine box")
		assert.assert_match(game:resume("give it to her"), "^Ruth Bell refuses it politely%.")
		assert.assert_match(game:resume("hello him"), "^Ruth Bell nods")
	end)

	t.it("asks what to examine, not what to examine on", function(assert)
		local game = story()
		assert.assert_match(game:resume("x"), "What do you want to x%?")
		game = story()
		game:resume("take box")
		assert.assert_match(game:resume("give box"), "give the box to%?")
		game = story()
		game:resume("take box")
		assert.assert_match(game:resume("put box"), "put the box in%?")
	end)

	t.it("cuts input longer than the buffer instead of overwriting memory", function(assert)
		local game = story()
		game:resume(string.rep("examine box ", 40))
		assert.assert_match(game:resume("look"), "small parlour")
	end)

	t.it("speaks of plural things in the plural", function(assert)
		local game = story()
		local out = game:resume("look")
		assert.assert_match(out, "There is a tin box here%.")
		assert.assert_match(out, "There are some cobwebs here%.")
		assert.assert_match(game:resume("listen to cobwebs"), "^The cobwebs make no sound%.")
		assert.assert_match(game:resume("listen to box"), "^The tin box makes no sound%.")
		assert.assert_match(game:resume("examine pots"), "^The copper pots are closed%.")
		assert.assert_match(game:resume("knock on pots"), "^Why knock on some copper pots%?")
		game:resume("open pots")
		assert.assert_match(game:resume("look in pots"), "^The copper pots are empty%.")
		game:resume("take pots")
		assert.assert_match(game:resume("inventory"), "\n  Some copper pots")
	end)

	t.it("asks about people and things that are not here", function(assert)
		local game = story()
		assert.assert_match(game:resume("ask ruth about rose"), "pride of the garden")
		assert.assert_match(game:resume("tell ruth about ada"), "Ada keeps the garden")
		-- No handler for the topic: the default reply, not "can't see any".
		local out = game:resume("ask guard about rose")
		assert.assert_match(out, "^The night guard doesn't answer that%.")
		-- A topic elsewhere does not overhear: Ada's own handler stays out of it.
		assert.assert_match(game:resume("ask guard about ada"), "^The night guard doesn't answer that%.")
		-- Shut away out of sight, still a topic.
		assert.assert_match(game:resume("ask guard about seed"), "^The night guard doesn't answer that%.")
		-- The person asked must still be here, and other verbs keep their scope.
		assert.assert_match(game:resume("ask ada about rose"), "You can't see any ada here!")
		assert.assert_match(game:resume("examine rose"), "You can't see any rose here!")
		assert.assert_match(game:resume("take seed"), "You can't see any seed here!")
		-- Here, the person spoken of still has her say, as before.
		game:resume("north")
		assert.assert_match(game:resume("ask ada about ada"), "Weeds first")
	end)

	t.it("never kills the player in a world verb", function(assert)

		local game = story()
		game:resume("take box")
		assert.assert_match(game:resume("throw box at me"), "bounces off you")
		assert.assert_match(game:resume("look"), "small parlour")
	end)
end)

local success = test.summary()
os.exit(success and 0 or 1)
