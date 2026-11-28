local Walk = require("tests.story_walk")
local w = Walk.new("books.en.limehouse-killings.limehouse-killings")
local e = w.env
local function step(command, expected)
    local out = w.game:resume(command)
    assert(type(out) == "string" and out:match("%S"), command)
    if expected then assert(out:find(expected, 1, true), command .. ": " .. out) end
end

-- Investigate by the front door rather than opening the library stair first.
for _, action in ipairs({
    "north", "west", "ask lady ashworth about alibi", "east", "down", "west", "south",
    "ask hudson about alibi", "ask hudson about key", "north", "east", "up",
    "east", "read ledger", "ask moriarty about poison", "west", "open study door",
    "north", "examine desk", "read unsent letter", "read poison bottle", "south",
}) do step(action) end
assert(e.CASE_ACT == 3 and e.INSPECTOR_PRESENT and not e.CIPHER_SOLVED)
step("show poison bottle to lestrade", "Compare it with the greenhouse")
assert(not e.POISON_PRESENTED, "an untested label is not the poison link")
for _, action in ipairs({ "east", "push red book", "push yellow book", "push green book" }) do step(action) end
step("push blue book", "shelving slides aside")
assert(e.CIPHER_SOLVED and e.CASE_ACT == 3, "a late stair discovery must not roll back Act III")
assert(e.INSPECTOR_PRESENT and e.LOC(e.INSPECTOR) == e.ASHWORTH_ENTRANCE_HALL)
for _, action in ipairs({ "west", "down", "west", "north", "examine labels", "south", "east", "up" }) do step(action) end
step("show poison bottle to lestrade", "The second link")
assert(e.POISON_PRESENTED)
step("show poison bottle to lestrade", "I have the comparison")
for _, action in ipairs({"show unsent letter to lestrade", "north", "examine fireplace", "align box to moriarty",
    "read bank statement", "south", "show bank statement to lestrade"}) do step(action) end
local ending = w.game:resume("accuse moriarty with unsent letter")
assert(ending:find("THE LIMEHOUSE KILLINGS -- SOLVED", 1, true), ending)
assert(ending:find("The stair you opened", 1, true), ending)
assert(not ending:find("surgeon's knife", 1, true), "never seen optional evidence must not appear in the verdict")
assert(e.GAME_WON and not w:running())
print("Limehouse: key-first investigation, late staircase and poison presentation pass")
