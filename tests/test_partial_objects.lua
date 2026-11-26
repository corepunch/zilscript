-- Objects merge: one story's logic is written once and each language edition
-- declares the same rooms and objects again with its words (docs/RPG-SYSTEMS.md,
-- "Editions: one story, many languages"). Fixture: tests/fixtures/partial-objects.
local runtime = require("zilscript.runtime")

local function load(module)
	local env = runtime.create_game_env()
	assert(runtime.init(env, true), "bootstrap failed")
	env.require("zilscript")
	return env, runtime.load_modules(env, { module }, { silent = true })
end

local function play(module)
	local env, ok = load(module)
	assert(ok, module .. " failed to load")
	return env, runtime.create_game(env, true)
end

local function check(command, output, texts)
	assert(type(output) == "string", command .. " printed nothing")
	for _, text in ipairs(texts or {}) do
		assert(output:find(text, 1, true), string.format("%s should print %q but printed:\n%s", command, text, output))
	end
	assert(not output:find("attempt to", 1, true) and not output:find("nil", 1, true), command .. " raised an error:\n" .. output)
end

local NAMES = { "CELLAR", "YARD", "LAMP", "CHEST", "COIN" }

local function numbering(env)
	local out = {}
	for _, name in ipairs(NAMES) do table.insert(out, name .. "=" .. tostring(env[name])) end
	return table.concat(out, ",")
end

local function children(env, parent)
	local out = {}
	local child = env.FIRSTQ(parent)
	while child do
		table.insert(out, child)
		child = env.NEXTQ(child)
	end
	return out
end

local function hasFlag(env, object, flag) return env.FSETQ(env[object], env[flag]) end

-- English: logic first, words after.
local en, game = play("tests.fixtures.partial-objects.en-story")
check("opening", game:start(), { "A damp cellar", "A brass lamp sits on the floor." })
check("examine", game:resume("examine lamp"), {})
check("take by edition synonym", game:resume("take lantern"), { "Taken." })
assert(en.LAMP_TAKEN == true or en["LAMP-TAKEN"] == true, "the logic's ACTION ran in the English edition")
check("adjective", game:resume("examine brass lamp"), {})
check("open chest", game:resume("look in oak chest"), { "gold coin" })
check("take coin", game:resume("take coin"), { "Taken." })
check("north", game:resume("north"), { "A quiet yard" })
-- Flags from both declarations
assert(hasFlag(en, "LAMP", "TAKEBIT"), "logic flag TAKEBIT kept")
assert(hasFlag(en, "CHEST", "CONTBIT") and hasFlag(en, "CHEST", "OPENBIT") and hasFlag(en, "CHEST", "NDESCBIT"), "container flags from both files are unioned")
assert(en.GETP(en.LAMP, en.PQACTION) ~= 0, "the logic ACTION survives the merge")
assert(en.GETP(en.CHEST, en.PQLOC) == en.CELLAR, "location comes from the logic")
assert(en.GETP(en.CHEST, en.PQCAPACITY) == 20, "logic property kept")

-- German: words first, logic after.
local de, dgame = play("tests.fixtures.partial-objects.de-story")
check("opening", dgame:start(), { "Ein feuchter Keller", "Eine Lampe steht auf dem Boden." })
check("take by edition synonym", dgame:resume("nimm die Laterne"), { "Genommen." })
assert(de["LAMP-TAKEN"] == true or de.LAMP_TAKEN == true, "the logic's ACTION ran in the German edition")
check("examine", dgame:resume("untersuche die Lampe"), { "Lampe" })
check("look in chest", dgame:resume("schau in die Truhe"), { "Münze" })
check("umlaut synonym", dgame:resume("nimm die muenze"), { "Genommen." })
check("north", dgame:resume("nord"), { "Ein stiller Hof" })
assert(hasFlag(de, "LAMP", "TAKEBIT") and hasFlag(de, "LAMP", "DIEBIT"), "logic and edition flags are unioned")
assert(hasFlag(de, "CHEST", "CONTBIT") and hasFlag(de, "CHEST", "OPENBIT") and hasFlag(de, "CHEST", "DIEBIT"))
assert(de.GETP(de.CHEST, de.PQLOC) == de.CELLAR, "location comes from the logic although the edition came first")

-- Tree order is declaration order, whichever file gave the location
for _, module in ipairs({ "en-story", "de-story" }) do
	local fresh = load("tests.fixtures.partial-objects." .. module)
	local kids = children(fresh, fresh.CELLAR)
	assert(#kids == 2 and kids[1] == fresh.LAMP and kids[2] == fresh.CHEST, module .. ": cellar children follow object numbers")
	assert(fresh.FIRSTQ(fresh.CHEST) == fresh.COIN, module .. ": coin is in the chest")
end

-- Deterministic numbering across loads
local again = load("tests.fixtures.partial-objects.en-story")
assert(numbering(again) == numbering(en), "object numbers are identical between two loads")
local dagain = load("tests.fixtures.partial-objects.de-story")
assert(numbering(dagain) == numbering(de), "German object numbers are identical between two loads")

-- Two files may not disagree
local env = runtime.create_game_env()
assert(runtime.init(env, true), "bootstrap failed")
env.require("zilscript")
local ok, err = pcall(env.require, "tests.fixtures.partial-objects.conflict")
assert(not ok, "a conflicting duplicate property must fail")
assert(tostring(err):find("LAMP", 1, true) and tostring(err):find("DESC", 1, true), "the error names the object and property: " .. tostring(err))

print("partial objects: ok")
