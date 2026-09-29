local runtime = require 'zilscript.runtime'
local test_format = require 'zilscript.test_format'
local terminal = require 'zilscript.terminal'
local choice_widget = require 'zilscript.choice_widget'

local options = {
  interface = "companion",
  story_module = nil,
}

local function usage()
  io.write([[
Usage: lua5.4 main.lua [options] [story-module]

Interfaces:
  --companion       Show all state-aware choices (default)
  --text            Use the classic free-text parser interface

Other:
  --help, -h        Show this help

Examples:
  lua5.4 main.lua
  lua5.4 main.lua --companion
  lua5.4 main.lua --text
  lua5.4 main.lua --companion infocom.zork1.zork1
]])
end

local i = 1
while i <= #arg do
  local value = arg[i]
  if value == "--text" then
    options.interface = "text"
  elseif value == "--companion" then
    options.interface = "companion"
  elseif value == "--help" or value == "-h" then
    usage()
    os.exit(0)
  elseif value:sub(1, 1) == "-" then
    io.stderr:write("Unknown option: " .. value .. "\n")
    usage()
    os.exit(2)
  elseif not options.story_module then
    options.story_module = value
  else
    io.stderr:write("Unexpected argument: " .. value .. "\n")
    usage()
    os.exit(2)
  end
  i = i + 1
end

local story_module = options.story_module or "infocom.zork1.zork1"

-- Create game environment
local env = runtime.create_game_env()

-- Load bootstrap
if not runtime.init(env) then
	os.exit(1)
end

-- Install ZIL support and load modules
env.require('zilscript')
if not runtime.load_modules(env, { story_module }, {save_lua = true}) then
	os.exit(1)
end

local story_prefix = story_module:match("^(.*)%.")
local companion_module = (story_prefix or story_module) .. ".companion"
local companion_loaded = false
if options.interface == "companion" then
  local ok, result = pcall(env.require, companion_module)
  if ok then
    companion_loaded = result ~= nil
  elseif not tostring(result):match("not found in environment") then
    io.stderr:write("Failed to load companion module " .. companion_module
      .. ": " .. tostring(result) .. "\n")
    os.exit(1)
  end
  -- load_modules captured restart state before the optional companion was
  -- loaded. Capture it again so companion globals reset with the adventure.
  if type(env.CAPTURE_RESTART_STATE) == "function" then
    env.CAPTURE_RESTART_STATE()
  end
end

local function highlight(text)
  text = terminal.bold_words(text, env.DESCS)
  text = terminal.bold_words(text, env.DIRS)
  return text
end

-- Create env as a coroutine
local game = runtime.create_game(env)
-- Start the game and get initial output
local res = game:start()
if type(res) == "string" then io.write(highlight(res)) end

local function write_response(response)
  if type(response) == "table" and response.status then
    io.write(test_format.format_test_result(response) .. "\n")
  elseif type(response) == "string" then
    io.write(highlight(response))
  end
end

local function companion_selector(query)
  local result = choice_widget.run({
    items = query.choices,
    render_item = function(choice)
      return choice.label .. " (" .. choice.command .. ")"
    end,
    item_value = function(choice)
      return choice.command
    end,
    allow_text = true,
  })

  if result.kind == "item" then
    return {
      kind = "choice",
      id = result.item.id,
      command = result.item.command,
    }
  elseif result.kind == "text" then
    return {kind = "typed", command = result.text}
  elseif result.kind == "interrupt" then
    os.exit(0)
  end
end

-- The arrow-key widget needs a terminal. Piped or scripted input gets a
-- numbered menu read a line at a time: a number picks a choice, anything
-- else is typed as a command.
local interactive = os.execute("test -t 0") == true

local function numbered_selector(query)
  local displayed = {}
  local function print_group(title, group)
    local shown = false
    for _, choice in ipairs(query.choices) do
      if (choice.group or "scene") == group then
        if not shown then io.write("\n" .. title .. "\n") shown = true end
        table.insert(displayed, choice)
        io.write(string.format("  %d. %s\n", #displayed, choice.label))
      end
    end
  end
  if query.scene and query.scene.alt then
    io.write("\n" .. query.scene.alt .. "\n")
  end
  io.write("\nWhat will you do?\n")
  print_group("In this scene", "scene")
  print_group("Go somewhere", "move")
  io.write("\nChoose a number, or type any command: ")
  local input = io.read()
  if not input then os.exit(0) end
  local trimmed = input:match("^%s*(.-)%s*$")
  local index = tonumber(trimmed)
  local choice = index and displayed[index]
  if choice then
    io.write("\n> " .. choice.command .. "\n\n")
    return {kind = "choice", id = choice.id, command = choice.command}
  end
  io.write("\n")
  return {kind = "typed", command = trimmed}
end

while game:is_running() do
  local command

  if options.interface == "companion" then
    local query = env.COMPANION_QUERY()
    if query.ok and #query.choices > 0 then
      local result = (interactive and companion_selector or numbered_selector)(query)
      if result.kind == "choice" then
        local selected = env.COMPANION_SELECT(result.id)
        if selected.ok then
          command = selected.command
        end
      elseif result.kind == "typed" then
        command = result.command
      end
    else
      if query.error then
        io.stderr:write("\nCompanion error: " .. tostring(query.error) .. "\n")
      end
      io.write("\n> ")
      local input = io.read()
      if not input then break end
      command = input
      io.write("\n")
    end
  else
    local input = io.read()
    if not input then break end
    command = input
    io.write("\n")
  end

  if command then
    res = game:resume(command)
    write_response(res)
  end
end

-- local ast = parser.parse_file "infocom/zork1/actions.zil"
-- local res = compiler.compile(ast)

-- print(parser.view(ast, 0))
-- print(res.body)
