<INSERT-FILE "books/house-of-the-ebb/house-of-the-ebb">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "look" T>
 ;"Kit walks the causeway with the reader, as the prose says, and follows into the hall."
 <ASSERT "Kit starts on the causeway beside the reader" <IN? ,EKIT ,CAUSEWAY>>
 <ASSERT-TEXT "oilskin" <CO-RESUME ,CO "examine kit">>
 <ASSERT-TEXT "Hello yourself" <CO-RESUME ,CO "hello kit">>
 <ASSERT-NOT-TEXT "The Kit" <CO-RESUME ,CO "hello kit">>
 <ASSERT-TEXT "Kit sets his bag" <CO-RESUME ,CO "north">>
 <ASSERT "Kit follows into the hall" <IN? ,EKIT ,HALL>>
 <ASSERT-TEXT "Kit walks a pace behind you" <CO-RESUME ,CO "south">>
 <ASSERT "Kit follows back onto the causeway" <IN? ,EKIT ,CAUSEWAY>>
 <CO-RESUME ,CO "north">
 <ASSERT-TEXT "Not yet" <CO-RESUME ,CO "take bag">>
 <ASSERT-TEXT "rag" <CO-RESUME ,CO "examine rag">>
 ;"Nouns the kitchen prose names."
 <CO-RESUME ,CO "west">
 <ASSERT-TEXT "moonlight comes in at the window" <CO-RESUME ,CO "examine window">>
 <ASSERT-TEXT "isn't yours" <CO-RESUME ,CO "drink from mug">>
 <ASSERT-TEXT "already shut" <CO-RESUME ,CO "close range">>
 <ASSERT-TEXT "K. R." <CO-RESUME ,CO "examine mug">>
 <CO-RESUME ,CO "east">
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "third was never there" <CO-RESUME ,CO "examine margin">>
 <ASSERT-TEXT "third line" <CO-RESUME ,CO "smell vinegar">>
 <CO-RESUME ,CO "west">
 <CO-RESUME ,CO "north">
 <ASSERT-TEXT "through a hatch" <CO-RESUME ,CO "examine hatch">>
 <CO-RESUME ,CO "read signal plate">
 <CO-RESUME ,CO "up">
 <ASSERT-TEXT "simple catch" <CO-RESUME ,CO "examine catch">>
 <ASSERT-TEXT "extra notch" <CO-RESUME ,CO "examine notch">>
 <CO-RESUME ,CO "open seaward shutter">
 ;"Ringing early must not carry off the bolted bell (RING implies TAKE)."
 <CO-RESUME ,CO "east">
 <ASSERT-NOT-TEXT "(Taken)" <CO-RESUME ,CO "ring bell">>
 <ASSERT "The bell stays bolted to the gallery" <IN? ,EBELL ,GALLERY>>
 <ASSERT-NOT-TEXT "witness bell" <CO-RESUME ,CO "inventory">>
 <ASSERT-TEXT "hums along the rail" <CO-RESUME ,CO "listen to wind">>
 <CO-RESUME ,CO "west">
 <ASSERT-TEXT "empty berth" <CO-RESUME ,CO "turn lens">>
 ;"Once Kit has gone ahead, the hall no longer offers his bag."
 <CO-RESUME ,CO "down">
 <ASSERT-TEXT "bag is gone" <CO-RESUME ,CO "south">>
 <ASSERT-TEXT "can't see any bag" <CO-RESUME ,CO "examine bag">>
 <ASSERT-TEXT "own boots" <CO-RESUME ,CO "south">>
 <ASSERT "Kit no longer follows after the lens is turned" <IN? ,EKIT ,GALLERY>>
 <CO-RESUME ,CO "north">
 <CO-RESUME ,CO "north">
 <CO-RESUME ,CO "up">
 <ASSERT-TEXT "clapper brake" <CO-RESUME ,CO "east">>
 <ASSERT-TEXT "THE END: THE SHORE HEARS" <CO-RESUME ,CO "ring bell">>>
