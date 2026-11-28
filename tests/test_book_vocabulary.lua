local failures = 0
local books = {}
for _, path in ipairs(arg) do
	-- books/<lang>/<book>/dungeon.zil, or a story folder books/<lang>/<book>
	local name = path:match("^books/(%a%a/[^/]+)/dungeon%.zil$") or assert(path:match("^books/(%a%a/[^/]+)$"), "expected a book dungeon.zil path or story folder")
	table.insert(books, name)
end
local objects, commands = require("tests.book_vocabulary")(".", function(ok, message)
	if not ok then failures = failures + 1; print(message) end
end, true, books)
print(string.format("%d objects, %d vocabulary commands, %d failures", objects, commands, failures))
os.exit(failures == 0 and 0 or 1)
