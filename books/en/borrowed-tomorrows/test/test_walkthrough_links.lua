local Walk = require("tests.link_walk")
local walk = Walk.new("books.en.borrowed-tomorrows.borrowed-tomorrows")
walk:play({
  { "open lending cabinet", expect = "lies a tomorrow leaf" },
  { "search lending cabinet", expect = "lies on the shelf" },
  { "take tomorrow leaf", expect = "records your name" },
  { "search lending cabinet", expect = "page-shaped patch" },
  "north",
  { "read loan receipt", expect = "SUN THE VILLAGE CAN'T USE" },
  "south", "east",
  { "read folding board", expect = "OPEN THE OLD FOLDS" },
  { "put tomorrow leaf in folding board", expect = "width of your arms" },
  "north",
  "examine reading frame",
  { "put tomorrow leaf in reading frame", expect = "Both clips hold" },
  { "read reading frame", expect = "answer comes from every side of the square" },
})
assert(walk.finishes == 1 and not walk:running() and #walk:menu() == 0)
print("ok - borrowed-tomorrows links-only walkthrough: " .. walk.steps .. " steps")
