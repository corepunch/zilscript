local Walk = require("tests.link_walk")
local walk = Walk.new("books.borrowed-tomorrows.borrowed-tomorrows")
walk:play({
  { "open lending cabinet", expect = "lies a tomorrow leaf" },
  { "take tomorrow leaf", expect = "records your name" },
  "north",
  { "read loan receipt", expect = "SUN THE VILLAGE CAN'T USE" },
  "south", "east",
  { "read folding board", expect = "OPEN THE OLD FOLDS" },
  { "put tomorrow leaf in folding board", expect = "width of your arms" },
  "north",
  "examine reading frame",
  { "put tomorrow leaf in reading frame", expect = "Both clips hold" },
  { "read reading frame", expect = "THE END -- ROOM FOR EVERY NAME" },
})
assert(walk.finishes == 1 and not walk:running() and #walk:menu() == 0)
print("ok - borrowed-tomorrows links-only walkthrough: " .. walk.steps .. " steps")
