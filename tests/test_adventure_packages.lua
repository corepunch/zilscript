-- Verify the reusable import graph does not refer to an Infocom game directory.
local function read(path)
 local f = assert(io.open(path, "rb")); local s = f:read("*a"); f:close(); return s
end
local function check(path, seen)
 seen = seen or {}
 if seen[path] then return end
 seen[path] = true
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
check("rulesets/superhero/en.zil")
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
local shared = {parser = "core/parser.zil", loop = "core/loop.zil",
 ["classic-verbs"] = "rulesets/classic/common.zil", ["classic-globals"] = "rulesets/classic/common.zil"}
for file, home in pairs(shared) do
 local de = forms("languages/de/" .. file .. ".zil")
 for key, body in pairs(forms("languages/en/" .. file .. ".zil")) do
  local moveable = not nested[key] and not key:match("^INSERT%-FILE ")
   and (home:match("^core/") or not has_text(body))
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
 local verbs = composition:find('<INSERT-FILE "languages.' .. lang .. '.classic-verbs">', 1, true)
 assert(common and verbs and common < verbs, lang .. " composition inserts the common classic rules before its verbs")
end
-- Core and languages name no game's rooms or objects.
for _, path in ipairs({"core/parser.zil", "core/loop.zil", "core/clock.zil", "core/objects.zil", "rulesets/classic/common.zil",
  "languages/en/parser.zil", "languages/de/parser.zil", "languages/en/loop.zil", "languages/de/loop.zil"}) do
 for _, name in ipairs({"WEST-OF-HOUSE", "MAILBOX", "TROLL", "THIEF", "CYCLOPS"}) do
  assert(not read(path):find("," .. name, 1, true) and not read(path):find(" " .. name .. ">", 1, true),
   path .. " names the game object " .. name)
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
