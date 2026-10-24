<INSERT-FILE "books/limehouse-killings/limehouse-killings">
<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
	;"Blind round 3: an opened, emptied roll was still described as neatly tied."
	<SETG HERE ,KITCHEN> <MOVE ,WINNER ,KITCHEN>
	<FSET ,DRAWER ,OPENBIT>
	<CO-RESUME ,CO "open leather roll">
	<CO-RESUME ,CO "take lockpick set">
	<ASSERT "The roll remains open" <FSET? ,LEATHER-ROLL ,OPENBIT>>
	<ASSERT "The picks are carried" <IN? ,LOCKPICK-SET ,WINNER>>
	<ASSERT-NOT-TEXT "neatly tied" <CO-RESUME ,CO "look">>

	;"Unlocking the normal entrance before the ribbon puzzle must be respected."
	<SETG HERE ,LIBRARY> <MOVE ,WINNER ,LIBRARY>
	<MOVE ,TORN-PAGE ,WINNER>
	<SETG STUDY-UNLOCKED T> <FSET ,STUDY-DOOR ,OPENBIT>
	<SETG CIPHER-SOLVED <>>
	<SETG CIPHER-STAGE 3>
	<ASSERT-NOT-TEXT "locked hall door" <CO-RESUME ,CO "push blue book">>
	<ASSERT "The alternate route opens" ,CIPHER-SOLVED>
	<ASSERT "The normal door stays open" <FSET? ,STUDY-DOOR ,OPENBIT>>

	;"All three texts had been read, but an unstated comparison still blocked the box."
	<SETG HERE ,STUDY> <MOVE ,WINNER ,STUDY>
	<SETG DEAD-LETTER-FOUND T> <SETG SECRET-LEDGER-FOUND T>
	<SETG POISON-BOTTLE-FOUND T> <SETG POISON-IDENTIFIED <>>
	<ASSERT-TEXT "Compare the poison bottle" <CO-RESUME ,CO "turn locked box to moriarty">>
	<ASSERT "A hint cannot bypass the missing comparison" <NOT ,LOCKED-BOX-OPENED>>
	<SETG POISON-IDENTIFIED T>
	<ASSERT-TEXT "box opens" <CO-RESUME ,CO "turn locked box to moriarty">>
	<ASSERT "The complete evidence still opens the box" ,LOCKED-BOX-OPENED>
	<ASSERT "There is only one bank statement, inside the box" <IN? ,BANK-STATEMENT ,LOCKED-BOX>>
	;"Lestrade compares five hundred pounds in both records; both must show it."
	<ASSERT-TEXT "£500" <CO-RESUME ,CO "read bank statement">>
>
