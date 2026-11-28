-- The same authored challenge passes on different colors for different
-- profiles, with an advance warning in each edition. Sheet export is read-only,
-- uses live values, and passes actual strings rather than ZIL string handles.
local Walk = require("tests.link_walk")

local editions = {
  en = {
    names = { "bulwark", "arc", "lens" },
    choose = "choose ", north = "north", east = "east",
    rescue = "rescue tram", inspect = "examine console", restore = "disable console",
    rankLabels = { "Remarkable", "Excellent", "Good" },
    forecast = "Challenge 20; needs ",
    tiers = { "success", "strong success", "exceptional success" },
  },
  de = {
    names = { "fels", "blitz", "luchs" },
    choose = "waehle ", north = "nord", east = "ost",
    rescue = "rette die straßenbahn", inspect = "untersuche schaltpult",
    restore = "deaktiviere das schaltpult",
    rankLabels = { "Bemerkenswert", "Ausgezeichnet", "Gut" },
    forecast = "Schwierigkeit 20; mindestens ",
    tiers = { "Erfolg", "starker Erfolg", "außerordentlicher Erfolg" },
  },
  ru = {
    names = { "бастиона", "искру", "призму" },
    choose = "выбрать ", north = "север", east = "восток",
    rescue = "спасти трамвай", inspect = "осмотреть пульт",
    restore = "отключить пульт",
    rankLabels = { "Выдающийся", "Отличный", "Хороший" },
    forecast = "Сложность 20; нужен результат: ",
    tiers = { "успех", "значительный успех", "исключительный успех" },
  },
}
local profiles = {
  { required = 3, cutoff = 98, health = 120, karma = 26 },
  { required = 2, cutoff = 71, health = 90, karma = 50 },
  { required = 1, cutoff = 31, health = 60, karma = 90 },
}

for _, language in ipairs({ "en", "de", "ru" }) do
  local words = editions[language]
  for index, profile in ipairs(profiles) do
    local walk = Walk.new("books." .. language .. ".blackout-at-meridian.blackout-at-meridian", 97)
    local env = walk.env
    local roll, rollCount, rows, identity = 1, 0, {}
    env.math = setmetatable({ random = function() rollCount = rollCount + 1; return roll end }, { __index = math })
    env.SHEET_IDENTITY = function(name, kind) identity = { name, kind } end
    env.SHEET_ROW = function(label, value, max, group, rankLabel)
      rows[#rows + 1] = { label, value, max, group, rankLabel }
    end
    local function command(value)
      local output = walk.game:resume(value)
      assert(type(output) == "string" and output:match("%S"), value)
      return output
    end

    assert(not env.ZIL_TRUE(env.RPG_EXPORT_SHEET()) and #rows == 0)
    command(words.choose .. words.names[index])
    assert(env.HERO_CLASS == index and env.MOVES == 0)
    command(words.north)
    command(words.rescue) -- first roll: fail, lose five Health
    assert(env.LAST_FEAT_REQUIRED == 1)
    local moves, beforeExport = env.MOVES, rollCount
    assert(env.ZIL_TRUE(env.RPG_EXPORT_SHEET()))
    assert(env.MOVES == moves and rollCount == beforeExport, "export changed the game")
    assert(type(identity[1]) == "string" and type(identity[2]) == "string")
    assert(#rows == 10)
    for i = 1, 7 do
      assert(rows[i][4] == "abilities" and type(rows[i][5]) == "string" and #rows[i][5] > 0)
    end
    assert(rows[1][5] == words.rankLabels[index], rows[1][5])
    assert(rows[8][4] == "powers" and type(rows[8][5]) == "string")
    assert(rows[9][4] == "resources" and rows[9][2] == profile.health - 5 and rows[9][3] == profile.health and not rows[9][5])
    assert(rows[10][4] == "resources" and rows[10][2] == profile.karma and rows[10][3] == 0)

    roll = 100
    command(words.rescue)
    assert(env.ZIL_TRUE(env.RESCUED))
    command(words.east)
    local beforeInspect = rollCount
    local preview = command(words.inspect)
    assert(preview:find(words.forecast .. words.tiers[profile.required] .. ".", 1, true), preview)
    assert(rollCount == beforeInspect, "inspection rolled a die")
    roll = profile.cutoff - 1
    command(words.restore)
    assert(not env.ZIL_TRUE(env.DISABLED) and env.LAST_FEAT_REQUIRED == profile.required)
    assert(env.STAT(env.HERO, env.A_HEALTH) == profile.health - 15)
    roll = profile.cutoff
    command(words.restore)
    assert(env.ZIL_TRUE(env.DISABLED) and walk.finishes == 1)
    assert(env.STAT(env.HERO, env.A_KARMA) == profile.karma + 30)
  end
end
print("ok - FASERIP thresholds and read-only live sheets for all nine localized hero profiles")
