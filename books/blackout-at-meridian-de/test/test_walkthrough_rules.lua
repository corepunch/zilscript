-- Plays Stromausfall in Meridian (the German Blackout at Meridian) with typed
-- commands on the seeded generator link_walk.lua installs, so every d100 roll
-- replays. Umlaut and ASCII spellings, articles by case, and pronouns by
-- gender are all typed the way a child would.
local Hero = require("books.blackout-at-meridian-de.test.hero")

local h = Hero.new()
local w = h.w
local function until_success(command, text, tries)
	for _ = 1, tries do
		if h:send(command):find(text, 1, true) then return end
		assert(w:running(), command .. " ended the story")
	end
	error(command .. " never printed " .. text)
end

assert(w.output:find("Stromausfall in Meridian", 1, true), "the opening names the story:\n" .. w.output)
assert(w.output:find("Leitstelle", 1, true), w.output)
-- Nobody leaves dispatch without a profile.
h:expect("nord", "Wähle zuerst ein Profil")
h:expect("geh nach norden", "Wähle zuerst ein Profil")
-- The ruleset's own words answer when no object does.
h:expect("tanz", "kann nicht von dem Spielvokabular verstanden werden")
h:expect("schlage regen", "Das ist kein Ziel.")
h:expect("rette fenster", "Dort muss niemand gerettet werden.")
h:expect("deaktiviere tafel", "Das ist keine Steuerung.")
h:expect("wähle fenster", "Das ist kein Profil.")
h:expect("fokussiere das fenster", "Das hilft dir nicht.")
h:expect("diagnose", "Du hast noch keine Ränge")
h:expect("inventar", "Du trägst:")
-- The sheet is masculine: "ihn" is the sheet, and it stays with the hero.
h:expect("untersuche den heldenbogen", "Noch kein Profil angemeldet.")
h:expect("lass ihn fallen", "Du behältst deinen Heldenbogen.")
-- Umlauts and ASCII both reach the same verb: waehle / wähle / Wähle.
local sheet = h:expect("Wähle den Fels", "Die Leitstelle meldet dich als Fels an.")
assert(sheet:find("Kampf: 30, Gewandtheit: 10\n", 1, true), sheet)
assert(sheet:find("Stärke: 40, Ausdauer: 40\n", 1, true), sheet)
assert(sheet:find("Gesundheit: 120/120, Karma: 26", 1, true), sheet)
h:expect("waehle blitz", "bereits als Fels angemeldet")
-- An unnamed hero is called Meridian.
h:expect("lies bogen", "Held: Meridian (Fels)\n")
h:expect("zustand", "Gesundheit 120 von 120, Karma 26.")
h:expect("hilfe", "RETTE die FAHRGÄSTE")
h:expect("nord", "Es sind noch Menschen darin.")
h:expect("untersuche die straßenbahn", "mit der Nase nach unten über dem Fluss")
h:expect("untersuche die strassenbahn", "mit der Nase nach unten über dem Fluss")
-- The tram is feminine: "sie" is the tram.
h:expect("stoße sie an", "Fahrgäste müssen gehalten werden")
until_success("rette die fahrgäste", "reichst die Fahrgäste", 8)
h:expect("rette die bahn", "Alle sind schon in Sicherheit.")
h:expect("ost", "Wachdrohne")
h:expect("zustand", "Gesundheit ")
h:expect("untersuche die drohne", "Panzerung 40 von 40")
-- The drone is feminine too.
until_success("schlag sie", "Die Drohne kracht auf den Boden", 8)
local ending = h:expect("deaktiviere das schaltpult", "ruft deinen Namen: Meridian. Meridian ist gerettet.")
assert(not ending:find("Verstandsprobe", 1, true), "a downed drone leaves the lever unguarded:\n" .. ending)
assert(ending:find("ENDE: DIE LICHTER VON MERIDIAN", 1, true), ending)
assert(ending:find("Held: Meridian (Fels)", 1, true), "the ending prints the hero:\n" .. ending)
assert(w.finishes == 1 and not w:running(), "the story ends through FINISH when Meridian is safe")
print("ok - Stromausfall in Meridian typed walkthrough")
