local Walk = require("tests.story_walk")
local walk = Walk.new("books.bell-grew-leaves.bell-grew-leaves")
walk:play({
  { "ring root bell", expect = "Tuk" },
  "east",
  { "read signal tile", expect = "three white leaves" },
  "take reed wick",
  "west", "north",
  { "spin brass spout", expect = "fills faster" },
  "examine soaking bowl",
  { "put reed wick in soaking bowl", expect = "goes dark" },
  "east",
  { "open frost shutter", expect = "lift the peg" },
  "west", "south",
  "examine root bell",
  { "put reed wick in root bell", expect = "takes hold" },
  { "ring root bell", expect = "THE END -- THREE LEAVES FOR YES" },
})
assert(walk.finishes == 1 and not walk:running())
print("ok - bell-grew-leaves typed walkthrough: " .. walk.steps .. " steps")
