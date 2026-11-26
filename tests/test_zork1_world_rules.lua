-- Zork I keeps the special cases that left the English world verbs: they now
-- live in Zork I's own actions (TREE-F, TREE-ROOM, MIRROR-ROOM, SANDY-CAVE-F,
-- WATER-F, PUTTY-FCN, JIGS-UP) and in the world routines Zork I replaces
-- (SCORE-UPD, FIRSTER, V-SWIM, SHAKE-LOOP). Each case plays the packaged
-- story, infocom.zork1.zork1, and expects the replies Zork I always gave.
local test = require 'tests.test_framework'
local runtime = require 'zilscript.runtime'

local function story(room, setup)
	local env = runtime.create_game_env()
	assert(runtime.init(env, true))
	env.require("zilscript")
	assert(runtime.load_modules(env, { "infocom.zork1.zork1" }, { silent = true }))
	local game = runtime.create_game(env, true)
	game:start()
	env.MOVE(env.WINNER, env[room])
	env.HERE = env[room]
	env.LIT = true
	env.FSET(env.HERE, env.TOUCHBIT)
	if setup then setup(env) end
	env.TAKE_OUTPUT()
	return game, env
end

local function give(env, ...)
	for _, name in ipairs({ ... }) do env.MOVE(env[name], env.WINNER) end
end

test.describe("Zork I world rules", function(t)
	t.it("climbs only the tree beside the path", function(assert)
		local game = story("FOREST_1")
		assert.assert_match(game:resume("climb down tree"), "^There are no climbable trees here%.")
		assert.assert_match(game:resume("climb tree"), "^There is no tree here suitable for climbing%.")
		game = story("PATH")
		assert.assert_match(game:resume("climb down tree"), "^You can't do that!")
		assert.assert_match(game:resume("climb tree"), "10 feet above the ground")
	end)

	t.it("jumps down from the tree and shakes things onto the path", function(assert)
		local game, env = story("UP_A_TREE")
		assert.assert_match(game:resume("jump"), "^In a feat of unaccustomed daring")
		assert.assert_equal(env.HERE, env.PATH)
		game, env = story("UP_A_TREE", function(e) give(e, "SANDWICH_BAG") e.FSET(e.SANDWICH_BAG, e.OPENBIT) end)
		assert.assert_match(game:resume("shake sack"), "^The contents of the brown sack spill to the ground%.")
		assert.assert_equal(env.LOC(env.GARLIC), env.PATH)
		game = story("FOREST_1")
		assert.assert_match(game:resume("jump over tree"), "^That would be a good trick%.")
	end)

	t.it("turns the black book's pages by hand", function(assert)
		local game = story("SOUTH_TEMPLE", function(e) give(e, "BOOK", "SWORD") end)
		assert.assert_match(game:resume("turn book"), "^Beside page 569")
		assert.assert_match(game:resume("turn sword"), "^Your bare hands don't appear to be enough%.")
	end)

	t.it("sees a tired image in the mirror rooms only", function(assert)
		assert.assert_match(story("MIRROR_ROOM_1"):resume("examine me"), "^Your image in the mirror looks tired%.")
		assert.assert_match(story("MIRROR_ROOM_2"):resume("examine me"), "^Your image in the mirror looks tired%.")
		assert.assert_match(story("LIVING_ROOM"):resume("examine me"), "^That's difficult unless your eyes are prehensile%.")
	end)

	t.it("digs the sandy cave's ground as sand", function(assert)
		local game = story("SANDY_CAVE", function(e) give(e, "SHOVEL", "SWORD") end)
		assert.assert_match(game:resume("dig ground with shovel"), "^You seem to be digging a hole here%.")
		assert.assert_match(game:resume("put sword on ground"), "^Dropped%.")
		game = story("SANDY_BEACH", function(e) give(e, "SHOVEL") end)
		assert.assert_match(game:resume("dig ground with shovel"), "^The ground is too hard for digging here%.")
	end)

	t.it("drinks, fills, swims and pours its water", function(assert)
		local game = story("STREAM_VIEW", function(e) give(e, "BOTTLE") end)
		assert.assert_match(game:resume("drink water"), "^Thank you very much%. I was rather thirsty")
		assert.assert_match(game:resume("swim in water"), "^Swimming isn't usually allowed in the dungeon%.")
		assert.assert_match(game:resume("board water"), "^Swimming isn't usually allowed in the dungeon%.")
		assert.assert_match(game:resume("swim in bottle"), "^Swimming isn't usually allowed in the glass bottle%.")
		game:resume("open bottle")
		assert.assert_match(game:resume("fill bottle"), "^The bottle is now full of water%.")
		assert.assert_match(game:resume("pour water on bottle"), "^The water spills over the glass bottle, to the floor, and evaporates%.")
		local env
		game, env = story("KITCHEN")
		game:resume("take bottle")
		game:resume("open bottle")
		assert.assert_match(game:resume("drink water"), "^Thank you very much")
		assert.assert_false(env.LOC(env.WATER) == env.BOTTLE, "drinking the bottle's water uses it up")
		assert.assert_match(game:resume("fill bottle"), "^There is nothing to fill it with%.")
		assert.assert_match(game:resume("swim"), "^Go jump in a lake!")
		game = story("KITCHEN", function(e) give(e, "BOTTLE", "CANDLES") e.FSET(e.BOTTLE, e.OPENBIT) end)
		assert.assert_match(game:resume("pour water on candles"), "^The pair of candles is extinguished%.")
	end)

	t.it("pours the gunk as putting it", function(assert)
		local game = story("KITCHEN", function(e) give(e, "PUTTY", "BOTTLE") end)
		assert.assert_match(game:resume("pour gunk on bottle"), "^The all%-purpose gunk isn't a lubricant%.")
		assert.assert_match(game:resume("pour bottle on gunk"), "^You can't pour that%.")
	end)

	t.it("lists the trophy case as a collection of treasures", function(assert)
		local game = story("LIVING_ROOM", function(e) e.MOVE(e.PAINTING, e.TROPHY_CASE) e.FSET(e.PAINTING, e.TOUCHBIT) end)
		assert.assert_match(game:resume("look"), "Your collection of treasures consists of:\n  A painting")
	end)

	t.it("reveals the final secret at 350 points", function(assert)
		local game, env = story("GALLERY", function(e) e.SCORE = 346 e.BASE_SCORE = 346 end)
		assert.assert_match(game:resume("take painting"), "^An almost inaudible voice whispers in your ear")
		assert.assert_false(env.FSETQ(env.MAP, env.INVISIBLE), "the map appears")
	end)

	t.it("describes the gates of Hades once after dying there", function(assert)
		local setup = function(e) give(e, "SWORD") e.FSET(e.SOUTH_TEMPLE, e.TOUCHBIT) end
		local out = story("ENTRANCE_TO_HADES", setup):resume("attack me with sword")
		assert.assert_match(out, "gates of Hell")
		assert.assert_false(out:find("Abandon every hope", 1, true) ~= nil, out)
		out = story("LIVING_ROOM", setup):resume("attack me with sword")
		assert.assert_match(out, "Abandon every hope")
	end)
end)
