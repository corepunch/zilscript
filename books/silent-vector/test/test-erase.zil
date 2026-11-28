<INSERT-FILE "books/silent-vector/test/walkthrough">
<ROUTINE RUN-TEST ()
	<PREPARE-ENDING>
	<ASSERT-TEXT "FOUR PULSES" <CO-RESUME ,CO "erase console">>
	<ASSERT "ending resolved" ,RESOLVED>
	<ASSERT "sample erased" <NOT <LOC ,WAFER>>>
>
