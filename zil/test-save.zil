<DIRECTIONS NORTH SOUTH>
<CONSTANT RELEASEID 1>

<OBJECT ADVENTURER
        (DESC "you")
        (SYNONYM ADVENTURER ME SELF)
        (FLAGS)>

<ROOM STARTROOM
      (IN ROOMS)
      (DESC "Start Room")
      (LDESC "A test room.")
      (NORTH TO SECONDROOM)
      (FLAGS RLANDBIT ONBIT)>

<ROOM SECONDROOM
      (IN ROOMS)
      (DESC "Second Room")
      (LDESC "Another test room.")
      (FLAGS RLANDBIT ONBIT)>

<OBJECT APPLE
        (IN STARTROOM)
        (SYNONYM APPLE)
        (DESC "apple")
        (FLAGS TAKEBIT)>

<OBJECT LAMP
        (IN STARTROOM)
        (SYNONYM LAMP)
        (DESC "lamp")
        (FLAGS TAKEBIT)>

<GLOBAL TEST-SCORE 0>
<GLOBAL TEST-MOVES 0>
<GLOBAL TEST-FLAG <>>

<ROUTINE RUN-TEST ()
    <TELL "Testing SAVE and RESTORE..." CR CR>

    ;"Set up initial state"
    <SETG HERE ,STARTROOM>
    <SETG WINNER ,ADVENTURER>
    <MOVE ,WINNER ,HERE>
    <SETG TEST-SCORE 42>
    <SETG TEST-MOVES 7>
    <SETG TEST-FLAG T>
    <MOVE ,APPLE ,ADVENTURER>
    <FSET ,LAMP ,ONBIT>

    ;"Verify initial state"
    <ASSERT "Initial TEST-SCORE is 42" <==? ,TEST-SCORE 42>>
    <ASSERT "Initial TEST-FLAG is true" ,TEST-FLAG>
    <ASSERT "Apple is in adventurer's inventory" <==? <LOC ,APPLE> ,ADVENTURER>>
    <ASSERT "Lamp has ONBIT set" <FSET? ,LAMP ,ONBIT>>

    ;"Save game state"
    <ASSERT "SAVE returns true" <SAVE "zil-test-save.tmp">>

    ;"Modify state after save"
    <SETG TEST-SCORE 99>
    <SETG TEST-MOVES 100>
    <SETG TEST-FLAG <>>
    <MOVE ,APPLE ,STARTROOM>
    <FCLEAR ,LAMP ,ONBIT>

    ;"Verify modified state"
    <ASSERT "TEST-SCORE changed to 99" <==? ,TEST-SCORE 99>>
    <ASSERT "TEST-FLAG is now false" <NOT ,TEST-FLAG>>
    <ASSERT "Apple moved back to room" <==? <LOC ,APPLE> ,STARTROOM>>
    <ASSERT "Lamp ONBIT cleared" <NOT <FSET? ,LAMP ,ONBIT>>>

    ;"Restore game state"
    <ASSERT "RESTORE returns true" <RESTORE "zil-test-save.tmp">>

    ;"Verify restored state matches original saved state"
    <ASSERT "TEST-SCORE restored to 42" <==? ,TEST-SCORE 42>>
    <ASSERT "TEST-MOVES restored to 7" <==? ,TEST-MOVES 7>>
    <ASSERT "TEST-FLAG restored to true" ,TEST-FLAG>
    <ASSERT "Apple restored to adventurer inventory" <==? <LOC ,APPLE> ,ADVENTURER>>
    <ASSERT "Lamp ONBIT restored" <FSET? ,LAMP ,ONBIT>>

    ;"Clean up temp file"
    <TELL CR "All save/restore tests passed!" CR>>
