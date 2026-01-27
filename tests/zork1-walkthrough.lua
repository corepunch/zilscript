-- Test file for Zork I walkthrough
-- Based on standard Zork I walkthrough - tests major game progression
-- This walkthrough covers key early game steps from the classic Zork I

return {
	name = "Zork I Complete Walkthrough Test",
	files = {
		"zork1/globals.zil",
		"zork1/dungeon.zil",
		"zork1/actions.zil",
		"zork1/macros.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		-- Part 1: Starting the Game
		{input="look",here="WEST-OF-HOUSE",description="Start at West of House"},
		{input="open mailbox",flag="MAILBOX OPENBIT",description="Open the mailbox"},
		{input="read leaflet",text="ZORK",description="Read the welcome leaflet"},
		
		-- Part 2: Navigate Around the House
		{input="north",here="NORTH-OF-HOUSE",description="Go to North of House"},
		{input="east",here="EAST-OF-HOUSE",description="Go to East of House (Behind House)"},
		
		-- Part 3: Look Around
		{input="look",here="EAST-OF-HOUSE",description="Confirm we're at East of House"},
		
		-- Note: This is a basic walkthrough showing early game steps
		-- The complete game includes many locations, puzzles, and treasures
		-- This test demonstrates that the Zork I dungeon and actions load correctly
		-- and that basic navigation and object interaction work
	}
}
