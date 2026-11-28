<INSERT-FILE "books/en/blackwood-horror/blackwood-horror">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    <CO-RESUME ,CO "look" T>
    ;"Run a narrow chapter fixture independently of the long parser walkthrough."
    <SETG HERE ,CHAPEL> <MOVE ,WINNER ,HERE>
    <MOVE ,MEDICAL-BAG ,WINNER>
    <MOVE ,ANCIENT-RELIC ,WINNER>
    <MOVE ,STRANGE-SERUM ,MEDICAL-BAG>
    <MOVE ,SYRINGE ,WINNER>
    <FCLEAR ,MEDICAL-BAG ,OPENBIT>
    <ASSERT-TEXT "But something still binds it" <CO-RESUME ,CO "say hello">>
    <ASSERT "Serum sealed in the bag cannot finish the story" <NOT ,GAME-WON>>
    <ASSERT-TEXT "chamber is empty" <CO-RESUME ,CO "inject patient with syringe">>
    <ASSERT "Explicit injection also respects access to the serum" <NOT ,GAME-WON>>
    <ASSERT-TEXT "syringe is empty" <CO-RESUME ,CO "inject me with syringe">>
    <ASSERT "The unprepared attempt does not end play" <EQUAL? ,HERE ,CHAPEL>>
    <CO-RESUME ,CO "open medical bag">
    <ASSERT "Opening the bag makes stored serum available" <ACCESSIBLE? ,STRANGE-SERUM>>
    <ASSERT-TEXT "I remember... who I was" <CO-RESUME ,CO "inject patient with syringe">>
    <ASSERT "Accessible supplies can resolve the ending without a forced inventory rearrangement" ,GAME-WON>>
