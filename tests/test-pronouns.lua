-- Test file for pronoun handling (IT, THEM, etc.)
-- Inspired by ZILF's test-pronouns.zil

return {
	name = "Pronoun Handling Tests",
	files = {
		"zork1/globals.zil",
		"tests/test-pronouns.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		{
			input = "look",
			description = "Look at starting room"
		},
		{
			input = "take all",
			description = "Take all items in room"
		},
		{
			input = "inventory",
			description = "Check inventory"
		},
		{
			input = "drop them",
			description = "Drop items using 'them' pronoun"
		},
		{
			input = "inventory",
			description = "Check inventory is now empty"
		},
		{
			input = "take apple",
			description = "Take the apple"
		},
		{
			input = "examine it",
			description = "Examine the apple using 'it' pronoun"
		},
		{
			input = "drop wallet",
			description = "Drop wallet"
		},
		{
			input = "west",
			description = "Move to hallway"
		},
		{
			input = "examine it",
			description = "Try to examine 'it' in another room (should fail or give message)"
		},
	}
}
