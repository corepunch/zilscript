-- Exercise declared words through the real parser, independently of puzzle
-- prerequisites. Literal prose phrases below also catch deleted vocabulary.
return function(root, expect, exhaustive, bookNames)
	root = root or "."
	local oldPath, oldZilPath = package.path, package.zilpath
	package.path = root .. "/?.lua;" .. root .. "/?/init.lua;" .. package.path
	local runtime = require("zilscript.runtime")
	local parser = require("zilscript.parser")
	local dictionary = runtime.create_game_env()
	assert(runtime.init(dictionary, true))
	local leather = dictionary.VOC("LEATHER", dictionary.ADJ)
	local brass = dictionary.VOC("BRASS", dictionary.ADJ)
	local bound = dictionary.VOC("LEATHER-BOUND", dictionary.ADJ)
	expect(leather == bound, "six-character adjective collisions retain the original property value")
	expect(brass ~= leather, "unrelated adjectives retain independent values")
	expect(dictionary.VOC("LEATHER", dictionary.ADJ) == leather, "re-registering the short form stays stable")
	local reverse = runtime.create_game_env()
	assert(runtime.init(reverse, true))
	local yellowed = reverse.VOC("YELLOWED", reverse.ADJ)
	expect(reverse.VOC("YELLOW", reverse.ADJ) == yellowed, "long-before-short adjective registration stays stable")
	local books = {
		["blackwood-horror"] = {
			BELL = "small bell|small brass bell|brass chime",
			PIPES = "rusty pipes", SYRINGE = "glass syringe",
			["COAL-SHOVEL"] = "sturdy shovel|heavy shovel",
			["SAFE-KEY"] = "small safe key", ["SHOCK-CHAIR"] = "electroshock chair",
			["PATIENT-LEDGER"] = "leather-bound ledger",
			["BRASS-KEY"] = "reception key|drawer key|3 key",
		},
		["pocket-weather"] = {
			BELL = "small bell|solid bell|small brass bell",
			SPOON = "baking spoon|narrow scoop", FLOWER = "blue flower",
			RIBBON = "wool ribbon|long ribbon", WEATHERBOX = "brass weatherbox",
			CARD = "forecast card|blank weather card",
		},
		["silent-vector"] = {
			WRENCH = "calibrated wrench|torque spanner",
			SHEARS = "nonconductive shears|ceramic scissors",
			RECORDER = "sealed mechanical recorder", BUS = "live cable",
			MARA = "mara vale", IVO = "ivo chen", SENN = "senn orlov",
		},
		["last-broadcast"] = {
			["LB-STYLUS"] = "sapphire stylus|small needle",
			["LB-PLAYER"] = "spring-driven gramophone|broadcast phonograph",
			["LB-SPANNER"] = "square-socket spanner",
			["LB-WEIGHT"] = "heavy counterweight|loose weight",
			["LB-EDITH"] = "doctor shaw", ["LB-TOMAS"] = "tomas vale",
		},
		["limehouse-killings"] = {
			["POISON-BOTTLE"] = "small glass bottle",
			["MAGNIFYING-GLASS"] = "brass magnifying glass",
			["WAX-SEAL"] = "crimson seal|broken seal",
			["SECRET-LEDGER"] = "leather-bound ledger",
			INSPECTOR = "inspector lestrade|officer lestrade", TRUNK = "large wooden chest",
			["RED-BOOK"] = "red-marked book",
			["DEAD-LETTER"] = "unsent letter", ["TRUNK-LETTER"] = "folded note",
		},
		wondertown = {
			["MUSIC-BOX"] = "small silver box",
			BERTRAND = "captain bertrand", ["CLOCK-WINDING"] = "winding mechanism",
			["WORKSHOP-KEY"] = "warm brass key",
			["TOLLIVER-COAT"] = "tweed coat", NUTMEG = "fox toy",
			["HEART-MECH"] = "workshop heart|vast brass mechanism",
		},
	}
	if bookNames and #bookNames > 0 then
		local selected = {}
		for _, name in ipairs(bookNames) do selected[name] = books[name] or {} end
		books = selected
	end
	local objects, commands = 0, 0
	for book, phrases in pairs(books) do
		local declarations = {}
		for _, source in ipairs({ "dungeon.zil", "actions.zil" }) do
			local file = assert(io.open(root .. "/books/" .. book .. "/" .. source))
			for _, node in ipairs(parser.parse(file:read("a"))) do
				if node.name == "OBJECT" then table.insert(declarations, node) end
			end
			file:close()
		end
		local env = runtime.create_game_env()
		assert(runtime.init(env, true))
		env.require("zilscript")
		package.zilpath = root .. "/books/" .. book .. "/?.zil;" .. root .. "/infocom/zork1/?.zil;" .. root .. "/?.zil"
		assert(runtime.load_zil_files({ root .. "/books/" .. book .. "/" .. book .. ".zil" }, env, { silent = true }))
		local game = runtime.create_game(env, true)
		game:start()

		-- Keep action behavior in this regression: EXAMINE teaches the phrase,
		-- and RING must reach the bell handler and produce its actual reply.
		if book == "pocket-weather" or book == "blackwood-horror" then
			local room = book == "pocket-weather" and env.DISPATCH or env.CAFETERIA
			env.MOVE(env.WINNER, room)
			env.HERE, env.LIT = room, true
			env.FSET(room, env.ONBIT)
			local description = tostring(game:resume("examine bell"))
			expect(description:lower():find("small", 1, true) ~= nil, book .. ": EXAMINE teaches small")
			for _, phrase in ipairs({ "small bell", "small brass bell" }) do
				local reply = tostring(game:resume("ring " .. phrase))
				local expected = book == "pocket-weather" and "Ting!" or "You ring the bell"
				expect(reply:find(expected, 1, true) ~= nil, book .. ": ring " .. phrase .. ": " .. reply)
			end
		end
		if book == "blackwood-horror" then
			-- Both keys are described as small and brass. Their distinguishing
			-- names must still work once the player carries them together.
			env.MOVE(env.BRASS_KEY, env.WINNER)
			env.MOVE(env.SAFE_KEY, env.WINNER)
			env.FCLEAR(env.BRASS_KEY, env.INVISIBLE)
			local perform, selected = env.PERFORM, nil
			env.PERFORM = function(action, object, indirect)
				selected = object
				return perform(action, object, indirect)
			end
			local reply = tostring(game:resume("examine reception key"))
			expect(selected == env.BRASS_KEY, "reception key resolves among carried brass keys: "
				.. tostring(selected) .. ": " .. reply)
			selected = nil
			game:resume("examine safe key")
			expect(selected == env.SAFE_KEY, "safe key resolves among carried brass keys")
			env.PERFORM = perform
			env.REMOVE(env.BRASS_KEY)
			env.REMOVE(env.SAFE_KEY)
		end
		if book == "wondertown" then
			local room = env.LOC(env.MAILBOX)
			env.MOVE(env.WINNER, room)
			env.HERE, env.LIT = room, true
			env.FSET(room, env.ONBIT)
			local reply = tostring(game:resume("examine envelope")):lower()
			expect(reply:find("crumpled envelope", 1, true) ~= nil,
				"the loose envelope remains distinct from the open mailbox's bundle: " .. reply)
		end
		if book == "limehouse-killings" then
			env.MOVE(env.INSPECTOR, env.HERE)
			for _, verb in ipairs({ "examine", "inspect" }) do
				local reply = tostring(game:resume(verb .. " inspector lestrade"))
				expect(reply:find("Inspector Lestrade", 1, true) ~= nil,
					"full inspector title and INSPECT verb coexist: " .. reply)
			end
			local perform, selected = env.PERFORM, nil
			env.PERFORM = function(action, object, indirect)
				selected = object
				return perform(action, object, indirect)
			end
			for _, object in ipairs({ env.DEAD_LETTER, env.TRUNK_LETTER }) do
				env.MOVE(object, env.WINNER)
				env.FCLEAR(object, env.INVISIBLE)
			end
			game:resume("examine unsent letter")
			expect(selected == env.DEAD_LETTER, "unsent letter remains distinguishable from the folded note")
			selected = nil
			game:resume("examine folded note")
			expect(selected == env.TRUNK_LETTER, "folded note remains distinguishable from the unsent letter")
			env.PERFORM = perform
			env.REMOVE(env.DEAD_LETTER)
			env.REMOVE(env.TRUNK_LETTER)
		end

		-- An isolated lit room lets us test hidden items and topic objects too.
		-- No handlers or clocks run during these parser-only probes; gameplay
		-- walkthroughs separately prove scope, discovery and puzzle transitions.
		env.VOCABULARY_ROOM = env.DECL_OBJECT("VOCABULARY_ROOM")
		env.OBJECT({ NAME = "VOCABULARY_ROOM", LOC = env.ROOMS,
			DESC = "Vocabulary test", FLAGS = { "RLANDBIT", "ONBIT" } })
		local room = env.VOCABULARY_ROOM
		env.MOVE(env.WINNER, room)
		env.HERE, env.LIT = room, true
		env.CLOCKER = function() return true end
		local resolved
		env.PERFORM = function(_, object)
			resolved = object
			env.TELL("Resolved.\n")
			return true
		end
		for _, node in ipairs(declarations) do
			if node.name == "OBJECT" then
				local name, nouns, adjectives = node[1].value, {}, {}
				for _, prop in ipairs(node) do
					if prop.type == "list" then
						local key = prop[1].value
						if key == "SYNONYM" or key == "ADJECTIVE" then
							local words = key == "SYNONYM" and nouns or adjectives
							for i = 2, #prop do table.insert(words, tostring(prop[i].value):lower()) end
						end
					end
				end
				local object = env[name:gsub("-", "_")]
				if name == "GLOBAL-OBJECTS" or name == "QUOTE" or name == "INTQUOTE" then
					-- Limehouse also declares the substrate's global container and
					-- quotation tokens in actions.zil. These are parser internals,
					-- not things the story describes or the player can examine.
					expect(book == "limehouse-killings" and object ~= nil,
						"only known parser internals are exempt from world-object probes")
				else
					expect(type(object) == "number", book .. ": vocabulary for " .. name)
					objects = objects + 1
					env.MOVE(object, room)
					env.FCLEAR(object, env.INVISIBLE)
					local probes = {}
					if exhaustive ~= false then
						for _, noun in ipairs(nouns) do table.insert(probes, noun) end
						for _, adjective in ipairs(adjectives) do table.insert(probes, adjective .. " " .. nouns[1]) end
					end
					for phrase in (phrases[name] or ""):gmatch("[^|]+") do table.insert(probes, phrase) end
					phrases[name] = nil
					for _, phrase in ipairs(probes) do
						resolved = nil
						local reply = tostring(game:resume("examine " .. phrase))
						commands = commands + 1
						expect(resolved == object, book .. ": " .. name .. ": examine " .. phrase
							.. " (wanted " .. object .. ", got " .. tostring(resolved) .. "): " .. reply)
					end
					env.REMOVE(object)
				end
			end
		end
		expect(next(phrases) == nil, book .. ": every literal phrase names a declared object")
	end
	package.path, package.zilpath = oldPath, oldZilPath
	return objects, commands
end
