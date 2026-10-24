<INSERT-FILE "books/limehouse-killings/limehouse-killings">
<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
	;"The hidden route has a named, reciprocal stair; the garden window owns west."
	<SETG HERE ,STUDY> <MOVE ,WINNER ,STUDY>
	<SETG CIPHER-SOLVED T>
	<ASSERT-TEXT "down" <CO-RESUME ,CO "look">>
	<CO-RESUME ,CO "down">
	<ASSERT "Study stair returns to passage" <==? ,HERE ,SECRET-PASSAGE>>
	<CO-RESUME ,CO "up">
	<ASSERT "Passage stair reaches study" <==? ,HERE ,STUDY>>

	;"A real tool must be deliberately selected; possession is never a gate bypass."
	<MOVE ,LOCKPICK-SET ,WINNER>
	<MOVE ,KEYRING ,WINNER>
	<FCLEAR ,WINDOW ,OPENBIT>
	<ASSERT-TEXT "fine pick" <CO-RESUME ,CO "open window">>
	<ASSERT "Bare OPEN does not use a carried tool" <NOT <FSET? ,WINDOW ,OPENBIT>>>
	<ASSERT-TEXT "does not fit" <CO-RESUME ,CO "open window with keyring">>
	<ASSERT "Wrong tool keeps window closed" <NOT <FSET? ,WINDOW ,OPENBIT>>>
	<MOVE ,LEATHER-ROLL ,WINNER> <FSET ,LEATHER-ROLL ,OPENBIT>
	<MOVE ,LOCKPICK-SET ,LEATHER-ROLL>
	<ASSERT-TEXT "clicks open" <CO-RESUME ,CO "open window with lockpick set">>
	<ASSERT "Open carried roll makes picks available" <FSET? ,WINDOW ,OPENBIT>>
	<ASSERT-TEXT "window is open" <CO-RESUME ,CO "examine window">>
	<CO-RESUME ,CO "southwest">
	<ASSERT "Window route reaches garden" <==? ,HERE ,GARDEN>>
	<CO-RESUME ,CO "northeast">
	<ASSERT "Garden route returns through same open window" <==? ,HERE ,STUDY>>
	<FCLEAR ,WINDOW ,OPENBIT> <FCLEAR ,LEATHER-ROLL ,OPENBIT>
	<CO-RESUME ,CO "open window with lockpick set">
	<ASSERT "Closed roll prevents use of concealed picks" <NOT <FSET? ,WINDOW ,OPENBIT>>>
	<FSET ,LEATHER-ROLL ,OPENBIT>

	<FCLEAR ,STUDY-DOOR ,OPENBIT> <SETG STUDY-UNLOCKED <>>
	<SETG HERE ,ASHWORTH-ENTRANCE-HALL> <MOVE ,WINNER ,ASHWORTH-ENTRANCE-HALL>
	<CO-RESUME ,CO "unlock study door with lockpick set">
	<ASSERT "Picks cannot replace Hudson's warded study key" <NOT ,STUDY-UNLOCKED>>
	<MOVE ,KEYRING ,WINNER>
	<CO-RESUME ,CO "unlock study door with keyring">
	<ASSERT "Study key retains its distinct purpose" ,STUDY-UNLOCKED>

	;"The dust and lantern convey a real, limited observation."
	<SETG HERE ,SECRET-PASSAGE> <MOVE ,WINNER ,SECRET-PASSAGE>
	<MOVE ,MAGNIFYING-GLASS ,WINNER>
	<ASSERT-TEXT "too dim" <CO-RESUME ,CO "examine dust">>
	<MOVE ,LANTERN ,WINNER> <FSET ,LANTERN ,ONBIT>
	<ASSERT-TEXT "toward the study" <CO-RESUME ,CO "examine dust">>
	<ASSERT-TEXT "no clean heel edge" <CO-RESUME ,CO "use magnifying glass on dust">>

	<SETG HERE ,KITCHEN> <MOVE ,WINNER ,KITCHEN>
	<ASSERT-TEXT "too much sugar" <CO-RESUME ,CO "drink tea">>
	<SETG HERE ,DINING-ROOM> <MOVE ,WINNER ,DINING-ROOM>
	<ASSERT-TEXT "blunt dinner cutlery" <CO-RESUME ,CO "examine cutlery">>
	<SETG HERE ,STUDY> <MOVE ,WINNER ,STUDY>
	<FCLEAR ,WINDOW ,OPENBIT>
	<ASSERT-TEXT "clicks open" <CO-RESUME ,CO "use lockpick set on window">>
	<ASSERT "Natural tool-on-target operation opens window" <FSET? ,WINDOW ,OPENBIT>>
	<ASSERT-TEXT "mantelpiece" <CO-RESUME ,CO "examine outline">>
>
