#!/usr/bin/env lua5.4
-- Generic ZIL test runner
-- Usage: lua5.4 run-zil-test.lua test-name
--   e.g., lua5.4 run-zil-test.lua tests.test-simple-new

-- Simple ASSERT that uses Lua's built-in assert
function ASSERT(...)
	return assert(...)
end

require "zil"
require "zil.bootstrap"

-- Set up direct output (bypass ZIL's buffering system)
_G['io_write'] = io.write
_G['io_flush'] = io.flush

-- Load the test module from command line argument
local test_module = arg[1] or "tests.test-simple-new"
require(test_module)

-- Run the GO routine
GO()

-- Flush any remaining output
io.flush()
