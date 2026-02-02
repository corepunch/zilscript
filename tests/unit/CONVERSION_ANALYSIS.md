# Conversion Analysis: Lua Unit Tests to ZIL

## Executive Summary

**Conclusion: Converting the Lua unit tests in `tests/unit/` to ZIL is NOT feasible or recommended.**

The Lua unit tests serve a fundamentally different purpose than ZIL tests and test different layers of the system.

## Background

### Current Test Structure

1. **Lua Unit Tests** (`tests/unit/*.lua`) - 134+ tests
   - Test parser, compiler, runtime, source mapping modules
   - Use Lua test framework with assertions
   - Directly access internal Lua modules
   - Test the compilation pipeline itself

2. **Pure ZIL Tests** (`tests/*.zil`) - Integration tests
   - Test compiled game functionality
   - Use ASSERT function provided by Lua test runner
   - Test game logic, object behavior, runtime features
   - Written entirely in ZIL

## Why Conversion is Not Feasible

### 1. Module Access Limitation

**Problem**: ZIL cannot access Lua modules like `parser`, `compiler`, or `runtime`.

**Example from test_parser.lua**:
```lua
local test = require 'tests.unit.test_framework'
local parser = require 'zilscript.parser'  -- Cannot do this in ZIL

test.describe("Parser - Basic Types", function(t)
    t.it("should parse numbers", function(assert)
        local ast = parser.parse("42")  -- ZIL cannot call parser.parse()
        assert.assert_not_nil(ast)
        assert.assert_equal(ast[1].type, "number")
    end)
end)
```

**Why it doesn't work in ZIL**:
- ZIL files are compiled to Lua and run in an isolated environment
- The isolated environment only has game-related globals from `bootstrap.lua`
- No `require()` function available in ZIL context
- No access to parser/compiler/runtime modules

### 2. Testing Internal Compilation Process

**Problem**: The tests verify the compilation pipeline itself - ZIL code IS the output of this pipeline.

**Example from test_compiler.lua**:
```lua
local compiler = require 'zilscript.compiler'

t.it("should compile simple routine", function(assert)
    local code = [[<ROUTINE TEST () <RETURN 42>>]]
    local ast = parser.parse(code)
    local result = compiler.compile(ast)  -- Testing the compiler
    
    assert.assert_not_nil(result)
    assert.assert_match(result.declarations, "TEST = function")
end)
```

**Why it doesn't work**:
- To test the compiler from ZIL, you'd need ZIL to compile ZIL - circular dependency
- The test needs to inspect compiler output (generated Lua code)
- ZIL has no facilities for code introspection or meta-programming at this level

### 3. AST Inspection and Validation

**Problem**: Tests inspect Abstract Syntax Trees (ASTs) which are Lua tables.

**Example from test_parser.lua**:
```lua
t.it("should parse expressions", function(assert)
    local ast = parser.parse("<ROUTINE TEST ()>")
    assert.assert_equal(ast[1].type, "expr")  -- Inspecting AST structure
    assert.assert_equal(ast[1].name, "ROUTINE")
    assert.assert_equal(#ast[1], 2)
end)
```

**Why it doesn't work**:
- ASTs are internal Lua data structures
- ZIL has no concept of its own AST (it's already been compiled)
- Would require exposing complex Lua table structures to ZIL

### 4. Different Testing Paradigms

**Lua Unit Tests**:
- White-box testing of internal modules
- Test individual functions and methods
- Verify data structures and transformations
- Mock/stub capabilities
- Test edge cases in parser/compiler logic

**ZIL Tests**:
- Black-box testing of compiled functionality
- Test game behavior and runtime features
- Verify object state and game logic
- Integration-level testing
- Test end-user features

## What CAN Be Tested in ZIL

ZIL tests are excellent for testing:

1. **Runtime Behavior** - already covered by tests like:
   - `test-simple-new.zil` - Basic runtime features
   - `test-containers.zil` - Container interactions
   - `test-directions.zil` - Direction handling
   - `test-pronouns.zil` - Pronoun resolution

2. **Game Logic**:
```zil
<ROUTINE TEST-GAME-LOGIC ()
    <TELL "Testing game logic..." CR>
    <ASSERT "Object in room" <==? <LOC ,APPLE> ,TESTROOM>>
    <ASSERT "Flag is set" <FSET? ,APPLE ,TAKEBIT>>
    <MOVE ,APPLE ,ADVENTURER>
    <ASSERT "Object moved" <==? <LOC ,APPLE> ,ADVENTURER>>
>
```

3. **Compiled ZIL Features**:
   - ROUTINE execution
   - Object manipulation
   - Flag operations
   - Conditional logic
   - Loops and control flow

## Current Test Coverage is Appropriate

### Lua Unit Tests (tests/unit/)
- ✅ Parser: 60 tests for syntax parsing
- ✅ Compiler: 44 tests for code generation
- ✅ Runtime: 25 tests for execution environment
- ✅ Source Mapping: 5 tests for error tracking
- ✅ TypeScript modules: Testing compiler architecture

**These MUST remain in Lua** - they test the compilation infrastructure.

### ZIL Integration Tests (tests/)
- ✅ test-simple-new.zil - Runtime features
- ✅ test-containers.zil - Game interactions
- ✅ test-directions.zil - Navigation
- ✅ test-pronouns.zil - Parser integration
- ✅ Zork1 walkthrough tests - Full game testing

**These are properly in ZIL** - they test the game runtime.

## Recommendations

### 1. Keep Existing Structure ✅
- Maintain Lua unit tests for compiler/parser/runtime
- Maintain ZIL tests for game functionality
- Each serves its purpose effectively

### 2. Enhance ZIL Test Coverage
If you want more ZIL tests, add tests for:
- More complex ROUTINE behaviors
- Edge cases in game logic
- Object interactions
- DEFMAC macro usage in real code
- Complex control flow scenarios

### 3. Documentation
Add clear documentation explaining:
- When to write Lua tests (compiler internals)
- When to write ZIL tests (game features)
- How each test type contributes to quality

## Example: What Would Fail

If you attempted to write `test_parser.lua` in ZIL, you'd encounter:

```zil
; This CANNOT work - ZIL has no access to parser module
<ROUTINE TEST-PARSER ()
    ; No way to require 'zilscript.parser'
    ; No way to call parser.parse()
    ; No way to inspect AST structure
    ; No way to run assertions on internal data
>
```

Compare to what DOES work in ZIL:

```zil
; This WORKS - testing compiled runtime behavior
<ROUTINE TEST-RUNTIME ()
    <TELL "Testing runtime..." CR>
    <ASSERT "Math works" <==? <+ 2 3> 5>>
    <ASSERT "Objects exist" ,APPLE>
    <ASSERT "Flags work" <FSET? ,APPLE ,TAKEBIT>>
>
```

## Conclusion

The Lua unit tests in `tests/unit/` should remain in Lua. They test the compilation infrastructure itself and require access to internal Lua modules that ZIL cannot access by design.

The separation between Lua unit tests (compiler testing) and ZIL tests (runtime testing) is not a limitation - it's a proper architectural separation that allows comprehensive testing at all layers of the system.

### Summary Table

| Aspect | Lua Unit Tests | ZIL Tests |
|--------|---------------|-----------|
| Purpose | Test compiler internals | Test game functionality |
| Access | Internal Lua modules | Compiled runtime only |
| Layer | White-box testing | Black-box testing |
| Scope | Parser, compiler, AST | Game logic, objects, runtime |
| Should Convert? | ❌ NO | N/A (already in ZIL) |
| Current Status | ✅ Appropriate | ✅ Appropriate |

