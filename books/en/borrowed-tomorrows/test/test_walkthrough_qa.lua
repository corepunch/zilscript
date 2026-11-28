-- Story and companion regressions.
local runtime = require("zilscript.runtime")

local function new_game()
  local env = runtime.create_game_env()
  assert(runtime.init(env, true))
  env.require("zilscript")
  assert(runtime.load_modules(env, { "books.en.borrowed-tomorrows.borrowed-tomorrows" }, { silent = true }))
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
    for _, failure in ipairs({ "don't know the word", "can't see any", "what do you want", "you can't do that", "isn't one i recognize", "you must tell me", "what a concept", "would agree with you", "find nothing unusual", "thrown." }) do
      assert(not lower:find(failure, 1, true), command .. " failed: " .. reply)
    end
    if expect then
      assert(reply:find(expect, 1, true), command .. " should print '" .. expect .. "' but printed: " .. reply)
    end
    checks = checks + 1
  end
end

do
  local env, game = new_game()
  play(game, {
    { "help", "Try opening it" },
    { "attack cabinet", "would never hurt" },
    { "examine door", "little door" },
    { "examine clock", "Lending Hall" },
    { "search cabinet", "lies a tomorrow leaf" },
    { "hint", "Take the tomorrow leaf" },
    { "take leaf", "records your name" },
    { "examine name", "single box" },
    { "unfold leaf", "flat, steady place" },
    { "open leaf", "flat, steady place" },
    { "fold leaf", "as small as it will go" },
    { "hint", "loan receipt" },
    "north",
    { "drink water", "drop left" },
    { "take water", "bone dry" },
    { "put leaf in trough", "dry" },
    { "read receipt", "SUN THE VILLAGE CAN'T USE" },
    { "hint", "folding board" },
    "east",
    { "examine baker", "baker" },
    { "throw leaf over railing", "hold on tight" },
    { "throw leaf at market", "hold on tight" },
  })
  assert(env.LOC(env.LEAF) == env.ADVENTURER, "a thrown page stays in hand")
  play(game, {
    "south",
    { "open folds", "width of your arms" },
    { "fold leaf", "leave it open" },
    { "hint", "reading frame" },
    "drop leaf",
    { "hint", "Pick up the tomorrow leaf" },
    "take leaf", "north",
    { "put leaf in frame", "Both clips hold" },
    { "hint", "Read from the reading frame" },
    { "read frame", "THE END -- ROOM FOR EVERY NAME" },
  })
end

-- Before the loan the trough still runs: drinking and touching are safe.
do
  local env, game = new_game()
  play(game, {
    "north",
    { "drink water", "cool and tastes" },
    { "take water", "hurries on" },
  })
  assert(not env.ON_LOAN, "flavour verbs borrow nothing")
  play(game, {
    "south", "open cabinet", "take leaf", "east",
    { "unfold leaf", "width of your arms" },
  })
  assert(env.WIDE_LOAN, "unfold on the board's room opens the folds")
end

print("ok - borrowed-tomorrows QA regressions: " .. checks .. " commands checked")
