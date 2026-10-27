-- Source-informed regression: every step must be present in real reader menus.
-- The separate Python CLI proof crosses save/reload boundaries for every choice.
local runtime = require("zilscript.runtime")
local Session = require("zilscript.reader.Session")
local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, { "books.pocket-weather.pocket-weather" }, { silent = true }))
env.PROSE_LINKS = true
local finishes = 0
local finish = env.FINISH
env.FINISH = function(...) finishes = finishes + 1; return finish(...) end
local game = runtime.create_game(env, true)
local session = Session.new()
session.running = true
session.engine = {
 roomName = function() return tostring(env.HERE) end,
 items = function()
  local items = game:resume("room-items")
  for _, item in ipairs(game:resume("inventory-items")) do table.insert(items, item) end
  return items
 end,
}
local function record(output)
 if finishes == 0 then session:refreshEngineState() end
 session.openEntry = nil
 session:appendOutput(output, tostring(env.HERE))
end
local function choices()
 local result, seen = {}, {}
 local function add(command)
  if not seen[command] then seen[command] = true; table.insert(result, command) end
 end
 for _, command in ipairs({ "look", "inventory", "wait" }) do add(command) end
 local active = false
 for _, entry in ipairs(session.entries) do
  if entry == session.scene then active = true end
  if active then
   for _, links in ipairs(entry.links or {}) do
    for _, link in ipairs(links) do
     for _, action in ipairs(session:linkActions(link.target)) do add(action.command) end
    end
   end
  end
 end
 return result
end
record(game:start())
local commands = {
 "examine official forecast",
 "take weather card",
 "west",
 "take narrow spoon",
 "west",
 "examine laundry apron",
 "take brass button",
 "take soft ribbon",
 "north",
 "give brass button to aster rook",
 "east",
 "spin weather vane",
 "down",
 "east",
 "dig garden gutter with narrow spoon",
 "east",
 "read rain chart",
 "west",
 "west",
 "south",
 "south",
 "open brass weatherbox",
 "take folded report",
 "north",
 "west",
 "inventory",
 "steam folded report over steaming kettle",
 "read folded report",
 "east",
 "north",
 "north",
 "tie wind chime to soft ribbon",
 "east",
 "listen to nimbus cloud",
 "show folded report to nimbus cloud",
 "tell nimbus cloud about pause rule",
 "tell nimbus cloud about promise",
 "west",
 "south",
 "south",
 "inventory",
 "write weather card",
 "give weather card to postmaster mica",
 "east",
 "put weather card in broadcast slot",
 "west",
 "north",
 "drizzle nimbus cloud",
}
local output, largestMenu = nil, 0
for step, wanted in ipairs(commands) do
 local menu, index = choices(), nil
 largestMenu = math.max(largestMenu, #menu)
 local available = {}
 for _, command in ipairs(menu) do available[command] = true end
 if wanted == "give brass button to aster rook" then
  assert(not available["give weather card to aster rook"], "Rook menu does not offer irrelevant card gift")
 end
 if wanted == "dig garden gutter with narrow spoon" then
  assert(available["dig garden gutter with soft ribbon"], "Useful wrong-tool experiment remains available")
 end
 if wanted == "steam folded report over steaming kettle" then
  assert(available["steam folded report over narrow spoon"], "Wrong steam tool remains an understandable experiment")
  assert(not available["steam folded report over baker pip"], "No steaming a person")
  assert(not available["put narrow spoon in folded report"], "No meaningless spoon/report container pairing")
 end
 for candidate, command in ipairs(menu) do if command == wanted then index = candidate; break end end
 assert(index, "Missing menu step " .. step .. ": " .. wanted .. "\n" .. table.concat(menu, "\n"))
 output = game:resume(menu[index])
 assert(type(output) == "string" and output ~= "", "Every choice prints a response")
 record(output)
end
assert(finishes == 1, "Ending must enter FINISH exactly once")
assert(output:find("A FORECAST YOU CAN KEEP", 1, true), "Meaningful ending reached")
assert(env.PUBLISHED and env.AGREED and env.CARD_APPROVED, "Real puzzle state complete")
print("Pocket Weather reader menus: " .. #commands .. " numbered selections reach FINISH; largest menu " .. largestMenu)
