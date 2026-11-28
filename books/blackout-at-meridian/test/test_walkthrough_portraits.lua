local Runtime = require("zilscript.runtime")
local Setup = require("zilscript.rpg_setup")
local book = "blackout-at-meridian"
local portraitRoot = "books/" .. book .. "/portraits/"

local function load(module)
  local env = Runtime.create_game_env()
  assert(Runtime.init(env, true))
  env.require("zilscript")
  assert(Runtime.load_modules(env, {module}, {silent = true}))
  return env
end

for _, id in ipairs({"bulwark", "arc", "lens"}) do
  local f = assert(io.open(portraitRoot .. id .. ".png", "rb"))
  local header = f:read(24)
  f:close()
  assert(header:sub(1, 8) == "\137PNG\r\n\26\n")
  local w, h = string.unpack(">I4I4", header, 17)
  assert(w == 720 and h == 1080, id)

  do
    local env = load("books." .. book .. "." .. book)
    assert(not env.ZIL_TRUE(env.RPG_PORTRAIT()), "no portrait before setup")
    assert(Setup.select(env, {id = id, name = "Test Hero"}))
    assert(not env.ZIL_TRUE(env.RPG_PORTRAIT()), "selected is not started")
    local game = Runtime.create_game(env, true)
    assert(type(game:start()) == "string")
    local prior = env.MOVES
    assert(env.RPG_PORTRAIT() == id, id)
    assert(env.MOVES == prior and env.TAKE_OUTPUT() == "", "portrait lookup is read-only")
  end
end

local other = load("books.the-water-that-answers.the-water-that-answers")
assert(other.RPG_PORTRAIT == nil, "other RPGs do not have to supply portraits")
print("ok - all three portrait lookups and a portrait-free RPG")
