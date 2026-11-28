"Wondertown round 4: a book for reading with children. No countdown unless
the reader asks for one, no default verb that kills or scolds, hints that
start gently at every stage, and an ending that keeps a way back to Nutmeg."

<INSERT-FILE "books/wondertown/wondertown">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    <CO-RESUME ,CO "look">

    ;"The dawn countdown is off until the reader types EASY."
    <ASSERT "No countdown by default" <NOT ,TIMER-ACTIVE>>
    <CO-RESUME ,CO "wait">
    <CO-RESUME ,CO "wait">
    <ASSERT "The night does not run down" <==? ,TICK-COUNT 200>>
    <ASSERT-TEXT "countdown is on" <CO-RESUME ,CO "easy">>
    <ASSERT "EASY switches the countdown on" ,TIMER-ACTIVE>
    <ASSERT-TEXT "countdown is off" <CO-RESUME ,CO "easy">>
    <ASSERT "EASY switches it off again" <NOT ,TIMER-ACTIVE>>

    ;"Every hint stage starts at its gentlest hint."
    <CO-RESUME ,CO "hint">
    <CO-RESUME ,CO "hint">
    <CO-RESUME ,CO "hint">
    <ASSERT-TEXT "WIND NUTCRACKER" <CO-RESUME ,CO "hint">>
    <SETG BERTRAND-WOUND T>
    <ASSERT-TEXT "will not rise" <CO-RESUME ,CO "hint">>
    <ASSERT-NOT-TEXT "LUBRICATE" <CO-RESUME ,CO "look">>
    <SETG LADDER-OILED T>
    <ASSERT-TEXT "Someone small took the key" <CO-RESUME ,CO "hint">>
    <ASSERT-NOT-TEXT "investigate" <CO-RESUME ,CO "hint">>
    <SETG BERTRAND-WOUND <>>
    <SETG LADDER-OILED <>>

    ;"The workshop clock points to its twin; the tower points to its winder."
    <ASSERT-TEXT "storage loft" <CO-RESUME ,CO "wind clock">>
    <ASSERT-NOT-TEXT "nothing to wind" <CO-RESUME ,CO "wind clock">>
    <SETG HERE ,CLOCK-SQUARE>
    <MOVE ,WINNER ,CLOCK-SQUARE>
    <ASSERT-TEXT "out of reach" <CO-RESUME ,CO "wind tower">>
    <ASSERT-TEXT "stuck with frost" <CO-RESUME ,CO "enter bakery">>
    <ASSERT-NOT-TEXT "hit your head" <CO-RESUME ,CO "enter bakery">>

    ;"Playing with a toy is play, never the base game's deadly PLAY."
    <SETG HERE ,TOOL-BENCH>
    <MOVE ,WINNER ,TOOL-BENCH>
    <ASSERT-TEXT "needs winding first" <CO-RESUME ,CO "play nutcracker">>
    <ASSERT "Playing does not end the story" <NOT ,GAME-WON>>
    <SETG HERE ,COUNTERTOP>
    <MOVE ,WINNER ,COUNTERTOP>
    <ASSERT-TEXT "pat-a-cake" <CO-RESUME ,CO "play doll">>
    <SETG HERE ,STORAGE-LOFT>
    <MOVE ,WINNER ,STORAGE-LOFT>
    <ASSERT-TEXT "needs winding" <CO-RESUME ,CO "play clock">>
    <SETG HERE ,MAILBOX-CORNER>
    <MOVE ,WINNER ,MAILBOX-CORNER>
    <ASSERT-TEXT "pretend letter" <CO-RESUME ,CO "play mailbox">>

    ;"The fox as a topic away from her den reads without a doubled article."
    <SETG HERE ,SCRAP-YARD>
    <MOVE ,WINNER ,SCRAP-YARD>
    <ASSERT-NOT-TEXT "the the" <CO-RESUME ,CO "examine fox">>

    ;"Saying sorry to a frightened Nutmeg is the whole answer."
    <SETG HERE ,FOX-DEN>
    <MOVE ,WINNER ,FOX-DEN>
    <ASSERT-TEXT "does not trust" <CO-RESUME ,CO "play fox">>
    <SETG NUTMEG-TRUST -1>
    <ASSERT-TEXT "Saying sorry" <CO-RESUME ,CO "play fox">>
    <ASSERT-TEXT "gentle word" <CO-RESUME ,CO "hint">>
    <ASSERT-NOT-TEXT "manual" <CO-RESUME ,CO "tell fox about tolliver">>
    <ASSERT "Sorry with no gifts yet leaves her wary, not afraid" <==? ,NUTMEG-TRUST 0>>
    <SETG NUTMEG-TRUST -1>
    <ASSERT-TEXT "Nobody ever said sorry" <CO-RESUME ,CO "tell fox about key">>
    <ASSERT-NOT-TEXT "dying" <CO-RESUME ,CO "look">>

    ;"Grandfather comes home, and a frightened Nutmeg still has a way back."
    <SETG NUTMEG-TRUST -1>
    <SETG KEY-FOUND T>
    <SETG STUDY-ACCESS T>
    <SETG KEY-WOUND T>
    <SETG HERE ,WORKSHOP-HEART>
    <MOVE ,WINNER ,WORKSHOP-HEART>
    <MOVE ,TIN-SOLDIER ,WINNER>
    <MOVE ,MUSIC-BOX ,WINNER>
    <MOVE ,DOLL-ARM ,WINNER>
    <CO-RESUME ,CO "position tin soldier">
    <ASSERT "Nutmeg does not join while frightened" <NOT ,NUTMEG-SAVED>>
    <CO-RESUME ,CO "position music box">
    <ASSERT-TEXT "say sorry properly" <CO-RESUME ,CO "position porcelain arm">>
    <ASSERT "The heart is restored" ,GAME-WON>>
