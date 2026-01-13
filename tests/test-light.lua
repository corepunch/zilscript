-- Test file for light source mechanics
-- Inspired by ZILF's test-light.zil

return {
	name = "Light Source Tests",
	files = {
		"zork1/globals.zil",
		"tests/test-light.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		{
			input = "look",
			description = "Look in the dark (should show darkness message)"
		},
		{
			input = "turn on flashlight",
			description = "Turn on flashlight"
		},
		{
			input = "look",
			description = "Look with light (should see room description)"
		},
		{
			input = "turn off flashlight",
			description = "Turn off flashlight"
		},
		{
			input = "look",
			description = "Look in darkness again"
		},
		{
			input = "take lantern",
			description = "Take the lantern"
		},
		{
			input = "turn on lantern",
			description = "Turn on lantern"
		},
		{
			input = "look",
			description = "Look with lantern light"
		},
		{
			input = "inventory",
			description = "Check inventory"
		},
	}
}
