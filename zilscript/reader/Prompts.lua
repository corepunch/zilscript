return {
	companion = { controls = "Use ↑ or ↓ to pick an action and Enter to play it. You can also type a command.",
		question = "What will you do?", scene = "In this scene", move = "Go somewhere",
		prompt = "Choose a number, or type any command: " },
	look = "look", inventory = "inventory", wait = "wait", take = "take", examine = "examine",
	lookTitle = "Look around", inventoryTitle = "Inventory",
	-- Commands handled separately by the completion generator.
	skip = { look = true, examine = true },
	verbs = {
		"look", "examine", "open", "take", "inventory", "read", "go", "drop",
		"close", "enter", "turn on", "turn off", "push", "pull", "move", "put",
		"give", "unlock", "lock", "climb", "light", "search", "listen", "smell",
		"wait", "attack", "eat", "drink", "wear", "remove", "throw", "tie",
		"knock", "jump", "exit", "turn", "ask", "tell", "say", "touch",
	},
	needsSecond = { put = true, give = true, tie = true, throw = true, show = true, unlock = true, lock = true },
	-- "moves" and "score" status line pieces.
	score = "Score %d of %d", scoreOnly = "Score %d", time = "Time %d",
	move = "move", moves = "moves", movesOnly = "%d moves",
	-- Commands played on every object to prove each gets an answer.
	probes = {
		"take %s", "drop %s", "climb %s", "push %s", "pull %s", "open %s", "close %s",
		"read %s", "touch %s", "search %s", "move %s", "kick %s", "eat %s", "smell %s",
		"listen to %s", "look under %s", "look behind %s", "look in %s", "turn %s",
		"enter %s", "sit on %s", "break %s", "wear %s", "knock on %s", "light %s",
	},
	-- Printed when a command ends the game and the tool must restart.
	ended = "RESTART, RESTORE, or QUIT", restart = "restart",
	smallWords = { a = true, an = true, ["and"] = true, at = true, by = true, ["for"] = true,
		["in"] = true, of = true, on = true, the = true, to = true, under = true, with = true },
}
