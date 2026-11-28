-- Exercise the same prose-link action menus used by the persistent reader.
local Walk = require("tests.link_walk")
local paths = {
 en = {"choose spider spider-man", "take copper coil", "north", "use shield relay", "north", "north",
       "pull hand winch", "north", "examine market scales", "take brass clapper", "west", "inventory",
       "put brass clapper in village bell", "pull village bell", "east", "north", "north"},
 ru = {"выбрать паук", "взять катушка", "север", "использовать передатчик", "север", "север",
       "потянуть лебёдка", "север", "осмотреть весы", "взять язык", "запад", "инвентарь",
       "вставить язык в колокол", "потянуть колокол", "восток", "север", "север"},
}
for lang, route in pairs(paths) do
 local w=Walk.new("books."..lang..".last-door-of-battleworld.last-door-of-battleworld",97,lang)
 w:play(route)
 assert(w.env.BW_BELL_RUNG, "village puzzle should be completed")
 assert(w.env.HERE==w.env.BW_WORLDSHIP, "link route should reach the Worldship")
end
print("ok - English and Russian reader links reach the Worldship via the village")
