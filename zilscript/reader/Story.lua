-- Resolve a story entry point and the sources used by the lint tools.
local Story = {}

function Story.of(path, root)
	root = root or "."
	local dir = path:gsub("/$", "")
	local manifest = io.open(root .. "/" .. dir .. "/game.json", "r")
	local json = ""
	if manifest then
		json = manifest:read("a")
		manifest:close()
	end
	local start = json:match('"startFile"%s*:%s*"([^"]*)"') or (dir:match("([^/]+)$") .. ".zil")
	local story = { dir = dir, module = dir:gsub("/", ".") .. "." .. start:gsub("%.zil$", ""),
		words = {}, sources = {}, declarations = {} }
	local sourceDir = "'" .. (root .. "/" .. dir):gsub("'", "'\\''") .. "'"
	local pipe = assert(io.popen('find ' .. sourceDir .. ' -maxdepth 1 -name "*.zil" 2>/dev/null'))
	for file in pipe:lines() do
		local relative = file:sub(#root + 2)
		table.insert(story.sources, relative)
	end
	pipe:close()
	table.sort(story.sources)
	for _, file in ipairs(story.sources) do
		-- Role-playing stories describe objects across several scene files.
		local name = file:match("([^/]+)$")
		if name == "dungeon.zil" or name:match("^dungeon%-") then
			table.insert(story.words, file)
			table.insert(story.declarations, file)
		elseif name == "actions.zil" then
			table.insert(story.declarations, file)
		end
	end
	return story
end

return Story
