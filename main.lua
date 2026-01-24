local runtime = require 'zil.runtime'

local files = {
  "zork1/globals.zil",
  "zork1/parser.zil",
  "zork1/verbs.zil",
  -- "zork1/actions.zil",
  "zork1/syntax.zil",
  -- "zork1/dungeon.zil",
  "adventure/horror.zil",
  "zork1/main.zil",
}

-- Create game environment
local env = runtime.create_game_env()

-- Load bootstrap
if not runtime.load_bootstrap(env) then
	os.exit(1)
end

-- Load ZIL files (save compiled .lua files to disk)
if not runtime.load_zil_files(files, env, {save_lua = true}) then
	os.exit(1)
end

-- Create env as a coroutine
local game, input = runtime.create_game(env), nil
repeat
	local res = game:resume(input)
  io.write(res)
  -- if res.items then
  --   print("\nItems:")
  --   for item, verbs in pairs(res.items) do
  --     if #verbs > 0 then
  --       print(string.format("  %s (%s)", item:upper(), table.concat(verbs, ', ')))
  --     else
  --       print(string.format("  %s", item:upper()))
  --     end
  --   end
  -- end
  -- if res.exits then
  --   print("\nExits:")
  --   for exit, desc in pairs(res.exits) do
  --     print(string.format("  %s -> %s", exit, desc))
  --   end
  -- end
  input = io.read()
until not input or not game:is_running()

-- local ast = parser.parse_file "zork1/actions.zil"
-- local res = compiler.compile(ast)

-- print(parser.view(ast, 0))
-- print(res.body)