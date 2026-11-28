local Walk = require("tests.story_walk")
local runtime = require("zilscript.runtime")
local Setup = require("zilscript.rpg_setup")
local name = "books.en.the-water-that-answers.the-water-that-answers"

local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, {name}, {silent = true}))
local presets = Setup.profiles(env)
assert(#presets == 3 and presets[1].id == "doctor" and presets[2].id == "reporter" and presets[3].id == "mechanic")
assert(presets[1].rows[1].value == 80 and presets[2].rows[2].value == 70 and presets[3].rows[3].value == 90)
assert(presets[1].rows[4].group == "resources" and presets[1].rows[4].maximum == 65)
assert(not env.RPG_STARTED and env.MOVES == 0)
assert(Setup.select(env, {id = "reporter", name = "Morgan Vale"}))
local fresh = runtime.create_game(env, true)
assert(fresh:start():find("At 02:13", 1, true) and env.HERE == env.PUMP_ROOM and env.MOVES == 0)
local identity, rows = nil, {}
env.SHEET_IDENTITY = function(n, p) identity = {n, p} end
env.SHEET_ROW = function(...) rows[#rows + 1] = {...} end
assert(env.RPG_EXPORT_SHEET() and identity[1] == "Morgan Vale" and identity[2] == "Reporter")
assert(rows[4][1] == "Composure" and rows[4][2] == 55 and rows[4][3] == 55 and rows[4][4] == "resources")

assert(env.INV_TARGET(77, 1) == 77 and env.INV_TARGET(77, 2) == 38 and env.INV_TARGET(77, 5) == 15)
assert(env.INV_TARGET(77, 3) == 0 and env.INV_TARGET(101, 1) == 0)
assert(env.SYSTEM_GRADE(env.HERO, env.A_INTERVIEW, env.INV_HARD, 0) == 0)
assert(env.SYSTEM_GRADE(env.HERO, env.A_INTERVIEW, env.INV_HARD, 35) == 1)
assert(env.SYSTEM_GRADE(env.HERO, env.A_INTERVIEW, env.INV_HARD, 36) == 0)

local function new(rolls)
  local w = Walk.new(name)
  assert(w.output:find("CHOOSE DOCTOR, CHOOSE REPORTER, or CHOOSE MECHANIC", 1, true), w.output)
  local i = 0
  w.env.math = setmetatable({ random = function()
    i = i + 1
    return assert(rolls[i], "unexpected d100 #" .. i)
  end }, {__index = math})
  return w, function(n) assert(i == n, "wanted " .. n .. " rolls, got " .. i) end
end
local function card(w, command)
  for _, choice in ipairs(w.game:resume("choices").choices) do
    if choice.command == command then return choice.label end
  end
end
local function typed(w, command, expected)
  local output = w.game:resume(command)
  assert(type(output) == "string" and output:find(expected, 1, true), command .. ": " .. tostring(output))
  w:record(output)
  return output
end

for i,p in ipairs(presets) do
  local w, count = new({1, 35})
  typed(w, "choose " .. p.id, "At 02:13")
  assert(w.env.MOVES == 0)
  w:play({{"examine tape", expect = "Isolate circuit C"},
    {"search tape", expect = ({"without breathing", "conversation that never took place", "telephone feed"})[i]},
    "east", {"use telephone", expect = "CASE CLOSED"}})
  assert(w.finishes == 1 and w.env.REPORT_DETAIL == i)
  count(2)
end

-- Failure never hides the work order or creates a repeatable roll.
local w, count = new({100, 100, 100})
typed(w, "choose doctor", "At 02:13")
assert(not card(w, "open cover"))
typed(w, "diagnose", "Composure 65 of 65.")
typed(w, "open cover", "until you've tried")
count(0)
w:play({{"examine tape", expect = "lose 5 Composure"}, {"search tape", expect = "failure will be heard"}})
assert(w.env.STAT(w.env.HERO, w.env.A_COMPOSURE) == 48)
assert(card(w, "open cover"):find("failure will be heard", 1, true))
assert(card(w, "listen to track"):find("lose 5 Composure", 1, true))
typed(w, "examine tape", "does not change")
typed(w, "search tape", "already taken")
count(2)
w:play({{"open relay cover", expect = "taps three times"}, {"listen to second track", expect = "five Composure"}})
assert(w.env.STAT(w.env.HERO, w.env.A_COMPOSURE) == 43)
assert(not card(w, "open cover") and not card(w, "listen to track"))
typed(w, "open cover", "no reason to pry")
typed(w, "listen to second track", "Nothing follows")
w:play({"east", {"call telephone", expect = "stays on the line"}})
typed(w, "call telephone", "still on the line")
assert(w.env.STAT(w.env.HERO, w.env.A_COMPOSURE) == 51)
w:play({{"use telephone", expect = "footsteps stop one stair short"}})
assert(w.finishes == 1)
count(3)

local safe, safeCount = new({100})
typed(safe, "choose reporter", "At 02:13")
safe:play({"east", {"use telephone", expect = "I need the work order"}, "west", "examine tape", "east", "call telephone", "west", "listen to second track", "east", {"use telephone", expect = "CASE CLOSED"}})
assert(safe.finishes == 1 and safe.env.STAT(safe.env.HERO, safe.env.A_COMPOSURE) == 46)
safeCount(1)

local retry, retryCount = new({1, 100, 80})
typed(retry, "choose mechanic", "At 02:13")
retry:play({"examine tape", "search tape", {"open relay cover", expect = "a splice"}, "east", {"use telephone", expect = "photograph the splice"}})
assert(retry.finishes == 1 and retry.env.REPORT_DETAIL == 4 and not retry.env.LOUD)
retryCount(3)

print("ok - engine preset roster, exact d100 boundaries, three investigation routes, safe recovery and both pushed outcomes")
