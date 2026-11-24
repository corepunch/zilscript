<ROUTINE SUGGEST-ACTIONS ()
 <COND (<IN? ,MESSAGE-SPOOL ,HERE>
  <CHOICE "museum.take-spool" "Take the spool marked for review" "take spool" ,CHOICE-PROGRESS 95>)>
 <COND (<OR <IN? ,MESSAGE-SPOOL ,HERE> <IN? ,MESSAGE-SPOOL ,WINNER> <AND <EQUAL? ,HERE ,SIGNAL-BOOTH> <IN? ,MESSAGE-SPOOL ,READING-BASIN>>>
  <CHOICE "museum.spool" "Look closely at the edge of the spool" "examine spool" ,CHOICE-INVESTIGATE 75>)>
 <COND (<EQUAL? ,HERE ,ADMISSIONS>
  <CHOICE "museum.plaque" "Read what the caretaker left on the plaque" "read plaque" ,CHOICE-INVESTIGATE 95>
  <CHOICE "museum.letters" "Walk to Dead Letters" "east" ,CHOICE-PROGRESS 90>
  <CHOICE-DETAILS "group" "move">
  <CHOICE "museum.quiet" "Step into the Quiet Hall" "west" ,CHOICE-INVESTIGATE 80>
  <CHOICE-DETAILS "group" "move">
  <CHOICE "museum.booth" "Walk to the signal booth" "north" ,CHOICE-PROGRESS 85>
  <CHOICE-DETAILS "group" "move">)
  (<EQUAL? ,HERE ,DEAD-LETTERS>
   <CHOICE "museum.lens" "Look through the inspection lens" "examine lens" ,CHOICE-INVESTIGATE 90>
   <COND (<NOT ,LENS-READ>
    <CHOICE "museum.turn-lens" "Tilt the brass lens toward the light" "tilt lens" ,CHOICE-PROGRESS 100>)>
   <CHOICE "museum.letters-back" "Return to admissions" "west" ,CHOICE-RETURN 60>
   <CHOICE-DETAILS "group" "move">)
  (<EQUAL? ,HERE ,QUIET-HALL>
   <CHOICE "museum.bench" "Look at the marks on the bench" "examine bench" ,CHOICE-INVESTIGATE 80>
   <CHOICE "museum.diagram" "Study where the old wires go" "read diagram" ,CHOICE-INVESTIGATE 95>
   <CHOICE "museum.quiet-back" "Return to admissions" "east" ,CHOICE-RETURN 60>
   <CHOICE-DETAILS "group" "move">)
  (<EQUAL? ,HERE ,SIGNAL-BOOTH>
   <CHOICE "museum.basin" "Examine the reading basin" "examine basin" ,CHOICE-INVESTIGATE 80>
   <CHOICE "museum.check-return" "Find out who would receive a reply" "examine return key" ,CHOICE-INVESTIGATE 82>
   <CHOICE "museum.check-memorial" "Find out what the memorial feed would send" "examine memorial key" ,CHOICE-INVESTIGATE 81>
   <COND (<IN? ,MESSAGE-SPOOL ,WINNER>
     <CHOICE "museum.load" "Set the spool into the reading basin" "put spool in basin" ,CHOICE-PROGRESS 100>)
    (<IN? ,MESSAGE-SPOOL ,READING-BASIN>
     <CHOICE "museum.audition" "Hear the spool inside the booth" "push stud" ,CHOICE-PROGRESS 99>
     <CHOICE "museum.recover" "Lift the spool out of the basin" "take spool" ,CHOICE-INVESTIGATE 64>)>
   <COND (,SIGNAL-HEARD
    <CHOICE "museum.reply" "Send a private acknowledgment" "push return key" ,CHOICE-PROGRESS 100>
    <CHOICE "museum.memorial" "Share the recorded minute of silence, without the voice" "push memorial key" ,CHOICE-PROGRESS 99>)>
   <CHOICE "museum.booth-back" "Return to admissions" "south" ,CHOICE-RETURN 60>
   <CHOICE-DETAILS "group" "move">)>>
