<INSERT-FILE "books/limehouse-killings/limehouse-killings">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    ;"INSPECT remains a verb while the exact long noun INSPECTOR resolves to Lestrade."
    <ASSERT-TEXT "gravel path leads north" <CO-RESUME ,CO "inspect path">>
    <SETG HERE ,ASHWORTH-ENTRANCE-HALL>
    <MOVE ,WINNER ,ASHWORTH-ENTRANCE-HALL>
    <MOVE ,INSPECTOR ,ASHWORTH-ENTRANCE-HALL>
    <SETG INSPECTOR-PRESENT T>
    <ASSERT-TEXT "Inspector Lestrade" <CO-RESUME ,CO "examine inspector">>
    <ASSERT-TEXT "case as a chain" <CO-RESUME ,CO "ask inspector about murder">>

    ;"Natural sensory and manipulation commands reach authored handlers."
    <ASSERT-TEXT "settling timber" <CO-RESUME ,CO "listen">>
    <ASSERT-TEXT "Beeswax" <CO-RESUME ,CO "smell">>
    <ASSERT-TEXT "one bright kitchen bell" <CO-RESUME ,CO "pull bell wire">>

    ;"State-aware descriptions stop advertising removed evidence."
    <SETG HERE ,LIBRARY>
    <MOVE ,WINNER ,LIBRARY>
    <MOVE ,TORN-PAGE ,WINNER>
    <ASSERT-TEXT "clean rectangle" <CO-RESUME ,CO "examine reading desk">>
    <SETG HERE ,GARDEN>
    <MOVE ,WINNER ,GARDEN>
    <MOVE ,FOOTPRINT-CAST ,WINNER>
    <MOVE ,BLOOD-STAINED-KNIFE ,WINNER>
    <ASSERT-NOT-TEXT "cast lies nearby" <CO-RESUME ,CO "examine fountain">>
    <ASSERT-TEXT "where the knife was lodged" <CO-RESUME ,CO "examine hedges">>

    ;"The puzzle box owns a persistent, state-aware room description."
    <SETG HERE ,STUDY>
    <MOVE ,WINNER ,STUDY>
    <SETG LOCKED-BOX-OPENED T>
    <FSET ,LOCKED-BOX ,OPENBIT>
    <ASSERT-TEXT "box lies open among the cold ashes" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "small locked box" <CO-RESUME ,CO "look">>

    ;"The kitchen map has only the documented west exit."
    <SETG HERE ,KITCHEN>
    <MOVE ,WINNER ,KITCHEN>
    <ASSERT-TEXT "can't go that way" <CO-RESUME ,CO "east">>

    ;"Blind round 1: the shelf clue names the exact actionable books, and
      a completed mechanism still leaves the ordinary library exit visible."
    <SETG HERE ,LIBRARY> <MOVE ,WINNER ,LIBRARY>
    <ASSERT-TEXT "red book" <CO-RESUME ,CO "examine ribbons">>
    <ASSERT-TEXT "yellow book" <CO-RESUME ,CO "examine bookshelf">>
    <ASSERT-TEXT "spine projects" <CO-RESUME ,CO "examine red book">>
    <SETG CIPHER-SOLVED T>
    <ASSERT-TEXT "west to the entrance hall" <CO-RESUME ,CO "look">>

    ;"A removed roll never reappears in the drawer's opening response."
    <SETG HERE ,KITCHEN> <MOVE ,WINNER ,KITCHEN>
    <MOVE ,LEATHER-ROLL ,WINNER>
    <FCLEAR ,DRAWER ,OPENBIT>
    <ASSERT-NOT-TEXT "Inside is a leather roll" <CO-RESUME ,CO "open drawer">>
    <ASSERT "Opening retains the roll's unique location" <IN? ,LEATHER-ROLL ,WINNER>>
    <ASSERT "Drawer really opened" <FSET? ,DRAWER ,OPENBIT>>

    ;"The greenhouse identifies one poison source, not a second foxglove
      resource competing with the pantry bottle."
    <SETG HERE ,GREENHOUSE> <MOVE ,WINNER ,GREENHOUSE>
    <ASSERT-TEXT "Aconitum" <CO-RESUME ,CO "examine labels">>
    <ASSERT-NOT-TEXT "Digitalis" <CO-RESUME ,CO "examine labels">>

    ;"Every suspect offers meaningful topics when approached without one."
    <SETG HERE ,SERVANTS-QUARTERS> <MOVE ,WINNER ,SERVANTS-QUARTERS>
    <ASSERT-TEXT "alibi" <CO-RESUME ,CO "tell hudson">>
    <ASSERT-TEXT "study key" <CO-RESUME ,CO "tell hudson">>
    <SETG HERE ,DINING-ROOM> <MOVE ,WINNER ,DINING-ROOM>
    <ASSERT-TEXT "marriage" <CO-RESUME ,CO "tell lady">>
    <SETG HERE ,LIBRARY> <MOVE ,WINNER ,LIBRARY>
    <ASSERT-TEXT "experiments" <CO-RESUME ,CO "tell moriarty">>

    ;"Wrong accusations are counted safely."
    <SETG WRONG-ATTEMPTS 0>
    <SETG HERE ,DINING-ROOM>
    <MOVE ,WINNER ,DINING-ROOM>
    <ASSERT-TEXT "alibi" <CO-RESUME ,CO "accuse lady">>
    <ASSERT "Wrong accusation counter increments" <==? ,WRONG-ATTEMPTS 1>>
>
