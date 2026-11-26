<INSERT-FILE "books/en/station-minus-one/station-minus-one">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "" T>
 <ASSERT-TEXT "one second behind" <CO-RESUME ,CO "examine clock">>
 <CO-RESUME ,CO "north">
 <ASSERT-TEXT "Run the comparison" <CO-RESUME ,CO "push latch">>
 <CO-RESUME ,CO "south"> <CO-RESUME ,CO "east">
 <ASSERT-TEXT "EMPTY REFERENCE" <CO-RESUME ,CO "push stud">>
 <ASSERT "no train proved by an empty test" <NOT ,LOOP-OBSERVED>>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "west">
 <ASSERT-TEXT "A reflection weighs nothing" <CO-RESUME ,CO "read logbook">>
 <CO-RESUME ,CO "take puck"> <CO-RESUME ,CO "drop puck">
 <ASSERT-TEXT "ceramic puck" <CO-RESUME ,CO "look">>
 <CO-RESUME ,CO "take ceramic puck"> <ASSERT "portable calibration weight" <HELD? ,TEST-PUCK>>
 <CO-RESUME ,CO "east"> <CO-RESUME ,CO "east">
 <CO-RESUME ,CO "put puck in cradle">
 <ASSERT "test object sits in the receiver" <IN? ,TEST-PUCK ,RECEIVER-CRADLE>>
 <ASSERT-TEXT "A reflection cannot do that" <CO-RESUME ,CO "push calibration stud">>
 <ASSERT "mass comparison is recorded" ,LOOP-OBSERVED>
 <ASSERT-TEXT "Again" <CO-RESUME ,CO "push stud">>
 <CO-RESUME ,CO "take puck"> <CO-RESUME ,CO "west"> <CO-RESUME ,CO "north">
 <ASSERT-TEXT "ENDING: THE EXTRA STOP" <CO-RESUME ,CO "push rescue switch">>
 <ASSERT "registered rescue" <EQUAL? ,STATION-END 1>>
 <ASSERT-TEXT "wrong side of midnight" <CO-RESUME ,CO "restart">>
 <ASSERT "restart clears observed evidence" <NOT ,LOOP-OBSERVED>>
 <ASSERT "restart clears ending" <EQUAL? ,STATION-END 0>>
 <ASSERT "restart restores calibration puck" <IN? ,TEST-PUCK ,STAFF-ROOM>>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "take puck"> <CO-RESUME ,CO "east"> <CO-RESUME ,CO "east">
 <CO-RESUME ,CO "put puck in cradle"> <CO-RESUME ,CO "push stud">
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "north">
 <ASSERT-TEXT "ENDING: OUTSIDE THE TIMETABLE" <CO-RESUME ,CO "push quarantine latch">>
 <ASSERT "warned the train without opening" <EQUAL? ,STATION-END 2>>>
