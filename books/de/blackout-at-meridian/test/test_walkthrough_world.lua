-- Story and companion regressions.
local Hero = require("books.de.blackout-at-meridian.test.hero")

local h = Hero.new()
h:force(100)

-- Before a profile: no way out, no ranks, and every hero action refuses.
h:expect("schau", "Wähle deinen Helden")
h:expect("nord", "Wähle zuerst ein Profil")
h:expect("raus", "Wähle zuerst ein Profil")
for _, dir in ipairs({ "sued", "süden", "ost", "west", "rauf", "runter" }) do h:expect(dir, "kannst du nicht gehen") end
h:expect("untersuche den bogen", "Noch kein Profil angemeldet.")
h:expect("punktestand", "noch kein Profil angemeldet")
h:expect("diagnose", "Du hast noch keine Ränge")
h:expect("tipp", "WÄHLE FELS, BLITZ oder LUCHS")
h:expect("rette die straßenbahn", "draußen auf der Brücke")
h:expect("schlag das fenster", "genug zu reparieren")
h:expect("benutze den kasten", "Du kannst das hier nicht sehen!")
h:expect("nimm fels", "bleibt an der Tafel")
assert(h:state().class == 0, "taking a card does not choose it")
h:expect("untersuche die karte", "meinst du")
for _, card in ipairs({ "fels", "blitz", "luchs" }) do h:expect("untersuche " .. card, "Um dieses Profil zu übernehmen, wähle es.") end

-- The typed name: READ lowercases it, so words are capitalised; spaces are
-- collapsed; a blank line or a line with umlauts keeps the current name; a
-- long name is cut at the last whole word within 32 characters.
local function name(text, expected)
	h:expect("nenne den bogen", "Gib den Namen deines Helden ein")
	h:expect(text, expected)
end
name("", "Die Leitstelle nennt dich weiter Meridian.")
name("   ", "Die Leitstelle nennt dich weiter Meridian.")
name("Jörg", "Dein Name bleibt Meridian.")
name("the very long hero name of the night watch", "Name des Helden eingetragen: The Very Long Hero Name Of The\n")
name("abcdefghijklmnopqrstuvwxyz0123456789abcdefgh", "Name des Helden eingetragen: Abcdefghijklmnopqrstuvwxyz012345\n")
name("kapitaen regen", "Name des Helden eingetragen: Kapitaen Regen\n")
name("Ñame", "Dein Name bleibt Kapitaen Regen.")
name("", "nennt dich weiter Kapitaen Regen.")
name("  dr.   o'neil-smith, jr.!?  ", "Name des Helden eingetragen: Dr. O'neil-Smith, Jr.!?\n")
h:expect("lies den bogen", "Held: Dr. O'neil-Smith, Jr.!?\n")
h:expect("nenne mich", "Das hat keinen Namen zu vergeben.")
h:expect("lass den bogen fallen", "Du behältst deinen Heldenbogen.")
h:expect("wirf den bogen", "Du behältst deinen Heldenbogen.")

-- One profile per call.
h:expect("waehle luchs", "meldet dich als Luchs an.")
h:expect("wähle blitz", "bereits als Luchs angemeldet")
h:expect("wähle fels", "bereits als Luchs angemeldet")
local s = h:state()
assert(s.class == 3 and s.max == 60 and s.karma == 90, "a second choice changes nothing")
h:expect("untersuche luchs", "Das ist dein Profil.")
h:expect("untersuche die tafel", "Die Luchs-Karte ist mit rotem Stift als AKTIV markiert")
h:expect("schau", "Dein Profil ist auf der")
h:expect("hilfe", "RETTE die FAHRGÄSTE")

-- Scenery named in prose answers, per room. Jumping and swimming never kill.
local scenery = {
	{ "untersuche das fenster", "regennasse Glas" }, { "öffne das fenster", "zugestrichen" }, { "schau durch das fenster", "regennasse Glas" },
	{ "untersuche den regen", "silbernen Streifen" }, { "höre den regen", "gleichmäßiges Rauschen" }, { "rieche den regen", "verbranntem Kabel" },
	{ "untersuche die stadt", "dunkel da" }, { "untersuche den fluss", "hoch und schnell" }, { "untersuche die straßenbahn", "rotes Warnlicht" },
	{ "untersuche die brücke", "kurzes Stück nach Norden" }, { "untersuche die tafel", "AKTIV" }, { "lausche", "Regen am Glas" },
	{ "hör zu", "Regen am Glas" }, { "spring", "zu allem bereit" }, { "schwimme", "Strömung würde dich" },
}
for _, step in ipairs(scenery) do h:expect(step[1], step[2]) end

