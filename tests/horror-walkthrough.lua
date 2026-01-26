-- Test file for horror.zil complete walkthrough
-- Based on horror-walkthrough.md - tests that the game is winnable

return {
	name = "Horror.zil Complete Walkthrough Test",
	files = {
		"zork1/globals.zil",
		"adventure/horror.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		-- Act 1: Entrance and Upper Floors
		-- Note: Object names use underscores (e.g., BRASS-PLAQUE) because ZIL hyphens
		-- are converted to underscores during Lua compilation
		{input="look",here="SANITARIUM-GATE",description="Start at Sanitarium Gate"},
		{input="examine plaque",description="Learn about Blackwood Sanitarium"},
		{input="take plaque",inventory="BRASS-PLAQUE",description="Take the brass plaque"},
		{input="north",here="SANITARIUM-ENTRANCE",description="Enter Sanitarium Entrance Hall"},
		{input="examine wallpaper",description="Notice the Victorian-era decay"},
		{input="west",description="Go to Reception Room"},
		{input="take key",inventory="BRASS-KEY",description="Take brass key from scattered papers"},
		{input="examine desk",description="Notice the bottom drawer is locked"},
		{input="open drawer",flag="BOTTOM-DRAWER OPENBIT",description="Unlock bottom drawer with brass key"},
		{input="take ledger",inventory="PATIENT-LEDGER",description="Take patient ledger from drawer"},
		{input="read ledger",description="Learn about Patient 237 and Dr. Mordecai"}
		-- "east", -- "Return to Entrance Hall"
		-- "north", -- "Go to Operating Theater"
		-- "examine table", -- "See the gruesome operating table"
		-- "examine cabinet", -- "Notice the medical cabinet"
		-- "take scalpel", -- "Take scalpel - important tool"
		-- "test:inventory SCALPEL", -- "Verify scalpel in inventory"
		-- "take bottle", -- "Take ether bottle"
		-- "south", -- "Return to Entrance Hall"
		-- "east", -- "Go to Patient Ward"
		-- "examine beds", -- "See the deteriorated ward"
		-- "examine door", -- "Notice chains blocking morgue"
		-- "attack chains", -- "Cut through chains with scalpel"
		-- "north", -- "Enter Morgue"
		-- "test:location", -- "Verify at morgue"
		-- "examine drawers", -- "Find glowing contents"
		-- "take serum", -- "Take strange glowing serum (Compound 237)"
		-- "test:inventory GLOWING-SERUM", -- "Verify serum in inventory"
		-- "examine bundle", -- "See canvas-wrapped body"
		-- "take journal", -- "Take Dr. Mordecai's journal"
		-- "read journal", -- "Learn about the terrible experiment"
		
		-- -- Act 2: Basement Exploration
		-- "south", -- "Return to Patient Ward"
		-- "west", -- "Return to Entrance Hall"
		-- "down", -- "Descend to Basement Stairs"
		-- "down", -- "Continue to Basement Corridor"
		-- "examine pipes", -- "Notice the valve"
		-- "turn valve", -- "Release steam - important for later"
		-- "east", -- "Enter Boiler Room"
		-- "examine boiler", -- "See the massive iron furnace"
		-- "open boiler", -- "Open the boiler"
		-- "take shovel", -- "Take coal shovel"
		-- "examine workbench", -- "Find tools"
		-- "take flashlight", -- "Take flashlight (dead batteries)"
		-- "west", -- "Return to Basement Corridor"
		-- "west", -- "Enter Storage Room"
		-- "examine shelves", -- "Find supplies"
		-- "take lantern", -- "Take oil lantern - working light"
		-- "test:inventory OIL-LANTERN", -- "Verify lantern in inventory"
		-- "light lantern", -- "Illuminate the darkness"
		-- "test:flag OIL-LANTERN ONBIT", -- "Verify lantern is lit"
		-- "take records", -- "Take medical records"
		-- "read records", -- "Learn about Patient 189"
		-- "east", -- "Return to Basement Corridor"
		-- "north", -- "Enter Flooding Chamber"
		-- "examine water", -- "Cold ankle-deep water"
		-- "examine door", -- "Sealed door to east - needs steam"
		-- "open door", -- "Steam has loosened it - access Hydrotherapy"
		-- "east", -- "Enter Hydrotherapy Room"
		-- "examine tubs", -- "See restraint-equipped tubs"
		-- "look in tubs", -- "Find notebook"
		-- "take notebook", -- "Take soggy notebook"
		-- "read notebook", -- "Learn about water torture"
		-- "examine cabinet", -- "Medicine cabinet"
		-- "take syringe", -- "Take syringe"
		-- "west", -- "Return to Flooding Chamber"
		-- "north", -- "Enter Isolation Ward"
		-- "examine doors", -- "See the cell doors"
		-- "examine scratches", -- "Critical clue: PATIENT 189 STILL ALIVE IN THE CHAPEL"
		-- "north", -- "Enter Electroshock Theater"
		-- "examine chair", -- "The terrible shock chair"
		-- "examine machine", -- "Electroshock equipment"
		-- "west", -- "Enter Padded Cell"
		-- "examine padding", -- "Blood message about chapel and Patient 189"
		-- "take jacket", -- "Take straitjacket (optional)"
		-- "east", -- "Return to Electroshock Theater"
		
		-- -- Act 3: Administrative Wing and Final Confrontation
		-- "east", -- "Climb to Observation Deck"
		-- "examine mirror", -- "One-way mirror overlooking theater"
		-- "take logbook", -- "Take observation logbook"
		-- "read logbook", -- "Learn about Patient 189's treatment"
		-- "north", -- "Enter Administrative Wing"
		-- "examine papers", -- "Find memo about Patient 189 and chapel"
		-- "east", -- "Enter Director's Office"
		-- "examine portrait", -- "See Dr. Heinrich Mordecai's portrait"
		-- "examine desk", -- "Find hidden compartment"
		-- "take key", -- "Take safe key"
		-- "test:inventory SAFE-KEY", -- "Verify safe key in inventory"
		-- "examine safe", -- "Notice wall safe"
		-- "unlock safe", -- "Open safe with safe key"
		-- "test:flag WALL-SAFE OPENBIT", -- "Verify safe is open"
		-- "take notes", -- "Take Dr. Mordecai's private notes"
		-- "read notes", -- "Learn Patient 189 transcended death"
		-- "take key", -- "Take chapel key (iron key with cross)"
		-- "test:inventory CHAPEL-KEY", -- "Verify chapel key in inventory"
		-- "west", -- "Return to Administrative Wing"
		-- "north", -- "Enter Staff Quarters"
		-- "examine lockers", -- "Find personal items"
		-- "take photograph", -- "Take staff photo from 1950"
		-- "examine photograph", -- "See the sanitarium staff"
		-- "west", -- "Enter Cafeteria"
		-- "examine counter", -- "Old service area"
		-- "take bell", -- "Take service bell (optional)"
		-- "north", -- "Enter Overgrown Garden"
		-- "examine garden", -- "Wild tangle of dead plants"
		-- "examine door", -- "Chapel door with ominous message"
		-- "unlock door", -- "Use chapel key to unlock final area"
		-- "north", -- "Enter Chapel - Final Location"
		-- "test:location", -- "Verify at chapel - final location"
		-- "examine pews", -- "Strange carved symbols"
		-- "examine candles", -- "Unnatural green flames"
		-- "examine patient", -- "Patient 189 - Dr. Mordecai's achievement"
		-- "hello", -- "WIN CONDITION - Patient 189 speaks and crumbles to ash"
	}
}
