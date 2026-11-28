<INSERT-FILE "books/blackwood-horror/blackwood-horror">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
	<CO-RESUME ,CO "look">
	<SETG HERE ,CHAPEL> <MOVE ,WINNER ,HERE>
	<ASSERT-TEXT "south" <CO-RESUME ,CO "look">>
	<CO-RESUME ,CO "south">
	<ASSERT "The chapel return reaches the garden" <==? ,HERE ,OVERGROWN-GARDEN>>
	<SETG HERE ,BASEMENT-CORRIDOR> <MOVE ,WINNER ,HERE>
	<SETG BOILER-LIT <>> <SETG VALVE-TURNED-FLAG <>>
	<ASSERT-TEXT "no steam" <CO-RESUME ,CO "turn pipe valve">>
	<ASSERT-NOT-TEXT "Steam hisses" <CO-RESUME ,CO "look">>
	<ASSERT "Opening a cold valve does not light the boiler" <NOT ,BOILER-LIT>>
	<SETG BOILER-LIT T>
	<ASSERT-TEXT "Steam hisses" <CO-RESUME ,CO "look">>
	<SETG HERE ,PATIENT-WARD> <MOVE ,WINNER ,HERE>
	<MOVE ,SCALPEL ,WINNER>
	<ASSERT-TEXT "leather" <CO-RESUME ,CO "examine chains">>
	<CO-RESUME ,CO "cut chains with scalpel">
	<ASSERT "Cutting the fastening opens the actual morgue gate" ,CHAINS-CUT-FLAG>
	<ASSERT "The fastening is removed after cutting" <NOT <LOC ,CHAINS>>>
	<SETG HERE ,MORGUE> <MOVE ,WINNER ,HERE>
	<MOVE ,MORPHINE-VIAL ,WINNER>
	<ASSERT-TEXT "glowing serum" <CO-RESUME ,CO "open refrigerated drawers">>
	<ASSERT-TEXT "Compound 237" <CO-RESUME ,CO "examine glowing serum">>
	<ASSERT-TEXT "Morphine Sulfate" <CO-RESUME ,CO "examine morphine">>
	<ASSERT "Examining either vial preserves the morphine" <IN? ,MORPHINE-VIAL ,WINNER>>
	<ASSERT "Examining either vial preserves the serum" <IN? ,STRANGE-SERUM ,REFRIGERATED-DRAWERS>>
	<SETG HERE ,STORAGE-ROOM> <MOVE ,WINNER ,HERE>
	<CO-RESUME ,CO "search shelves">
	<ASSERT-TEXT "refrigerated morgue drawers" <CO-RESUME ,CO "read medical records">>
	<ASSERT "The storage instruction points to the serum's actual location" <IN? ,STRANGE-SERUM ,REFRIGERATED-DRAWERS>>
	<MOVE ,MORDECAI-NOTES ,WINNER>
	<ASSERT-TEXT "second dose" <CO-RESUME ,CO "read private notes">>
	<SETG HERE ,CHAPEL> <MOVE ,WINNER ,HERE>
	<ASSERT-TEXT "Mordecai's" <CO-RESUME ,CO "tell patient about private notes">>
	<ASSERT-NOT-TEXT "manual" <CO-RESUME ,CO "tell patient about scalpel">>
	<ASSERT "Conversation cannot bypass the prepared ending" <NOT ,GAME-WON>>
>
