-- Replays a route file through the reader's link menus and shows where it
-- ends: lua5.4 scripts/play-links.lua <game> <route.txt> [tail] [seed] [en|de]
-- The route holds one offered command per line; "#" starts a comment. A line
-- starting with "!" is typed to the parser unchecked, for diagnosing
-- vocabulary; a route with such a line is not a link-only playthrough.
package.path = "./?.lua;./?/init.lua;" .. package.path
local Walk = require("tests.link_walk")
local Editions = require("zilscript.editions")
local name, path, tail, seed = arg[1], arg[2], tonumber(arg[3]) or 1, tonumber(arg[4])
local walk = Walk.new(assert(Editions.bookModule(arg[5] or "en", name), "Unknown book edition"), seed)
local shown = { "[start] " .. walk.output }
local failure
for raw in io.lines(path) do
	local line = raw:gsub("%s+$", "")
	if line ~= "" and line:sub(1, 1) ~= "#" then
		if line:sub(1, 1) == "!" then
			-- Parser diagnostic, not link play: typed straight past the menus.
			if not walk:running() then failure = "The story has ended; nothing can be typed." break end
			local command = line:sub(2)
			local output = walk.game:resume(command)
			walk:record(output)
			table.insert(shown, "PARSER> " .. command .. "\n" .. tostring(output))
		else
			local ok, text = pcall(walk.choose, walk, line)
			if not ok then failure = text break end
			table.insert(shown, "> " .. line .. "\n" .. walk.output)
		end
	end
end
for index = math.max(1, #shown - tail + 1), #shown do print(shown[index]) end
if failure then print("!! " .. failure) os.exit(1) end
print(string.format("-- %s, step %d, running=%s", walk:room(), walk.steps, tostring(walk:running())))
print(walk:describeMenu())
