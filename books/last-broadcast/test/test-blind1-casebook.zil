<INSERT-FILE "books/last-broadcast/last-broadcast">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<ASSERT-NOT-TEXT "generator room" <CO-RESUME ,CO "read casebook">>
	<ASSERT-NOT-TEXT "compare" <CO-RESUME ,CO "examine casebook">>
	<ASSERT "Ordinary reading never completes an investigation" <NOT ,LB-RECONSTRUCTED>>
	<ASSERT-TEXT "generator room" <CO-RESUME ,CO "hint casebook">>
>
