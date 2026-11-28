-- Story and companion regressions.
local Walk = require("tests.story_walk")
local paths = {"choose spider spider-man", "take copper coil", "north", "use shield relay", "north", "north",
       "pull hand winch", "north", "examine market scales", "take brass clapper", "west", "inventory",
       "put brass clapper in village bell", "pull village bell", "east", "north", "north"}
local route = paths
do
 local w=Walk.new("books.last-door-of-battleworld.last-door-of-battleworld",97)
 w:play(route)
 assert(w.env.BW_BELL_RUNG, "village puzzle should be completed")
 assert(w.env.HERE==w.env.BW_WORLDSHIP, "the route should reach the Worldship")
end
print("ok - typed commands reach the Worldship via the village")
