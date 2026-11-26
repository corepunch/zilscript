local Walk = require("tests.link_walk")
local Session = require("zilscript.reader.Session")
local route1 = {
  "read auction notice",
  "east",
  "examine porter ives",
  "west",
  "north",
  {"spin evidence panel", expect="WHEN is blank"},
  "west",
  "examine weigh scale",
  "examine wall clock",
  "east",
  "east",
  "read midnight ledger",
  "examine key cabinet",
  "north",
  "examine syndicate seal",
  "examine transit crate",
  "south",
  "west",
  "north",
  "read shift register",
  "examine assessor orr",
  "south",
  {"spin evidence panel", expect="three columns together"},
  {"spin ives tab", expect="finding unsigned"},
  {"spin orr tab", expect="THE END: THE WEIGHT OF THE RECORD"}
}
local game1 = Walk.new("books.en.the-midnight-ledger.the-midnight-ledger")
game1:play(route1)
assert(game1.finishes == 1 and not game1:running() and #game1:menu() == 0, "finding")

local module = "books.en.the-midnight-ledger.the-midnight-ledger"

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
print("ok - the-midnight-ledger typed by engine, prose links and authored companion paths reach all endings")
