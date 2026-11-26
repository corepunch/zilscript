local ending_global = "STATION_END"

local back = {"staff","take-puck","staff-back","gauge"}
local seated = {"staff","take-puck","staff-back","gauge","seat"}
local ready = {"staff","take-puck","staff-back","gauge","seat","test","gauge-back","platform"}
local states = {
 {path={}, room="TICKET_HALL"},
 {path={"staff"}, room="STAFF_ROOM", yes={"take-puck"}},
 {path={"gauge"}, room="GAUGE_ROOM", no={"seat","test"}},
 {path={"platform"}, room="LOWER_PLATFORM", no={"rescue","quarantine"}},
 {path=back, room="GAUGE_ROOM", yes={"seat"}, no={"test"}},
 {path=seated, room="GAUGE_ROOM", yes={"test","recover"}, no={"seat"}},
 {path=ready, room="LOWER_PLATFORM", yes={"rescue","quarantine"}},
}
local endings = {
 ["station.rescue"] = "ENDING: THE EXTRA STOP",
 ["station.quarantine"] = "ENDING: OUTSIDE THE TIMETABLE",
}
local routes = {
 {path=ready,last="rescue",value=1,marker=endings["station.rescue"]},
 {path=ready,last="quarantine",value=2,marker=endings["station.quarantine"]},
}

local runtime = require("zilscript.runtime")
local function new()
  local env = runtime.create_game_env()
  assert(runtime.init(env, true))
  env.require("zilscript")
  assert(runtime.load_modules(env, {"books.en.station-minus-one.station-minus-one"}, {silent=true}))
  assert(env.require("books.en.station-minus-one.companion"))
  env.CAPTURE_RESTART_STATE()
  local game = runtime.create_game(env, true)
  assert(game:start())
  return env, game
end

local function menu(env)
  local query = env.COMPANION_QUERY()
  assert(query.ok and #query.choices > 0, tostring(query.error))
  local choices, seen = {}, {}
  for _, group in ipairs({"scene", "move"}) do
    for _, choice in ipairs(query.choices) do
      if (choice.group or "scene") == group then
        assert(choice.id:match("^station%."), "authored coverage fell back: " .. choice.id)
        assert(not seen[choice.id], "duplicate authored card: " .. choice.id)
        seen[choice.id] = true
        choices[#choices + 1] = choice
      end
    end
  end
  assert(#choices == #query.choices)
  return choices, seen
end

local function select(env, game, choices, index)
  local card = assert(choices[index])
  local parsed = env.COMPANION_SELECT(card.id)
  assert(parsed.ok and parsed.command == card.command)
  local output = tostring(game:resume(parsed.command) or "")
  assert(output:match("%S"), card.id .. " printed nothing")
  for _, rejection in ipairs({"don't know the word", "can't see any", "do you mean", "isn't one I recognize"}) do
    assert(not output:find(rejection, 1, true), card.id .. ": " .. output)
  end
  return output
end

local function choose(env, game, id)
  local choices = menu(env)
  for index, choice in ipairs(choices) do
    if choice.id == "station." .. id then
      return select(env, game, choices, index), index
    end
  end
  error("no visible number for " .. id)
end

local function replay(env, game, path)
  local numeric = {}
  for _, id in ipairs(path) do
    local _, index = choose(env, game, id)
    numeric[#numeric+1] = index
  end
  return numeric
end

-- The same numbered grouping/order as main.lua's noninteractive reader.
-- At each checkpoint query twice, then execute every authored card from a
-- matching saved state. Endings get a fresh coroutine since FINISH yields
-- at the restart prompt rather than the normal parser prompt.
local checked = 0
for _, state in ipairs(states) do
  local env, game = new()
  replay(env, game, state.path)
  assert(env.HERE == env[state.room], state.room)
  local turns = env.MOVES
  local choices, seen = menu(env)
  assert(#choices == #menu(env) and env.MOVES == turns)
  for _, id in ipairs(state.no or {}) do assert(not seen["station." .. id], "premature card: " .. id) end
  for _, id in ipairs(state.yes or {}) do assert(seen["station." .. id], "missing card: " .. id) end
  local snapshot = os.tmpname()
  assert(env.SAVE(snapshot))
  for index, card in ipairs(choices) do
    local ending = endings[card.id]
    if ending then
      local fresh, alternate = new()
      replay(fresh, alternate, state.path)
      local output = select(fresh, alternate, menu(fresh), index)
      assert(output:find(ending, 1, true), output)
    else
      assert(env.RESTORE(snapshot))
      select(env, game, choices, index)
    end
    checked = checked + 1
  end
  os.remove(snapshot)
end

for _, route in ipairs(routes) do
  local env, game = new()
  local numbers = replay(env, game, route.path)
  local output, last = choose(env, game, route.last)
  numbers[#numbers+1] = last
  print(route.marker .. ": " .. table.concat(numbers, " "))
  assert(output:find(route.marker, 1, true), output)
  assert(env[ending_global] == route.value, "wrong narrative state after numbered choice")
end
print("station-minus-one: " .. checked .. " authored card executions; " .. #routes .. " numeric-only endings")