h:expect("nord", "Es sind noch Menschen darin.")
h:expect("hilfe", "RETTE die FAHRGÄSTE")
for _, step in ipairs({
	{ "untersuche die mannschaft", "gelben Mänteln" }, { "sag mannschaft", "nicht mehr lange" }, { "frage die mannschaft", "nicht mehr lange" },
	{ "untersuche die schienen", "nach außen verbogen" }, { "besteige die schienen", "Bis hinunter zum Fluss" }, { "nimm die schienen", "geschraubt" },
	{ "untersuche das kabel", "reißt noch ein Draht" }, { "berühre das kabel", "Es ist tot." }, { "höre das kabel", "singt im Wind" },
	{ "höre die fahrgäste", "Kind weinen" }, { "stoße die straßenbahn an", "gehalten werden" }, { "schlage die bahn", "Leute drin" },
	{ "rette die mannschaft", "Dort muss niemand gerettet werden." }, { "schlage die mannschaft", "auf deiner Seite" },
	{ "untersuche den fluss", "hoch und schnell" }, { "schwimme im fluss", "Strömung würde dich" }, { "spring in den fluss", "Strömung würde dich" },
	{ "untersuche den regen", "waagerecht" }, { "untersuche die stadt", "dunkel da" }, { "untersuche die brücke", "alte Stahlbrücke" },
	{ "untersuche die station", "gedrungenes Betongebäude" }, { "untersuche die tür", "aus dem Schloss gerissen" }, { "schließe die tür", "geht nicht mehr zu" },
	{ "lausche", "das Kabel, das über dem Fluss knarrt" }, { "spring", "eines Besseren" }, { "schwimme", "Strömung würde dich" },
	{ "ost", "Rette sie zuerst." }, { "geh in die station", "Rette sie zuerst." }, { "runter", "Die Mannschaft sichert das Flussufer." },
	{ "nord", "kannst du nicht gehen" }, { "west", "kannst du nicht gehen" },
}) do h:expect(step[1], step[2]) end
assert(h:running(), "no scenery verb ends the story")
h:expect("sued", "Notleitstelle")
h:expect("nord", "Es sind noch Menschen darin.")
h:expect("ziehe das kabel", "reichst die Fahrgäste")
h:expect("schau", "Fahrgäste sind bei der")
h:expect("untersuche die straßenbahn", "Es ist niemand mehr darin.")
h:expect("sag mannschaft", "schalte sie ab")
h:expect("hilfe", "DROHNE ANGREIFEN")
h:expect("geh durch die tür", "Betonhalle")
h:expect("west", "Fahrgäste sind bei der")
h:expect("ost", "Betonhalle")
for _, step in ipairs({
	{ "untersuche die station", "Du bist drin." }, { "untersuche die tür", "aus dem Schloss gerissen" }, { "untersuche den regen", "Betondach" },
	{ "untersuche die brücke", "nach Westen in den Regen" }, { "untersuche die drohne", "Panzerung 40 von 40" }, { "untersuche das auge", "Panzerung 40 von 40" },
	{ "sag drohne", "SPERRGEBIET" }, { "nimm die drohne", "gegen sie kämpfen" }, { "höre die drohne", "Rotoren surren" },
	{ "untersuche das pult", "Handhebel" }, { "untersuche den hebel", "Handhebel" }, { "nimm das pult", "geschraubt" },
	{ "schlage das pult", "Der Hebel reicht." }, { "untersuche den kasten", "kostet 10 Karma" }, { "nimm den kasten", "Benutze ihn dort" },
	{ "lausche", "Surren der Drohnenrotoren" }, { "spring", "zu allem bereit" }, { "rette die drohne", "Dort muss niemand gerettet werden." },
	{ "wähle die drohne", "Das ist kein Profil." }, { "fokussiere die drohne", "Das hilft dir nicht." }, { "ost", "kannst du nicht gehen" },
}) do h:expect(step[1], step[2]) end
h:expect("raus", "Fahrgäste sind bei der")
h:expect("ost", "Betonhalle")
assert(h:running() and h:state().health == 60, "nothing in the station hurts until the hero acts")

h:expect("deaktiviere das pult", "Meridian ist gerettet.")
assert(not h:running(), "the lever ends the story")

-- Downed drone, used kit and the bridge after the rescue.
h = Hero.new()
h:force(100)
h:start("blitz")
h:send("rette die bahn")
h:send("ost")
h:force(1)
h:send("schlag die drohne")
h:send("benutze den kasten")
h:force(100)
h:send("schlag die drohne")
h:expect("sued", "kannst du nicht gehen")
h:expect("west", "Fahrgäste sind bei der")
h:send("sued")

print("ok - Stromausfall in Meridian world and names")
