# Testing horror.zil for Winnability

This document describes how to test that the horror.zil adventure game is winnable using the automated test infrastructure.

## Important Note About Game State

**Current Status**: Testing has revealed several issues in horror.zil that prevent the game from being winnable in its current state:

1. **Light Source Accessibility Issue**: Many rooms (Operating Theater, Patient Ward, Morgue, and all basement rooms) are dark (lack ONBIT flag), but the only light sources (flashlight and oil lantern) are located in dark basement rooms. This creates a chicken-and-egg problem where you need light to get to the light sources.

2. **Container Item Access Issue**: Items in containers (like the patient ledger in the bottom drawer) are visible after opening the container but cannot be taken with the standard "take" command. This appears to be a verb implementation or game logic bug.

**Recommended Fixes**:
1. Add ONBIT flag to OPERATING-THEATER, PATIENT-WARD, and potentially MORGUE rooms
2. OR move a working light source (OIL-LANTERN) to an initially lit room (SANITARIUM-GATE or RECEPTION-ROOM)
3. Fix container item taking mechanics to allow items to be removed from open containers

**Testing Value**: The test infrastructure provided here successfully identifies these issues and can be used to verify when they are fixed, or to test modified versions of the game.

## Overview

The test infrastructure provides two key capabilities:

1. **Automated walkthrough testing** - Run a complete game walkthrough to verify the game can be completed
2. **State verification helpers** - Check game state during tests to ensure puzzles are solved correctly

## Running the Horror Tests

### Available Tests

1. **horror-test-helpers.lua** - Basic test to verify helper functions work
   ```bash
   lua5.3 tests/run_tests.lua tests/horror-test-helpers.lua
   ```

2. **horror-partial.lua** - Tests accessible portions of the game (recommended)
   ```bash
   lua5.3 tests/run_tests.lua tests/horror-partial.lua
   ```
   This test demonstrates:
   - Test infrastructure functionality
   - Basic gameplay mechanics (taking items, using keys, unlocking)
   - The darkness/light accessibility issue
   - The container item access issue
   - State verification using test commands

3. **horror-walkthrough.lua** - Complete walkthrough (will fail due to game issues)
   ```bash
   lua5.3 tests/run_tests.lua tests/horror-walkthrough.lua
   ```
   This test is based on the walkthrough in `adventure/horror-walkthrough.md` but will fail due to the issues noted above. It serves as a template for what a complete winnability test would look like if the game issues are fixed.

## Verifying Winnability

The test infrastructure includes special helper commands that can be used in test files to verify game state. These commands are prefixed with `test:` and are handled by the bootstrap system.

### Available Test Commands

There are two types of test commands:
1. **Check commands** - Report current state with `status="ok"` (backward compatible)
2. **Assert commands** - Verify expected state with `status="pass"` or `status="fail"` (new)

### Assertion Commands (Recommended)

Use these commands to verify that game state matches expectations. They return `pass` when expectations are met, `fail` when they aren't.

