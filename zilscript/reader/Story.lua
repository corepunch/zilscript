-- Where a story's files are, for the lint scripts and the vocabulary tests.
--
-- A story folder is books/<lang>/<book> and holds a game.json. Most books are
-- that one folder (dungeon.zil, actions.zil, <book>.zil). A book with
-- editions keeps its logic once in books/shared/<book> (logic.zil, rules.zil)
-- and each language's words in its own folder (books/<lang>/<book>/<lang>.zil,
-- beside the edition's entry file and game.json).
local Language = require("zilscript.reader.Language")

local Story = {}

local function exists(path)
	local file = io.open(path, "r")
	if not file then return false end
	local _, err = file:read(0)
	file:close()
	return err == nil
end

local function listing(dir, depth)
	local files = {}
	local pipe = io.popen(string.format('find "%s" -maxdepth %d -name "*.zil" -not -path "*/test/*" 2>/dev/null', dir, depth))
	for line in pipe:lines() do table.insert(files, line) end
	pipe:close()
	table.sort(files)
	return files
end

local function read(path)
	local file = io.open(path, "r")
	if not file then return nil end
	local body = file:read("*a")
	file:close()
	return body
end

-- `path` is a story folder such as books/en/wondertown. Returns
-- { dir, module, language, edition, words, sources, declarations }: `words`
-- the files that declare objects with their words, `sources` every file
-- whose prose and vocabulary the story's player sees, `declarations` the
-- files the vocabulary tests read objects from.
function Story.of(path, root)
	root = root or "."
	local dir = tostring(path):gsub("/$", "")
	local json = read(root .. "/" .. dir .. "/game.json") or ""
	local start = json:match('"startFile"%s*:%s*"([^"]*)"') or (dir:match("([^/]+)$") .. ".zil")
	local language = Language.ofBook(dir)
	local story = { dir = dir, language = language, module = dir:gsub("/", ".") .. "." .. start:gsub("%.zil$", "") }
	local book = dir:match("^books/%a%a/([^/]+)$")
	local shared = book and ("books/shared/" .. book)
	if shared and exists(root .. "/" .. shared .. "/logic.zil") then
		story.edition = true
		story.words = { dir .. "/" .. language.code .. ".zil" }
		story.declarations = story.words
		story.sources = { shared .. "/logic.zil", shared .. "/rules.zil", story.words[1] }
		for _, file in ipairs(listing(root .. "/" .. dir, 1)) do
			local relative = file:sub(#root + 2)
			if relative ~= story.words[1] then table.insert(story.sources, relative) end
		end
	else
		story.words = { dir .. "/dungeon.zil" }
		story.declarations = { dir .. "/dungeon.zil", dir .. "/actions.zil" }
		story.sources = {}
		for _, file in ipairs(listing(root .. "/" .. dir, 8)) do table.insert(story.sources, file:sub(#root + 2)) end
	end
	return story
end

return Story
