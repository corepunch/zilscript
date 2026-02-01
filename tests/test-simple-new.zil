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

<OBJECT APPLE
        (IN TESTROOM)
        (SYNONYM APPLE)
        (DESC "apple")
        (FLAGS TAKEBIT)>

<ROUTINE TEST-SIMPLE ()
    <TELL "Testing ASSERT function..." CR CR>
    
    ;"Basic assertions using ASSERT with comparisons"
    <ASSERT T "Basic true assertion">
    <ASSERT <NOT <>> "Basic false assertion">
    <ASSERT <==? 5 5> "Numbers are equal">
    <ASSERT <N==? 3 5> "Numbers are not equal">
    
    ;"Test object location using ASSERT with EQUALQ"
    <SETG HERE ,TESTROOM>
    <SETG WINNER ,ADVENTURER>
    <MOVE ,ADVENTURER ,HERE>
    
    <ASSERT <==? <LOC ,ADVENTURER> ,TESTROOM> "Adventurer at test room">
    <ASSERT <==? ,HERE ,TESTROOM> "HERE is test room">
    
    ;"Test flag using ASSERT with FSET?"
    <ASSERT <FSET? ,APPLE ,TAKEBIT> "Apple has TAKEBIT">
    
    ;"Test inventory using ASSERT with EQUALQ and LOC"
    <MOVE ,APPLE ,ADVENTURER>
    <ASSERT <==? <LOC ,APPLE> ,ADVENTURER> "Apple in inventory">
    
    <TEST-SUMMARY>>

<ROUTINE GO ()
    <TEST-SIMPLE>>
