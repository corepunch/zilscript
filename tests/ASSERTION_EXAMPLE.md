# Example: How the Issue is Fixed

## Problem Statement

Previously, test commands always returned "ok" even when they should indicate failure:

```
> test:check-inventory PATIENT_LEDGER
[TEST] ok: PATIENT_LEDGER is not in player's inventory
```

This says "ok" but there's no way to assert that the ledger SHOULD be in the inventory.

## Solution

New assertion commands that return "pass" or "fail":

### Example 1: Testing Inventory

**Before (old check command):**
```lua
{
    input = "test:check-inventory PATIENT_LEDGER",
    description = "Check if ledger is in inventory"
}
-- Output: [TEST] ok: PATIENT_LEDGER is not in player's inventory
-- Problem: Always says "ok", can't assert it SHOULD be there
```

**After (new assert command):**
```lua
{
    input = "test:assert-inventory PATIENT_LEDGER true",
    description = "Assert ledger should be in inventory"
}
-- Output if correct: [TEST] pass: PATIENT_LEDGER is in player's inventory (expected: in)
-- Output if wrong:   [TEST] fail: PATIENT_LEDGER is not in player's inventory (expected: in)
```

### Example 2: Testing Unlock Action Success

**Problem:** How do you verify that "unlock drawer" actually worked?

**Solution:** Use assert-flag to check OPENBIT:

```lua
-- Before unlocking
{
    input = "test:assert-flag BOTTOM_DRAWER OPENBIT false",
    description = "Verify drawer is closed"
},
-- Output: [TEST] pass: BOTTOM_DRAWER does not have OPENBIT (expected: does not have)

-- Attempt to unlock
{
    input = "unlock drawer with key",
    description = "Unlock the drawer"
},
{
    input = "open drawer",
    description = "Open the drawer"
},

-- After unlocking
{
    input = "test:assert-flag BOTTOM_DRAWER OPENBIT true",
    description = "Verify drawer is now open"
},
-- Output if worked:  [TEST] pass: BOTTOM_DRAWER has OPENBIT (expected: has)
-- Output if failed:  [TEST] fail: BOTTOM_DRAWER does not have OPENBIT (expected: has)
```

If the unlock command didn't work, the assertion would return "fail", clearly indicating the problem.

## Complete Commands Reference

### Assertion Commands (New - Return pass/fail)
- `test:assert-inventory <object> <true|false>` - Assert object in/not in inventory
- `test:assert-flag <object> <flag> <true|false>` - Assert flag is/isn't set
- `test:assert-location <object> <location>` - Assert object at location

### Check Commands (Original - Return ok/error)
- `test:check-inventory <object>` - Report if object in inventory
- `test:check-flag <object> <flag>` - Report if flag is set
- `test:check-location <object> <location>` - Report if object at location
- `test:get-location` - Report current location

## Test Output Interpretation

The test runner now displays different status values:
- `[TEST] pass:` - Assertion succeeded (actual matches expected)
- `[TEST] fail:` - Assertion failed (actual doesn't match expected)
- `[TEST] ok:` - Check command executed successfully (just reporting state)
- `[TEST] error:` - Command had an error (e.g., object not found)
