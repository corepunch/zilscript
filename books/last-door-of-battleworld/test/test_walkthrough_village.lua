local Walk = require("tests.story_walk")

local words = {
		wound = "focus skiff", drop = "drop clapper", scale = "examine scales",
		pull = "pull bell", fit = "put clapper in bell", wrong = "use clapper on scales", feedback = "fit together",
		cell = "use battery on port", cache = "open chest", take = "take cell", east = "east",
	}

do
	local w = Walk.new("books.last-door-of-battleworld.last-door-of-battleworld")
	local e = w.env
	e.math.random = function() return 1 end
	local function play(command)
		local output = w.game:resume(command)
		assert(type(output) == "string" and output:find("%S"), command)
		w:record(output)
		return output
	end
	local function choice(id)
		for _, card in ipairs(w.game:resume("choices").choices) do
			if card.id == id or card.id == "bw." .. id then
				play(card.command)
				return
			end
		end
		error("Missing " .. id .. " in " .. w:room())
	end
	choice("profile.storm")
	local health = e.STAT(e.HERO, e.A_HEALTH)
	choice("landing.coil")
	choice("landing.ridge")
	choice("ridge.fix")
	choice("ridge.camp")
	choice("camp.span")
	play(words.wound)
	choice("span.winch")
	choice("span.market")
	choice("market.village")
	assert(e.HERE == e.VILLAGE and e.STAT(e.HERO, e.A_HEALTH) == health - 5)
	play(words.pull)
	assert(not e.BW_BELL_RUNG)
	choice("village.healer")
	choice("village.healer")
	assert(e.STAT(e.HERO, e.A_HEALTH) == health)
	choice("village.market")
	choice("market.scales")
	choice("clapper.take")
	assert(play(words.wrong):find(words.feedback, 1, true))
	assert(e.INQ(e.CLAPPER, e.WINNER))
	choice("market.village")
	play(words.drop)
	choice("clapper.take")
	choice("village.fit")
	assert(e.INQ(e.CLAPPER, e.BELL), words.fit)
	local karma = e.STAT(e.HERO, e.A_KARMA)
	choice("village.ring")
	play(words.pull)
	assert(e.BW_BELL_RUNG and e.STAT(e.HERO, e.A_KARMA) == karma + 5)
	choice("village.market")
	play(words.scale)
	assert(e.INQ(e.CLAPPER, e.BELL), "Searching again must not duplicate the clapper")
	play(words.cache)
	play(words.take)
	play(words.east)
	play(words.cell)
	assert(e.BW_CHARGED and not e.INQ(e.CELL, e.WINNER), words.cell)
end

print("ok - Battleworld guides a wounded hero through healing and the village bell rescue")
