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
local names = {"bell-grew-leaves", "blackwood-horror", "borrowed-tomorrows", "house-of-the-ebb", "last-broadcast", "limehouse-killings", "museum-unsent-signals", "pocket-weather", "silent-vector", "station-minus-one", "the-midnight-ledger", "wondertown"}
for _, name in ipairs(names) do
 local path = "books/en/" .. name .. "/" .. name .. ".zil"
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
 assert(runtime.load_modules(env,{"books.en.the-midnight-ledger.the-midnight-ledger"},{silent=true}))
 local game=runtime.create_game(env,true)
 local opening=game:start()
 assert(type(opening)=="string" and opening:match("%S"),"empty opening")
 assert(game:is_running(),"story stopped")
end)
io.open=originalOpen
assert(ok,err)
print("ok - independent package graph and original book startup")
