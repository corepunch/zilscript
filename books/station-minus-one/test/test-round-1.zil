;"QA round 1: up and down the steps, the arrivals board, the unseen
  train, the platform and bell, the chair, the tap, and the table."
<INSERT-FILE "books/station-minus-one/station-minus-one">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "" T>
 <ASSERT-TEXT "ARRIVAL MINUS ONE" <CO-RESUME ,CO "read arrivals board">>
 <ASSERT-TEXT "rail, not from anyone" <CO-RESUME ,CO "turn clock">>
 <ASSERT-TEXT "locked open" <CO-RESUME ,CO "open gates">>
 ;"The steps lead down; DOWN, UP and CLIMB all use them."
 <CO-RESUME ,CO "down">
 <ASSERT "down reaches the platform" <EQUAL? ,HERE ,LOWER-PLATFORM>>
 <CO-RESUME ,CO "up">
 <ASSERT "up returns to the hall" <EQUAL? ,HERE ,TICKET-HALL>>
 <CO-RESUME ,CO "climb steps">
 <ASSERT "climbing the hall steps goes down" <EQUAL? ,HERE ,LOWER-PLATFORM>>
 <ASSERT-TEXT "gauge room could tell you" <CO-RESUME ,CO "examine train">>
 <ASSERT-TEXT "yellow line" <CO-RESUME ,CO "examine platform edge">>
 <ASSERT-TEXT "behind the yellow line" <CO-RESUME ,CO "jump off platform">>
 <ASSERT-TEXT "platform bell" <CO-RESUME ,CO "examine bell">>
 <ASSERT-TEXT "dull note" <CO-RESUME ,CO "ring bell">>
 <ASSERT-TEXT "melted" <CO-RESUME ,CO "examine sleepers">>
 <ASSERT "nothing on the platform ends the story" <EQUAL? ,STATION-END 0>>
 <CO-RESUME ,CO "climb stairs">
 <ASSERT "climbing the platform steps goes up" <EQUAL? ,HERE ,TICKET-HALL>>
 <CO-RESUME ,CO "west">
 <ASSERT-TEXT "chair" <CO-RESUME ,CO "look under table">>
 <ASSERT-TEXT "faintly warm" <CO-RESUME ,CO "examine chair">>
 <ASSERT-TEXT "You sit" <CO-RESUME ,CO "sit on chair">>
 <ASSERT-TEXT "Both cups are empty" <CO-RESUME ,CO "drink tea">>
 <ASSERT-TEXT "dripping again" <CO-RESUME ,CO "turn tap">>
 <ASSERT-TEXT "A reflection weighs nothing" <CO-RESUME ,CO "read last entry">>
 <CO-RESUME ,CO "take puck">
 <ASSERT-TEXT "beside the logbook" <CO-RESUME ,CO "put puck on table">>
 <ASSERT "the puck is back in the staff room" <IN? ,TEST-PUCK ,STAFF-ROOM>>
 <CO-RESUME ,CO "take white disc">
 <ASSERT "the puck is carried" <IN? ,TEST-PUCK ,WINNER>>
 <CO-RESUME ,CO "east"> <CO-RESUME ,CO "east">
 <ASSERT-TEXT "rests at zero" <CO-RESUME ,CO "examine needle">>
 <CO-RESUME ,CO "put weight in cradle">
 <CO-RESUME ,CO "push button">
 <ASSERT "the comparison ran" ,LOOP-OBSERVED>
 <ASSERT-TEXT "full weight of a train" <CO-RESUME ,CO "examine window">>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "down">
 <ASSERT-TEXT "someone aboard" <CO-RESUME ,CO "examine train">>
 <ASSERT-TEXT "wheels standing still" <CO-RESUME ,CO "listen to train">>
 <ASSERT-TEXT "ENDING: THE EXTRA STOP" <CO-RESUME ,CO "push red switch">>>
