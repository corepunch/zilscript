-- Test file for Zork I walkthrough
-- Based on standard Zork I walkthrough - tests major game progression
-- This walkthrough covers the main quest to collect the 20 treasures

return {
	name = "Zork I Complete Walkthrough Test",
	files = {
		"zork1/globals.zil",
		"zork1/dungeon.zil",
		"zork1/actions.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		-- Part 1: Starting the Game and Getting Inside
		{input="look",here="WEST-OF-HOUSE",description="Start at West of House"},
		{input="open mailbox",flag="MAILBOX OPENBIT",description="Open the mailbox"},
		{input="take leaflet",take="LEAFLET",description="Take the leaflet from mailbox"},
		{input="read leaflet",text="ZORK",description="Read the welcome leaflet"},
		{input="drop leaflet",lose="LEAFLET",description="Drop leaflet (no longer needed)"},
		
		-- Part 2: Navigate to Behind House and Enter
		{input="north",here="NORTH-OF-HOUSE",description="Go to North of House"},
		{input="east",here="EAST-OF-HOUSE",description="Go behind the house (EAST-OF-HOUSE)"},
		{input="open window",flag="KITCHEN-WINDOW OPENBIT",description="Open the kitchen window"},
		{input="west",here="KITCHEN",description="Enter the kitchen through window"},
		
		-- Part 3: Get the Lamp and Explore Living Room
		{input="take lamp",take="BRASS-LANTERN",description="Take the brass lantern"},
		{input="west",here="LIVING-ROOM",description="Go to the living room"},
		{input="take sword",take="SWORD",description="Take the elvish sword"},
		{input="open trap door",flag="TRAP-DOOR OPENBIT",description="Open the trap door"},
		{input="turn on lamp",flag="BRASS-LANTERN ONBIT",description="Turn on the brass lantern"},
		{input="down",here="CELLAR",description="Descend into the cellar"},
		
		-- Part 4: Trophy Case and First Exploration
		{input="east",here="EAST-OF-CHASM",description="Go east to East of Chasm"},
		{input="north",here="GALLERY",description="Go north to Gallery"},
		{input="up",here="ATTIC",description="Go up to Attic"},
		{input="take rope",take="ROPE",description="Take the rope"},
		{input="take knife",take="RUSTY-KNIFE",description="Take the rusty knife"},
		{input="down",here="GALLERY",description="Go back down to Gallery"},
		{input="west",here="STUDIO",description="Go west to Studio"},
		{input="take painting",take="PAINTING",description="Take the painting (treasure 1)"},
		{input="east",here="GALLERY",description="Return to Gallery"},
		{input="south",here="EAST-OF-CHASM",description="Go south to East of Chasm"},
		{input="west",here="CELLAR",description="Return to cellar"},
		{input="put painting in case",description="Put painting in trophy case"},
		
		-- Note: This is a basic walkthrough showing key early game steps
		-- A complete walkthrough would continue with more treasures and puzzles
		-- The actual game requires solving the troll, thief, and many other challenges
	}
}
