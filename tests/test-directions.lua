-- Test file for direction/movement commands
-- Inspired by ZILF's test-directions.zil

return {
	name = "Direction/Movement Tests",
	files = {
		"zork1/globals.zil",
		"zork1/clock.zil",
		"tests/test-directions.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		{
			input = "look",
			here = "STARTROOM",
			description = "Look at starting room"
		},
		{
			input = "north",
			here = "HALLWAY",
			description = "Move north to hallway"
		},
		{
			input = "look",
			here = "HALLWAY",
			description = "Look at hallway"
		},
		{
			input = "north",
			here = "CLOSET",
			description = "Move north again to closet"
		},
		{
			input = "look",
			here = "CLOSET",
			description = "Look at closet"
		},
		{
			input = "south",
			here = "HALLWAY",
			description = "Move south back to hallway"
		},
		{
			input = "south",
			here = "STARTROOM",
			description = "Move south to start room"
		},
		{
			input = "in",
			here = "HALLWAY",
			description = "Use IN direction (should go to hallway)"
		},
		{
			input = "out",
			here = "STARTROOM",
			description = "Use OUT direction (should return to start room)"
		},
	}
}
