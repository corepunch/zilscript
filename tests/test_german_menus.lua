-- A German reader's menu speaks the plain verb of an action the language
-- spells several ways: nimm (not heb auf) takes, leg X in Y (not benutz X
-- fuer Y) puts. Plays a German book whose Morgenblatt sits in a cabinet.
package.path = "./tests/?.lua;" .. package.path
local Walk = require("link_walk")

local walk = Walk.new("books.de.borrowed-tomorrows.borrowed-tomorrows")
walk:choose("oeffn leihschrank")
assert(walk:offers("nimm morgenblatt"), "an item in an open container is taken with nimm:\n" .. walk:describeMenu())
assert(not walk:offers("heb auf morgenblatt"), "the particle spelling is not the menu's:\n" .. walk:describeMenu())
walk:choose("nimm morgenblatt")
for _, step in ipairs({ "nord", "lies leihschein", "ost", "inventar", "leg morgenblatt in leserahmen", "sued", "lies faltbrett" }) do
	walk:choose(step)
end
assert(walk:offers("leg morgenblatt in faltbrett"), "putting uses leg ... in:\n" .. walk:describeMenu())
for _, entry in ipairs(walk:menu()) do
	assert(not entry.command:match("^benutz "), "benutz is not a put: " .. entry.command)
end
print("German menu verbs ok")
