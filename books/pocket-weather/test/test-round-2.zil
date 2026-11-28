; Parser and milestone regressions from the second blind round.
<INSERT-FILE "books/pocket-weather/pocket-weather">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "take card">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "take spoon">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "search apron">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "take button">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "take ribbon">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "give button to rook">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "turn vane">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "down">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">>
 <ASSERT-TEXT "spoon you are carrying" <CO-RESUME ,CO "dig in gutter">>
 <ASSERT-NOT-TEXT "if you brought" <CO-RESUME ,CO "dig in gutter">>
 <ASSERT "Bare dig requires a tool" <NOT ,GUTTER-READY>>
 <ASSERT-TEXT "spoon you are carrying" <CO-RESUME ,CO "dig gutter with ribbon">>
 <ASSERT "Wrong tool does not clear gutter" <NOT ,GUTTER-READY>>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "dig gutter with spoon">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "south">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "south">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "open weatherbox">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "take report">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "steam report over kettle">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "read report">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "tie ribbon to chime">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "listen to cloud">>
 <ASSERT-TEXT "yesterday" <CO-RESUME ,CO "ask cloud about forecast">>
 <ASSERT-NOT-TEXT "Could you listen to me" <CO-RESUME ,CO "ask cloud about forecast">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "show report to cloud">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "ask cloud about pause">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "tell cloud about promise">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "south">>
 <ASSERT-TEXT "We have agreed" <CO-RESUME ,CO "ask cloud about forecast">>
 <ASSERT-TEXT "Write" <CO-RESUME ,CO "ask cloud about forecast">>
 <ASSERT-NOT-TEXT "Could you listen to me" <CO-RESUME ,CO "ask cloud about forecast">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "south">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "write card">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">>
 <ASSERT-TEXT "Mica" <CO-RESUME ,CO "ask cloud about forecast">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "south">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "give card to mica">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">>
 <ASSERT-TEXT "broadcast slot" <CO-RESUME ,CO "ask cloud about forecast">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "south">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "put card in slot">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">>
 <ASSERT-TEXT "town has heard" <CO-RESUME ,CO "ask cloud about forecast">>
 <ASSERT-NOT-TEXT "Write" <CO-RESUME ,CO "ask cloud about forecast">>
 <ASSERT "Agreement remains complete" ,AGREED>
 <ASSERT "Publication remains complete" ,PUBLISHED>
 <ASSERT-TEXT "A FORECAST YOU CAN KEEP" <CO-RESUME ,CO "shower cloud">>
>
