-- Replays a route file through the reader's link menus and shows where it
-- ends: lua5.4 scripts/play-links.lua <game> <route.txt> [tail] [seed]
-- The route holds one offered command per line; "#" starts a comment. A line
-- starting with "!" is typed to the parser unchecked, for diagnosing
-- vocabulary; a route with such a line is not a link-only playthrough.
package.path = "./?.lua;./?/init.lua;" .. package.path
local Walk = require("tests.link_walk")
local name, path, tail, seed = arg[1], arg[2], tonumber(arg[3]) or 1, tonumber(arg[4])
local walk = Walk.new("books." .. name .. "." .. name, seed)
local shown = { "[start] " .. walk.output }
local failure
for raw in io.lines(path) do
	local line = raw:gsub("%s+$", "")
	if line ~= "" and line:sub(1, 1) ~= "#" then
		if line:sub(1, 1) == "!" then
			-- Parser diagnostic, not link play: typed straight past the menus.
			table.insert(shown, "PARSER> " .. line:sub(2) .. "\n" .. tostring(walk.game:resume(line:sub(2))))
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
