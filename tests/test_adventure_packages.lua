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
  if target:match("^core[.]") or target:match("^world[.]") or target:match("^rulesets[.]") then
   check((target:gsub("%.", "/")) .. ".zil", seen)
  else
   error(path .. " has nonqualified package dependency " .. target)
  end
 end
end
for _, rules in ipairs({ "classic", "horror", "investigator", "superhero" }) do
 local graph = {}
 check("rulesets/" .. rules .. "/init.zil", graph)
 assert(graph["world/base.zil"], rules .. " uses the shared world")
 if rules == "investigator" or rules == "superhero" then
  assert(graph["rulesets/rpg/kernel.zil"] and graph["rulesets/rpg/actions.zil"], rules .. " uses the RPG kernel and actions")
  assert(graph["rulesets/" .. rules .. "/system.zil"], rules .. " loads its own system")
  assert(not graph["rulesets/classic/init.zil"] and not graph["rulesets/classic/verbs.zil"], rules .. " does not use classic rules")
 end
end
assert(not read("rulesets/superhero/system.zil"):find("INSERT%-FILE"), "the superhero system inserts nothing")
-- The kernel and the RPG actions name no system and no story: no
-- attribute of any system, no object or room of any book.
local systemNames = {}
for _, path in ipairs({"rulesets/superhero/system.zil"}) do
 for name in read(path):gmatch("<CONSTANT%s+([%w%-]+)") do systemNames[name] = true end
end
assert(systemNames["A-FIGHTING"] and systemNames["A-HEALTH"], "the system's attribute names are read from system.zil")
local function storyNames()
 local names = {}
 for _, book in ipairs({"blackout-at-meridian"}) do
  for _, file in ipairs({book .. "/logic.zil"}) do
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
for _, path in ipairs({"rulesets/rpg/kernel.zil", "rulesets/rpg/actions.zil"}) do
 local text = read(path)
 for name in text:gmatch(",([%w%-%?]+)") do
  assert(not systemNames[name], path .. " names the system's attribute " .. name)
  assert(not story[name], path .. " names the story's " .. name)
 end
 assert(not text:find("DRONE", 1, true) and not text:find("Meridian", 1, true), path .. " names a story")
end
for _, path in ipairs({"rulesets/superhero/system.zil", "rulesets/superhero/init.zil"}) do
 local text = read(path)
 for name in text:gmatch(",([%w%-%?]+)") do assert(not story[name], path .. " names the story's " .. name) end
 assert(not text:find("DRONE", 1, true) and not text:find("Meridian", 1, true) and not text:find("Dispatch", 1, true), path .. " names a story")
end
-- Core and the shared world name no game's rooms or objects.
for _, path in ipairs({"core/parser.zil", "core/loop.zil", "core/clock.zil", "core/objects.zil", "core/world.zil", "rulesets/classic/common.zil",
  "rulesets/rpg/kernel.zil", "rulesets/rpg/actions.zil", "rulesets/superhero/system.zil", "rulesets/superhero/init.zil",
  "world/parser.zil", "world/loop.zil"}) do
 for _, name in ipairs({"WEST-OF-HOUSE", "MAILBOX", "TROLL", "THIEF", "CYCLOPS"}) do
  assert(not read(path):find("," .. name, 1, true) and not read(path):find(" " .. name .. ">", 1, true),
   path .. " names the game object " .. name)
 end
end
-- Core and the shared world name none of Zork I's rooms and objects and
-- test no ZORK-NUMBER: Zork I's special cases live in infocom/zork1. A name
-- Zork I shares with the world (GROUND, STAIRS) belongs to the world.
local world = {}
check("world/base.zil", world)
local defined = {}
for _, path in ipairs(world.order) do
 for name in read(path):gmatch("\n<[A-Z]+%s+([%w%-%?]+)") do defined[name] = true end
end
local zork1 = {}
for _, kind in ipairs({"OBJECT", "ROOM"}) do
 for name in read("infocom/zork1/dungeon.zil"):gmatch("\n<" .. kind .. "%s+([%w%-%?]+)") do
  if not defined[name] then zork1[name] = true end
 end
end

assert(zork1["WEST-OF-HOUSE"] and zork1.TREE and zork1["GLOBAL-WATER"] and not zork1.GROUND, "the Zork I name list reads dungeon.zil")
for _, path in ipairs(world.order) do
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
 assert(runtime.load_modules(env,{"books.the-midnight-ledger.the-midnight-ledger"},{silent=true}))
 local game=runtime.create_game(env,true)
 local opening=game:start()
 assert(type(opening)=="string" and opening:match("%S"),"empty opening")
 assert(game:is_running(),"story stopped")
 local heroEnv = runtime.create_game_env()
 assert(runtime.init(heroEnv,true))
 heroEnv.require("zilscript")
 assert(runtime.load_modules(heroEnv,{"books.blackout-at-meridian.blackout-at-meridian"},{silent=true}))
 local hero=runtime.create_game(heroEnv,true)
 local heroOpening=hero:start()
 assert(type(heroOpening)=="string" and heroOpening:match("%S"),"empty superhero opening")
 assert(hero:is_running(),"superhero story stopped")
end)
io.open=originalOpen
assert(ok,err)
print("ok - independent package graph, shared core, original and superhero book startup")
