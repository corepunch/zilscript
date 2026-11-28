; Parser and world-state regressions from the first blind round.
<INSERT-FILE "books/pocket-weather/pocket-weather">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "take card">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "take spoon">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">>
 <ASSERT-TEXT "pockets bulging" <CO-RESUME ,CO "look">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "search apron">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "take button">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "take ribbon">>
 <ASSERT-NOT-TEXT "pockets bulging" <CO-RESUME ,CO "look">>
 <ASSERT-TEXT "pockets flat" <CO-RESUME ,CO "look">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "give button to rook">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "turn vane">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "down">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">>
 <ASSERT-TEXT "chime" <CO-RESUME ,CO "drizzle cloud">>
 <ASSERT-NOT-TEXT "Our promise" <CO-RESUME ,CO "drizzle cloud">>
 <ASSERT-NOT-TEXT "Write your card" <CO-RESUME ,CO "drizzle cloud">>
 <ASSERT-TEXT "chime" <CO-RESUME ,CO "shower cloud">>
 <ASSERT "No listening before the conversation" <NOT ,LISTENED>>
 <ASSERT "No agreement before the conversation" <NOT ,AGREED>>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "tie ribbon to chime">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">>
 <ASSERT-TEXT "Listen to Nimbus first" <CO-RESUME ,CO "drizzle cloud">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "listen to cloud">>
 <ASSERT-TEXT "yesterday" <CO-RESUME ,CO "drizzle cloud">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "south">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "south">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "south">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "open weatherbox">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "take report">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "steam report over kettle">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "read report">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "take flower">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "untie chime">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">>
 <ASSERT-TEXT "chime" <CO-RESUME ,CO "show flower to cloud">>
 <ASSERT-NOT-TEXT "Ludo kept" <CO-RESUME ,CO "show flower to cloud">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "tie ribbon to chime">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "show report to cloud">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "ask cloud about pause">>
 <ASSERT-TEXT "not agreed" <CO-RESUME ,CO "drizzle cloud">>
 <ASSERT "Understanding is not agreement" <NOT ,AGREED>>
 <ASSERT "Understanding is not publication" <NOT ,PUBLISHED>>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "south">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "dig gutter with spoon">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "tell cloud about promise">>
 <ASSERT "Agreement moves Nimbus" <IN? ,CLOUD ,TERRACE>>
 <ASSERT-NOT-TEXT "Nimbus the cloud" <CO-RESUME ,CO "look">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "south">>
 <ASSERT-TEXT "Nimbus the cloud" <CO-RESUME ,CO "look">>
 <ASSERT-TEXT "Our promise" <CO-RESUME ,CO "drizzle cloud">>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "south">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "write card">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "give card to mica">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "east">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "put card in slot">> <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "take card">>
 <ASSERT-NOT-TEXT "card rests" <CO-RESUME ,CO "examine slot">>
 <ASSERT "Taking the card preserves publication" ,PUBLISHED>
 <ASSERT "Retrieved card is held" <HELD? ,CARD>>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "west">>
 <ASSERT-NOT-TEXT "Mica bows" <CO-RESUME ,CO "ring bell">>
 <ASSERT "Mica remains on the balcony" <IN? ,MICA ,BROADCAST>>
 <ASSERT-TEXT-MINIMUM 1 <CO-RESUME ,CO "north">>
 <ASSERT-TEXT "Ludo calls" <CO-RESUME ,CO "drizzle cloud">>
>
