<INSERT-FILE "books/silent-vector/silent-vector">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<CO-RESUME ,CO "look" T>
	<ASSERT-TEXT "dry click" <CO-RESUME ,CO "look">>
	<ASSERT-TEXT "interlock holds" <CO-RESUME ,CO "north">>
	<ASSERT "gate blocks" <EQUAL? ,HERE ,CRADLE>>
	<ASSERT-TEXT "one atmosphere" <CO-RESUME ,CO "push breaker">>
	<ASSERT-TEXT "Already reset" <CO-RESUME ,CO "push breaker">>
	<ASSERT-TEXT "junction tastes" <CO-RESUME ,CO "north">>
	<ASSERT-TEXT "pressure-balanced" <CO-RESUME ,CO "south">>>
