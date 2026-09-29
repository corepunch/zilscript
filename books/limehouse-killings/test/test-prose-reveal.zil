<INSERT-FILE "books/limehouse-killings/limehouse-killings">

<GLOBAL CO <CO-CREATE GO>>

;"A glance takes in what is in plain sight. What hides among or inside
  something, what is written on a thing, and what a detective concludes from
  it, is learned by examining it (Zork I hides the grating under the leaves
  and prints the leaflet only when read)."

<ROUTINE RUN-TEST ()
    ;"The unsent letter lies among the desk papers until the desk is searched."
    <SETG HERE ,STUDY> <MOVE ,WINNER ,STUDY>
    <ASSERT-TEXT "Papers lie heaped" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "envelope" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "[[" <CO-RESUME ,CO "look">>
    <ASSERT "The letter cannot be taken unseen" <CO-RESUME ,CO "take letter" T> <==? <LOC ,DEAD-LETTER> ,STUDY>>
    <ASSERT-TEXT "envelope" <CO-RESUME ,CO "search desk">>
    <ASSERT-TEXT "envelope" <CO-RESUME ,CO "look">>
    ;"The poison bottle keeps its label to itself at a glance."
    <ASSERT-NOT-TEXT "deadly" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "Aconitum" <CO-RESUME ,CO "examine bottle">>

    ;"The knife hangs in the hedge; the garden shows only a glint."
    <SETG HERE ,GARDEN> <MOVE ,WINNER ,GARDEN>
    <ASSERT-TEXT "glints deep in the hedge" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "knife" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "knife" <CO-RESUME ,CO "examine hedges">>
    <ASSERT-TEXT "knife" <CO-RESUME ,CO "look">>
    <ASSERT "Take the found knife" <CO-RESUME ,CO "take knife" T> <==? <LOC ,BLOOD-STAINED-KNIFE> ,WINNER>>

    ;"A moved piece of evidence is described, not interpreted."
    <ASSERT "Take the cast" <CO-RESUME ,CO "take footprint cast" T> <==? <LOC ,FOOTPRINT-CAST> ,WINNER>>
    <CO-RESUME ,CO "drop footprint cast">
    <ASSERT-NOT-TEXT "Lady Ashworth" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "too large for Lady Ashworth" <CO-RESUME ,CO "examine footprint cast">>

    ;"The trunk keeps its note until its lid is lifted."
    <SETG HERE ,SERVANTS-QUARTERS> <MOVE ,WINNER ,SERVANTS-QUARTERS>
    <ASSERT-NOT-TEXT "folded note" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "folded note" <CO-RESUME ,CO "examine trunk">>

    ;"The pantry names its remedies once."
    <SETG HERE ,PANTRY> <MOVE ,WINNER ,PANTRY>
    <ASSERT-NOT-TEXT "warning-labeled" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "foxglove" <CO-RESUME ,CO "look">>>
