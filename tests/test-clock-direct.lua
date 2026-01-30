-- Direct tests for clock/interrupt system
-- These tests verify the QUEUE, INT, and CLOCKER functions work correctly

local runtime = require 'zil.runtime'

print("=== Clock System Direct Tests ===\n")

-- Load clock.zil
local files = {
  "zork1/globals.zil",
  "zork1/clock.zil",
  "zork1/verbs.zil",  -- For MOVES
  "zork1/main.zil",   -- For P_WON
}

local env = runtime.create_game_env()
runtime.load_bootstrap(env)
runtime.load_zil_files(files, env)

-- Helper to run code in env
local function run(code)
  local func, err = load("return " .. code, "test", "t", env)
  if not func then
    func = load(code, "test", "t", env)
  end
  if not func then error("Failed to compile: " .. err) end
  return func()
end

-- Test 1: Verify globals are defined
print("Test 1: Verify clock globals are defined")
assert(env.C_TABLE, "C_TABLE should be defined")
assert(env.C_TABLELEN == 180, "C_TABLELEN should be 180")
assert(env.C_DEMONS == 180, "C_DEMONS should be 180")
assert(env.C_INTS == 180, "C_INTS should be 180")
assert(env.C_INTLEN == 6, "C_INTLEN should be 6")
assert(env.C_ENABLEDQ == 0, "C_ENABLEDQ should be 0")
assert(env.C_TICK == 1, "C_TICK should be 1")
assert(env.C_RTN == 2, "C_RTN should be 2")
assert(env.CLOCK_WAIT == nil or env.CLOCK_WAIT == false, "CLOCK_WAIT should be nil or false, got " .. tostring(env.CLOCK_WAIT))
assert(env.MOVES == 0, "MOVES should be 0")
print("✓ All globals defined correctly\n")

-- Test 2: Verify C_TABLE is a memory address, not a Lua table
print("Test 2: Verify C_TABLE is a memory address")
assert(type(env.C_TABLE) == "number", "C_TABLE should be a number (memory address), got " .. type(env.C_TABLE))
print("✓ C_TABLE is a memory address:", env.C_TABLE, "\n")

-- Test 3: Verify functions are defined
print("Test 3: Verify clock functions are defined")
assert(type(env.QUEUE) == "function", "QUEUE should be a function")
assert(type(env.INT) == "function", "INT should be a function")
assert(type(env.CLOCKER) == "function", "CLOCKER should be a function")
print("✓ All functions defined\n")

-- Test 4: Test INT function - create an interrupt
print("Test 4: Test INT function")
-- Create a test function and register it
env.TEST_INTERRUPT = function()
  print("  Test interrupt called!")
  return env.T
end
local fn_idx = #env.FUNCTIONS + 1
env.FUNCTIONS[fn_idx] = env.TEST_INTERRUPT

print("  Calling INT with function index:", fn_idx)
print("  C_INTS before:", env.C_INTS)
print("  C_DEMONS before:", env.C_DEMONS)

local cint = run(string.format([[
  INT(%d, nil)
]], fn_idx))

print("  Result from INT:", cint, type(cint))
print("  C_INTS after:", env.C_INTS)
print("  C_DEMONS after:", env.C_DEMONS)

assert(cint, "INT should return an interrupt entry")
print("✓ INT created interrupt entry\n")

-- Test 5: Test QUEUE function
print("Test 5: Test QUEUE function")
local result = run(string.format([[
  QUEUE(%d, 5)
]], fn_idx))
assert(result, "QUEUE should return the interrupt entry")
print("✓ QUEUE set tick count\n")

-- Test 6: Test CLOCKER increments MOVES
print("Test 6: Test CLOCKER increments MOVES")
local initial_moves = env.MOVES
run("CLOCKER()")
assert(env.MOVES == initial_moves + 1, string.format("MOVES should increment (was %d, now %d)", initial_moves, env.MOVES))
print("✓ CLOCKER incremented MOVES\n")

