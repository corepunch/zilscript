<INSERT-FILE "books/last-broadcast/last-broadcast">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<SETG HERE ,LB-OFFICE> <MOVE ,WINNER ,HERE>
	<MOVE ,LB-CHART ,WINNER>
	<ASSERT-TEXT "has yet to account" <CO-RESUME ,CO "examine body">>
	<CO-RESUME ,CO "compare office clock with chart">
	<ASSERT "The real time comparison was established" ,LB-CLOCK>
	<ASSERT-NOT-TEXT "has yet to account" <CO-RESUME ,CO "examine body">>
	<ASSERT-TEXT "electrical fault" <CO-RESUME ,CO "examine body">>
	<ASSERT "Body examination preserves established clock evidence" ,LB-CLOCK>
>
