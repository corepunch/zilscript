<INSERT-FILE "books/pocket-weather/pocket-weather">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "look" T>
 <ASSERT-NOT-TEXT "weather card" <CO-RESUME ,CO "look">>
 <ASSERT-TEXT "blank weather card" <CO-RESUME ,CO "examine bell">>
 <ASSERT-TEXT "write on it once" <CO-RESUME ,CO "examine card">>
 <CO-RESUME ,CO "take card"> <ASSERT "card held" <HELD? ,CARD>>
 <CO-RESUME ,CO "drop card">
 <ASSERT-TEXT "weather card" <CO-RESUME ,CO "look">>
 <ASSERT-NOT-TEXT "card" <CO-RESUME ,CO "examine bell">>
 <CO-RESUME ,CO "take card">
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "take spoon"> <CO-RESUME ,CO "west">
 <CO-RESUME ,CO "search apron"> <CO-RESUME ,CO "take button"> <CO-RESUME ,CO "take ribbon">
 <CO-RESUME ,CO "north">
 <ASSERT-TEXT "You may turn the vane now" <CO-RESUME ,CO "give button to rook">>
 <ASSERT "aster keeps the button" <IN? ,BUTTON ,ROOK>>
 <ASSERT "aster hops to the perch" <IN? ,ROOK ,VANE-DECK>>
 <CO-RESUME ,CO "east"> <ASSERT "on the perch" <EQUAL? ,HERE ,VANE-DECK>>
 <ASSERT-TEXT "counterweight is free" <CO-RESUME ,CO "examine counterweight">>
 <CO-RESUME ,CO "turn vane"> <ASSERT "wind measured" ,WIND-KNOWN>
 <CO-RESUME ,CO "down"> <CO-RESUME ,CO "east">
 <ASSERT-TEXT "narrow, gentle scoop" <CO-RESUME ,CO "dig gutter with ribbon">>
 <ASSERT "wrong explicit tool cannot borrow spoon" <NOT ,GUTTER-READY>>
 <ASSERT-TEXT "No roots break" <CO-RESUME ,CO "dig gutter with spoon">>
 <ASSERT "gutter clear" ,GUTTER-READY>
 <CO-RESUME ,CO "east"> <ASSERT-TEXT "small hand raised" <CO-RESUME ,CO "read chart">>
 <ASSERT-TEXT "vane agrees with the picture" <CO-RESUME ,CO "read chart">>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "west"> <CO-RESUME ,CO "south"> <CO-RESUME ,CO "south">
 <CO-RESUME ,CO "open weatherbox"> <ASSERT "box physically open" <FSET? ,WEATHERBOX ,OPENBIT>>
 <CO-RESUME ,CO "take report"> <ASSERT "report held" <HELD? ,REPORT>>
 <ASSERT-TEXT "Warm steam" <CO-RESUME ,CO "read report">>
 <ASSERT-TEXT "hold the report over the kettle" <CO-RESUME ,CO "examine report">>
 <ASSERT "flower still hidden" <FSET? ,FLOWER ,INVISIBLE>>
 <CO-RESUME ,CO "north"> <CO-RESUME ,CO "west">
 <ASSERT-TEXT "folded report could be held over it" <CO-RESUME ,CO "examine kettle">>
 <ASSERT-TEXT "Hold your report over it" <CO-RESUME ,CO "show report to pip">>
 <ASSERT-TEXT "fold uncurls" <CO-RESUME ,CO "steam report over kettle">>
 <ASSERT "report softened" ,REPORT-SOFT>
 <ASSERT-TEXT "Ludo asked Nimbus to stop" <CO-RESUME ,CO "read report">>
 <ASSERT "report understood" ,REPORT-READ>
 <ASSERT "flower revealed only inside report" <NOT <FSET? ,FLOWER ,INVISIBLE>>>
 <CO-RESUME ,CO "take flower">
 <ASSERT-TEXT "Evidence is kinder" <CO-RESUME ,CO "show report to pip">>
 <CO-RESUME ,CO "east"> <CO-RESUME ,CO "north"> <CO-RESUME ,CO "north">
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "chime" <CO-RESUME ,CO "listen to cloud">>
 <ASSERT "noise prevents fake listening" <NOT ,LISTENED>>
 <CO-RESUME ,CO "west">
 <ASSERT-TEXT "matching bright spot" <CO-RESUME ,CO "examine clapper">>
 <ASSERT-TEXT "CLANG becomes tok" <CO-RESUME ,CO "tie ribbon to clapper">>
 <ASSERT-TEXT "only the ribbon touches metal" <CO-RESUME ,CO "examine clapper">>
 <ASSERT-TEXT "softens each strike" <CO-RESUME ,CO "listen to clapper">>
 <ASSERT "ribbon physically tied" <IN? ,RIBBON ,CHIME>>
 <ASSERT-TEXT "clapper wrapped in the soft ribbon" <CO-RESUME ,CO "look">>
 <ASSERT "room text tells of the tied ribbon, so it is not listed" <FSET? ,RIBBON ,NDESCBIT>>
 <ASSERT-TEXT "You untie the ribbon" <CO-RESUME ,CO "take ribbon">>
 <ASSERT "taking the tied ribbon unties it" <AND <HELD? ,RIBBON> <NOT <FSET? ,RIBBON ,NDESCBIT>>>>
 <CO-RESUME ,CO "tie ribbon to chime"> <ASSERT "ribbon tied again" <IN? ,RIBBON ,CHIME>>
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "You let Nimbus finish" <CO-RESUME ,CO "listen to cloud">>
 <ASSERT-TEXT "stops apologizing" <CO-RESUME ,CO "show report to cloud">>
 <ASSERT "understanding reached" ,APOLOGY>
 <ASSERT-TEXT "Including me" <CO-RESUME ,CO "ask cloud about pause">>
 <ASSERT-TEXT "like to come back" <CO-RESUME ,CO "tell cloud about promise">>
 <ASSERT "cloud returns by choice" <IN? ,CLOUD ,TERRACE>>
 <ASSERT "promise agreed" ,AGREED>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "south"> <ASSERT "on the terrace" <EQUAL? ,HERE ,TERRACE>>
 <ASSERT-TEXT "That is our promise now" <CO-RESUME ,CO "ask cloud about pause">>
 <ASSERT-TEXT "Write our forecast on your weather card" <CO-RESUME ,CO "tell cloud about promise">>
 <CO-RESUME ,CO "south">
 <ASSERT-TEXT "largest letters" <CO-RESUME ,CO "write card">>
 <ASSERT-TEXT "hands it back" <CO-RESUME ,CO "give card to mica">>
 <ASSERT "card reviewed and returned" <HELD? ,CARD>>
 <ASSERT "card approved" ,CARD-APPROVED>
 <ASSERT-TEXT "I have signed it" <CO-RESUME ,CO "ask mica about promise">>
 <ASSERT-TEXT "Yours is approved" <CO-RESUME ,CO "ask mica about forecast">>
 <CO-RESUME ,CO "east"> <ASSERT "on the balcony" <EQUAL? ,HERE ,BROADCAST>>
 <ASSERT-TEXT "no door" <CO-RESUME ,CO "open slot">>
 <ASSERT-TEXT "quiet hum carries" <CO-RESUME ,CO "put card in slot">>
 <ASSERT "card physically published" <IN? ,CARD ,SLOT>>
 <ASSERT "mica comes to listen" <IN? ,MICA ,BROADCAST>>
 <ASSERT "forecast published" ,PUBLISHED>
 <ASSERT-TEXT "Nimbus is waiting for you on the terrace" <CO-RESUME ,CO "ask mica about forecast">>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "north"> <ASSERT "back on the terrace" <EQUAL? ,HERE ,TERRACE>>
 <ASSERT-TEXT "choose a drizzle or a shower" <CO-RESUME ,CO "tell cloud about promise">>
 <ASSERT-TEXT "A FORECAST YOU CAN KEEP" <CO-RESUME ,CO "drizzle cloud">>>
