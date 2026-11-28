-- A full countdown must warn the player again after the first grey sky.
local Walk = require("tests.link_walk")
local w = Walk.new("books.en.wondertown.wondertown", 97)
w.game:resume("easy")
local grey, urgent, sunrise
for turn = 1, 200 do
	local output = w.game:resume("wait")
	if output:find("first grey hint", 1, true) then grey = turn end
	if output:find("Dawn is close", 1, true) or output:find("growing still", 1, true) or output:find("Pip has minutes", 1, true) then urgent = turn end
	if output:find("sun rises", 1, true) then sunrise = turn; break end
end
assert(grey and urgent and sunrise and grey < urgent and urgent < sunrise,
	"the reader needs an urgent warning between grey sky and sunrise")
print("ok - Wondertown warns again as dawn approaches")
