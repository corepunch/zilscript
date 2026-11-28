<INSERT-FILE "books/en/house-of-the-ebb/house-of-the-ebb">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "look" T>
 <ASSERT-TEXT "second pair of boots" <CO-RESUME ,CO "listen">>
 <ASSERT-TEXT "smell of home" <CO-RESUME ,CO "smell">>
 <CO-RESUME ,CO "enter house">
 <ASSERT "entering the lit house arrives in its waiting hall" <EQUAL? ,HERE ,HALL>>
 <ASSERT-TEXT "never hear it hit the floor" <CO-RESUME ,CO "listen to bag">>
 <CO-RESUME ,CO "climb stairs">
 <ASSERT "climbing the stairs reaches the landing" <EQUAL? ,HERE ,LANTERN-LANDING>>
 <CO-RESUME ,CO "climb down ladder">
 <ASSERT "going down at the foot of a ladder does not go up" <EQUAL? ,HERE ,LANTERN-LANDING>>
 <CO-RESUME ,CO "climb ladder">
 <ASSERT "climbing the ladder continues to the lantern" <EQUAL? ,HERE ,LANTERN>>
 <CO-RESUME ,CO "open shutter">
 <ASSERT-TEXT "a lucky turn won't" <CO-RESUME ,CO "turn lens">>
 <ASSERT "clues cannot be bypassed" <NOT ,LENS-READY>>
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "Not into a dark sea" <CO-RESUME ,CO "ring bell">>
 <ASSERT "the wild bell stroke does not end the story" <NOT ,EBB-ENDING>>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "down">
 <CO-RESUME ,CO "read plate">
 <CO-RESUME ,CO "south"> <CO-RESUME ,CO "west">
 <ASSERT-TEXT "K. R." <CO-RESUME ,CO "look under mug">>
 <ASSERT "looking under the mug discovers the hidden initials" ,MUG-SEEN>
 <ASSERT-TEXT "fainter one" <CO-RESUME ,CO "knock on mug">>
 <CO-RESUME ,CO "east"> <CO-RESUME ,CO "east">
 <CO-RESUME ,CO "read tally">
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "north"> <CO-RESUME ,CO "up">
 <CO-RESUME ,CO "turn lens">
 <CO-RESUME ,CO "down"> <CO-RESUME ,CO "south"> <CO-RESUME ,CO "south">
 <ASSERT-TEXT "no second set of steps" <CO-RESUME ,CO "listen">>
 <CO-RESUME ,CO "north"> <CO-RESUME ,CO "north"> <CO-RESUME ,CO "up"> <CO-RESUME ,CO "east">
 <ASSERT-TEXT "teeth almost closing" <CO-RESUME ,CO "listen to brake">>
 <ASSERT "inspection of the brake is not the final choice" <NOT ,EBB-ENDING>>
 <ASSERT-TEXT "THE END: THE LIGHT STAYS" <CO-RESUME ,CO "pull brake">>>
