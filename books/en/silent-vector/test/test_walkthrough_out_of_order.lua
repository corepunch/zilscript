local Walk = require("tests.link_walk")
local w = Walk.new("books.en.silent-vector.silent-vector")
local e = w.env
local function step(command, expected)
    local out = w.game:resume(command)
    assert(type(out) == "string" and out:match("%S"), command)
    if expected then assert(out:find(expected, 1, true), command .. ": " .. out) end
end

for _, action in ipairs({"push breaker", "north", "west", "take wrench", "take spool",
    "east", "down", "west", "turn pump with wrench", "east", "up", "east", "east",
    "open recorder", "take strip"}) do step(action) end
step("put wrench in recorder", "Only the witness strip")
assert(e.LOC(e.WRENCH) == e.WINNER, "a rejected tool insertion keeps the wrench in hand")
for _, action in ipairs({"west", "show strip to ivo", "west", "north", "take shears",
    "north", "compare strip with comparator", "south", "south", "east",
    "show strip to ivo", "west", "down", "east", "fit spool to bus", "cut bus with shears",
    "north", "open receiver", "take wafer"}) do step(action) end
step("put shears in receiver", "no place to stow equipment")
assert(e.LOC(e.SHEARS) == e.WINNER, "foreign equipment cannot disappear inside the receiver")
assert(not e.ORIGIN)
for _, action in ipairs({"south", "west", "up", "north", "north", "east"}) do step(action) end
local reply = w.game:resume("show wafer to senn")
assert(reply:find("outer-relay", 1, true) and reply:find("Lena died at nine", 1, true), reply)
assert(e.ORIGIN and e.SENN_DISCLOSED, "showing the wafer documents its markings before recording the confession")
step("show wafer to senn", "The years between nine and thirty-one")
for _, action in ipairs({"north", "put wafer in archive", "south", "west", "south",
    "south", "up", "push beacon", "down", "north", "north", "east", "north"}) do step(action) end
step("erase console", "FOUR PULSES")
assert(e.RESOLVED and not w:running())
print("Silent Vector: foreign equipment stays in hand; Senn verifies the physical wafer before the ending")
