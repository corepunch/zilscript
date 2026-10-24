<INSERT-FILE "books/last-broadcast/last-broadcast">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<SETG LB-CLOCK T> <SETG LB-SOUND T> <SETG LB-PROVENANCE T>
	<SETG LB-ROUTE T> <SETG LB-WEAPON T> <SETG LB-TRACE T>
	<SETG LB-RUTH-CLEARED T> <SETG LB-EDITH-CLEARED T> <SETG LB-TOMAS-CLEARED T>
	<SETG LB-MOTIVE T>
	<ASSERT-NOT-TEXT "Ada" <CO-RESUME ,CO "reconstruct casebook">>
	<ASSERT "Evidence may be organized without accusing anyone" ,LB-RECONSTRUCTED>
	<ASSERT "Reconstruction alone does not solve the case" <NOT ,LB-WON>>
	<ASSERT-NOT-TEXT "RECONSTRUCT CASEBOOK" <CO-RESUME ,CO "reconstruct casebook">>
>
