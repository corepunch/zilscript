<INSERT-FILE "books/last-broadcast/last-broadcast">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<SETG HERE ,LB-OFFICE> <MOVE ,WINNER ,HERE>
	<ASSERT-NOT-TEXT "boots" <CO-RESUME ,CO "compare clock with casebook">>
	<ASSERT-NOT-TEXT "stain" <CO-RESUME ,CO "compare clock with casebook">>
	<ASSERT "An irrelevant comparison discovers no physical clue" <NOT ,LB-TRACE>>
>
