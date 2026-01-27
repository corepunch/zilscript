#!/usr/bin/env lua
-- Test runner for ZIL runtime
-- Usage: lua tests/run_tests.lua [test_file]

local runtime = require 'zil.runtime'
local test_format = require 'zil.test_format'

local function run_test_file(test_file_path)
	print("=== Running test: " .. test_file_path .. " ===\n")
	
	-- Load test configuration
	local test_config = dofile(test_file_path)
	print("Test suite: " .. test_config.name .. "\n")
	
	-- Create game environment
	local game = runtime.create_game_env()
	
	-- Load bootstrap
	if not runtime.load_bootstrap(game, true) then
		print("Failed to load bootstrap")
		return false
	end
	
	-- Load ZIL files (use defaults or custom list from test config)
	local files = test_config.files or {
		"zork1/globals.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"adventure/horror.zil",
		"zork1/main.zil",
	}
	
	if not runtime.load_zil_files(files, game, {silent = true}) then
		print("Failed to load ZIL files")
		return false
	end
	
	-- Create game as a coroutine
	local game_coro = runtime.create_game(game, true)
	
	-- Start the game (first resume to initialize - no input needed yet)
	local result = game_coro:resume()
	if result then
		print(result)
	end
	
	-- Feed test commands to the coroutine
	for i, cmd in ipairs(test_config.commands) do
		if not game_coro:is_running() then
			print("\nGame ended unexpectedly after command " .. (i-1))
			break
		end
		
		-- print("> " .. cmd.input)
		
		local GREEN = "\27[1;32m"
		local RED = "\27[1;31m"
		local NEUTRAL = "\27[36m"
		local RESET = "\27[0m"

		local function feedback(test, err)
			if err then
				local input_str = cmd.input or test
				print(RED .. "[FAIL] " .. (cmd.description or test) .. RESET .. " (" .. input_str .. ")")
				if output then
					print(RED .. output .. RESET)
				end
				if output and output:find("too many things") then
					print(RED .. game_coro:resume("inventory") .. RESET)
				elseif type(err) == "string" then
					print(RED .. err .. RESET)
				end
			else
				local input_str = cmd.input or test
				print(GREEN .. "[PASS] " .. (cmd.description or test) .. RESET .. " (" .. input_str .. ")")
			end
		end
		local function report(test) 
			feedback(test, game_coro:resume(test:gsub("-", "_")))
		end
		
		local function silent_execute(test)
			local ok, err = pcall(function()
				game_coro:resume(test:gsub("-", "_"))
			end)
			if not ok then
				-- If there's an error, we still want to know about it
				error(err)
			end
		end

		-- Process commands in order: start -> input -> assertions
		-- 1. Execute start (teleport) if present (silently if other commands present)
		if cmd.start then
			if cmd.input or cmd.here or cmd.take or cmd.lose or cmd.flag or cmd.no_flag or cmd.text then
				-- Execute silently if there are other commands
				silent_execute("test:start-location "..cmd.start)
			else
				-- Report if this is the only command
				report("test:start-location "..cmd.start)
			end
		elseif cmd.start_location then
			if cmd.input or cmd.here or cmd.take or cmd.lose or cmd.flag or cmd.no_flag or cmd.text then
				silent_execute("test:start-location "..cmd.start_location)
			else
				report("test:start-location "..cmd.start_location)
			end
		end
		
		-- 2. Execute input command if present
		local output
		if cmd.input then
			output = game_coro:resume(cmd.input)
		end
		
		-- 3. Execute test assertions (these will report)
		-- If no assertions, but we had input, report the input
		local has_assertion = cmd.here or cmd.take or cmd.lose or cmd.flag or cmd.no_flag or cmd.global or cmd.text
		
		if cmd.here then
			report("test:here "..cmd.here)
		elseif cmd.take then
			report("test:take "..cmd.take)
		elseif cmd.lose then
			report("test:lose "..cmd.lose)
		elseif cmd.flag then
			report("test:flag "..cmd.flag)
		elseif cmd.no_flag then
			report("test:no-flag "..cmd.no_flag)
		elseif cmd.global then
			report("test:global "..cmd.global)
		elseif cmd.text then
			feedback(cmd.text, not (output or ""):lower():find(cmd.text:lower(), 1, true))
		elseif cmd.input then
			-- Input command without assertion - just print SKIP
			print(NEUTRAL .. "[SKIP] " .. (cmd.description or cmd.input) .. RESET)
		elseif not cmd.start and not cmd.start_location then
			-- No recognized commands at all
			print(NEUTRAL .. "[SKIP] " .. (cmd.description or cmd.input) .. RESET)
		end
		-- print(output)
	end
	
	print("\n=== Test commands completed ===")
	return true
end

-- Main
local test_file = arg[1] or "tests/zork1_basic.lua"

-- Check if test file exists
local file_check = io.open(test_file, "r")
if not file_check then
	print("Error: Test file not found: " .. test_file)
	print("Usage: lua tests/run_tests.lua [test_file]")
	os.exit(1)
end
file_check:close()

local success = run_test_file(test_file)
os.exit(success and 0 or 1)
