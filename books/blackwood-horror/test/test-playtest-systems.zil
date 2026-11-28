<INSERT-FILE "books/blackwood-horror/blackwood-horror">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    <CO-RESUME ,CO "look">

    ;"Hints reveal help progressively instead of dumping the solution."
    <ASSERT-TEXT "meant to be opened" <CO-RESUME ,CO "hint">>
    <ASSERT-TEXT "cutting instrument" <CO-RESUME ,CO "hints">>
    <ASSERT-TEXT "use it on the chains" <CO-RESUME ,CO "hint">>
    <ASSERT-TEXT "ATTACK CHAINS WITH SCALPEL" <CO-RESUME ,CO "hint">>

    ;"Coal cannot be recovered bare-handed."
    <SETG HERE ,BOILER-ROOM>
    <MOVE ,WINNER ,BOILER-ROOM>
    <MOVE ,LUMP-OF-COAL ,COAL-BIN>
    <MOVE ,COAL-SHOVEL ,BOILER-ROOM>
    <ASSERT-TEXT "lump of coal" <CO-RESUME ,CO "examine bin">>
    <ASSERT-TEXT "need something broad enough" <CO-RESUME ,CO "take coal">>

    ;"The cabinet visibly communicates its state and implied solution."
    <SETG HERE ,HYDROTHERAPY-ROOM>
    <MOVE ,WINNER ,HYDROTHERAPY-ROOM>
    <SETG CABINET-THAWED <>>
    <FCLEAR ,MEDICINE-CABINET ,OPENBIT>
    <ASSERT-TEXT "sustained heat" <CO-RESUME ,CO "scrape cabinet">>

    ;"Cold exposure is telegraphed before the fatal threshold."
    <SETG HERE ,MORGUE>
    <MOVE ,WINNER ,MORGUE>
    <SETG COLD-EXPOSURE 7>
    <ASSERT-TEXT "fingers are beginning to stiffen" <CO-RESUME ,CO "look">>
    <SETG COLD-EXPOSURE 15>
    <ASSERT-TEXT "Staying here much longer" <CO-RESUME ,CO "look">>

    ;"A heated room clears exposure and only reports recovery once."
    <SETG HERE ,BOILER-ROOM>
    <MOVE ,WINNER ,BOILER-ROOM>
    <SETG BOILER-LIT T>
    <ASSERT-TEXT "works the numbness from your hands" <CO-RESUME ,CO "look">>
    <ASSERT "Warmth resets exposure" <EQUAL? ,COLD-EXPOSURE 0>>
    <ASSERT-NOT-TEXT "works the numbness from your hands" <CO-RESUME ,CO "look">>

    ;"Patient 189 reacts to discoveries and follows the player into the garden."
    <SETG HERE ,OVERGROWN-GARDEN>
    <MOVE ,WINNER ,OVERGROWN-GARDEN>
    <MOVE ,PATIENT-189 ,CHAPEL>
    <SETG PATIENT-STATE 1>
    <SETG PATIENT-LORE 3>
    <I-PATIENT-AUTONOMY>
    <ASSERT "Patient state advances from discoveries" <==? ,PATIENT-STATE 2>>
    <ASSERT "Patient follows into the garden" <IN? ,PATIENT-189 ,OVERGROWN-GARDEN>>

    ;"The last safe turn still allows a command. The next tick ends the story."
    <SETG HERE ,MORGUE>
    <MOVE ,WINNER ,MORGUE>
    <SETG COLD-EXPOSURE 23>
    <ASSERT-NOT-TEXT "the cold has won" <CO-RESUME ,CO "look">>
    <ASSERT "The last safe turn is 24" <EQUAL? ,COLD-EXPOSURE 24>>
    <ASSERT-TEXT "the cold has won" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "end this session" <CO-RESUME ,CO "look">>
>
