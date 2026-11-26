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
local superhero = read("books/blackout-at-meridian/blackout-at-meridian.zil")
assert(superhero:find('<INSERT-FILE "rulesets.superhero.en">',1,true), "superhero book imports its ruleset")
assert(not superhero:find("infocom/",1,true), "superhero book depends on a historical directory")

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
  "rulesets/superhero/percentile.zil", "rulesets/superhero/en-verbs.zil",
  "languages/en/parser.zil", "languages/de/parser.zil", "languages/en/loop.zil", "languages/de/loop.zil"}) do
 for _, name in ipairs({"WEST-OF-HOUSE", "MAILBOX", "TROLL", "THIEF", "CYCLOPS"}) do
  assert(not read(path):find("," .. name, 1, true) and not read(path):find(" " .. name .. ">", 1, true),
   path .. " names the game object " .. name)
 end
end
-- The world verbs still carry Zork I special cases (climbing the tree, the
-- entrance to Hades) and Zork II/III branches. They belong to the classic
-- rules or the story; this list may only shrink.
local zork = {"WEST-OF-HOUSE", "ENTRANCE-TO-HADES", "BOOK", "ROPE", "TREE", "STAIRS", "GROUND", "WATER", "GLOBAL-WATER", "TROLL", "THIEF", "CYCLOPS", "MAILBOX", "LAMP", "SWORD"}
local allowed = {en = {["WEST-OF-HOUSE"] = 1, ["ENTRANCE-TO-HADES"] = 1, BOOK = 1, ROPE = 1, TREE = 1, STAIRS = 1, GROUND = 1, WATER = 1, ["GLOBAL-WATER"] = 1}}
for _, lang in ipairs({"en"}) do
 for _, file in ipairs({"verbs", "globals"}) do
  local text = read("languages/" .. lang .. "/" .. file .. ".zil")
  for _, name in ipairs(zork) do
   if text:find("," .. name .. "[%s>)]") then
    assert(allowed[lang][name], "languages/" .. lang .. "/" .. file .. ".zil gained a reference to the Zork object " .. name)
   end
  end
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
