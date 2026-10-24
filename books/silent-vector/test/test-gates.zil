<INSERT-FILE "books/silent-vector/silent-vector">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<CO-RESUME ,CO "look" T>
	<ASSERT-TEXT "interlock holds" <CO-RESUME ,CO "north">>
	<ASSERT "power gate" <EQUAL? ,HERE ,CRADLE>>
	<CO-RESUME ,CO "push breaker" T>
	<CO-RESUME ,CO "north" T>
	<CO-RESUME ,CO "west" T>
	<CO-RESUME ,CO "take wrench" T>
	<CO-RESUME ,CO "take spool" T>
	<CO-RESUME ,CO "drop wrench" T>
	<ASSERT "drop falls through" <IN? ,WRENCH ,WORKSHOP>>
	<CO-RESUME ,CO "take wrench" T>
	<ASSERT "take falls through" <IN? ,WRENCH ,ADVENTURER>>
	<CO-RESUME ,CO "east" T>
	<CO-RESUME ,CO "east" T>
	<CO-RESUME ,CO "east" T>
	<ASSERT-NOT-TEXT "witness strip" <CO-RESUME ,CO "look">>
	<CO-RESUME ,CO "take strip" T>
	<ASSERT "unseen foil not taken" <IN? ,STRIP ,RECORDER>>
	<CO-RESUME ,CO "open recorder" T>
	<CO-RESUME ,CO "take strip" T>
	<CO-RESUME ,CO "close recorder" T>
	<ASSERT "close default" <NOT <FSET? ,RECORDER ,OPENBIT>>>
	<ASSERT-TEXT "drum is empty" <CO-RESUME ,CO "open recorder">>
	<CO-RESUME ,CO "west" T>
	<ASSERT-TEXT "laboratory first" <CO-RESUME ,CO "show strip to ivo">>
	<ASSERT "consent needs proof" <NOT ,CONSENT>>
	<CO-RESUME ,CO "west" T>
	<CO-RESUME ,CO "north" T>
	<CO-RESUME ,CO "take shears" T>
	<ASSERT-TEXT "error correction" <CO-RESUME ,CO "ask mara about signal">>
	<CO-RESUME ,CO "north" T>
	<CO-RESUME ,CO "east" T>
	<ASSERT-TEXT "interlock requires" <CO-RESUME ,CO "north">>
	<ASSERT "core gate" <EQUAL? ,HERE ,QUARANTINE>>
	<CO-RESUME ,CO "west" T>
	<ASSERT-TEXT "Four breath loads" <CO-RESUME ,CO "compare comparator with strip">>
	<ASSERT-TEXT "still resolves to four" <CO-RESUME ,CO "compare strip with comparator">>
	<CO-RESUME ,CO "south" T>
	<CO-RESUME ,CO "south" T>
	<CO-RESUME ,CO "down" T>
	<CO-RESUME ,CO "west" T>
	<ASSERT-TEXT "calibrated torque wrench" <CO-RESUME ,CO "turn pump with shears">>
	<ASSERT "wrong tool cannot repair" <NOT ,COOLING>>
	<ASSERT-TEXT "calibrated click" <CO-RESUME ,CO "turn pump with wrench">>
	<ASSERT-TEXT "already seated" <CO-RESUME ,CO "turn pump with wrench">>
	<CO-RESUME ,CO "east" T>
	<CO-RESUME ,CO "east" T>
	<ASSERT-TEXT "wrong tool" <CO-RESUME ,CO "cut bus with wrench">>
	<ASSERT-TEXT "Fit the null spool" <CO-RESUME ,CO "cut bus with shears">>
	<ASSERT "cut cannot bypass termination" <NOT ,ISOLATED>>
	<ASSERT-TEXT "Only the null spool" <CO-RESUME ,CO "fit wrench to bus">>
	<ASSERT "wrong part cannot terminate" <NOT ,TERMINATED>>
	<ASSERT-TEXT "Use FIT" <CO-RESUME ,CO "put spool in bus">>
	<ASSERT "loose storage cannot strand spool" <IN? ,SPOOL ,ADVENTURER>>
	<CO-RESUME ,CO "north" T>
	<ASSERT-TEXT "live housing" <CO-RESUME ,CO "open receiver">>
	<ASSERT "receiver remains closed" <NOT <FSET? ,RECEIVER ,OPENBIT>>>
	<CO-RESUME ,CO "south" T>
	<CO-RESUME ,CO "fit spool to bus" T>
	<ASSERT "fitting moves actual part" <IN? ,SPOOL ,BUS>>
	<ASSERT-TEXT "already fitted" <CO-RESUME ,CO "fit spool to bus">>
	<ASSERT-TEXT "not a box" <CO-RESUME ,CO "close bus">>
	<ASSERT "fitting scope stays accessible" <FSET? ,BUS ,OPENBIT>>
	<ASSERT-TEXT "Leave it there" <CO-RESUME ,CO "take spool">>
	<CO-RESUME ,CO "cut bus with shears" T>
	<ASSERT "isolation succeeds" ,ISOLATED>
	<ASSERT-TEXT "already severed" <CO-RESUME ,CO "cut bus with shears">>
	<CO-RESUME ,CO "north" T>
	<CO-RESUME ,CO "open receiver" T>
	<CO-RESUME ,CO "take wafer" T>
	<ASSERT "only actual sample moves" <IN? ,WAFER ,ADVENTURER>>
	<ASSERT-TEXT "open and empty" <CO-RESUME ,CO "open receiver">>
	<ASSERT-NOT-TEXT "still warm" <CO-RESUME ,CO "open receiver">>>
