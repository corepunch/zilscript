local Walk = require("tests.link_walk")
local walk = Walk.new("books.en.station-minus-one.station-minus-one"):play({
  "examine station clock", "west", "read shift logbook",
  "take ceramic puck", "east", "east", "inventory",
  {"put ceramic puck in receiver cradle", expect="ceramic click"},
  {"push calibration stud", expect="A reflection cannot do that"},
  "west", "north", "examine quarantine latch",
  {"push quarantine latch", expect="ENDING: OUTSIDE THE TIMETABLE"},
})
assert(walk.finishes == 1 and walk.env.STATION_END == 2)
print("station-minus-one: portable reader links reached quarantine ending")
