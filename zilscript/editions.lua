-- Edition IDs are stable across app and CLI saves. A locale owns its catalog
-- and book tree. The ZIL entry file declares the substrate it actually loads.
local Editions = {}

Editions.languages = {
	{ id = "en", title = "English" },
	{ id = "de", title = "Deutsch", speechLocale = "de-DE" },
	{ id = "ru", title = "Русский", speechLocale = "ru-RU" },
}

function Editions.index(language)
	for index, edition in ipairs(Editions.languages) do
		if edition.id == language then return index end
	end
end

function Editions.preferredLanguage(preferences, available)
	for _, identifier in ipairs(preferences or {}) do
		local language = identifier:lower():match("^[a-z]+")
		if available[language] then return language end
	end
	return "en"
end

function Editions.bookId(language, slug)
	if not Editions.index(language) or type(slug) ~= "string" or not slug:match("^[a-z0-9][a-z0-9-]*$") then
		return nil
	end
	return "books." .. language .. "." .. slug
end

function Editions.bookModule(language, slug)
	local id = Editions.bookId(language, slug)
	return id and id .. "." .. slug
end

return Editions
