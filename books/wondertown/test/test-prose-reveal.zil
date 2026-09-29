<INSERT-FILE "books/wondertown/wondertown">

<GLOBAL CO <CO-CREATE GO>>

;"A glance takes in what is in plain sight. What hides under, among or inside
  something, and what is written on a thing, is learned by examining it (Zork I
  hides the grating under the leaves and prints the leaflet only when read)."

<ROUTINE RUN-TEST ()
    ;"The oil can shows only as a copper glint until Pip looks under the bench."
    <ASSERT-TEXT "something small and copper" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "oil can" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "[[" <CO-RESUME ,CO "look">>
    <ASSERT "The can cannot be taken unseen" <CO-RESUME ,CO "take oil can" T> <==? <LOC ,OIL-CAN> ,WORKSHOP-FLOOR>>
    <ASSERT-TEXT "oil can" <CO-RESUME ,CO "look under workbench">>
    <ASSERT-TEXT "oil can" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "copper catches" <CO-RESUME ,CO "look">>

    ;"The workbench top names the repair book once, whatever its state."
    <MOVE ,WINNER ,WORKBENCH-TOP> <SETG HERE ,WORKBENCH-TOP>
    <ASSERT-TEXT "repair book rests closed" <CO-RESUME ,CO "look">>

    ;"The doll head lies under the snowy scrap until Pip searches the piles."
    <MOVE ,WINNER ,SCRAP-YARD> <SETG HERE ,SCRAP-YARD>
    <ASSERT-TEXT "something pale" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "doll head" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "doll head" <CO-RESUME ,CO "search piles">>
    <ASSERT-TEXT "doll head" <CO-RESUME ,CO "look">>
    <ASSERT "Take the found head" <CO-RESUME ,CO "take head" T> <==? <LOC ,DOLL-HEAD> ,ADVENTURER>>

    ;"The study diagram keeps its instructions until it is read."
    <MOVE ,WINNER ,TOLLIVER-STUDY> <SETG HERE ,TOLLIVER-STUDY>
    <ASSERT-TEXT "diagram" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "clockwise" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "clockwise" <CO-RESUME ,CO "read diagram">>>
