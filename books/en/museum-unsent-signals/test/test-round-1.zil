;"QA round 1: words the prose uses, the front door, the bench, the
  address indicator, a second tilt, and putting the spool back."
<INSERT-FILE "books/en/museum-unsent-signals/museum-unsent-signals">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "" T>
 ;"The caretaker's note is taped under the brass plaque."
 <ASSERT-TEXT "forty years" <CO-RESUME ,CO "read note">>
 <ASSERT-TEXT "forty years" <CO-RESUME ,CO "examine brass plaque">>
 <ASSERT-TEXT "LAST NIGHT" <CO-RESUME ,CO "examine stamp">>
 <ASSERT-TEXT "locked for the night" <CO-RESUME ,CO "open door">>
 <ASSERT-NOT-TEXT "how to do that" <CO-RESUME ,CO "open front door">>
 <CO-RESUME ,CO "west">
 <ASSERT-TEXT "two hollows" <CO-RESUME ,CO "sit on bench">>
 <ASSERT-TEXT "MEMORIAL FEED" <CO-RESUME ,CO "examine thin line">>
 <CO-RESUME ,CO "east"> <CO-RESUME ,CO "east">
 <ASSERT-TEXT "BLANK" <CO-RESUME ,CO "examine catalogue card">>
 <ASSERT-TEXT "apology" <CO-RESUME ,CO "examine wax cylinder">>
 <ASSERT-TEXT "take them for damage" <CO-RESUME ,CO "examine cuts">>
 ;"TURN reaches the lens without asking for a second object."
 <ASSERT-TEXT "RETURN ONLY" <CO-RESUME ,CO "turn lens">>
 <ASSERT "turning the lens reads it" ,LENS-READ>
 <ASSERT-TEXT "already tilted" <CO-RESUME ,CO "tilt lens">>
 <ASSERT-NOT-TEXT "invisible a moment ago" <CO-RESUME ,CO "adjust lens">>
 <ASSERT-TEXT "exactly the mark the lens described" <CO-RESUME ,CO "examine edge">>
 <CO-RESUME ,CO "take spool">
 <ASSERT-TEXT "signal booth" <CO-RESUME ,CO "put spool in case">>
 <ASSERT "the spool stays in hand" <IN? ,MESSAGE-SPOOL ,WINNER>>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "north">
 <ASSERT-TEXT "under the desk" <CO-RESUME ,CO "examine cables">>
 <ASSERT-TEXT "small speaker" <CO-RESUME ,CO "examine speaker">>
 <ASSERT-TEXT "PUBLIC OR PRIVATE" <CO-RESUME ,CO "examine counter">>
 <CO-RESUME ,CO "put spool in basin">
 <ASSERT-TEXT "address indicator" <CO-RESUME ,CO "push stud">>
 <ASSERT-TEXT "PRIVATE RETURN REGISTER" <CO-RESUME ,CO "read indicator">>
 <ASSERT-TEXT "takes no answer" <CO-RESUME ,CO "push indicator">>
 <ASSERT "the indicator sends nothing" <EQUAL? ,MUSEUM-END 0>>
 <ASSERT-TEXT "ENDING: A MINUTE FOR THE LIVING" <CO-RESUME ,CO "push right key">>>
