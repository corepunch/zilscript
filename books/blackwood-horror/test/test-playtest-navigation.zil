<INSERT-FILE "books/blackwood-horror/blackwood-horror">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    ;"Observed: DOWN, DOWN, UP -> 'Basement Stairs' and nothing else."
    ;"Expected: the story starts VERBOSE, so a revisited room is described in full."
    <ASSERT "The story starts in verbose mode" ,VERBOSE>
    <CO-RESUME ,CO "north">
    <CO-RESUME ,CO "down">
    <CO-RESUME ,CO "down">
    <ASSERT-TEXT "narrow stone staircase" <CO-RESUME ,CO "up">>
    <ASSERT-TEXT "basement corridor is dim" <CO-RESUME ,CO "down">>

    ;"Observed: the lit corridor called itself pitch black and put the dripping water east."
    ;"Expected: the dark flooded chamber to the north is the one announced as dark and wet."
    <ASSERT-TEXT "North, another corridor descends into total darkness, toward the sound of dripping water" <CO-RESUME ,CO "look">>

    ;"Observed: CLIMB STAIRCASE and other verbs on scenery printed nothing at all."
    ;"Expected: handled verbs answer, and unhandled verbs fall through to the defaults."
    <CO-RESUME ,CO "up">
    <CO-RESUME ,CO "up">
    <ASSERT "Back in the entrance hall" <==? ,HERE ,SANITARIUM-ENTRANCE>>
    <ASSERT-TEXT "collapsed landing" <CO-RESUME ,CO "climb staircase">>
    <ASSERT-TEXT "no way up" <CO-RESUME ,CO "up">>
    <ASSERT-TEXT "to the east, a corridor opens onto the patient ward" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "ascends to darkness in the east" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "wallpaper" <CO-RESUME ,CO "push wallpaper">>
    <SETG HERE ,OPERATING-THEATER>
    <MOVE ,WINNER ,OPERATING-THEATER>
    <ASSERT-TEXT "trays" <CO-RESUME ,CO "push trays">>

    ;"Observed: a dropped object printed a fragment or its original placement."
    ;"Expected: its room description reads as a sentence wherever it lies."
    <MOVE ,FLASHLIGHT ,WINNER>
    <FSET ,FLASHLIGHT ,TOUCHBIT>
    <CO-RESUME ,CO "drop flashlight">
    <ASSERT-TEXT "An old-fashioned electric flashlight lies here." <CO-RESUME ,CO "look">>
    <MOVE ,OBSERVATION-LOGBOOK ,WINNER>
    <FSET ,OBSERVATION-LOGBOOK ,TOUCHBIT>
    <CO-RESUME ,CO "drop logbook">
    <ASSERT-NOT-TEXT "rests on a desk" <CO-RESUME ,CO "look">>

    ;"Observed: SCORE printed a run of garbage characters after 'Rank:'."
    ;"Expected: the first rank names the starting player."
    <ASSERT-TEXT "Rank: Confused Patient." <CO-RESUME ,CO "score">>

    ;"Observed: dying printed its message and play simply continued."
    ;"Expected: a death ends the story with the RESTART, RESTORE, or QUIT prompt."
    <MOVE ,SYRINGE ,WINNER>
    <ASSERT-TEXT "RESTART, RESTORE, or QUIT" <CO-RESUME ,CO "inject me with syringe">>
    <ASSERT-TEXT "RESTART, RESTORE, or QUIT" <CO-RESUME ,CO "north">>
    <CO-RESUME ,CO "restart">
    <ASSERT "RESTART returns to the gate" <==? ,HERE ,SANITARIUM-GATE>>
>
