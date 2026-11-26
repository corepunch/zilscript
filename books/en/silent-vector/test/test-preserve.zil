<INSERT-FILE "books/en/silent-vector/test/walkthrough">
<ROUTINE RUN-TEST ()
	<PREPARE-ENDING>
	<ASSERT-TEXT "THE UNPLAYED WITNESS" <CO-RESUME ,CO "preserve console">>
	<ASSERT "ending resolved" ,RESOLVED>
	<ASSERT "sample contained" <IN? ,WAFER ,COLD-ARCHIVE>>
>
