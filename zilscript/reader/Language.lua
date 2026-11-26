local Language = {}

local profiles = {
	en = {
		directions = {
			n = "north", north = "north", e = "east", east = "east",
			s = "south", south = "south", w = "west", west = "west",
			ne = "northeast", northeast = "northeast", nw = "northwest", northwest = "northwest",
			se = "southeast", southeast = "southeast", sw = "southwest", southwest = "southwest",
			u = "up", up = "up", d = "down", down = "down", ["in"] = "in", out = "out",
		},
		compass = { "north", "south", "east", "west", "northeast", "northwest",
			"southeast", "southwest", "up", "down", "in", "out" },
		look = "look", inventory = "inventory", wait = "wait",
		lookTitle = "Look around", inventoryTitle = "Inventory", examine = "examine", take = "take",
		go = "go", goTitle = "Go ", release = "Release",
	},
	de = {
		directions = {
			n = "nord", nord = "nord", norden = "nord", o = "ost", ost = "ost", osten = "ost",
			s = "sued", sued = "sued", ["süd"] = "sued", sueden = "sued", ["süden"] = "sued",
			w = "west", west = "west", westen = "west",
			no = "no", nordost = "no", nw = "nw", nordwest = "nw",
			so = "so", ["südost"] = "so", suedost = "so", sw = "sw", ["südwest"] = "sw", suedwest = "sw",
			rauf = "rauf", runter = "runter", hinein = "hinein", raus = "raus",
		},
		compass = { "nord", "sued", "ost", "west", "no", "nw", "so", "sw", "rauf", "runter", "hinein", "raus" },
		directionTitles = {
			nord = "Nach Norden", sued = "Nach Süden", ost = "Nach Osten", west = "Nach Westen",
			no = "Nach Nordosten", nw = "Nach Nordwesten", so = "Nach Südosten", sw = "Nach Südwesten",
			rauf = "Hinauf", runter = "Hinunter", hinein = "Hinein", raus = "Hinaus",
		},
		look = "schau", inventory = "inventar", wait = "warte",
		lookTitle = "Umsehen", inventoryTitle = "Inventar", examine = "untersuch", take = "nimm",
		go = "geh", release = "Ausgabe",
		titles = {
			untersuch = "Untersuchen", oeffn = "Öffnen", nimm = "Nehmen", lies = "Lesen",
			leg = "Legen", schliess = "Schließen", lass = "Fallen lassen", hoer = "Hören",
			drueck = "Drücken", kipp = "Kippen", reib = "Reiben", riech = "Riechen",
		},
	},
}

function Language.profile(code)
	return profiles[code] or profiles.en
end

function Language.controls(code)
	local profile = Language.profile(code)
	return { profile.look, profile.inventory, profile.wait }
end

return Language
