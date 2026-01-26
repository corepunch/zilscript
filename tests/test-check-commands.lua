-- Simple test to verify check commands now return ok/fail properly
return {
	name = "Test Check Commands (ok/fail behavior)",
	files = {
		"zork1/globals.zil",
		"adventure/horror.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		{
			input = "look",
			description = "Start game"
		},
		-- Test check-inventory when object is NOT in inventory (should show fail)
		{
			input = "test:check-inventory BRASS_PLAQUE",
			description = "Check if plaque is in inventory (should fail - not taken yet)"
		},
		-- Take the plaque
		{
			input = "take plaque",
			description = "Take the brass plaque"
		},
		-- Test check-inventory when object IS in inventory (should show ok)
		{
			input = "test:check-inventory BRASS_PLAQUE",
			description = "Check if plaque is in inventory (should be ok - just taken)"
		},
		-- Move to reception room to test flags
		{
			input = "north",
			description = "Enter sanitarium"
		},
		{
			input = "west",
			description = "Go to reception room"
		},
		-- Test check-flag when flag is NOT set (should show fail)
		{
			input = "test:check-flag BOTTOM_DRAWER OPENBIT",
			description = "Check if drawer is open (should fail - not opened yet)"
		},
		-- Take the key
		{
			input = "take key",
			description = "Take brass key"
		},
		-- Unlock and open drawer
		{
			input = "unlock drawer with key",
			description = "Unlock the bottom drawer"
		},
		{
			input = "open drawer",
			description = "Open the drawer"
		},
		-- Test check-flag when flag IS set (should show ok)
		{
			input = "test:check-flag BOTTOM_DRAWER OPENBIT",
			description = "Check if drawer is open (should be ok - just opened)"
		},
	}
}
