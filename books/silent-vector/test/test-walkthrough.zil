;"The complete walkthrough: PREPARE-ENDING (test/walkthrough.zil) plays from the
  opening to the cold core with every safety milestone met; this test checks the
  state it leaves, the descriptions that follow that state, and the win."
<INSERT-FILE "books/silent-vector/test/walkthrough">
<ROUTINE RUN-TEST ()
	<PREPARE-ENDING>
	<ASSERT "walkthrough ends in the cold core" <==? ,HERE ,CORE>>
	<ASSERT "habitat power restored" ,POWER>
	<ASSERT "coolant restored" ,COOLING>
	<ASSERT "independent comparison made" ,PROOF>
	<ASSERT "origin index examined" ,ORIGIN>
	<ASSERT "Ivo consented" ,CONSENT>
	<ASSERT "bus terminated" ,TERMINATED>
	<ASSERT "bus severed" ,ISOLATED>
	<ASSERT "Senn disclosed" ,SENN-DISCLOSED>
	<ASSERT "beacon armed" ,EVAC>
	<ASSERT "spool stays on the bus" <==? <LOC ,SPOOL> ,BUS>>
	<ASSERT "strip is carried" <==? <LOC ,STRIP> ,ADVENTURER>>
	<ASSERT "Mara is in the cupola" <==? <LOC ,MARA> ,LAUNCH>>
	<ASSERT "not yet resolved" <NOT ,RESOLVED>>

	;"The stored wafer is told once, and examining it leaves it stored."
	<ASSERT-TEXT "rests in cold" <CO-RESUME ,CO "look">>
	<ASSERT-NOT-TEXT "contains" <CO-RESUME ,CO "look">>
	<ASSERT-TEXT "rescue-compression" <CO-RESUME ,CO "examine wafer">>
	<ASSERT "examined wafer stays in the archive" <==? <LOC ,WAFER> ,COLD-ARCHIVE>>
	<ASSERT-TEXT "physically contained" <CO-RESUME ,CO "examine archive">>
	<ASSERT-TEXT "PRESERVE seals" <CO-RESUME ,CO "examine console">>
	<ASSERT-NOT-TEXT "ERASE CONSOLE" <CO-RESUME ,CO "examine console">>
	<ASSERT-TEXT "Choose PRESERVE or ERASE" <CO-RESUME ,CO "push console">>

	;"Retrieving the wafer withdraws the commitment; storing it again restores it."
	<ASSERT "take the wafer back" <CO-RESUME ,CO "take wafer" T> <==? <LOC ,WAFER> ,ADVENTURER>>
	<ASSERT-TEXT "No commitment is made" <CO-RESUME ,CO "preserve console">>
	<ASSERT "still unresolved" <NOT ,RESOLVED>>
	<ASSERT-TEXT "Frost" <CO-RESUME ,CO "put wafer in archive">>
	<ASSERT "wafer stored again" <==? <LOC ,WAFER> ,COLD-ARCHIVE>>

	<ASSERT-TEXT "THE UNPLAYED WITNESS" <CO-RESUME ,CO "preserve console">>
	<ASSERT "WIN - ending resolved" ,RESOLVED>
	<ASSERT "sample contained" <==? <LOC ,WAFER> ,COLD-ARCHIVE>>
	<ASSERT "archive sealed" <NOT <FSET? ,COLD-ARCHIVE ,OPENBIT>>>
	<ASSERT "crew gathered at the cupola" <AND <==? <LOC ,IVO> ,LAUNCH> <==? <LOC ,SENN> ,LAUNCH>>>
>
