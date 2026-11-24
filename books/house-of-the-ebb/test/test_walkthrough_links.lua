local Walk = require("tests.link_walk")
local Session = require("zilscript.reader.Session")
local route1 = {
  {"north", expect="Kit"},
  "examine younger kit",
  "west",
  {"examine child mug", expect="K. R."},
  "east",
  "east",
  {"read old sheet", expect="third was never there"},
  "west",
  "north",
  {"read signal plate", expect="private vigil"},
  "up",
  {"spin signal lens", expect="closed shutter"},
  "open seaward shutter",
  {"spin signal lens", expect="empty berth"},
  "east",
  {"ring witness bell", expect="THE END: THE SHORE HEARS"}
}
local game1 = Walk.new("books.house-of-the-ebb.house-of-the-ebb")
game1:play(route1)
assert(game1.finishes == 1 and not game1:running() and #game1:menu() == 0, "witness")
local route2 = {
  {"north", expect="Kit"},
  "examine younger kit",
  "west",
  {"examine child mug", expect="K. R."},
  "east",
  "east",
  {"read old sheet", expect="third was never there"},
  "west",
  "north",
  {"read signal plate", expect="private vigil"},
  "up",
  {"spin signal lens", expect="closed shutter"},
  "open seaward shutter",
  {"spin signal lens", expect="empty berth"},
  "east",
  {"pull clapper brake", expect="THE END: THE LIGHT STAYS"}
}
local game2 = Walk.new("books.house-of-the-ebb.house-of-the-ebb")
game2:play(route2)
assert(game2.finishes == 1 and not game2:running() and #game2:menu() == 0, "vigil")

local module = "books.house-of-the-ebb.house-of-the-ebb"

-- Exercise the authored companion (not the prose-link menu) through each route.
local function check_companion(route)
  local w = Walk.new(module)
  local seen = {}
  assert(w.env.SUGGEST_ACTIONS, "authored companion loaded")
  for _, step in ipairs(route) do
    local expected = type(step) == "table" and step.expect
    local command = type(step) == "table" and step[1] or step
    local state = w:room()
    seen[state] = true
    local choices = w.env.COMPANION_QUERY()
    assert(choices.ok and #choices.choices > 0, state)
    local id
    for _, card in ipairs(choices.choices) do
      assert(not card.id:match("^fallback"), "unexpected fallback in " .. state)
      if card.command == command then id = card.id end
    end
    local choice = w.env.COMPANION_SELECT(assert(id, "missing authored choice: " .. command .. " in " .. state))
    assert(choice.ok and choice.command == command)
    local output = w.game:resume(choice.command)
    assert(type(output) == "string" and output:match("%S"), command)
    if expected then assert((Session.parseLinks(output)):find(expected, 1, true), command .. ": " .. output) end
  end
  local rooms = 0
  for _ in pairs(seen) do rooms = rooms + 1 end
  assert(rooms == 7 and w.finishes == 1 and not w:running())
end
check_companion(route1)
check_companion(route2)
print("ok - house-of-the-ebb typed by engine, prose links and authored companion paths reach all endings")
