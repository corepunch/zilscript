-- Verify the reusable import graph does not refer to an Infocom game directory.
local function read(path)
 local f = assert(io.open(path, "rb")); local s = f:read("*a"); f:close(); return s
end
local function check(path, seen)
 seen = seen or {}
 seen.order = seen.order or {}
 if seen[path] then return end
 seen[path] = true
 table.insert(seen.order, path)
 for target in read(path):gmatch('<INSERT%-FILE%s+"([^"]+)"') do
  assert(not target:lower():match("infocom[./]"), path .. " depends on " .. target)
  if target:match("^core[.]") or target:match("^languages[.]") or target:match("^rulesets[.]") then
   check((target:gsub("%.", "/")) .. ".zil", seen)
  else
   error(path .. " has nonqualified package dependency " .. target)
  end
 end
end
check("rulesets/classic/en.zil")
check("rulesets/classic/de.zil")
check("languages/de/init.zil")
-- A ruleset stands on its language's base, never on another ruleset.
local hero = {}
check("rulesets/superhero/en.zil", hero)
for _, path in ipairs(hero.order) do
 assert(not path:match("^rulesets/classic/"), "superhero rules depend on the classic rules through " .. path)
end
for _, lang in ipairs({"en", "de"}) do
 local classic = {}
 check("rulesets/classic/" .. lang .. ".zil", classic)
 assert(classic["languages/" .. lang .. "/base.zil"], "classic " .. lang .. " composes over languages/" .. lang .. "/base.zil")
end
assert(hero["languages/en/base.zil"], "superhero composes over languages/en/base.zil")
-- The layers of an RPG system: kernel (no language, no system), the kernel's
-- words per language, the system's numbers, the system's names per language.
for _, lang in ipairs({"en", "de"}) do
 local g = {}
 check("rulesets/superhero/" .. lang .. ".zil", g)
 for _, layer in ipairs({"languages/" .. lang .. "/base.zil", "rulesets/rpg/kernel.zil", "rulesets/rpg/" .. lang .. ".zil", "rulesets/superhero/system.zil"}) do
  assert(g[layer], "superhero " .. lang .. " composes " .. layer)
 end
 assert(not g["languages/" .. (lang == "en" and "de" or "en") .. "/base.zil"], "superhero " .. lang .. " stands on one language only")
end
for _, path in ipairs({"rulesets/rpg/kernel.zil", "rulesets/rpg/en.zil", "rulesets/rpg/de.zil"}) do
 assert(not read(path):find("rulesets.superhero", 1, true) and not read(path):find("rulesets.classic", 1, true), path .. " names a ruleset it should stand beneath")
end
assert(not read("rulesets/superhero/system.zil"):find("INSERT%-FILE"), "a system's numbers insert nothing")
-- The kernel and the language files name no system and no story: no
-- attribute of any system, no object or room of any book.
local systemNames = {}
for _, path in ipairs({"rulesets/superhero/system.zil"}) do
 for name in read(path):gmatch("<CONSTANT%s+([%w%-]+)") do systemNames[name] = true end
end
assert(systemNames["A-FIGHTING"] and systemNames["A-HEALTH"], "the system's attribute names are read from system.zil")
local function storyNames()
 local names = {}
 for _, book in ipairs({"blackout-at-meridian"}) do
  for _, file in ipairs({"shared/" .. book .. "/logic.zil"}) do
   local f = io.open("books/" .. file, "rb")
   if f then
    local src = f:read("*a"); f:close()
    for name in src:gmatch("\n<[OR][BO][JO][EM]C?T?%s+([%w%-]+)") do names[name] = true end
   end
  end
 end
 return names
end
local story = storyNames()
assert(story.DRONE and story.DISPATCH, "the story names are read from the book")
for _, path in ipairs({"rulesets/rpg/kernel.zil", "rulesets/rpg/en.zil", "rulesets/rpg/de.zil"}) do
 local text = read(path)
 for name in text:gmatch(",([%w%-%?]+)") do
  assert(not systemNames[name], path .. " names the system's attribute " .. name)
  assert(not story[name], path .. " names the story's " .. name)
 end
 assert(not text:find("DRONE", 1, true) and not text:find("Meridian", 1, true), path .. " names a story")
end
for _, path in ipairs({"rulesets/superhero/system.zil", "rulesets/superhero/en.zil", "rulesets/superhero/de.zil"}) do
 local text = read(path)
 for name in text:gmatch(",([%w%-%?]+)") do assert(not story[name], path .. " names the story's " .. name) end
 assert(not text:find("DRONE", 1, true) and not text:find("Meridian", 1, true) and not text:find("Dispatch", 1, true), path .. " names a story")
