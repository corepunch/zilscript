<INSERT-FILE "books/en/museum-unsent-signals/museum-unsent-signals">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "" T>
 <ASSERT-TEXT "forty years" <CO-RESUME ,CO "read plaque">>
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "take them for damage" <CO-RESUME ,CO "examine spool">>
 <CO-RESUME ,CO "take spool"> <CO-RESUME ,CO "west"> <CO-RESUME ,CO "north">
 <ASSERT-TEXT "Load the wooden spool" <CO-RESUME ,CO "push stud">>
 <CO-RESUME ,CO "put spool in basin">
 <ASSERT "playing medium is in the basin" <IN? ,MESSAGE-SPOOL ,READING-BASIN>>
 <ASSERT-TEXT "asks for the kind of address" <CO-RESUME ,CO "push stud">>
 <ASSERT "audition alone cannot authorize routing" <NOT ,SIGNAL-HEARD>>
 <ASSERT-TEXT "The keys stay dark" <CO-RESUME ,CO "push return key">>
 <CO-RESUME ,CO "south"> <CO-RESUME ,CO "west">
 <ASSERT-TEXT "not the spool itself" <CO-RESUME ,CO "read diagram">>
 <CO-RESUME ,CO "east"> <CO-RESUME ,CO "east">
 <ASSERT-TEXT "tilt it" <CO-RESUME ,CO "examine lens">>
 <ASSERT "examining the lens is not tilting it" <NOT ,LENS-READ>>
 <ASSERT-TEXT "RETURN ONLY" <CO-RESUME ,CO "tilt lens">>
 <ASSERT "turned lens exposed the legend" ,LENS-READ>
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "north">
 <ASSERT-TEXT "private return register" <CO-RESUME ,CO "push audition stud">>
 <ASSERT "routing is unlocked after replay" ,SIGNAL-HEARD>
 <ASSERT-TEXT "ENDING: PRIVATE RETURN" <CO-RESUME ,CO "push return key">>
 <ASSERT "private destination" <EQUAL? ,MUSEUM-END 1>>
 <ASSERT-TEXT "closing for good" <CO-RESUME ,CO "restart">>
 <ASSERT "restart clears lens and audition" <NOT <OR ,LENS-READ ,SIGNAL-HEARD>>>
 <ASSERT "restart restores spool" <IN? ,MESSAGE-SPOOL ,DEAD-LETTERS>>
 <CO-RESUME ,CO "east"> <CO-RESUME ,CO "tilt lens"> <CO-RESUME ,CO "take spool">
 <CO-RESUME ,CO "west"> <CO-RESUME ,CO "north"> <CO-RESUME ,CO "put spool in basin"> <CO-RESUME ,CO "push stud">
 <ASSERT-TEXT "minute without the voice" <CO-RESUME ,CO "push memorial key">>
 <ASSERT "public quiet not private reply" <EQUAL? ,MUSEUM-END 2>>>
