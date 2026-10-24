<INSERT-FILE "books/pocket-weather/pocket-weather">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "look" T>
 <CO-RESUME ,CO "take card">
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "take spoon"> <CO-RESUME ,CO "west">
 <CO-RESUME ,CO "search apron"> <CO-RESUME ,CO "take button"> <CO-RESUME ,CO "take ribbon">
 <CO-RESUME ,CO "north"> <CO-RESUME ,CO "give button to rook"> <CO-RESUME ,CO "east">
 <CO-RESUME ,CO "turn vane"> <ASSERT "wind measured" ,WIND-KNOWN>
 <CO-RESUME ,CO "down"> <CO-RESUME ,CO "east">
 <ASSERT-TEXT "narrow, gentle scoop" <CO-RESUME ,CO "dig gutter with ribbon">>
 <ASSERT "wrong explicit tool cannot borrow spoon" <NOT ,GUTTER-READY>>
 <ASSERT-TEXT "No roots break" <CO-RESUME ,CO "dig gutter with spoon">>
 <ASSERT "gutter clear" ,GUTTER-READY>
 <CO-RESUME ,CO "east"> <ASSERT-TEXT "small hand raised" <CO-RESUME ,CO "read chart">>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "west"> <CO-RESUME ,CO "south"> <CO-RESUME ,CO "south">
 <CO-RESUME ,CO "open weatherbox"> <ASSERT "box physically open" <FSET? ,WEATHERBOX ,OPENBIT>>
 <CO-RESUME ,CO "take report"> <ASSERT "report held" <HELD? ,REPORT>>
 <ASSERT-TEXT "Warm steam" <CO-RESUME ,CO "read report">>
 <ASSERT "flower still hidden" <FSET? ,FLOWER ,INVISIBLE>>
 <CO-RESUME ,CO "north"> <CO-RESUME ,CO "west">
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
 <ASSERT-TEXT "CLANG becomes tok" <CO-RESUME ,CO "tie ribbon to chime">>
 <ASSERT "ribbon physically tied" <IN? ,RIBBON ,CHIME>>
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "You let Nimbus finish" <CO-RESUME ,CO "listen to cloud">>
 <ASSERT-TEXT "stops apologizing" <CO-RESUME ,CO "show report to cloud">>
 <ASSERT "understanding reached" ,APOLOGY>
 <ASSERT-TEXT "Including me" <CO-RESUME ,CO "ask cloud about pause">>
 <ASSERT-TEXT "like to come back" <CO-RESUME ,CO "tell cloud about promise">>
 <ASSERT "cloud returns by choice" <IN? ,CLOUD ,TERRACE>>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "south"> <CO-RESUME ,CO "south">
 <ASSERT-TEXT "largest letters" <CO-RESUME ,CO "write card">>
 <ASSERT-TEXT "hands it back" <CO-RESUME ,CO "give card to mica">>
 <ASSERT "card reviewed and returned" <HELD? ,CARD>>
 <ASSERT "card approved" ,CARD-APPROVED>
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "quiet hum carries" <CO-RESUME ,CO "put card in slot">>
 <ASSERT "card physically published" <IN? ,CARD ,SLOT>>
 <ASSERT "mica comes to listen" <IN? ,MICA ,BROADCAST>>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "north">
 <ASSERT-TEXT "A FORECAST YOU CAN KEEP" <CO-RESUME ,CO "drizzle cloud">>>
