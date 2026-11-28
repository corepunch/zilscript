<INSERT-FILE "books/en/blackwood-horror/blackwood-horror">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "look" T>
 <ASSERT-TEXT "wet leaves" <CO-RESUME ,CO "smell tree">>
 <ASSERT-TEXT "gate shudders" <CO-RESUME ,CO "climb gate">>
 <ASSERT "climbing does not silently move the player" <EQUAL? ,HERE ,SANITARIUM-GATE>>
 <CO-RESUME ,CO "enter sanitarium">
 <ASSERT "entering the named building follows its open entrance" <EQUAL? ,HERE ,SANITARIUM-ENTRANCE>>
 <ASSERT-TEXT "settles back" <CO-RESUME ,CO "peel wallpaper">>
 <CO-RESUME ,CO "enter door">
 <ASSERT "the jammed door is open enough to walk through" <EQUAL? ,HERE ,OPERATING-THEATER>>
 <CO-RESUME ,CO "enter door">
 <ASSERT "the same passage leads back from the theater" <EQUAL? ,HERE ,SANITARIUM-ENTRANCE>>
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "still bound shut" <CO-RESUME ,CO "enter heavy door">>
 <ASSERT "entering the chained door cannot bypass the ward puzzle" <EQUAL? ,HERE ,PATIENT-WARD>>
 <CO-RESUME ,CO "west">
 <CO-RESUME ,CO "west">
 <CO-RESUME ,CO "search papers">
 <CO-RESUME ,CO "take reception key">
 <CO-RESUME ,CO "open drawer">
 <CO-RESUME ,CO "take ledger">
 <CO-RESUME ,CO "take file">
 <CO-RESUME ,CO "close drawer">
 <ASSERT "closing hides the drawer interior" <NOT <FSET? ,BOTTOM-DRAWER ,OPENBIT>>>
 <CO-RESUME ,CO "drop reception key">
 <ASSERT-TEXT "It is empty." <CO-RESUME ,CO "open drawer">>
 <ASSERT "closing the unlocked drawer did not relock it" <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
 ;"The long walkthrough checks the discovery route to this safe."
 <SETG HERE ,DIRECTORS-OFFICE> <MOVE ,WINNER ,HERE>
 <FCLEAR ,WALL-SAFE ,INVISIBLE> <MOVE ,SAFE-KEY ,WINNER>
 <CO-RESUME ,CO "open safe">
 <CO-RESUME ,CO "take private notes">
 <CO-RESUME ,CO "take chapel key">
 <ASSERT-TEXT "bolt is still drawn back" <CO-RESUME ,CO "close safe">>
 <ASSERT "closing hides the safe interior" <NOT <FSET? ,WALL-SAFE ,OPENBIT>>>
 <CO-RESUME ,CO "drop safe key">
 <ASSERT-TEXT "It is empty." <CO-RESUME ,CO "open safe">>
 <ASSERT "closing the unlocked safe did not relock it" <FSET? ,WALL-SAFE ,OPENBIT>>>
