<INSERT-FILE "books/last-broadcast/last-broadcast">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<SETG HERE ,LB-BUNKROOM> <MOVE ,WINNER ,HERE>
	<MOVE ,LB-DISC ,WINNER> <MOVE ,LB-BOOTS ,WINNER> <MOVE ,LB-WEIGHT ,WINNER>
	<SETG LB-SOUND T> <SETG LB-PROVENANCE T> <SETG LB-TRACE T> <SETG LB-WEAPON T>
	<ASSERT-TEXT "reserve" <CO-RESUME ,CO "show disc to ada">>
	<ASSERT-TEXT "stitching" <CO-RESUME ,CO "show boots to ada">>
	<ASSERT-TEXT "counterweight" <CO-RESUME ,CO "show counterweight to ada">>
	<ASSERT "Exhibits cannot silently replace the final deduction" <NOT ,LB-WON>>
	<ASSERT "Pressuring a suspect does not reconstruct a missing case" <NOT ,LB-RECONSTRUCTED>>
>
