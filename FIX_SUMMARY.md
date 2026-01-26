# Fix Summary: Test Assertion Commands

## Original Problem

From the problem statement:

```
> test:check-inventory PATIENT_LEDGER
[TEST] ok: PATIENT_LEDGER is not in player's inventory
> read ledger
You can't see any ledger here!

this is obviously a fail, but says "ok" 

Or > unlock drawer
What do you want to unlock the drawer?

also a fail, find a way to test if action was successful - check OPENBIT flags?
```

The issue was that test commands always returned "ok" regardless of whether the state matched expectations, making it impossible to write proper test assertions.

## Solution Implemented

Added three new assertion commands that accept expected values and return "pass" or "fail":

1. **`test:assert-inventory <object> <true|false>`**
   - Asserts that an object should (or shouldn't) be in the player's inventory
   - Returns `status="pass"` if actual matches expected, `status="fail"` otherwise

2. **`test:assert-flag <object> <flag> <true|false>`**
   - Asserts that an object should (or shouldn't) have a specific flag set
   - Returns `status="pass"` if actual matches expected, `status="fail"` otherwise

3. **`test:assert-location <object> <location>`**
   - Asserts that an object should be at a specific location
   - Returns `status="pass"` if object is at location, `status="fail"` otherwise

## How It Fixes The Problem

### Issue 1: Testing Inventory
**Before:**
```
> test:check-inventory PATIENT_LEDGER
[TEST] ok: PATIENT_LEDGER is not in player's inventory
```
Problem: Always says "ok", can't tell if ledger SHOULD be in inventory

**After:**
```
> test:assert-inventory PATIENT_LEDGER true
[TEST] fail: PATIENT_LEDGER is not in player's inventory (expected: in)
```
Now clearly shows the assertion FAILED because the ledger isn't in inventory when it should be!

### Issue 2: Testing Unlock Success
**Before:** No way to verify "unlock drawer" command succeeded

**After:**
```
> test:assert-flag BOTTOM_DRAWER OPENBIT false
[TEST] pass: BOTTOM_DRAWER does not have OPENBIT (expected: does not have)

> unlock drawer with key
What do you want to unlock the drawer?

> test:assert-flag BOTTOM_DRAWER OPENBIT true
[TEST] fail: BOTTOM_DRAWER does not have OPENBIT (expected: has)
```
The assertion clearly FAILS, showing the unlock command didn't work!

## Files Changed

1. **zil/bootstrap.lua**
   - Added `to_boolean()` helper function
   - Added `assert_flag()`, `assert_inventory()`, `assert_location()` functions
   - Updated `handle_test_command()` to route new assertion commands

2. **tests/HORROR_TESTING.md**
   - Documented all new assertion commands with examples
   - Added usage guide comparing assertion vs check commands
   - Updated examples to use new assertion syntax

3. **tests/ASSERTION_EXAMPLE.md**
   - Created comprehensive examples showing before/after
   - Demonstrates how the problem is solved

4. **tests/test-assertions.lua**
   - Created test file demonstrating new assertion commands

## Backward Compatibility

All existing `test:check-*` commands continue to work exactly as before:
- `test:check-inventory <object>` - Reports state with status="ok"
- `test:check-flag <object> <flag>` - Reports state with status="ok"
- `test:check-location <object> <location>` - Reports state with status="ok"
- `test:get-location` - Reports current location with status="ok"

## Testing

Created and ran standalone unit test verifying:
- ✓ `assert_inventory` correctly passes when expectations met
- ✓ `assert_inventory` correctly fails when expectations not met
- ✓ `assert_flag` correctly passes/fails based on flag state
- ✓ `assert_location` correctly passes/fails based on object location

All tests passed successfully!

## Summary

The test infrastructure now supports proper assertions with pass/fail results, making it possible to:
1. Write tests that verify expected game state
2. Detect when game actions don't produce expected results
3. Identify game bugs through automated testing

The original issues from the problem statement are completely resolved.
