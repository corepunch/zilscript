<DIRECTIONS NORTH SOUTH>
<CONSTANT RELEASEID 1>

;"Define common test objects inline (no INSERT-FILE needed)"
<OBJECT ADVENTURER
        (DESC "you")
        (SYNONYM ADVENTURER ME SELF)
        (FLAGS)>

<ROUTINE TEST-SETUP (ROOM-OBJ)
    <SETG HERE .ROOM-OBJ>
    <SETG LIT T>
    <SETG WINNER ,ADVENTURER>
    <SETG PLAYER ,WINNER>
    <MOVE ,ADVENTURER ,HERE>>

<ROOM STARTROOM
      (IN ROOMS)
      (DESC "Start Room")
      (LDESC "A test room.")
      (FLAGS RLANDBIT ONBIT)>

<OBJECT APPLE
        (IN STARTROOM)
        (SYNONYM APPLE)
        (DESC "apple")
        (FLAGS TAKEBIT)>

<ROUTINE TEST-BASIC ()
    <TELL "Testing basic ASSERT functionality..." CR CR>
    
    ;"Test that ADVENTURER object exists"
    <ASSERT ,ADVENTURER "ADVENTURER object exists">
    
    ;"Test that TEST-SETUP routine works"
    <TEST-SETUP ,STARTROOM>
    <ASSERT <==? <LOC ,ADVENTURER> ,STARTROOM> "ADVENTURER at STARTROOM after TEST-SETUP">
    <ASSERT <==? ,HERE ,STARTROOM> "HERE is STARTROOM">
    
    ;"Test basic functionality"
    <ASSERT <==? <LOC ,APPLE> ,STARTROOM> "Apple in STARTROOM">
    <MOVE ,APPLE ,ADVENTURER>
    <ASSERT <==? <LOC ,APPLE> ,ADVENTURER> "Apple in inventory">
    
    <TEST-SUMMARY>>

<ROUTINE GO ()
    <TEST-BASIC>>
