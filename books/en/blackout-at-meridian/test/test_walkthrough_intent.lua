-- Costs belong to what the player actually chose, not the indirect object
-- or a harmless attempt to inspect/take a prop.
local Hero = require("books.en.blackout-at-meridian.test.hero")
local h = Hero.new()
h:force(1)
h:start("arc")

h:expect("take tram", "RESCUE THE PASSENGERS")
h:expect("take cable", "keeping an entire carriage")
h:expect("climb tram", "The whole carriage would lurch")
h:expect("enter station", "Rescue them first")
assert(not h:state().rescued and h:state().health == 90 and h:state().karma == 50,
	"inspection did not make a covert rescue attempt")

h:expect("rescue passengers", "Health 85 of 90")
assert(#h.reports == 1 and not h:state().rescued, "a deliberate rescue can fail")
h:force(100)
h:expect("rescue passengers", "pass the passengers down")
h:expect("rescue passengers", "already safe")
assert(#h.reports == 0 and h:state().karma == 60, "retrying a completed rescue earns nothing")

h:expect("east", "concrete hall")
h:force(1)
h:expect("strike sheet with drone", "Keep it in one piece")
h:expect("strike console with drone", "The lever will do")
h:expect("open console", "a single manual bypass lever")
h:expect("open kit", "without breaking the seal")
local s = h:state()
assert(s.health == 85 and s.karma == 60 and s.drone == 40 and not s.disabled and not s.boosted,
	"only an explicit attack/bypass or kit activation has a cost")

h:expect("use kit", "You recover 5 Health")
h:expect("use kit", "The kit is empty")
assert(h:state().health == 90 and h:state().karma == 50)

h:force(100)
h:expect("strike drone with sheet", "crashes to the floor")
assert(h:state().disabled and h:state().karma == 60, "a direct attack still resolves")
h:expect("strike drone", "already out of action")
h:expect("open console", "a single manual bypass lever")
assert(h:running() and h:state().karma == 60, "inspection cannot earn the bypass reward")
h:expect("pull lever", "THE END: THE LIGHTS OF MERIDIAN")
assert(h.w.finishes == 1 and h:state().karma == 80 and not h:running())
print("ok - Blackout resource costs, direct action target, and one-time rewards")
