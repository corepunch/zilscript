local Walk = require("tests.story_walk")
local w=Walk.new("books.ru.last-door-of-battleworld.last-door-of-battleworld",97,"ru")
local first=w:command("выбрать паук")
assert(first:find("Здесь: медная катушка.",1,true) and not first:find("There is",1,true))
w:play({"взять катушка", "север", "использовать передатчик", "север", "север",
        "потянуть лебёдка", "север", "осмотреть весы"})
local market=w:command("осмотреться")
assert(market:find("Здесь: бронзовый язык.",1,true) and not market:find("There is",1,true))

print("ok - Russian room listings name loose coil and clapper")
