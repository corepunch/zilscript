<INSERT-FILE "books/last-broadcast/last-broadcast">
<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
	;"Contents are not exposed by a glance or by wishing hard enough."
	<SETG HERE ,LB-ARCHIVE> <MOVE ,WINNER ,HERE>
	<ASSERT-NOT-TEXT "lacquer disc" <CO-RESUME ,CO "look">>
	<CO-RESUME ,CO "take disc">
	<ASSERT "Unseen disc stays in sleeve" <IN? ,LB-DISC ,LB-SLEEVE>>
	<ASSERT-TEXT "reveals a lacquer disc" <CO-RESUME ,CO "open sleeve">>
	<CO-RESUME ,CO "take disc">
	<ASSERT "Default TAKE moves actual disc" <IN? ,LB-DISC ,WINNER>>
	<ASSERT-TEXT "It is empty" <CO-RESUME ,CO "examine sleeve">>
	<CO-RESUME ,CO "drop disc">
	<ASSERT "Default DROP moves actual disc" <IN? ,LB-DISC ,LB-ARCHIVE>>
	<ASSERT-NOT-TEXT "gull" <CO-RESUME ,CO "look">>
	<CO-RESUME ,CO "take disc">
	<CO-RESUME ,CO "close sleeve">
	<ASSERT "Default CLOSE clears physical state" <NOT <FSET? ,LB-SLEEVE ,OPENBIT>>>
	<ASSERT-TEXT "flap is folded tight" <CO-RESUME ,CO "examine sleeve">>

	;"Apparatus uses real containment; an explicit wrong tool never substitutes."
	<SETG HERE ,LB-CONTROL> <MOVE ,WINNER ,HERE>
	<MOVE ,LB-STYLUS ,WINNER> <MOVE ,LB-SPANNER ,WINNER>
	<CO-RESUME ,CO "use gramophone with spanner">
	<ASSERT "Wrong explicit tool leaves pickup bare" <NOT <IN? ,LB-STYLUS ,LB-PLAYER>>>
	<CO-RESUME ,CO "put disc in gramophone">
	<ASSERT "Native PUT places disc on player" <IN? ,LB-DISC ,LB-PLAYER>>
	<ASSERT-TEXT "pickup is bare" <CO-RESUME ,CO "play disc">>
	<ASSERT "No needle means no sound evidence" <NOT ,LB-SOUND>>
	<CO-RESUME ,CO "use gramophone with stylus">
	<ASSERT "Mounted stylus is physically in player" <IN? ,LB-STYLUS ,LB-PLAYER>>
	<CO-RESUME ,CO "take stylus">
	<ASSERT "Needle can actually be removed" <IN? ,LB-STYLUS ,WINNER>>
	<ASSERT-TEXT "pickup is bare" <CO-RESUME ,CO "play gramophone">>
	<CO-RESUME ,CO "use stylus on gramophone">
	<ASSERT-TEXT "gull coughs twice" <CO-RESUME ,CO "play gramophone">>
	<ASSERT "Correct apparatus establishes sound evidence" ,LB-SOUND>
	<CO-RESUME ,CO "take disc">
	<ASSERT-NOT-TEXT "rests on its platter" <CO-RESUME ,CO "examine gramophone">>

	;"The same hatch owns both directions, and nested tool scope is honest."
	<SETG HERE ,LB-OFFICE> <MOVE ,WINNER ,HERE>
	<CO-RESUME ,CO "down">
	<ASSERT "Hatch blocks office descent" <EQUAL? ,HERE ,LB-OFFICE>>
	<CO-RESUME ,CO "use disc on hatch">
	<ASSERT "Correct spanner held does not excuse wrong explicit disc" <NOT <FSET? ,LB-HATCH ,OPENBIT>>>
	<MOVE ,LB-BAG ,WINNER> <MOVE ,LB-SPANNER ,LB-BAG> <FCLEAR ,LB-BAG ,OPENBIT>
	<CO-RESUME ,CO "use hatch with spanner">
	<ASSERT "Closed carried bag prevents nested tool use" <NOT <FSET? ,LB-HATCH ,OPENBIT>>>
	<FSET ,LB-BAG ,OPENBIT>
	<CO-RESUME ,CO "use hatch with spanner">
	<ASSERT "Open nested held tool operates hatch" <FSET? ,LB-HATCH ,OPENBIT>>
	<CO-RESUME ,CO "down">
	<ASSERT "Open descent reaches passage" <EQUAL? ,HERE ,LB-PASSAGE>>
	<ASSERT-TEXT "open hatch" <CO-RESUME ,CO "look">>
	<CO-RESUME ,CO "close hatch">
	<CO-RESUME ,CO "up">
	<ASSERT "Same closed hatch blocks passage ascent" <EQUAL? ,HERE ,LB-PASSAGE>>
	<CO-RESUME ,CO "use spanner on hatch">
	<CO-RESUME ,CO "up">
	<ASSERT "Open ascent returns office" <EQUAL? ,HERE ,LB-OFFICE>>
	<CO-RESUME ,CO "close hatch">
	<ASSERT "Knowledge of route survives closing hatch" ,LB-ROUTE>

	;"A collection is not a reconstruction; wrong charges are recoverable."
	<SETG HERE ,LB-BUNKROOM> <MOVE ,WINNER ,HERE>
	<ASSERT-TEXT "reconstructed sequence" <CO-RESUME ,CO "accuse ada">>
	<ASSERT "Premature charge never wins" <NOT ,LB-WON>>
	<ASSERT-TEXT "still a gap" <CO-RESUME ,CO "reconstruct casebook">>
	<ASSERT "Incomplete casebook stays incomplete" <NOT ,LB-RECONSTRUCTED>>
	<SETG HERE ,LB-TELEGRAPH> <MOVE ,WINNER ,HERE>
	<ASSERT-TEXT "accusation fails" <CO-RESUME ,CO "accuse tomas">>
	<ASSERT "Wrong charge never ends case" <NOT ,LB-WON>>
	<ASSERT-TEXT "far-end stamps" <CO-RESUME ,CO "read receipt">>
	<ASSERT "Investigation continues after wrong charge" ,LB-RECEIPT-SEEN>
>
