;" Proof of Concept: Attempting to Test Compiler Functionality from ZIL
;" This file demonstrates WHY unit tests cannot be converted to ZIL
;"
;" Key findings:
;" 1. ZIL cannot access Lua modules (parser, compiler, runtime)
;" 2. ZIL cannot inspect its own AST or compilation process
;" 3. ZIL can only test runtime behavior, not compiler internals

<CONSTANT RELEASEID 1>

<OBJECT ADVENTURER
        (DESC "you")
        (SYNONYM ADVENTURER ME SELF)
        (FLAGS)>

<ROOM TESTROOM
      (IN ROOMS)
      (DESC "Test Room")
      (LDESC "A test room.")
      (FLAGS RLANDBIT ONBIT)>

;" ==============================================================
;" MAIN TEST ENTRY POINT
;" ==============================================================

<ROUTINE RUN_TEST ()
    <TELL "=== Tests that WORK in ZIL ===" CR CR>
    
    <ASSERT "Basic math operations" <==? <+ 2 3> 5>>
    <ASSERT "Multiplication" <==? <* 4 5> 20>>
    <ASSERT "Comparison operators" <G? 10 5>>
    <ASSERT "Boolean logic" <AND T T>>
    <ASSERT "NOT operator" <NOT <>>>
    <ASSERT "String equality" <==? "hello" "hello">>
    
    <TELL "  ✓ All basic runtime operations work in ZIL" CR>
    <TELL CR "Runtime tests demonstrate what ZIL CAN test!" CR CR>
    
    <TELL "=== Tests that DON'T WORK in ZIL ===" CR CR>
    
    <TELL "❌ Cannot require() Lua modules from ZIL" CR>
    <TELL "❌ Cannot call parser.parse() - module not accessible" CR>
    <TELL "❌ Cannot inspect AST - it's a Lua internal structure" CR>
    <TELL "❌ Cannot call compiler.compile() - module not accessible" CR>
    <TELL "❌ Cannot inspect generated Lua code" CR>
    <TELL "❌ Cannot test compilation process from within compiled code" CR>
    
    <TELL CR "These limitations are BY DESIGN - ZIL is for game logic, not compiler testing" CR CR>
    
    <TELL CR "============================================" CR>
    <TELL "CONCLUSION:" CR>
    <TELL "  ✅ ZIL can test RUNTIME behavior" CR>
    <TELL "  ❌ ZIL CANNOT test COMPILER internals" CR>
    <TELL "  → Keep Lua unit tests in tests/unit/" CR>
    <TELL "  → Use ZIL tests for game functionality" CR>
    <TELL "============================================" CR>>

