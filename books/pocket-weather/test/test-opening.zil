<INSERT-FILE "books/pocket-weather/pocket-weather">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "look" T>
 <ASSERT-TEXT "Apprentice present" <CO-RESUME ,CO "ring bell">>
 <CO-RESUME ,CO "west">
 <ASSERT-TEXT "Taken" <CO-RESUME ,CO "take spoon">>
 <CO-RESUME ,CO "west">
 <ASSERT-TEXT "brass button" <CO-RESUME ,CO "search apron">>
 <CO-RESUME ,CO "take button"> <CO-RESUME ,CO "take ribbon">
 <CO-RESUME ,CO "north">
 <ASSERT-TEXT "fair exchange" <CO-RESUME ,CO "give button to rook">>
 <ASSERT "button really traded" <IN? ,BUTTON ,ROOK>>
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "measured a safe route" <CO-RESUME ,CO "turn vane">>
 <ASSERT "wind measured" ,WIND-KNOWN>>
