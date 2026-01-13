<DIRECTIONS NORTH SOUTH EAST WEST UP DOWN IN OUT>
<CONSTANT RELEASEID 1>

<ROOM STARTROOM
      (IN ROOMS)
      (DESC "Start Room")
      (LDESC "A test room for directions.")
      (NORTH TO HALLWAY)
      (IN TO HALLWAY)
      (FLAGS RLANDBIT ONBIT)>

<ROOM HALLWAY
      (IN ROOMS)
      (DESC "Hallway")
      (LDESC "A long hallway.")
      (NORTH TO CLOSET)
      (SOUTH TO STARTROOM)
      (IN TO CLOSET)
      (OUT TO STARTROOM)
      (FLAGS RLANDBIT ONBIT)>

<ROOM CLOSET
      (IN ROOMS)
      (DESC "Closet")
      (LDESC "A small closet.")
      (SOUTH TO HALLWAY)
      (OUT TO HALLWAY)
      (FLAGS RLANDBIT ONBIT)>

<OBJECT APPLE
        (IN STARTROOM)
        (SYNONYM APPLE FRUIT)
        (DESC "apple")
        (FLAGS TAKEBIT VOWELBIT)>

<ROUTINE GO ()
    <SETG HERE ,STARTROOM>
    <SETG LIT T>
    <SETG WINNER ,ADVENTURER>
    <SETG PLAYER ,WINNER>
    <MOVE ,WINNER ,HERE>
    <V-LOOK>
    <MAIN-LOOP>
    <AGAIN>>
