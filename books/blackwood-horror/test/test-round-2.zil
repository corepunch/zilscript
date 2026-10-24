<INSERT-FILE "books/blackwood-horror/blackwood-horror">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
	<CO-RESUME ,CO "look">
	<SETG HERE ,OPERATING-THEATER> <MOVE ,WINNER ,HERE>
	<CO-RESUME ,CO "open metal cabinet">
	<ASSERT-TEXT "Handle with Care" <CO-RESUME ,CO "examine ether bottle">>
	<ASSERT-TEXT "Taken" <CO-RESUME ,CO "take ether bottle">>
	<CO-RESUME ,CO "drop ether bottle">
	<SETG HERE ,STORAGE-ROOM> <MOVE ,WINNER ,HERE>
	<CO-RESUME ,CO "examine shelves">
	<CO-RESUME ,CO "open medical bag">
	<ASSERT-TEXT "Morphine Sulfate" <CO-RESUME ,CO "examine glass vial">>
	<ASSERT "Examining shelf contents does not move the bag" <IN? ,MEDICAL-BAG ,SHELVES>>
	<ASSERT-TEXT "Taken" <CO-RESUME ,CO "take glass vial">>
	<CO-RESUME ,CO "drop glass vial">
	<MOVE ,PATIENT-FILE ,WINNER>
	<ASSERT-TEXT "unusual resistance to sedation" <CO-RESUME ,CO "read medical records">>
	<CO-RESUME ,CO "drop medical records">
	<CO-RESUME ,CO "drop patient file">
	<ASSERT-TEXT "Taken" <CO-RESUME ,CO "take oil lantern">>
	<ASSERT-TEXT "Once lit" <CO-RESUME ,CO "examine oil lantern">>
	<CO-RESUME ,CO "turn on oil lantern">
	<ASSERT "Lit lantern has both native flame flags" <AND <FSET? ,OIL-LANTERN ,FLAMEBIT> <FSET? ,OIL-LANTERN ,ONBIT>>>
	<CO-RESUME ,CO "east">
	<ASSERT-TEXT "no steam" <CO-RESUME ,CO "turn metal valve">>
	<ASSERT "Plain valve turn changes its state" ,VALVE-TURNED-FLAG>
	<CO-RESUME ,CO "north">
	<ASSERT-TEXT "cold" <CO-RESUME ,CO "open sealed door">>
	<ASSERT "Valve alone cannot heat the sealed door" <NOT ,STEAM-DOOR-OPEN>>
	<CO-RESUME ,CO "south">
	<CO-RESUME ,CO "east">
	<CO-RESUME ,CO "examine boiler">
	<CO-RESUME ,CO "take shovel">
	<CO-RESUME ,CO "examine bin">
	<CO-RESUME ,CO "take coal">
	<CO-RESUME ,CO "put coal in boiler">
	<CO-RESUME ,CO "take coal">
	<ASSERT "Taking cold coal removes the actual fuel" <IN? ,LUMP-OF-COAL ,WINNER>>
	<ASSERT-TEXT "needs coal first" <CO-RESUME ,CO "kindle boiler with lantern">>
	<ASSERT "Remembered fueling cannot bypass missing coal" <NOT ,BOILER-LIT>>
	<CO-RESUME ,CO "put coal in boiler">
	<ASSERT-TEXT "deep metallic thud" <CO-RESUME ,CO "kindle iron boiler with oil lantern">>
	<ASSERT "Kindling lights the boiler" ,BOILER-LIT>
	<ASSERT-TEXT "burning coal" <CO-RESUME ,CO "take coal">>
	<ASSERT "A lit boiler keeps its burning fuel" <IN? ,LUMP-OF-COAL ,IRON-BOILER>>
	<SETG BOILER-LIT <>>
	<ASSERT-TEXT "deep metallic thud" <CO-RESUME ,CO "turn on iron boiler with oil lantern">>
	<ASSERT "Instrument dispatch does not consume the boiler action" ,BOILER-LIT>
	<CO-RESUME ,CO "drop shovel">
	<SETG HERE ,DIRECTORS-OFFICE> <MOVE ,WINNER ,HERE>
	<CO-RESUME ,CO "take red book">
	<CO-RESUME ,CO "move portrait">
	<ASSERT-TEXT "need the key" <CO-RESUME ,CO "open wall safe">>
	<ASSERT "A key hidden in a closed carried book cannot bypass the gate" <NOT <FSET? ,WALL-SAFE ,OPENBIT>>>
	<CO-RESUME ,CO "open red book">
	<ASSERT-TEXT "unlock" <CO-RESUME ,CO "open wall safe with safe key">>
	<ASSERT "A reachable key inside a carried open book works" <FSET? ,WALL-SAFE ,OPENBIT>>
	<ASSERT "Unlocking leaves the actual key in its book" <IN? ,SAFE-KEY ,HOLLOW-BOOK>>
	<ASSERT-TEXT "transcended death" <CO-RESUME ,CO "read private notes">>
	<ASSERT-TEXT "already open" <CO-RESUME ,CO "open wall safe">>
>
