<INSERT-FILE "books/wondertown/wondertown">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
	<ASSERT-TEXT "east" <CO-RESUME ,CO "look">>
	<ASSERT-TEXT "clock" <CO-RESUME ,CO "look">>
	<ASSERT-TEXT "ladder" <CO-RESUME ,CO "look">>
	<CO-RESUME ,CO "take string">
	<ASSERT "String is carried" <IN? ,KEY-STRING ,WINNER>>
	<ASSERT-NOT-TEXT "string" <CO-RESUME ,CO "look">>
	<ASSERT-NOT-TEXT "string dangles" <CO-RESUME ,CO "examine hook">>
	<ASSERT-NOT-TEXT "string dangling" <CO-RESUME ,CO "take hook">>
	<CO-RESUME ,CO "drop string">
	<ASSERT-TEXT "string" <CO-RESUME ,CO "look">>
	<ASSERT-NOT-TEXT "hangs" <CO-RESUME ,CO "look">>
	<CO-RESUME ,CO "examine workbench">
	<ASSERT-TEXT "oil can" <CO-RESUME ,CO "look under workbench">>
	<CO-RESUME ,CO "take oil can">
	<ASSERT-NOT-TEXT "oil can" <CO-RESUME ,CO "look under workbench">>
	<CO-RESUME ,CO "drop oil can">
	<ASSERT-TEXT "oil can" <CO-RESUME ,CO "look">>
	<ASSERT-NOT-TEXT "Underneath" <CO-RESUME ,CO "look under workbench">>
	<SETG HERE ,MAILBOX-CORNER>
	<MOVE ,WINNER ,MAILBOX-CORNER>
	<ASSERT-TEXT "west" <CO-RESUME ,CO "examine footprints">>
	<ASSERT-NOT-TEXT "east of the square" <CO-RESUME ,CO "ask mailbox about fox">>
	<SETG HERE ,SCRAP-YARD>
	<MOVE ,WINNER ,SCRAP-YARD>
	<ASSERT-TEXT "headless" <CO-RESUME ,CO "examine cart">>
	<CO-RESUME ,CO "examine piles">
	<CO-RESUME ,CO "take head">
	<CO-RESUME ,CO "give head to cart">
	<ASSERT "Given head belongs to cart" <IN? ,DOLL-HEAD ,SCRAP-CART>>
	<ASSERT "Given head no longer carried" <NOT <IN? ,DOLL-HEAD ,WINNER>>>
	<CO-RESUME ,CO "east">
	<ASSERT "Helping cart opens actual route" <EQUAL? ,HERE ,FOX-DEN>>
>
