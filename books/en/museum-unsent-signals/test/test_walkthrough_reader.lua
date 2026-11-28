local Walk = require("tests.story_walk")
local walk = Walk.new("books.en.museum-unsent-signals.museum-unsent-signals"):play({
  "read museum plaque", "east", "examine inspection lens",
  {"tilt inspection lens", expect="RETURN ONLY"}, "take wooden spool",
  "west", "north", "inventory",
  {"put wooden spool in reading basin", expect="starts to turn"},
  {"push audition stud", expect="private return register"},
  "examine return key",
  {"push return key", expect="ENDING: PRIVATE RETURN"},
})
assert(walk.finishes == 1 and walk.env.MUSEUM_END == 1)
print("museum-unsent-signals: typed commands reached private ending")
