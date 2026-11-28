; Round 3: reading with children. Playing with a character is play, never
; the base game's deadly PLAY; every spoken line uses one kind of quotation
; mark; the weather card no longer answers to the word "forecast".
<INSERT-FILE "books/en/pocket-weather/pocket-weather">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "look">
 <ASSERT-TEXT "I-spy" <CO-RESUME ,CO "play mica">>
 <ASSERT-NOT-TEXT "kill" <CO-RESUME ,CO "play postmaster">>
 <CO-RESUME ,CO "take card">
 <ASSERT-NOT-TEXT "already have" <CO-RESUME ,CO "take forecast">>
 <ASSERT-TEXT "continuous rain" <CO-RESUME ,CO "examine forecast">>
 <CO-RESUME ,CO "west">
 <ASSERT-TEXT "dough" <CO-RESUME ,CO "play pip">>
 <CO-RESUME ,CO "west">
 <CO-RESUME ,CO "search apron">
 <CO-RESUME ,CO "take ribbon">
 <CO-RESUME ,CO "north">
 <ASSERT-TEXT "bottle top" <CO-RESUME ,CO "play rook">>
 <CO-RESUME ,CO "east">
 <ASSERT-NOT-TEXT "stings" <CO-RESUME ,CO "examine vane">>
 <CO-RESUME ,CO "down">
 <CO-RESUME ,CO "north">
 <ASSERT-TEXT "small voice says, “Oh. There you are.”" <CO-RESUME ,CO "tie ribbon to chime">>
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "playing tag" <CO-RESUME ,CO "play cloud">>
 <ASSERT "Playing does not end the story" <IN? ,WINNER ,HOLLOW>>
 <CO-RESUME ,CO "listen to cloud">
 <SETG APOLOGY T>
 <ASSERT-TEXT "Nimbus says. “Including me." <CO-RESUME ,CO "ask cloud about pause">>
 <ASSERT-NOT-TEXT "'" <CO-RESUME ,CO "ask cloud about pause">>
 <SETG WIND-KNOWN T> <SETG GUTTER-READY T>
 <CO-RESUME ,CO "tell cloud about promise">
 <CO-RESUME ,CO "west">
 <CO-RESUME ,CO "south">
 <ASSERT-TEXT "Nimbus says. “Write our forecast" <CO-RESUME ,CO "ask cloud about forecast">>
 <ASSERT-TEXT "Nimbus waits. “Our promise" <CO-RESUME ,CO "drizzle cloud">>
 <ASSERT-NOT-TEXT "slot.'" <CO-RESUME ,CO "drizzle cloud">>>
