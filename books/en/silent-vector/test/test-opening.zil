<INSERT-FILE "books/en/silent-vector/silent-vector">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<CO-RESUME ,CO "look" T>
	<ASSERT-TEXT "dry click" <CO-RESUME ,CO "look">>
	<ASSERT-TEXT "restraint frame" <CO-RESUME ,CO "enter restraint frame">>
	<ASSERT-TEXT "interlock holds" <CO-RESUME ,CO "north">>
	<ASSERT "gate blocks" <EQUAL? ,HERE ,CRADLE>>
	<ASSERT-TEXT "one atmosphere" <CO-RESUME ,CO "push breaker">>
	<ASSERT-TEXT "Already reset" <CO-RESUME ,CO "push breaker">>
	<ASSERT-TEXT "junction tastes" <CO-RESUME ,CO "north">>
	<ASSERT-NOT-TEXT "too warm" <CO-RESUME ,CO "look">>
	<ASSERT-TEXT "almost too warm" <CO-RESUME ,CO "examine rail">>
	<SETG COOLING T>
	<ASSERT-TEXT "Cool air from below" <CO-RESUME ,CO "examine rail">>
	<ASSERT-TEXT "pressure-balanced" <CO-RESUME ,CO "south">>>
