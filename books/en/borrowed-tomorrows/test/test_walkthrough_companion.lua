-- Exercise every offered card at each checkpoint from an isolated save.
-- The winning route selects numbered entries; no winning step injects parser text.
local runtime = require("zilscript.runtime")
local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, { "books.en.borrowed-tomorrows.borrowed-tomorrows" }, { silent = true }))

local game = runtime.create_game(env, true)
local finished, executed = 0, 0
local finish = env.FINISH
env.FINISH = function(...)
  finished = finished + 1
  return finish(...)
end
game:start()
local initial, snapshot = os.tmpname(), os.tmpname()
assert(env.SAVE(initial))
local function query()
  local offer = env.COMPANION_QUERY()
  assert(offer.ok, tostring(offer.error))
  assert(#offer.choices >= 2, "no useful choices in " .. tostring(env.HERE))
  return offer.choices
end
local function choose(number)
  local card = assert(query()[number], "number not offered")
  local selected = env.COMPANION_SELECT(card.id)
  assert(selected.ok, card.id .. ": " .. tostring(selected.error))
  local reply = game:resume(selected.command)
  assert(type(reply) == "string" and reply:match("%S"), card.id .. " printed nothing")
  local lower = reply:lower()
  for _, failure in ipairs({ "not recognized", "don't know the word", "can't see any", "need to be more specific", "which .- do you mean", "isn't one i recognize", "you used the word" }) do
    assert(not lower:find(failure), card.id .. " failed: " .. reply)
  end
  executed = executed + 1
  return reply
end
local function probe()
  assert(env.SAVE(snapshot))
  local choices = query()
  for i, card in ipairs(choices) do
    assert(card.id:sub(1, 9) ~= "fallback.", card.id)
    assert(query()[i].id == card.id, "query changed choice order")
    if card.id ~= "terrace.read" then
      choose(i)
    else
      -- Endings enter a different READ loop and are tested by the actual route.
      -- A possible early ring can still be tested safely when not ready.
      local status = env.LOC(env.LEAF) == env.FRAME
      if not status then choose(i) end
    end
    assert(env.RESTORE(snapshot))
  end
end
for _, commands in ipairs({
  { "close lending cabinet", "drop tomorrow leaf" },
  { "north" },
  { "north", "read receipt", "east", "drop leaf" },
  { "east", "put leaf in board", "drop leaf" },
}) do
  assert(env.RESTORE(initial))
  for _, command in ipairs(commands) do game:resume(command) end
  probe()
end
assert(env.RESTORE(initial))

local route = {
  { "hall.open", "lies a tomorrow leaf" },
  { "hall.borrow", "records your name" },
  { "hall.basin", "backed out" },
  { "basin.receipt", "SUN THE VILLAGE CAN'T USE" },
  { "basin.terrace", "shadows have stopped" },
  { "terrace.fit", "won't reach" },
  { "terrace.folding", "folding board" },
  { "folding.guide", "OPEN THE OLD FOLDS" },
  { "folding.widen", "width of your arms" },
  { "folding.terrace", "reading frame" },
  { "terrace.fit", "Both clips hold" },
  { "terrace.unfit", "Taken" },
  { "terrace.fit", "Both clips hold" },
  { "terrace.read", "THE END -- ROOM FOR EVERY NAME" },
}
for step, entry in ipairs(route) do
  probe()
  local number
  for i, card in ipairs(query()) do
    if card.id == entry[1] then number = i break end
  end
  assert(number, "step " .. step .. " missing authored choice " .. entry[1])
  local reply = choose(number)
  assert(reply:find(entry[2], 1, true), "step " .. step .. ": " .. reply)
end
assert(finished == 1, "expected exactly one FINISH")
game:resume("quit")
assert(not game:is_running(), "quit should leave FINISH")
os.remove(initial)
os.remove(snapshot)
print("ok - borrowed-tomorrows: " .. #route .. " numbered choices to ROOM FOR EVERY NAME; " .. executed .. " authored actions checked")
