<INSERT-FILE "books/en/silent-vector/test/walkthrough">
<ROUTINE RUN-TEST ()
	<PREPARE-ENDING>
	<CO-RESUME ,CO "take wafer" T>
	<ASSERT "preparation reversible" <IN? ,WAFER ,ADVENTURER>>
	<ASSERT-TEXT "No commitment is made" <CO-RESUME ,CO "preserve console">>
	<ASSERT "no sample means no ending" <NOT ,RESOLVED>>
	<CO-RESUME ,CO "put wafer in archive" T>
	<SETG ORIGIN <>>
	<ASSERT-TEXT "examine the recovered wafer" <CO-RESUME ,CO "erase console">>
	<ASSERT "origin must be learned" <NOT ,RESOLVED>>
	<ASSERT-TEXT "cuts are equally sharp" <CO-RESUME ,CO "examine engraved index">>
	<ASSERT "reading the index establishes origin" ,ORIGIN>
	<SETG ORIGIN <>>
	<CO-RESUME ,CO "examine wafer" T>
	<ASSERT "safe index readable in storage" ,ORIGIN>
	<ASSERT-TEXT "FOUR PULSES" <CO-RESUME ,CO "erase console">>
	<ASSERT "complete after correction" ,RESOLVED>>