end
-- One book, two editions: each entry imports its language's ruleset, the
-- book's one logic and its own words; the logic and rules say no word of
-- either language.
for lang in pairs({en = true, de = true}) do
 local entry = "books/" .. lang .. "/blackout-at-meridian/blackout-at-meridian.zil"
 local superhero = read(entry)
 assert(superhero:find('<INSERT-FILE "rulesets.superhero.' .. lang .. '">',1,true), entry .. " imports its ruleset")
 assert(superhero:find('<INSERT-FILE "books.shared.blackout-at-meridian.logic">',1,true), entry .. " imports the book's logic")
 assert(superhero:find('<INSERT-FILE "books.shared.blackout-at-meridian.rules">',1,true), entry .. " imports the book's rules")
 assert(superhero:find('<INSERT-FILE "books.' .. lang .. '.blackout-at-meridian.' .. lang .. '">',1,true), entry .. " imports its edition's words")
 assert(not superhero:find("infocom/",1,true), entry .. " depends on a historical directory")
end
for _, path in ipairs({"books/shared/blackout-at-meridian/logic.zil", "books/shared/blackout-at-meridian/rules.zil"}) do
 local text = read(path):gsub(';"[^"]*"', ""):gsub('; "[^"]*"', "")
 for str in text:gmatch('"([^"]*)"') do
  assert(str == "OPTIONAL" or str == "AUX", path .. " contains the text " .. str:sub(1, 40) .. "; words belong to an edition")
 end
 assert(not read(path):find("INSERT%-FILE"), path .. " inserts files")
end

-- A top-level form that is the same in both languages is shared: parser and
-- loop code belongs in core/, text-free classic rules in
-- rulesets/classic/common.zil. A classic form with player-facing text stays
-- in each language, which owns its words. Forms nested in conditional
-- compilation stay with the code that owns them.
local nested = {["SETG DEBUG"] = true, ["DEFINE D-APPLY"] = true, ["ROUTINE DD-APPLY"] = true}
local markers = {AUX = true, OPTIONAL = true, OPT = true, ARGS = true, EXTRA = true, NAME = true, BIND = true, TUPLE = true}
local function forms(path)
 local src, out, depth, i, instr, start = read(path), {}, 0, 1, false, nil
 while i <= #src do
  local c = src:sub(i, i)
  if instr then
   if c == "\\" then i = i + 1 elseif c == '"' then instr = false end
  elseif c == '"' then instr = true
  elseif c == "<" then
   if depth == 0 and (i == 1 or src:sub(i - 1, i - 1) == "\n") then start = i end
   depth = depth + 1
  elseif c == ">" then
   depth = depth - 1
   if depth == 0 and start then
    local body = src:sub(start, i)
    local kind, name = body:match("^<(%u[%u%-]*)%s+([^%s>]+)")
    if kind then out[kind .. " " .. name] = body:gsub(';"[^"]*"', ""):gsub("%s+", " ") end
    start = nil
   end
  end
  i = i + 1
 end
 return out
end
local function has_text(body)
 for str in body:gmatch('"(.-)"') do
  if str:find("%a") and not markers[str] then return true end
 end
 return false
end
local shared = {
 {"languages/%s/parser.zil", "core/parser.zil"}, {"languages/%s/loop.zil", "core/loop.zil"},
 {"languages/%s/verbs.zil", "core/world.zil"}, {"languages/%s/globals.zil", "core/world.zil"},
 {"rulesets/rpg/%s.zil", "rulesets/rpg/kernel.zil"}, {"rulesets/superhero/%s.zil", "rulesets/superhero/system.zil"},
 {"rulesets/classic/%s-verbs.zil", "rulesets/classic/common.zil"}, {"rulesets/classic/%s-globals.zil", "rulesets/classic/common.zil"}}
for _, pair in ipairs(shared) do
 local file, home = pair[1], pair[2]
 local de = forms(file:format("de"))
 for key, body in pairs(forms(file:format("en"))) do
  local moveable = not nested[key] and not key:match("^INSERT%-FILE ")
   and (home:match("^core/p") or home:match("^core/l") or not has_text(body))
  assert(not moveable or de[key] ~= body, file .. ": " .. key .. " is identical in both languages; move it to " .. home)
 end
end
for _, file in ipairs({"parser", "loop"}) do
 for _, lang in ipairs({"en", "de"}) do
  assert(read("languages/" .. lang .. "/" .. file .. ".zil"):find('<INSERT-FILE "core.' .. file .. '">',1,true), lang .. " " .. file .. " inserts core." .. file)
 end
