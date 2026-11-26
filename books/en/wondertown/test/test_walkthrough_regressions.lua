-- What the links-only QA walk found and fixed, each pinned through the
-- reader's own menus (or the parser where the point is vocabulary).
package.path = "./?.lua;./?/init.lua;" .. package.path
local Walk = require("tests.link_walk")

local function new() return Walk.new("books.en.wondertown.wondertown", 97) end
local function has(text, part, why)
	assert(text:find(part, 1, true), (why or "") .. ": expected \"" .. part .. "\" in:\n" .. text)
end
local function lacks(text, part, why)
	assert(not text:find(part, 1, true), (why or "") .. ": unexpected \"" .. part .. "\" in:\n" .. text)
end
local function count(text, part)
	local n, from = 0, 1
	while true do
		local first, last = text:find(part, from, true)
		if not first then return n end
		n, from = n + 1, last + 1
	end
end
local function offered(walk, command, why)
	assert(walk:offers(command), (why or "") .. ": menu should offer \"" .. command .. "\"\n" .. walk:describeMenu())
end
local function notOffered(walk, command, why)
	assert(not walk:offers(command), (why or "") .. ": menu should not offer \"" .. command .. "\"")
end

-- 1. Workshop, loft, tool bench and countertop.
local walk = new()
walk:play({ "examine key hook", "take frayed string", "examine enormous bench", "take tiny broom", "take tiny can", "examine folding ladder" })
notOffered(walk, "open pet door with tiny broom", "Tools are not offered on scenery that ignores them")
notOffered(walk, "lubricate rusty mechanism with tiny broom", "Only the plain oiling is offered")
has(walk:choose("put tiny broom in enormous bench"), "far above Pip's head", "Workbench refuses in its own words")
walk:play({ "climb enormous bench", { "read repair book", expect = "follow the ticking beneath the ticking" } })
has(walk:choose("read repair book"), "follow the ticking beneath the ticking", "The open book can be read again")
notOffered(walk, "read repair book with frayed string", "Nothing is read with a tool")
walk:play({ "close repair book", "down", "examine folding ladder", "lubricate rusty mechanism" })
local loft = walk:choose("climb folding ladder")
has(loft, "ladder back down", "The loft is reached by a ladder")
lacks(loft, "Stairs", "The loft has no stairs")
walk:play({ "wind old clock", "examine dusty box", "read leather journal" })
notOffered(walk, "wind old clock with tiny can", "Old Tick is wound by hand")
offered(walk, "tell old clock about leather journal", "Tolliver's journal is a topic for Old Tick")
has(walk:choose("tell old clock about leather journal"), "The toymaker?", "Old Tick speaks of Tolliver")
has(walk:choose("open dusty box"), "porcelain doll arm")
local openBox = walk:choose("look")
has(openBox, "above the open box", "The room shows the box has been opened")
has(openBox, "A porcelain doll arm is in the dusty cardboard box", "The arm is described where it lies")
offered(walk, "tell old clock about leather journal")
walk:choose("inventory")
has(walk:choose("put tiny broom in dusty box"), "Done", "The repair box holds things")
walk:play({ "take porcelain arm", "down" })

local bench = walk:choose("east")
assert(count(bench, "frozen on the chair seat") == 1, "The frozen nutcracker is described once:\n" .. bench)
local steps = walk:choose("examine makeshift steps")
lacks(steps, "\n ", "No line starts with a stray space")
has(steps, "nutcracker stands squarely")
has(walk:choose("wind painted nutcracker"), "The key comes away in Pip's hand", "The key in his back winds him")
assert(walk.env.BERTRAND_WOUND, "Bertrand is wound")
has(walk:choose("inventory"), "tiny brass winding key", "Pip keeps the key")
local talk = walk:choose("talk to painted nutcracker")
lacks(talk, "address him properly", "Bertrand does not hint at a command no menu offers")
has(walk:choose("tell painted nutcracker about winding key"), "My winding key", "Bertrand answers about his key")
has(walk:choose("tell painted nutcracker about frayed string"), "The master's key", "The chewed string is the missing key's")
has(walk:choose("tell painted nutcracker about leather journal"), "The Grandfather?", "Bertrand speaks of Tolliver")
notOffered(walk, "tell painted nutcracker about tiny can", "Topics without an answer are not offered")
walk:choose("examine wooden rack")
has(walk:choose("put winding key in sticky pot"), "tacky varnish", "The varnish pot refuses in its own words")

walk:choose("climb makeshift steps")
walk:choose("examine dusty case")
has(walk:choose("wind music box"), "behind the glass", "The crank cannot be turned through the shut case")
walk:play({ "examine rag doll", "take spare button", "give spare button to rag doll", "open dusty case", "take tin soldier", "take music box" })
has(walk:choose("examine music box"), "would play a tune if wound", "An unwound box has not been played")
has(walk:choose("give tin soldier to rag doll"), "nothing comes of the offer", "A refused gift names no \"that\"")
has(walk:choose("put tin soldier in dusty case"), "Done", "The soldier fits back in his case")
has(walk:choose("examine dusty case"), "tin soldier")
walk:play({ "take tin soldier", "down", "west", "north" })

