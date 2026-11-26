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

-- A top-level form that is the same in both languages belongs in core/.
-- Forms inside conditional compilation stay with the loop that owns them.
local nested = {["SETG DEBUG"] = true, ["DEFINE D-APPLY"] = true, ["ROUTINE DD-APPLY"] = true}
local function forms(path)
 local src, out, i = read(path), {}, 1
 while true do
  local s, _, kind, name = src:find("\n<(%u[%u%-]*)%s+([^%s>]+)", i)
  if not s then break end
  local depth, j, instr = 0, s + 1, false
  while j <= #src do
   local c = src:sub(j, j)
   if instr then
    if c == "\\" then j = j + 1 elseif c == '"' then instr = false end
   elseif c == '"' then instr = true
   elseif c == "<" then depth = depth + 1
   elseif c == ">" then depth = depth - 1; if depth == 0 then break end end
   j = j + 1
  end
  out[kind .. " " .. name] = src:sub(s + 1, j):gsub(';"[^"]*"', ""):gsub("%s+", " ")
  i = j
 end
 return out
end
for _, file in ipairs({"parser", "loop"}) do
 local de = forms("languages/de/" .. file .. ".zil")
 for key, body in pairs(forms("languages/en/" .. file .. ".zil")) do
  assert(nested[key] or key:match("^INSERT%-FILE ") or de[key] ~= body, file .. ": " .. key .. " is identical in both languages; move it to core/" .. file .. ".zil")
 end
 for _, lang in ipairs({"en", "de"}) do
  assert(read("languages/" .. lang .. "/" .. file .. ".zil"):find('<INSERT-FILE "core.' .. file .. '">',1,true), lang .. " " .. file .. " inserts core." .. file)
 end
end
local names = {"bell-grew-leaves", "blackwood-horror", "borrowed-tomorrows", "house-of-the-ebb", "last-broadcast", "limehouse-killings", "museum-unsent-signals", "pocket-weather", "silent-vector", "station-minus-one", "the-midnight-ledger", "wondertown"}
for _, name in ipairs(names) do
 local path = "books/" .. name .. "/" .. name .. ".zil"
 local source = read(path)
 assert(source:find('<INSERT-FILE "rulesets.classic.en">',1,true), path)
 assert(not source:find("infocom/zork",1,true), path)
end
assert(not read("zilscript/bootstrap.lua"):find('try_candidate("infocom/zork1/',1,true), "hidden historical fallback")
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