end
for _, lang in ipairs({"en", "de"}) do
 local composition = read("rulesets/classic/" .. lang .. ".zil")
 local common = composition:find('<INSERT-FILE "rulesets.classic.common">', 1, true)
 local verbs = composition:find('<INSERT-FILE "rulesets.classic.' .. lang .. '-verbs">', 1, true)
 assert(common and verbs and common < verbs, lang .. " composition inserts the common classic rules before its verbs")
end
-- Core and languages name no game's rooms or objects.
for _, path in ipairs({"core/parser.zil", "core/loop.zil", "core/clock.zil", "core/objects.zil", "core/world.zil", "rulesets/classic/common.zil",
  "rulesets/rpg/kernel.zil", "rulesets/rpg/en.zil", "rulesets/rpg/de.zil", "rulesets/superhero/system.zil", "rulesets/superhero/en.zil", "rulesets/superhero/de.zil",
  "languages/en/parser.zil", "languages/de/parser.zil", "languages/en/loop.zil", "languages/de/loop.zil"}) do
 for _, name in ipairs({"WEST-OF-HOUSE", "MAILBOX", "TROLL", "THIEF", "CYCLOPS"}) do
  assert(not read(path):find("," .. name, 1, true) and not read(path):find(" " .. name .. ">", 1, true),
   path .. " names the game object " .. name)
 end
end
-- Core and the English language name none of Zork I's rooms and objects and
-- test no ZORK-NUMBER: Zork I's special cases live in infocom/zork1. A name
-- Zork I shares with the language (GROUND, STAIRS) is the language's own.
local english = {}
check("languages/en/base.zil", english)
local defined = {}
for _, path in ipairs(english.order) do
 for name in read(path):gmatch("\n<[A-Z]+%s+([%w%-%?]+)") do defined[name] = true end
end
local zork1 = {}
for _, kind in ipairs({"OBJECT", "ROOM"}) do
 for name in read("infocom/zork1/dungeon.zil"):gmatch("\n<" .. kind .. "%s+([%w%-%?]+)") do
  if not defined[name] then zork1[name] = true end
 end
end

assert(zork1["WEST-OF-HOUSE"] and zork1.TREE and zork1["GLOBAL-WATER"] and not zork1.GROUND, "the Zork I name list reads dungeon.zil")
for _, path in ipairs(english.order) do
 local text = read(path)
 assert(not text:find("ZORK-NUMBER", 1, true), path .. " tests ZORK-NUMBER")
 for name in text:gmatch(",([%w%-%?]+)") do
  assert(not zork1[name], path .. " names the Zork I object " .. name)
 end
end


-- Exercise a real compiler load and the new package graph without historical sources.
local runtime = require("zilscript.runtime")
local env = runtime.create_game_env()
assert(runtime.init(env,true))
env.require("zilscript")
local originalOpen = io.open
io.open = function(path, ...)
 if type(path) == "string" and path:find("infocom/",1,true) then error("unexpected historical dependency: " .. path) end
 return originalOpen(path,...)
end
local ok,err=pcall(function()
 assert(runtime.load_modules(env,{"books.en.the-midnight-ledger.the-midnight-ledger"},{silent=true}))
 local game=runtime.create_game(env,true)
 local opening=game:start()
 assert(type(opening)=="string" and opening:match("%S"),"empty opening")
 assert(game:is_running(),"story stopped")
 local heroEnv = runtime.create_game_env()
 assert(runtime.init(heroEnv,true))
 heroEnv.require("zilscript")
 assert(runtime.load_modules(heroEnv,{"books.en.blackout-at-meridian.blackout-at-meridian"},{silent=true}))
 local hero=runtime.create_game(heroEnv,true)
 local heroOpening=hero:start()
 assert(type(heroOpening)=="string" and heroOpening:match("%S"),"empty superhero opening")
 assert(hero:is_running(),"superhero story stopped")
 local deEnv = runtime.create_game_env()
 assert(runtime.init(deEnv,true))
 deEnv.require("zilscript")
 assert(runtime.load_modules(deEnv,{"books.de.blackout-at-meridian.blackout-at-meridian"},{silent=true}))
 local de=runtime.create_game(deEnv,true)
 local deOpening=de:start()
 assert(type(deOpening)=="string" and deOpening:find("Wähle deinen Helden", 1, true),"German edition does not open on character selection")
 assert(de:is_running(),"German edition stopped")
 assert(de:resume("waehl fels"):find("Um neun Uhr", 1, true),"choosing a German hero does not start the story")
end)
io.open=originalOpen
assert(ok,err)
print("ok - independent package graph, shared core, original and superhero book startup")
