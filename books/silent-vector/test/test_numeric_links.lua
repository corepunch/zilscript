-- Source-informed integration proof using only emitted numeric CLI choices.
-- Each selection crosses a real save/restore process boundary. No source-state
-- mutation or invented parser command is used to advance the story.
local function quote(value)
	return "'" .. value:gsub("'", "'\\''") .. "'"
end
local interpreter = arg[-1] or "lua5.4"
local save = os.tmpname()
local prefix = quote(interpreter) .. " llm.lua --game silent-vector --save " .. quote(save)
local function run(flags)
	local pipe = assert(io.popen(prefix .. " " .. flags, "r"))
	local output = pipe:read("*a")
	local ok = pipe:close()
	assert(ok, output)
	assert(not output:find('"ok":false', 1, true), output)
	return output
end
local output = run("--new-game --links --seed 97")
local choices = dofile("books/silent-vector/test/numeric-choices.lua")
for step, choice in ipairs(choices) do
	assert(output:find('"running":true', 1, true), "Ended before choice " .. step)
	output = run("--choose " .. choice)
end
assert(output:find("ENDING: THE UNPLAYED WITNESS", 1, true), output)
assert(output:find('"running":false', 1, true), output)
assert(output:find('"actions":[]', 1, true), output)
assert(run("--links"):find('"running":false', 1, true), "Terminal state did not persist")
for _, suffix in ipairs({ "", ".actions", ".transcript", ".reader" }) do os.remove(save .. suffix) end
print("Silent Vector: " .. #choices .. " numeric-only saved choices reached a persistent terminal ending")
