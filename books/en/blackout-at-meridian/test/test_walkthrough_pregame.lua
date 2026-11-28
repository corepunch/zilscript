local runtime = require("zilscript.runtime")
local Setup = require("zilscript.rpg_setup")

local ways = {
  en = { "Bulwark", "Arc", "Lens", "Choose your hero", "At nine o'clock", "north" },
  de = { "Fels", "Blitz", "Luchs", "Wähle deinen Helden", "Um neun Uhr", "nord" },
  ru = { "Бастион", "Искра", "Призма", "Выберите героя", "В девять вечера", "север" },
}

for language, words in pairs(ways) do
  local env = runtime.create_game_env()
  assert(runtime.init(env, true))
  env.require("zilscript")
  assert(runtime.load_modules(env, { "books." .. language .. ".blackout-at-meridian.blackout-at-meridian" }, { silent = true }))
  env.PROSE_LINKS = true
  local draws = 0
  env.math = setmetatable({ random = function() draws = draws + 1; return 42 end }, { __index = math })
  local original = env.HERE
  local all = Setup.profiles(env)
  assert(#all == 3 and all[1].id == "bulwark" and all[2].id == "arc" and all[3].id == "lens")
  for i = 1, 3 do
    assert(all[i].title == words[i], tostring(all[i].title))
    assert(#all[i].rows == 10 and utf8.len(all[i].summary))
  end
  assert(all[2].rows[9].value == 90 and all[2].rows[10].value == 50)
  assert(env.HERE == original and not env.ZIL_TRUE(env.BECAMEQ(env.HERO)) and env.MOVES == 0 and draws == 0)
  local ok, why = Setup.select(env, { id = "invalid", name = "Hero" })
  assert(not ok and why == "invalid_preset")
  ok, why = Setup.select(env, { id = "arc", name = ("Я"):rep(33) })
  assert(not ok and why == "invalid_name")
  ok, why = Setup.select(env, { id = "arc", name = "[[fake exit]]" })
  assert(not ok and why == "invalid_name")
  assert(Setup.select(env, { id = "arc", name = "  Алёна %u & Гром  " }))
  assert(not Setup.select(env, { id = "lens" }))
  assert(env.HERE == original and env.MOVES == 0 and draws == 0)
  local game = runtime.create_game(env, true)
  local out = game:start()
  assert(out:find(words[5], 1, true) and not out:find(words[4], 1, true), out)
  assert(env.HERO_CLASS == 2 and env.MOVES == 0 and draws == 0)
  local name, profile
  env.SHEET_IDENTITY = function(n, p) name, profile = n, p end
  env.SHEET_ROW = function() end
  assert(env.RPG_EXPORT_SHEET())
  assert(name == "Алёна %u & Гром" and profile == words[2], tostring(name))
  assert(type(game:resume(words[6])) == "string")
  assert(env.MOVES == 1 and env.HERE == env.BRIDGE)
end
print("ok - book-defined pre-game catalogs, validation and direct mission entry in all three editions")
