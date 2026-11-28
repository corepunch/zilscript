-- Story and companion regressions.
local Walk = require("tests.story_walk")
local w = Walk.new("books.en.wondertown.wondertown", 97)
assert(w.output:find("Type EASY", 1, true), "The opening makes the optional countdown discoverable")
w:command("easy")
local grey, urgent, sunrise
for turn = 1, 200 do
	local output = w:command("wait")
	if output:find("first grey hint", 1, true) then grey = turn end
	if output:find("Dawn is close", 1, true) or output:find("growing still", 1, true) or output:find("Pip has minutes", 1, true) then urgent = turn end
	if output:find("sun rises", 1, true) then sunrise = turn; break end
end
assert(grey and urgent and sunrise and grey < urgent and urgent < sunrise,
	"the reader needs an urgent warning between grey sky and sunrise")
assert(not w:running() and w.finishes == 1)
assert(w.output:find("Morning has come, and the toys are sleeping.", 1, true))
print("ok - Wondertown warns again as dawn approaches")