-- 2. Wrenfold: the tower, the mailbox, the cart.
has(walk:choose("east"), "just out of reach")
local before = walk.env.TICK_COUNT
has(walk:choose("wind brass mechanism"), "extra hours")
assert(walk.env.TICK_COUNT - before >= 98, "Winding the tower really buys time")
local square = walk:choose("look")
lacks(square, "just out of reach", "The wound mechanism is no longer out of reach")
has(square, "slow, deliberate rhythm")
walk:choose("east")
walk:choose("examine red mailbox")
notOffered(walk, "open red mailbox with tiny can")
has(walk:choose("tell red mailbox about red scarf"), "Somebody cold would be glad of it", "The mailbox saw the scarf")
has(walk:choose("tell red mailbox about crumpled letter"), "old toymaker's hand", "The mailbox saw the letter")
walk:play({ "read crumpled letter", "take red scarf" })
-- Thirteen things in hand: the base game's random fumble must never refuse a take.
has(walk:choose("inventory"), "red wool scarf", "Pip can carry everything")
assert(walk.env.FUMBLE_NUMBER >= 100, "No inventory fumble")
walk:play({ "west", "south", "examine broken piles", "take doll head", "take toy horse", "examine scrap cart" })
has(walk:choose("take headless doll"), "leaves her in its keeping", "The doll stays in the cart")
assert(walk.env.LOC(walk.env.HEADLESS_DOLL) == walk.env.SCRAP_CART, "Headless doll is still in the cart")
notOffered(walk, "give doll head to iron gate", "Gifts are offered only to those who answer")
notOffered(walk, "attack scrap cart with toy horse")
offered(walk, "give doll head to scrap cart")
has(walk:choose("put toy horse in scrap cart"), "settles it in the bed", "The cart takes a broken toy")
has(walk:choose("put doll head in scrap cart"), "rolls aside", "Putting the head in the cart is the gift")
assert(walk.env.CART_MOVED, "The cart moved")
has(walk:choose("take doll head"), "leaves them together", "The returned head stays with its doll")
has(walk:choose("examine headless doll"), "head resting beside her", "The doll is described with her head back")

-- 3. The fox: frightening her is not the end of the story.
walk:choose("east")
has(walk:choose("tell patchy fox about workshop key"), "has ever been mine", "Grammar of Nutmeg's refusal")
has(walk:choose("tell patchy fox about crumpled letter"), "The toymaker?", "Tolliver's letter is the toymaker topic")
has(walk.game:resume("examine winding key"), "tiny brass winding key", "\"winding key\" is Bertrand's key alone")
has(walk:choose("knock down patchy fox"), "just like the others")
assert(walk.env.NUTMEG_TRUST == -1, "Nutmeg is frightened")
has(walk:choose("tell patchy fox"), "I am sorry, Nutmeg", "Pip can say sorry")
assert(walk.env.NUTMEG_TRUST == 0, "An apology restores what the gifts had earned")
walk:play({ "inventory", "give red scarf to patchy fox" })
has(walk:choose("examine patchy fox"), "no longer shrinks from Pip", "A trusting fox is not described as wary")
has(walk:choose("take workshop key"), "Take it")
assert(walk.env.KEY_FOUND, "The key is won after an apology and a gift")

-- 4. The clock that opens, and the heart.
walk:play({ "west", "north", "west", "south", "climb folding ladder" })
local call = walk:choose("wind old clock")
has(call, "Suddenly, Nutmeg pads forward")
lacks(call, "\n ", "No line starts with a stray space")
local floor = walk:choose("down")
has(floor, "stairs behind the open clock", "The workshop shows the open clock")
offered(walk, "in", "The room text links the way into the study")
local clock = walk:choose("examine old clock")
lacks(clock, "may know how to release it", "An open clock needs no releasing")
walk:play({ "in", "down" })
notOffered(walk, "wind giant mechanism with winding key", "Only the workshop key is offered for the heart")
local wound = walk:choose("wind giant mechanism")
lacks(wound, "\n ", "No line starts with a stray space")
offered(walk, "position tin soldier", "Winding the heart names the companions Pip carries")
offered(walk, "position music box")
offered(walk, "position porcelain arm")
walk:play({ { "position porcelain arm", expect = "Let me help" }, { "position music box", expect = "restored the heart of Wrenfold" } })
assert(walk.finishes == 1 and walk.env.GAME_WON, "Won after the detours")

-- 5. Dawn warnings do not put a window or the cuckoo clock in the street.
local source = assert(io.open("books/en/wondertown/actions.zil")):read("a")
local warnings = source:match("<ROUTINE I%-DAWN%-WARNING.-\n\n")
lacks(warnings, "window", "Dawn warnings are true in every room")
lacks(warnings, "cuckoo", "Dawn warnings are true in every room")

-- 6. A book read with children: Grandfather comes home in both endings,
-- and the opt-in dawn puts the toys to sleep rather than ending them.
local ending = source:match("<ROUTINE REWIND%-ENDING.-\n\n")
lacks(ending, "somehow", "Grandfather is no voice in the gears")
has(ending, "Grandfather Tolliver hurries down the study stairs", "Grandfather returns in the softer ending")
has(ending, "boots stamp off the snow", "Grandfather returns in the full ending")
local dawn = source:match("<ROUTINE I%-TICK.-\n\n")
lacks(dawn, "forever", "Dawn is sleep, not loss")
lacks(dawn, "alone", "Dawn is sleep, not loss")

print("Wondertown link regressions: ok")
