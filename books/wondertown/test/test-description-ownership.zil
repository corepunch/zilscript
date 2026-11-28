<INSERT-FILE "books/wondertown/wondertown">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    ;"Look gives a lead. Following it reveals smaller things a reader can take."
    <ASSERT-TEXT "key hook is empty" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "string" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "frayed string" <CO-RESUME ,CO "examine hook">>
    <CO-RESUME ,CO "take string">
    <CO-RESUME ,CO "drop string">
    <ASSERT-TEXT "string lies here" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "dangles" <CO-RESUME ,CO "examine hook">>
    <ASSERT-NOT-TEXT "broom" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "broom" <CO-RESUME ,CO "examine workbench">>
    <CO-RESUME ,CO "take broom">
    <CO-RESUME ,CO "drop broom">
    <CO-RESUME ,CO "east">
    <CO-RESUME ,CO "west">
    <ASSERT-TEXT "A tiny broom and a frayed string lie here." <CO-RESUME ,CO "look">>
    <CO-RESUME ,CO "take broom">
    <ASSERT-TEXT "string lies here" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "broom" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "tiny broom" <CO-RESUME ,CO "inventory">>
    <ASSERT-NOT-TEXT "leans" <CO-RESUME ,CO "examine workbench">>

    ;"Stateful focal objects own their current descriptions."
    <SETG HERE ,COUNTERTOP>
    <MOVE ,WINNER ,COUNTERTOP>
    <SETG MARZIPAN-BUTTON T>
    <ASSERT "Marzipan has a dynamic description" <GETP ,MARZIPAN ,P?DESCFCN>>
    <ASSERT-TEXT "two mismatched button eyes" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "one button eye" <CO-RESUME ,CO "look">>

    <SETG HERE ,WORKSHOP-FLOOR>
    <MOVE ,WINNER ,WORKSHOP-FLOOR>
    <SETG LADDER-OILED T>
    <ASSERT-TEXT "rises smoothly" <CO-RESUME ,CO "examine loft ladder">>
    <ASSERT-NOT-TEXT "rusted solid" <CO-RESUME ,CO "examine loft ladder">>

    <SETG HERE ,TOOL-BENCH>
    <MOVE ,WINNER ,TOOL-BENCH>
    <MOVE ,BERTRAND-KEY ,WINNER>
    <ASSERT-NOT-TEXT "packing crate" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "packing crate" <CO-RESUME ,CO "examine steps">>
    <ASSERT-TEXT "winding socket in his back is empty" <CO-RESUME ,CO "examine nutcracker">>
    <ASSERT-NOT-TEXT "spool" <CO-RESUME ,CO "look">>

    <SETG HERE ,STORAGE-LOFT>
    <MOVE ,WINNER ,STORAGE-LOFT>
    <SETG OLD-TICK-HEARD T>
    <ASSERT-TEXT "ticks steadily" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "frozen at five to midnight" <CO-RESUME ,CO "look">>

    <SETG HERE ,SCRAP-YARD>
    <MOVE ,WINNER ,SCRAP-YARD>
    <SETG CART-MOVED T>
    <ASSERT-TEXT "rests beside the track" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "creaks along a rusted track" <CO-RESUME ,CO "look">>

    ;"Formerly suppressed FDESC prose is visible where it teaches the goal."
    <SETG HERE ,CLOCK-SQUARE>
    <MOVE ,WINNER ,CLOCK-SQUARE>
    <ASSERT-TEXT "hours until dawn" <CO-RESUME ,CO "examine tower">>

    <SETG HERE ,WORKSHOP-HEART>
    <MOVE ,WINNER ,WORKSHOP-HEART>
    <ASSERT-TEXT "a keyhole waits" <CO-RESUME ,CO "look">>
>
