<INSERT-FILE "books/pocket-weather/pocket-weather">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "look" T>
 <ASSERT-TEXT "Hint 1 of 3" <CO-RESUME ,CO "hint">>
 <ASSERT-TEXT "Hint 2 of 3" <CO-RESUME ,CO "hint">>
 <ASSERT-TEXT "GIVE BUTTON TO ROOK" <CO-RESUME ,CO "hint">>
 <CO-RESUME ,CO "take card"> <CO-RESUME ,CO "east">
 <ASSERT-TEXT "must approve" <CO-RESUME ,CO "put card in slot">>
 <ASSERT "unapproved card retained" <HELD? ,CARD>>
 <ASSERT "unapproved publication blocked" <NOT ,PUBLISHED>>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "west"> <CO-RESUME ,CO "take spoon">
 <CO-RESUME ,CO "drop spoon"> <ASSERT "drop falls through" <IN? ,SPOON ,KITCHEN>>
 <CO-RESUME ,CO "take spoon"> <CO-RESUME ,CO "west">
 <ASSERT-TEXT "can't see" <CO-RESUME ,CO "take button">>
 <ASSERT "hidden discovery required" <FSET? ,BUTTON ,INVISIBLE>>
 <CO-RESUME ,CO "search apron"> <CO-RESUME ,CO "take button"> <CO-RESUME ,CO "take ribbon">
 <CO-RESUME ,CO "north"> <CO-RESUME ,CO "give button to rook"> <CO-RESUME ,CO "east">
 <ASSERT-TEXT "counterweight is free" <CO-RESUME ,CO "examine vane">>
 <CO-RESUME ,CO "turn vane">
 <ASSERT-TEXT "Hint 1 of 3" <CO-RESUME ,CO "hint">>
 <CO-RESUME ,CO "down"> <CO-RESUME ,CO "north">
 <ASSERT-TEXT "ribbon can pad" <CO-RESUME ,CO "tie chime to spoon">>
 <ASSERT "wrong tie tool changes nothing" <NOT <IN? ,RIBBON ,CHIME>>>
 <CO-RESUME ,CO "tie chime to ribbon"> <ASSERT "symmetric menu tie works" <IN? ,RIBBON ,CHIME>>
 <CO-RESUME ,CO "untie chime"> <ASSERT "untie returns real ribbon" <HELD? ,RIBBON>>
 <CO-RESUME ,CO "tie ribbon to chime"> <CO-RESUME ,CO "east">
 <ASSERT-TEXT "Listen to Nimbus first" <CO-RESUME ,CO "tell cloud about promise">>
 <CO-RESUME ,CO "listen to cloud">
 <ASSERT-TEXT "old report" <CO-RESUME ,CO "tell cloud about promise">>
 <ASSERT "no premature agreement" <NOT ,AGREED>>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "south"> <CO-RESUME ,CO "south"> <CO-RESUME ,CO "south">
 <CO-RESUME ,CO "open weatherbox"> <CO-RESUME ,CO "close weatherbox">
 <ASSERT "native close works" <NOT <FSET? ,WEATHERBOX ,OPENBIT>>>
 <CO-RESUME ,CO "open weatherbox"> <CO-RESUME ,CO "take report">
 <CO-RESUME ,CO "north"> <CO-RESUME ,CO "west">
 <ASSERT-TEXT "other objects" <CO-RESUME ,CO "steam report over spoon">>
 <ASSERT "wrong steam target cannot borrow kettle" <NOT ,REPORT-SOFT>>
 <CO-RESUME ,CO "steam report over kettle"> <CO-RESUME ,CO "read report">
 <CO-RESUME ,CO "close report"> <ASSERT "report native close works" <NOT <FSET? ,REPORT ,OPENBIT>>>
 <CO-RESUME ,CO "open report"> <ASSERT "soft report reopens" <FSET? ,REPORT ,OPENBIT>>
 <CO-RESUME ,CO "take flower"> <CO-RESUME ,CO "drop flower"> <CO-RESUME ,CO "take flower">
 <ASSERT "flower take drop round trip" <HELD? ,FLOWER>>
 <CO-RESUME ,CO "east"> <CO-RESUME ,CO "north"> <CO-RESUME ,CO "east">
 <CO-RESUME ,CO "dig gutter with spoon"> <CO-RESUME ,CO "west"> <CO-RESUME ,CO "north"> <CO-RESUME ,CO "east">
 <CO-RESUME ,CO "show report to cloud"> <CO-RESUME ,CO "show flower to cloud">
 <CO-RESUME ,CO "ask cloud about pause"> <CO-RESUME ,CO "tell cloud about promise">
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "untie chime"> <CO-RESUME ,CO "south">
 <ASSERT-TEXT "still be good at rain" <CO-RESUME ,CO "listen to cloud">>
 <CO-RESUME ,CO "south"> <CO-RESUME ,CO "write card"> <CO-RESUME ,CO "give card to mica">
 <CO-RESUME ,CO "east"> <CO-RESUME ,CO "put card in slot"> <CO-RESUME ,CO "west"> <CO-RESUME ,CO "north">
 <ASSERT-TEXT "one excellent puddle" <CO-RESUME ,CO "shower cloud">>>
