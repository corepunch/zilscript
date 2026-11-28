-- Shared book behavior: taken objects score and inventory uses the right article.
local Walk = require("tests.story_walk")

-- Taking an object with a VALUE scores it once (ITAKE's compile-time OR).
local ward = Walk.new("books.blackwood-horror.blackwood-horror")
local env = ward.env
env.MOVE(env.PATIENT_FILE, env.HERE)
local before, value = env.SCORE, env.GETP(env.PATIENT_FILE, env.PQVALUE)
assert(value > 0, "The patient file carries a score value")
ward.game:resume("take patient file")
assert(env.SCORE == before + value, "Taking the file adds its value to the score")

-- Listings choose their article by the name's first letter.
env.MOVE(env.ANCIENT_RELIC, env.HERE)
env.PUTP(env.ANCIENT_RELIC, env.PQDESC, "ancient relic")
env.FSET(env.ANCIENT_RELIC, env.TOUCHBIT)
ward.game:resume("take ancient relic")
local listing = ward.game:resume("inventory")
assert(listing:find("An ancient relic", 1, true), "An inventory line starts \"An\" before a vowel:\n" .. listing)
ward.game:resume("take patient file")
listing = ward.game:resume("inventory")
assert(listing:find("A patient file", 1, true), "Consonant names keep \"A\":\n" .. listing)
print("ok - taken objects score and inventory articles agree")