#### `test:assert-inventory <object-name> <true|false>`
Asserts that an object is (or isn't) in the player's inventory.

**Example:**
```lua
{
    input = "test:assert-inventory BRASS_KEY true",
    description = "Assert brass key is in inventory"
}
```

**Returns on success:**
```lua
{
    status = "pass",
    object = "BRASS_KEY",
    expected = true,
    actual = true,
    message = "BRASS_KEY is in player's inventory (expected: in)"
}
```

**Returns on failure:**
```lua
{
    status = "fail",
    object = "BRASS_KEY",
    expected = true,
    actual = false,
    message = "BRASS_KEY is not in player's inventory (expected: in)"
}
```

#### `test:assert-flag <object-name> <flag-name> <true|false>`
Asserts that an object has (or doesn't have) a specific flag set.

**Example:**
```lua
{
    input = "test:assert-flag BOTTOM_DRAWER OPENBIT true",
    description = "Assert drawer is open"
}
```

**Returns on success:**
```lua
{
    status = "pass",
    object = "BOTTOM_DRAWER",
    flag = "OPENBIT",
    expected = true,
    actual = true,
    message = "BOTTOM_DRAWER has OPENBIT (expected: has)"
}
```

**Returns on failure:**
```lua
{
    status = "fail",
    object = "BOTTOM_DRAWER",
    flag = "OPENBIT",
    expected = true,
    actual = false,
    message = "BOTTOM_DRAWER does not have OPENBIT (expected: has)"
}
```

#### `test:assert-location <object-name> <location-name>`
Asserts that an object is at a specific location (room or container).

**Example:**
```lua
{
    input = "test:assert-location PATIENT_LEDGER BOTTOM_DRAWER",
    description = "Assert ledger is in drawer"
}
```

**Returns on success:**
```lua
{
    status = "pass",
    object = "PATIENT_LEDGER",
    location = "BOTTOM_DRAWER",
    expected = true,
    actual = true,
    message = "PATIENT_LEDGER is at BOTTOM_DRAWER (expected: at BOTTOM_DRAWER)"
}
```

**Returns on failure:**
```lua
{
    status = "fail",
    object = "PATIENT_LEDGER",
    location = "BOTTOM_DRAWER",
    expected = true,
    actual = false,
    message = "PATIENT_LEDGER is not at BOTTOM_DRAWER (expected: at BOTTOM_DRAWER)"
}
```

### Check Commands (Backward Compatible)

These commands report the current state without asserting expectations. They always return `status="ok"` unless there's an error.

#### `test:get-location`
Returns the current room/location name.

**Example:**
```lua
{
    input = "test:get-location",
    description = "Verify starting location"
}
```

**Returns:**
```lua
{
    status = "ok",
    location = "SANITARIUM_GATE",
    message = "Current location: SANITARIUM_GATE"
}
```

#### `test:check-inventory <object-name>`
Checks if an object is in the player's inventory.

**Example:**
```lua
{
    input = "test:check-inventory BRASS_KEY",
    description = "Verify brass key in inventory"
}
```

**Returns:**
```lua
{
    status = "ok",
    object = "BRASS_KEY",
    in_inventory = true,
    message = "BRASS_KEY is in player's inventory"
}
```

#### `test:check-flag <object-name> <flag-name>`
Checks if an object has a specific flag set (e.g., OPENBIT, ONBIT, TAKEBIT).

**Example:**
```lua
{
    input = "test:check-flag OIL_LANTERN ONBIT",
    description = "Verify lantern is lit"
}
```

**Returns:**
```lua
{
    status = "ok",
    object = "OIL_LANTERN",
    flag = "ONBIT",
    is_set = true,
    message = "OIL_LANTERN has ONBIT"
}
```

#### `test:check-location <object-name> <location-name>`
Checks if an object is at a specific location (room or container).

**Example:**
```lua
{
    input = "test:check-location BRASS_PLAQUE SANITARIUM_GATE",
    description = "Verify plaque is at gate"
}
```

**Returns:**
```lua
{
    status = "ok",
    object = "BRASS_PLAQUE",
    location = "SANITARIUM_GATE",
    is_at_location = true,
    message = "BRASS_PLAQUE is at SANITARIUM_GATE"
}
```

## Common ZIL Flags

When using `test:check-flag` or `test:assert-flag`, here are the most commonly used flags:

- `OPENBIT` - Container/door is open
- `ONBIT` - Light source is lit / Room is naturally lit
- `TAKEBIT` - Object can be taken
- `CONTBIT` - Object is a container
- `LIGHTBIT` - Object is a light source
- `DOORBIT` - Object is a door
- `READBIT` - Object can be read
- `TOUCHBIT` - Object has been touched/taken
- `INVISIBLE` - Object is not visible

## Using Assertion vs Check Commands

**Use assertion commands** (`test:assert-*`) when you want to verify that game state matches expectations:
- Testing that an action succeeded (e.g., drawer opened after unlock command)
- Validating puzzle solutions (e.g., key is now in inventory)
- Ensuring game winnability (e.g., required items are accessible)

**Use check commands** (`test:check-*`) when you just want to inspect current state:
- Debugging game flow
- Understanding current object locations
- Exploring game state without assertions

**Example: Testing the drawer puzzle with assertions**
```lua
-- Before unlocking
{
    input = "test:assert-flag BOTTOM_DRAWER OPENBIT false",
    description = "Verify drawer starts locked (should pass)"
},
-- Unlock the drawer
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
    description = "Verify drawer is now open (should pass)"
},
```

If the unlock command failed, the second assertion would return `status="fail"`, making it easy to identify the problem.

## Object and Room Names

Object and room names in ZIL are defined with hyphens (e.g., `SANITARIUM-GATE`, `BRASS-KEY`), but when compiled to Lua, these hyphens are converted to underscores. When using test helper commands, you must use the Lua names with underscores:

- **ZIL definition**: `<OBJECT BRASS-PLAQUE ...>` 
- **Test command**: `test:check-inventory BRASS_PLAQUE`

Examples:
- Rooms: `SANITARIUM_GATE`, `RECEPTION_ROOM`, `CHAPEL`, etc.
- Objects: `BRASS_KEY`, `OIL_LANTERN`, `PATIENT_LEDGER`, etc.

You can find the ZIL names in the `.zil` source files and convert hyphens to underscores for use in test commands.

## Creating Custom Tests

You can create custom test files to verify specific scenarios or puzzle sequences. Here's an example using the new assertion commands:

```lua
return {
    name = "Horror.zil Key Puzzle Test",
    files = {
        "zork1/globals.zil",
        "adventure/horror.zil",
        "zork1/parser.zil",
        "zork1/verbs.zil",
        "zork1/syntax.zil",
        "zork1/main.zil",
    },
    commands = {
        {
            input = "north",
            description = "Enter sanitarium"
        },
        {
            input = "west",
            description = "Go to reception"
        },
        {
            input = "take key",
            description = "Take brass key"
        },
        {
            input = "test:assert-inventory BRASS_KEY true",
            description = "Assert we have the key (should pass)"
        },
        {
            input = "test:assert-flag BOTTOM_DRAWER OPENBIT false",
            description = "Assert drawer is closed before unlock (should pass)"
        },
        {
            input = "unlock drawer with key",
            description = "Unlock the drawer"
        },
        {
            input = "open drawer",
            description = "Open the drawer"
        },
        {
            input = "test:assert-flag BOTTOM_DRAWER OPENBIT true",
            description = "Assert drawer is now open (should pass)"
        },
        {
            input = "test:assert-location PATIENT_LEDGER BOTTOM_DRAWER",
            description = "Assert ledger is in drawer (should pass)"
        },
        {
            input = "take ledger",
            description = "Take the patient ledger"
        },
        {
            input = "test:assert-inventory PATIENT_LEDGER true",
            description = "Assert ledger is in inventory (may fail due to game bug)"
        },
    }
}
```

Save this to a file like `tests/horror-key-puzzle.lua` and run it with:

```bash
lua tests/run_tests.lua tests/horror-key-puzzle.lua
```

The test runner will display `[TEST] pass:` for successful assertions and `[TEST] fail:` for failed assertions, making it easy to identify issues.

## Implementation Details

The test helper functions are implemented in `zil/bootstrap.lua`:

**Check functions (report state):**
- `check_flag(obj_name, flag_name)` - Checks object flags
- `check_location(obj_name, location_name)` - Checks object location
- `check_inventory(obj_name)` - Checks player inventory
- `get_location()` - Gets current player location

**Assert functions (verify expectations):**
- `assert_flag(obj_name, flag_name, expected)` - Asserts flag state matches expectation
- `assert_location(obj_name, location_name)` - Asserts object is at expected location
- `assert_inventory(obj_name, expected)` - Asserts inventory state matches expectation

**Command handler:**
- `handle_test_command(cmd)` - Parses and dispatches test commands

These functions are integrated into the game's READ loop and respond to inputs prefixed with `test:`.

## Verifying Winnability

**Current State**: As of this testing, horror.zil is **not winnable** in its current implementation due to the issues described above.

To verify winnability once the issues are fixed:

1. **Fix the identified issues** in horror.zil:
   - Add light to required rooms OR move a light source to an accessible location
   - Fix container item access mechanics

2. **Run the complete walkthrough test**:
   ```bash
   lua5.3 tests/run_tests.lua tests/horror-walkthrough.lua
   ```

3. **Verify all test assertions pass**:
   - All inventory checks should show items were successfully collected
   - All flag checks should show objects in expected states (drawers open, lights on, etc.)
   - All location checks should confirm progression through the game
   - The final commands should reach the chapel and trigger the win condition

4. **Watch for test failures** that indicate:
   - Items that couldn't be picked up
   - Doors/containers that couldn't be opened
   - Rooms that couldn't be accessed
   - The win condition not being reachable

The test infrastructure will clearly show `[TEST] ok` for passing assertions and `[TEST] error` for failures, making it easy to identify where the game flow breaks.

## Test Helper Commands

### Test Command Not Found
If you see "Unknown test command", ensure:
- The command starts with `test:`
- The command syntax is correct
- Object and room names match those defined in the .zil file (case-sensitive)

### Object Not Found
If you see "Object not found", verify:
- The object name is spelled correctly
- The object name matches the ZIL definition (usually UPPERCASE-WITH-HYPHENS)
- The object exists in the loaded game files

### Flag Not Set
If a flag check shows `is_set = false` when you expected true:
- Verify the action that should set the flag was executed successfully
- Check the game output for error messages
- Ensure prerequisite items or conditions are met
