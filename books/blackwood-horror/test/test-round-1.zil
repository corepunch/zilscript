<INSERT-FILE "books/blackwood-horror/blackwood-horror">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
	<CO-RESUME ,CO "look">
	<CO-RESUME ,CO "north">
	<ASSERT-TEXT "gates lie south" <CO-RESUME ,CO "look">>
	<CO-RESUME ,CO "north">
	<ASSERT-TEXT "doorway south" <CO-RESUME ,CO "look">>
	<CO-RESUME ,CO "south">
	<ASSERT-TEXT "wedged" <CO-RESUME ,CO "close door">>
	<CO-RESUME ,CO "north">
	<ASSERT-TEXT "scalpel" <CO-RESUME ,CO "open cabinet">>
	<CO-RESUME ,CO "take scalpel">
	<ASSERT "There is one scalpel, carried after discovery" <IN? ,SCALPEL ,WINNER>>
	<ASSERT-NOT-TEXT "a scalpel" <CO-RESUME ,CO "examine cabinet">>
	<CO-RESUME ,CO "south">
	<CO-RESUME ,CO "west">
	<ASSERT-TEXT "number 3" <CO-RESUME ,CO "examine desk">>
	<ASSERT-TEXT "need a key" <CO-RESUME ,CO "open drawer">>
	<CO-RESUME ,CO "examine papers">
	<CO-RESUME ,CO "take key">
	<CO-RESUME ,CO "open drawer">
	<ASSERT "Opening the drawer changes actual state" <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
	<ASSERT-TEXT "stands open" <CO-RESUME ,CO "examine desk">>
	<ASSERT-NOT-TEXT "locked" <CO-RESUME ,CO "examine desk">>
	<CO-RESUME ,CO "east">
	<CO-RESUME ,CO "down">
	<CO-RESUME ,CO "down">
	<ASSERT-TEXT "working light" <CO-RESUME ,CO "north">>
	<ASSERT "The unlit flooded passage leaves the player safe" <==? ,HERE ,BASEMENT-CORRIDOR>>
	<CO-RESUME ,CO "west">
	<CO-RESUME ,CO "examine shelves">
	<CO-RESUME ,CO "take lantern">
	<ASSERT-TEXT "striker" <CO-RESUME ,CO "examine lantern">>
	<CO-RESUME ,CO "turn on lantern">
	<ASSERT "The lantern actually emits light" <FSET? ,OIL-LANTERN ,ONBIT>>
	<CO-RESUME ,CO "east">
	<CO-RESUME ,CO "north">
	<ASSERT "A working light admits the flooded chamber" <==? ,HERE ,FLOODING-CHAMBER>>
	<CO-RESUME ,CO "south">
	<ASSERT "The flooded chamber's return route works" <==? ,HERE ,BASEMENT-CORRIDOR>>
	;"After an item leaves a container, examination must not conjure it back."
	<SETG HERE ,RECEPTION-ROOM> <MOVE ,WINNER ,HERE>
	<CO-RESUME ,CO "take ledger">
	<CO-RESUME ,CO "take file">
	<ASSERT-TEXT "empty" <CO-RESUME ,CO "examine drawer">>
	<ASSERT "Taking the ledger leaves the drawer open" <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
	<SETG HERE ,CAFETERIA> <MOVE ,WINNER ,HERE>
	<CO-RESUME ,CO "take bell">
	<ASSERT "The sole bell is carried" <IN? ,BELL ,WINNER>>
	<ASSERT-NOT-TEXT "bell" <CO-RESUME ,CO "examine counter">>
	<SETG HERE ,HYDROTHERAPY-ROOM> <MOVE ,WINNER ,HERE>
	<SETG CABINET-THAWED T>
	<CO-RESUME ,CO "open cabinet">
	<CO-RESUME ,CO "take syringe">
	<ASSERT "The sole syringe is carried" <IN? ,SYRINGE ,WINNER>>
	<ASSERT-NOT-TEXT "syringe" <CO-RESUME ,CO "examine cabinet">>
>
