<INSERT-FILE "books/blackwood-horror/blackwood-horror">

<GLOBAL CO <CO-CREATE GO>>

;"What is written on a thing, or shut inside one, is learned by examining it
  (Zork I prints the leaflet only when it is read, and lists the mailbox's
  contents only once it is open). GO BACK retraces the last step."

<ROUTINE RUN-TEST ()
    <ASSERT "Start at Sanitarium Gate" <CO-RESUME ,CO "look" T> <==? ,HERE ,SANITARIUM-GATE>>
    <ASSERT-TEXT "retrace" <CO-RESUME ,CO "go back">>
    <ASSERT "A refused GO BACK leaves the player in place" <==? ,HERE ,SANITARIUM-GATE>>
    <ASSERT-NOT-TEXT "[[" <CO-RESUME ,CO "look">>
    <ASSERT "Enter the entrance hall" <CO-RESUME ,CO "north" T> <==? ,HERE ,SANITARIUM-ENTRANCE>>
    <ASSERT "GO BACK returns to the gate" <CO-RESUME ,CO "go back" T> <==? ,HERE ,SANITARIUM-GATE>>
    <ASSERT "GO BACK again returns to the hall" <CO-RESUME ,CO "walk back" T> <==? ,HERE ,SANITARIUM-ENTRANCE>>

    <ASSERT "Go to Operating Theater" <CO-RESUME ,CO "north" T> <==? ,HERE ,OPERATING-THEATER>>
    <ASSERT-TEXT "slightly ajar" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "scalpel" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "contains" <CO-RESUME ,CO "look">>
    <ASSERT "The scalpel cannot be taken unseen" <CO-RESUME ,CO "take scalpel" T> <==? <LOC ,SCALPEL> ,METAL-CABINET>>
    <ASSERT-TEXT "scalpel" <CO-RESUME ,CO "examine cabinet">>
    <ASSERT "Examining the cabinet opens it" <FSET? ,METAL-CABINET ,OPENBIT>>
    <ASSERT-TEXT "rusty scalpel" <CO-RESUME ,CO "look">>
    <ASSERT "Take scalpel" <CO-RESUME ,CO "take scalpel" T> <==? <LOC ,SCALPEL> ,ADVENTURER>>
    <ASSERT-TEXT "slightly ajar" <CO-RESUME ,CO "close cabinet">>
    <ASSERT-NOT-TEXT "ether" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "bottle" <CO-RESUME ,CO "open cabinet">>

    <ASSERT "Back to the hall" <CO-RESUME ,CO "back" T> <==? ,HERE ,SANITARIUM-ENTRANCE>>
    <ASSERT "Go to Patient Ward" <CO-RESUME ,CO "east" T> <==? ,HERE ,PATIENT-WARD>>
    <ASSERT-TEXT "crayon drawing" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "HOME" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "HOME" <CO-RESUME ,CO "examine drawing">>>
