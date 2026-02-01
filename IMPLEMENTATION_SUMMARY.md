# Implementation Summary: Pure ZIL Testing with ASSERT and INSERT-FILE

## Problem Statement
Enable writing ZIL test files without Lua wrappers by:
1. Adding ASSERT functions to bootstrap.lua for test assertions
2. Implementing INSERT-FILE for including dependencies (e.g., `<INSERT-FILE "../zork-substrate/main">`)

## Solution Implemented

### 1. ASSERT Functions in bootstrap.lua ✅

Added 9 ZIL-callable assertion functions that output colored test results:

**Basic Assertions:**
- `ASSERT-TRUE` - Verify condition is true
- `ASSERT-FALSE` - Verify condition is false  
- `ASSERT-EQUAL` - Compare two values (with nil/false handling)
- `ASSERT-NOT-EQUAL` - Verify values differ

**Game-Specific Assertions:**
- `ASSERT-IN-INVENTORY` - Check if object is in player inventory
- `ASSERT-NOT-IN-INVENTORY` - Verify object not in inventory
- `ASSERT-AT-LOCATION` - Verify object at specific location
- `ASSERT-HAS-FLAG` - Check if object has flag set
- `ASSERT-NOT-HAS-FLAG` - Verify object doesn't have flag

**Test Summary:**
- `TEST-SUMMARY` - Print results and exit with proper code (0=pass, 1=fail)

### 2. INSERT-FILE Support ✅

**Created `zil/preprocessor.lua`:**
- Recursively processes `<INSERT-FILE "path">` directives
- Resolves relative paths (supports `../` notation)
- Prevents circular includes
- Auto-adds `.zil` extension if missing
- Integrated into `zil/base.lua` for automatic processing

**Example:**
```zil
<INSERT-FILE "test-utils">       ; Loads tests/test-utils.zil
<INSERT-FILE "../zork-substrate/main">  ; Relative path resolution
```

### 3. Direct Output Mode ✅

Added `ENABLE_DIRECT_OUTPUT()` function to bootstrap.lua:
- Enables immediate console output (bypasses coroutine buffering)
- Required for simple test runners that don't use game loop

### 4. Simplified Test Pattern ✅

Per user feedback, tests use simple require pattern:

**Test file (tests/my-test.zil):**
```zil
<ROUTINE TEST-MY-FEATURE ()
    <TELL "Testing..." CR>
    <ASSERT-TRUE T "Test passes">
    <TEST-SUMMARY>>

<ROUTINE GO ()
    <TEST-MY-FEATURE>>
```

**Runner (tests/my-test.lua):**
```lua
require "zil"
require "zil.bootstrap"
ENABLE_DIRECT_OUTPUT()
require "tests.my-test"
GO()
```

**Run:**
```bash
lua5.4 tests/my-test.lua
```

### 5. Examples Created ✅

- **test-simple-assert.zil** - Basic assertions demo
- **test-pure-zil-example.zil** - Comprehensive example (14 assertions)
- **test-insert-file.zil** - INSERT-FILE demonstration  
- **test-utils.zil** - Shared utilities (ADVENTURER, TEST-SETUP)
- **test-directions-pure.zil** - Conversion of existing test

### 6. Documentation ✅

**Created `tests/PURE_ZIL_TESTING.md`:**
- Quick start guide
- Complete assertion reference
- INSERT-FILE usage patterns
- Best practices
- Pure ZIL vs ZIL+Lua comparison

### 7. Build Integration ✅

Added Makefile target:
```bash
make test-pure-zil
```

Runs all pure ZIL tests with colorized output.

## Test Results

All tests passing:
- ✅ Simple assertions (2 tests)
- ✅ INSERT-FILE functionality (5 tests)  
- ✅ Pure ZIL directions test (10 tests)
- ✅ Existing integration tests (unchanged)

## Key Design Decisions

### Why Simple Test Pattern?
User feedback indicated tests don't need complex runtime abstraction. Simple `require` pattern leverages existing ZIL loader system.

### Why Preprocessor?
INSERT-FILE must run before parsing since it modifies source code. Preprocessor integrates seamlessly into existing require system.

### Why Direct Output Mode?
Game loop uses coroutine-based buffering (for READ/WRITE). Simple tests need immediate output without coroutine overhead.

### Nil/False Handling
For game testing, `nil` and `false` are treated as `0` in assertions, since ZIL commonly uses numeric comparisons. This is documented in code.

## Usage Examples

### Basic Test
```zil
<ROUTINE TEST-BASIC ()
    <ASSERT-TRUE T "This passes">
    <ASSERT-EQUAL 5 5 "Numbers match">
    <TEST-SUMMARY>>

<ROUTINE GO () <TEST-BASIC>>
```

### With INSERT-FILE
```zil
<INSERT-FILE "test-utils">

<ROUTINE TEST-WITH-SETUP ()
    <TEST-SETUP ,STARTROOM>
    <ASSERT-AT-LOCATION ,ADVENTURER ,STARTROOM "Setup worked">
    <TEST-SUMMARY>>

<ROUTINE GO () <TEST-WITH-SETUP>>
```

### Testing Objects
```zil
<ROUTINE TEST-OBJECTS ()
    <MOVE ,APPLE ,ADVENTURER>
    <ASSERT-IN-INVENTORY ,APPLE "Apple picked up">
    <ASSERT-HAS-FLAG ,APPLE ,TAKEBIT "Apple is takeable">
    <TEST-SUMMARY>>

<ROUTINE GO () <TEST-OBJECTS>>
```

## Files Changed/Created

**Modified:**
- `zil/bootstrap.lua` - Added ASSERT functions and direct output mode
- `zil/base.lua` - Integrated preprocessor
- `Makefile` - Added test-pure-zil target

**Created:**
- `zil/preprocessor.lua` - INSERT-FILE implementation
- `tests/PURE_ZIL_TESTING.md` - Documentation
- `tests/test-simple-assert.zil` - Example
- `tests/test-pure-zil-example.zil` - Comprehensive example
- `tests/test-insert-file.zil` - INSERT-FILE demo
- `tests/test-utils.zil` - Shared utilities
- `tests/test-directions-pure.zil` - Converted test
- `tests/test-simple.lua` - Simple runner
- `tests/test-insert.lua` - INSERT-FILE runner
- `tests/run_simple_zil_test.lua` - Generic runner (optional)
- `tests/run_pure_zil_test.lua` - Module-based runner (optional)

## Benefits

1. **Self-Contained Tests** - Pure ZIL with no Lua wrappers needed
2. **Reusable Utilities** - INSERT-FILE enables shared test code
3. **Simple Pattern** - Just require + GO(), no complex setup
4. **Immediate Feedback** - Colored pass/fail output
5. **Proper Exit Codes** - CI/CD integration ready
6. **Backwards Compatible** - Existing tests unchanged

## Future Enhancements

Possible additions (not in scope):
- More assertion types (ASSERT-CONTAINS, ASSERT-GREATER-THAN, etc.)
- Test fixtures/teardown
- Test suite organization (describe/it blocks)
- Assertion failure details (line numbers, stack traces)
