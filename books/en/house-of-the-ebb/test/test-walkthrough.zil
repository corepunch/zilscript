<INSERT-FILE "books/en/house-of-the-ebb/house-of-the-ebb">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "look" T>
 <ASSERT-TEXT "Kit" <CO-RESUME ,CO "north">>
 <CO-RESUME ,CO "examine younger kit">
 <CO-RESUME ,CO "west">
 <ASSERT-TEXT "K. R." <CO-RESUME ,CO "examine child mug">>
 <CO-RESUME ,CO "east">
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "third was never there" <CO-RESUME ,CO "read old sheet">>
 <CO-RESUME ,CO "west">
 <CO-RESUME ,CO "north">
 <ASSERT-TEXT "private vigil" <CO-RESUME ,CO "read signal plate">>
 <CO-RESUME ,CO "up">
 <ASSERT-TEXT "closed shutter" <CO-RESUME ,CO "spin signal lens">>
 <CO-RESUME ,CO "open seaward shutter">
 <ASSERT-TEXT "empty berth" <CO-RESUME ,CO "spin signal lens">>
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "THE END: THE SHORE HEARS" <CO-RESUME ,CO "ring witness bell">>>
