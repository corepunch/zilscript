-- QA regressions: words a child types, gentle refusals, no dead ends, and
-- hints that follow the story's state. Each case starts from a fresh game.
local runtime = require("zilscript.runtime")

local function new_game()
  local env = runtime.create_game_env()
  assert(runtime.init(env, true))
  env.require("zilscript")
  assert(runtime.load_modules(env, { "books.bell-grew-leaves.bell-grew-leaves" }, { silent = true }))
  local game = runtime.create_game(env, true)
  game:start()
  return env, game
end

local checks = 0
local function play(game, steps)
  for _, step in ipairs(steps) do
    local command, expect = step, nil
    if type(step) == "table" then command, expect = step[1], step[2] end
    local reply = game:resume(command)
    assert(type(reply) == "string" and reply:match("%S"), command .. " printed nothing")
    local lower = reply:lower()
    for _, failure in ipairs({ "don't know the word", "can't see any", "what do you want", "you can't do that", "isn't one i recognize", "how peculiar", "you hit your head", "reveals nothing" }) do
      assert(not lower:find(failure, 1, true), command .. " failed: " .. reply)
    end
    if expect then
      assert(reply:find(expect, 1, true), command .. " should print '" .. expect .. "' but printed: " .. reply)
    end
    checks = checks + 1
  end
end

-- Hints follow the route, from the tile to the final ring.
do
  local env, game = new_game()
  play(game, {
    { "hint", "signal tile" },
    { "south", "stay up here" },
    { "strike bell", "would never hurt" },
    { "hit bell", "would never hurt" },
    { "examine beam", "carved from one piece" },
    { "look in bell", "hollow and dark" },
    "east",
    { "examine pictures", "three painted pictures" },
    { "help", "Pick up the reed wick" },
    "take wick",
    { "put wick on shelf", "back on the shelf" },
    "take wick", "west",
    { "fit wick in bell", "takes hold" },
    { "hint", "still dry" },
    { "pull wick", "free of the root" },
    { "hang wick on bell", "takes hold" },
    "take wick", "north",
    { "hint", "where the brass spout points" },
    { "examine pin", "sits on a pin" },
    { "examine crack", "hairline crack" },
    { "put wick in water", "still water" },
    { "soak wick", "bowl is empty" },
    { "turn spout", "fills faster" },
    { "hint", "soaking bowl" },
    { "drink from bowl", "teeth ache" },
    { "dip wick", "goes dark" },
  })
  assert(env.WET_WICK and env.LOC(env.WICK) == env.ADVENTURER, "dip soaks the wick and keeps it in hand")
  play(game, {
    "east",
    { "hint", "frost shutter" },
    { "enter shutter", "stay safely on the landing" },
    { "east", "stay safely on the landing" },
    { "look through shutter", "closed" },
    { "pull peg", "lift the peg" },
    { "look through shutter", "small lamp" },
    { "examine lamp", "small lamp" },
    { "hint", "wet wick in the root bell" },
    "west", "south",
    { "put wick in bell", "takes hold" },
    { "hint", "Ring the root bell" },
    { "ring bell", "THE END -- THREE LEAVES FOR YES" },
  })
end

-- A wet wick rung with the shutter closed leaves a leaf that can be examined.
do
  local env, game = new_game()
  play(game, {
    "east", "take wick", "west", "north", "turn spout",
    { "dip wick in water", "goes dark" },
    "south", "put wick in bell",
    { "ring bell", "nowhere to go" },
    { "examine leaf", "tiny pale leaf droops" },
    { "examine bell", "tiny pale leaf droops" },
  })
  assert(env.LOC(env.WICK) == env.BELL, "failed ring keeps the wick in the bell")
  assert(not env.FSETQ(env.SHUTTER, env.OPENBIT), "ring opens nothing by itself")
end

-- Putting the wick ON the bowl or bell works like putting it IN.
do
  local env, game = new_game()
  play(game, {
    "east", "take wick", "west", "north", "turn spout",
    { "put wick on bowl", "goes dark" },
  })
  assert(env.WET_WICK and env.LOC(env.WICK) ~= env.TROUGH, "wick soaked and kept")
  play(game, { "south", { "put wick on bell", "takes hold" } })
  assert(env.LOC(env.WICK) == env.BELL, "wick fitted from PUT ON")
end

print("ok - bell-grew-leaves QA regressions: " .. checks .. " commands checked")
