<INSERT-FILE "books/silent-vector/silent-vector">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<CO-RESUME ,CO "look" T>
	<ASSERT-TEXT "protection trip" <CO-RESUME ,CO "hint">>
	<ASSERT-NOT-TEXT "push it" <CO-RESUME ,CO "hint">>
	<ASSERT-TEXT "push it" <CO-RESUME ,CO "hint">>
	<CO-RESUME ,CO "push breaker" T>
	<ASSERT-TEXT "mechanical sound" <CO-RESUME ,CO "hint">>
	<ASSERT "hint ladder resets on progress" <EQUAL? ,HINT-LEVEL 1>>
	<ASSERT-NOT-TEXT "dry click" <CO-RESUME ,CO "look">>
	<ASSERT-TEXT "quiet" <CO-RESUME ,CO "look">>>
