<INSERT-FILE "books/en/blackwood-horror/blackwood-horror">

<GLOBAL CO <CO-CREATE GO>>

;"QA round 4: verbs a reader tries on things the prose names."
<ROUTINE RUN-TEST ()
    ;"The hollow book's CUT adjective took CUT's six-letter entry and stripped
      the verb from its synonyms SLICE and PIERCE."
    <SETG HERE ,PATIENT-WARD> <MOVE ,WINNER ,HERE> <SETG LIT T>
    <MOVE ,SCALPEL ,WINNER>
    <ASSERT-TEXT "slice through it" <CO-RESUME ,CO "slice strap with scalpel">>
    <ASSERT "SLICE cuts the strap" ,CHAINS-CUT-FLAG>

    ;"Shelves are a surface: their finds are ON them, and things go back."
    <SETG HERE ,STORAGE-ROOM> <MOVE ,WINNER ,HERE> <SETG LIT T>
    <CO-RESUME ,CO "examine shelves">
    <ASSERT-TEXT "are on the shelves" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "in the shelves" <CO-RESUME ,CO "look">>
    <CO-RESUME ,CO "take bag">
    <ASSERT-TEXT "Done" <CO-RESUME ,CO "put bag on shelves">>
    <ASSERT "bag is back on the shelves" <IN? ,MEDICAL-BAG ,SHELVES>>

    ;"The cell doors answer OPEN instead of a parser complaint."
    <SETG HERE ,ISOLATION-WARD> <MOVE ,WINNER ,HERE> <SETG LIT T>
    <ASSERT-TEXT "keyholes have rusted solid" <CO-RESUME ,CO "open cell">>

    ;"The director's desk drawers and books are part of the desk."
    <SETG HERE ,DIRECTORS-OFFICE> <MOVE ,WINNER ,HERE> <SETG LIT T>
    <ASSERT-TEXT "red tome" <CO-RESUME ,CO "open desk">>
    <ASSERT-TEXT "medical texts" <CO-RESUME ,CO "examine books">>
    <ASSERT "opening the desk does not move the book" <IN? ,HOLLOW-BOOK ,DIRECTORS-OFFICE>>

    ;"The nurse's uniform is found with the photograph, never taken."
    <SETG HERE ,STAFF-QUARTERS> <MOVE ,WINNER ,HERE> <SETG LIT T>
    <ASSERT-TEXT "can't see any uniform" <CO-RESUME ,CO "examine uniform">>
    <ASSERT-TEXT "nurse's uniform" <CO-RESUME ,CO "examine lockers">>
    <ASSERT-TEXT "name tape" <CO-RESUME ,CO "examine uniform">>
    <ASSERT-TEXT "splits at the shoulder" <CO-RESUME ,CO "take uniform">>
    <ASSERT "uniform stays in the lockers" <IN? ,STAFF-UNIFORM ,LOCKERS>>
    <ASSERT-TEXT "springs complain" <CO-RESUME ,CO "sit on bed">>

    ;"Menus, kitchen and fountain named in the prose are examinable."
    <SETG HERE ,CAFETERIA> <MOVE ,WINNER ,HERE> <SETG LIT T>
    <ASSERT-TEXT "Mystery Meat" <CO-RESUME ,CO "read menus">>
    <SETG HERE ,OVERGROWN-GARDEN> <MOVE ,WINNER ,HERE> <SETG LIT T>
    <ASSERT-TEXT "crumbling fountain" <CO-RESUME ,CO "examine fountain">>
    <ASSERT-TEXT "stand again" <CO-RESUME ,CO "sit on bench">>
    <SETG HERE ,RECEPTION-ROOM> <MOVE ,WINNER ,HERE> <SETG LIT T>
    <ASSERT-TEXT "flue narrows" <CO-RESUME ,CO "climb up chimney">>
    <SETG HERE ,SANITARIUM-ENTRANCE> <MOVE ,WINNER ,HERE> <SETG LIT T>
    <ASSERT-TEXT "Black mold" <CO-RESUME ,CO "look">>

    ;"SHOW works like GIVE: the relic stills Patient 189 without ending the story."
    <SETG HERE ,CHAPEL> <MOVE ,WINNER ,HERE> <SETG LIT T>
    <MOVE ,ANCIENT-RELIC ,WINNER> <MOVE ,STRANGE-SERUM ,WINNER>
    <ASSERT-TEXT "nothing to deliver the dose" <CO-RESUME ,CO "show relic to patient">>
    <ASSERT "showing the relic alone does not win" <NOT ,GAME-WON>>
    <ASSERT-TEXT "no interest" <CO-RESUME ,CO "show serum to patient">>
    <ASSERT-TEXT "cannot bring yourself" <CO-RESUME ,CO "kick patient">>
    <ASSERT "Patient 189 remains" <IN? ,PATIENT-189 ,CHAPEL>>
    <MOVE ,SYRINGE ,WINNER>
    <ASSERT-TEXT "I remember... who I was" <CO-RESUME ,CO "show relic to patient">>
    <ASSERT "showing the relic with serum and syringe frees it" ,GAME-WON>
>