-- Test 7: Test CLOCK_WAIT pauses clock
print("Test 7: Test CLOCK_WAIT pauses clock")
env.CLOCK_WAIT = true
local moves_before = env.MOVES
run("CLOCKER()")
assert(env.CLOCK_WAIT == nil or env.CLOCK_WAIT == false, "CLOCK_WAIT should be cleared")
assert(env.MOVES == moves_before, "MOVES should not increment when clock is paused")
print("✓ CLOCK_WAIT pauses clock correctly\n")

print("\n=== All Clock System Tests Passed ===")

-- Additional comprehensive tests
print("\n=== Additional Comprehensive Tests ===\n")

-- Test 8: Test interrupt firing when tick counts down
print("Test 8: Test interrupt firing")
local interrupt_fired = false
env.TEST_FIRE = function()
  interrupt_fired = true
  return env.T
end
table.insert(env.FUNCTIONS, env.TEST_FIRE)
local fire_idx = #env.FUNCTIONS

-- Queue with tick = 2 (will fire on 2nd CLOCKER call)
run(string.format("QUEUE(%d, 2)", fire_idx))
print("  Queued interrupt with tick=2")

-- First CLOCKER call - should decrement to 1, not fire
interrupt_fired = false
run("CLOCKER()")
assert(not interrupt_fired, "Interrupt should not fire on first CLOCKER (tick=2 -> 1)")
print("  ✓ Tick=2: Interrupt not fired")

-- Second CLOCKER call - should decrement to 0 and fire
interrupt_fired = false  
run("CLOCKER()")
assert(interrupt_fired, "Interrupt should fire on second CLOCKER (tick=1 -> 0)")
print("  ✓ Tick=1: Interrupt fired")
print("✓ Interrupt fires at correct time\n")

-- Test 9: Test finding existing interrupt
print("Test 9: Test INT finds existing interrupt")
local first_int = run(string.format("INT(%d, nil)", fire_idx))
local second_int = run(string.format("INT(%d, nil)", fire_idx))
assert(first_int == second_int, string.format("INT should return same entry for same function (got %s and %s)", tostring(first_int), tostring(second_int)))
print("✓ INT reuses existing interrupt entry\n")

-- Test 10: Test multiple interrupts
print("Test 10: Test multiple interrupts")
local count1, count2 = 0, 0
env.TEST_INT1 = function() count1 = count1 + 1; return env.T end
env.TEST_INT2 = function() count2 = count2 + 1; return env.T end
table.insert(env.FUNCTIONS, env.TEST_INT1)
table.insert(env.FUNCTIONS, env.TEST_INT2)
local idx1, idx2 = #env.FUNCTIONS - 1, #env.FUNCTIONS

run(string.format("QUEUE(%d, 1)", idx1))
run(string.format("QUEUE(%d, 2)", idx2))

count1, count2 = 0, 0
run("CLOCKER()")  -- idx1 should fire (tick 1->0), idx2 should not (tick 2->1)
assert(count1 == 1, "First interrupt should fire")
assert(count2 == 0, "Second interrupt should not fire yet")

run("CLOCKER()")  -- idx2 should fire (tick 1->0)
assert(count2 == 1, "Second interrupt should fire")
print("✓ Multiple interrupts work correctly\n")

-- Test 11: Test C_INTS and C_DEMONS boundaries
print("Test 11: Test interrupt tracking")
print("  C_INTS:", env.C_INTS, " (should be less than 180 after creating interrupts)")
print("  C_DEMONS:", env.C_DEMONS, " (should equal 180 - no demons created)")
assert(env.C_INTS < 180, "C_INTS should decrease as interrupts are added")
assert(env.C_DEMONS == 180, "C_DEMONS should still be 180 (no demons created)")
print("✓ Interrupt boundaries correct\n")

-- Test 12: Test interrupt tick=0 doesn't fire
print("Test 12: Test tick=0 interrupts don't fire")
local zero_fired = false
env.TEST_ZERO = function() zero_fired = true; return env.T end
table.insert(env.FUNCTIONS, env.TEST_ZERO)
local zero_idx = #env.FUNCTIONS
run(string.format("QUEUE(%d, 0)", zero_idx))

zero_fired = false
run("CLOCKER()")
assert(not zero_fired, "Interrupt with tick=0 should not fire")
print("✓ Tick=0 interrupts don't fire\n")

print("\n=== All Comprehensive Tests Passed ===")

