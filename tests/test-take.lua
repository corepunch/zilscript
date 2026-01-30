-- Test file for TAKE command functionality
-- Inspired by ZILF's test-take.zil

return {
	name = "TAKE Command Tests",
	files = {
		"zork1/globals.zil",
		"zork1/clock.zil",
		"tests/test-take.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		{
			input = "take apple",
			take = "APPLE",
			description = "Take a nearby object"
		},
		{
			input = "inventory",
			text = "apple",
			description = "Check inventory contains the apple"
		},
		{
			input = "drop apple",
			lose = "APPLE",
			description = "Drop the apple"
		},
		{
			input = "take banana",
			take = "BANANA",
			description = "Take another object"
		},
		{
			input = "take desk",
			text = "valiant",
			description = "Attempt to take an untakeable object (should fail)"
		},
		{
			input = "inventory",
			text = "banana",
			description = "Check inventory"
		},
	}
}
