<INSERT-FILE "books/last-broadcast/last-broadcast">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<SETG HERE ,LB-KITCHEN> <MOVE ,WINNER ,HERE>
	<ASSERT-NOT-TEXT "recording" <CO-RESUME ,CO "accuse edith">>
	<ASSERT-NOT-TEXT "repaired heel" <CO-RESUME ,CO "accuse edith">>
	<ASSERT-NOT-TEXT "Ruth's glass cut" <CO-RESUME ,CO "accuse edith">>
	<ASSERT "Early charge establishes no hidden forensic knowledge" <NOT ,LB-EDITH-CLEARED>>
	<ASSERT "Wrong charge remains recoverable" <NOT ,LB-WON>>
	<CO-RESUME ,CO "open bag">
	<ASSERT-TEXT "initials R.B." <CO-RESUME ,CO "examine dressing">>
	<CO-RESUME ,CO "take dressing">
	<CO-RESUME ,CO "show dressing to edith">
	<ASSERT-TEXT "dressing" <CO-RESUME ,CO "accuse edith">>
>
