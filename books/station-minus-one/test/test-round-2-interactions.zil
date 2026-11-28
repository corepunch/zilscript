<INSERT-FILE "books/station-minus-one/station-minus-one">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "look" T>
 <ASSERT-TEXT "double tick" <CO-RESUME ,CO "listen">>
 <ASSERT-TEXT "hot dust" <CO-RESUME ,CO "smell">>
 <CO-RESUME ,CO "climb up steps">
 <ASSERT "a direction contrary to the stairs does not move the player" <EQUAL? ,HERE ,TICKET-HALL>>
 <CO-RESUME ,CO "climb down steps">
 <ASSERT "an explicit descent reaches the platform" <EQUAL? ,HERE ,LOWER-PLATFORM>>
 <CO-RESUME ,CO "climb down steps">
 <ASSERT "the downward command does not take you up from the platform" <EQUAL? ,HERE ,LOWER-PLATFORM>>
 <ASSERT-TEXT "Neither echo is quite in time" <CO-RESUME ,CO "talk to train">>
 <ASSERT-TEXT "too softly to ring" <CO-RESUME ,CO "listen to bell">>
 <ASSERT-TEXT "neither control has moved" <CO-RESUME ,CO "ring bell">>
 <ASSERT "none of the social actions chooses an ending" <EQUAL? ,STATION-END 0>>
 <CO-RESUME ,CO "climb up steps"> <CO-RESUME ,CO "west">
 <ASSERT-TEXT "tuck the chair" <CO-RESUME ,CO "push chair">>
 <ASSERT-TEXT "tucked neatly" <CO-RESUME ,CO "examine chair">>
 <ASSERT-TEXT "crescent in the dust" <CO-RESUME ,CO "look under table">>
 <ASSERT-TEXT "pull the chair out" <CO-RESUME ,CO "pull chair">>
 <ASSERT-TEXT "stands at an angle" <CO-RESUME ,CO "examine chair">>
 <CO-RESUME ,CO "take puck">
 <ASSERT-TEXT "STANDARD LOAD" <CO-RESUME ,CO "read puck">>
 <ASSERT-TEXT "underside is polished" <CO-RESUME ,CO "turn puck">>
 <CO-RESUME ,CO "east"> <CO-RESUME ,CO "east">
 <CO-RESUME ,CO "put puck in cradle"> <CO-RESUME ,CO "push stud"> <CO-RESUME ,CO "take puck">
 <ASSERT-TEXT "EMPTY REFERENCE" <CO-RESUME ,CO "push stud">>
 <ASSERT-TEXT "That is the last reading, not a new one" <CO-RESUME ,CO "examine needle">>
 <ASSERT "lifting the puck does not undo a test already witnessed" ,LOOP-OBSERVED>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "north">
 <ASSERT-TEXT "not your voice" <CO-RESUME ,CO "talk to train">>
 <ASSERT-TEXT "ENDING: OUTSIDE THE TIMETABLE" <CO-RESUME ,CO "push latch">>>
