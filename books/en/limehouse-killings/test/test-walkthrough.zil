<INSERT-FILE "books/en/limehouse-killings/limehouse-killings">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
	<ASSERT "Start at the manor gate" <CO-RESUME ,CO "look" T> <==? ,HERE ,ASHWORTH-MANOR-GATE>>
	<ASSERT-TEXT "name of the person it concerned" <CO-RESUME ,CO "read telegram">> ;"Lady Ashworth's hint for the name dial"
	<ASSERT "Reading takes the telegram" <==? <LOC ,TELEGRAM> ,ADVENTURER>>
	<ASSERT "Enter the entrance hall" <CO-RESUME ,CO "north" T> <==? ,HERE ,ASHWORTH-ENTRANCE-HALL>>
	<ASSERT-TEXT "need the study key" <CO-RESUME ,CO "open study door">> ;"The hall door is locked"
	<ASSERT "The locked door keeps the study shut" <CO-RESUME ,CO "north" T> <==? ,HERE ,ASHWORTH-ENTRANCE-HALL>>
	<ASSERT "Take the magnifying glass" <CO-RESUME ,CO "take magnifying glass" T> <==? <LOC ,MAGNIFYING-GLASS> ,ADVENTURER>>

	;"Library: the ledger, the torn page and the four marked books"
	<ASSERT "Go to the library" <CO-RESUME ,CO "east" T> <==? ,HERE ,LIBRARY>>
	<ASSERT-TEXT "red, yellow, green, blue" <CO-RESUME ,CO "read torn page">>
	<ASSERT "Reading takes the torn page" <==? <LOC ,TORN-PAGE> ,ADVENTURER>>
	<ASSERT-TEXT "UNPAID" <CO-RESUME ,CO "read ledger">>
	<ASSERT "The ledger is the first piece of evidence" <AND ,SECRET-LEDGER-FOUND <==? ,EVIDENCE-FOUND 1>>>
	<ASSERT-TEXT "red book" <CO-RESUME ,CO "examine ribbons">>
	<ASSERT-TEXT "sequence resets" <CO-RESUME ,CO "push blue book">> ;"A wrong book resets the order"
	<ASSERT "Red book first" <CO-RESUME ,CO "push red book" T> <==? ,CIPHER-STAGE 1>>
	<ASSERT "Yellow book second" <CO-RESUME ,CO "push yellow book" T> <==? ,CIPHER-STAGE 2>>
	<ASSERT "Green book third" <CO-RESUME ,CO "push green book" T> <==? ,CIPHER-STAGE 3>>
	<ASSERT-TEXT "hidden stair" <CO-RESUME ,CO "push blue book">>
	<ASSERT "The cipher opens the passage" <AND ,CIPHER-SOLVED ,SECRET-PASSAGE-OPEN <==? ,CASE-ACT 2>>>
	<ASSERT-TEXT "passage stands open" <CO-RESUME ,CO "push bookshelves">> ;"The solved shelf answers in the fiction"

	;"First interview: Moriarty and the poison"
	<ASSERT-TEXT "experiments" <CO-RESUME ,CO "ask moriarty">>
	<ASSERT-TEXT "medicinal plants" <CO-RESUME ,CO "ask moriarty about experiments">>
	<ASSERT-TEXT "walks out to the entrance hall" <CO-RESUME ,CO "ask moriarty about poison">>
	<ASSERT "Moriarty is interviewed" <AND ,MORIARTY-INTERVIEWED <==? ,SUSPECTS-INTERVIEWED 1>>>
	<ASSERT "Moriarty waits in the hall" <==? <LOC ,DR-MORIARTY> ,ASHWORTH-ENTRANCE-HALL>>

	;"The hidden stair into the locked study"
	<ASSERT "Enter the secret passage" <CO-RESUME ,CO "east" T> <==? ,HERE ,SECRET-PASSAGE>>
	<ASSERT-TEXT "lit lantern" <CO-RESUME ,CO "examine dust">> ;"Too dim without the lantern"
	<ASSERT "Climb into the study" <CO-RESUME ,CO "up" T> <==? ,HERE ,STUDY>>
	<ASSERT-TEXT "mantelpiece" <CO-RESUME ,CO "examine outline">>
	<ASSERT "The unsent letter is hidden among the papers" <FSET? ,DEAD-LETTER ,INVISIBLE>>
	<ASSERT-TEXT "yellowed envelope" <CO-RESUME ,CO "examine desk">>
	<ASSERT-TEXT "expose you to Scotland Yard" <CO-RESUME ,CO "read unsent letter">>
	<ASSERT "The letter is carried evidence" <AND ,DEAD-LETTER-FOUND <==? <LOC ,DEAD-LETTER> ,ADVENTURER>>>
	<ASSERT-TEXT "Wolfsbane" <CO-RESUME ,CO "read poison bottle">>
	<ASSERT "Three pieces of evidence" <AND ,POISON-BOTTLE-FOUND <==? ,EVIDENCE-FOUND 3>>>
	<ASSERT-TEXT "Lady Ashworth, Mr. Hudson, or Dr. Moriarty" <CO-RESUME ,CO "examine box">>
	<ASSERT-TEXT "does not connect" <CO-RESUME ,CO "align box to hudson">>
	<ASSERT-TEXT "purple-flower engraving" <CO-RESUME ,CO "align box to moriarty">> ;"The poison is not yet identified"
	<ASSERT "The box is still shut" <NOT ,LOCKED-BOX-OPENED>>
	<ASSERT-TEXT "bolt shot home on this side" <CO-RESUME ,CO "examine study door">>
	<ASSERT-TEXT "interior bolt" <CO-RESUME ,CO "open study door">>
	<ASSERT "The study door is open" <AND ,STUDY-UNLOCKED <FSET? ,STUDY-DOOR ,OPENBIT>>>
	<ASSERT "Leave by the hall door" <CO-RESUME ,CO "south" T> <==? ,HERE ,ASHWORTH-ENTRANCE-HALL>>

	;"Second interview: Lady Ashworth"
	<ASSERT "Go to the dining room" <CO-RESUME ,CO "west" T> <==? ,HERE ,DINING-ROOM>>
	<ASSERT-TEXT "narrow M" <CO-RESUME ,CO "examine wax seal">>
	<ASSERT "Take the wax seal" <CO-RESUME ,CO "take wax seal" T> <==? <LOC ,WAX-SEAL> ,ADVENTURER>>
	<ASSERT-TEXT "marriage" <CO-RESUME ,CO "ask lady ashworth">>
	<ASSERT-TEXT "drawing room" <CO-RESUME ,CO "ask lady ashworth about alibi">>
	<ASSERT "Lady Ashworth is interviewed" <AND ,LADY-INTERVIEWED <==? ,SUSPECTS-INTERVIEWED 2>>>
	<ASSERT-TEXT "keeping her thumb clear" <CO-RESUME ,CO "show unsent letter to lady ashworth">>
	<ASSERT "Showing the letter keeps it" <AND ,LADY-CONFRONTED <==? <LOC ,DEAD-LETTER> ,ADVENTURER>>>
	<ASSERT-TEXT "has an alibi" <CO-RESUME ,CO "accuse lady ashworth">>
	<ASSERT "A wrong accusation is counted, not fatal" <AND <==? ,WRONG-ATTEMPTS 1> <NOT ,GAME-ENDED>>>

	;"Kitchen and garden"
	<ASSERT "Back to the hall" <CO-RESUME ,CO "east" T> <==? ,HERE ,ASHWORTH-ENTRANCE-HALL>>
	<ASSERT "Down to the kitchen" <CO-RESUME ,CO "down" T> <==? ,HERE ,KITCHEN>>
	<ASSERT-TEXT "TEA FIRST" <CO-RESUME ,CO "read kettle">> ;"Reading scenery must return"
	<ASSERT-TEXT "leather roll" <CO-RESUME ,CO "open drawer">>
	<ASSERT "Take the leather roll" <CO-RESUME ,CO "take leather roll" T> <==? <LOC ,LEATHER-ROLL> ,ADVENTURER>>
	<ASSERT "Out to the garden" <CO-RESUME ,CO "west" T> <==? ,HERE ,GARDEN>>
	<ASSERT "The knife is hidden in the hedge" <FSET? ,BLOOD-STAINED-KNIFE ,INVISIBLE>>
	<ASSERT-TEXT "knife" <CO-RESUME ,CO "examine hedges">>
	<ASSERT "Take the knife" <CO-RESUME ,CO "take knife" T> <==? <LOC ,BLOOD-STAINED-KNIFE> ,ADVENTURER>>
	<ASSERT "The knife is evidence" <AND ,KNIFE-FOUND <==? ,EVIDENCE-FOUND 4>>>
	<ASSERT "Take the footprint cast" <CO-RESUME ,CO "take plaster cast" T> <==? <LOC ,FOOTPRINT-CAST> ,ADVENTURER>>
	<ASSERT-TEXT "crescent-shaped nick" <CO-RESUME ,CO "use magnifying glass on plaster cast">>
	<ASSERT "The heel detail is found" ,FOOTPRINT-DETAIL-FOUND>

	;"Greenhouse: the bottle and the labels name one plant"
	<ASSERT "Enter the greenhouse" <CO-RESUME ,CO "north" T> <==? ,HERE ,GREENHOUSE>>
	<ASSERT-TEXT "match the poison bottle label" <CO-RESUME ,CO "examine labels">>
	<ASSERT "The poison is identified" ,POISON-IDENTIFIED>
	<ASSERT-TEXT "once more" <CO-RESUME ,CO "use poison bottle on flowers">>

	;"Third interview: Hudson, his key and his lantern"
	<ASSERT "Back to the garden" <CO-RESUME ,CO "south" T> <==? ,HERE ,GARDEN>>
	<ASSERT "Enter the servants' quarters" <CO-RESUME ,CO "south" T> <==? ,HERE ,SERVANTS-QUARTERS>>
	<ASSERT-TEXT "The master, my alibi" <CO-RESUME ,CO "ask hudson">>
	<ASSERT-TEXT "hands you the keyring" <CO-RESUME ,CO "ask hudson about key">>
	<ASSERT "Hudson's keyring is carried" <AND ,HUDSON-KEY-GIVEN <==? <LOC ,KEYRING> ,ADVENTURER>>>
	<ASSERT "Lestrade has not come yet" <NOT ,INSPECTOR-PRESENT>>
	<ASSERT-TEXT "Scotland Yard has arrived" <CO-RESUME ,CO "ask hudson about alibi">>
	<ASSERT "All three suspects are interviewed" <AND ,HUDSON-INTERVIEWED <==? ,SUSPECTS-INTERVIEWED 3>>>
	<ASSERT "Lestrade waits in the hall" <AND ,INSPECTOR-PRESENT <==? ,CASE-ACT 3> <==? <LOC ,INSPECTOR> ,ASHWORTH-ENTRANCE-HALL>>>
	<ASSERT-TEXT "folded note" <CO-RESUME ,CO "examine trunk">>
	<ASSERT "Take the folded note" <CO-RESUME ,CO "take folded note" T> <==? <LOC ,TRUNK-LETTER> ,ADVENTURER>>
	<ASSERT "Take the lantern" <CO-RESUME ,CO "take lantern" T> <==? <LOC ,LANTERN> ,ADVENTURER>>
	<ASSERT "Light the lantern" <CO-RESUME ,CO "use lantern" T> <FSET? ,LANTERN ,ONBIT>>
	<ASSERT-TEXT "in the servants' quarters" <CO-RESUME ,CO "accuse hudson">>

	;"Back to the study for the name dial"
	<ASSERT "Garden" <CO-RESUME ,CO "north" T> <==? ,HERE ,GARDEN>>
	<ASSERT "Kitchen" <CO-RESUME ,CO "east" T> <==? ,HERE ,KITCHEN>>
	<ASSERT-TEXT "Inspector Lestrade has arrived" <CO-RESUME ,CO "up">>
	<ASSERT "Hall" <==? ,HERE ,ASHWORTH-ENTRANCE-HALL>>
	<ASSERT "Study" <CO-RESUME ,CO "north" T> <==? ,HERE ,STUDY>>
	<ASSERT-TEXT "bank statement" <CO-RESUME ,CO "align box to moriarty">>
	<ASSERT-TEXT "bank statement" <CO-RESUME ,CO "look in box">>
	<ASSERT "The box is open" <AND ,LOCKED-BOX-OPENED <FSET? ,LOCKED-BOX ,OPENBIT>>>

	;"Closing the solved box used to make the statement irretrievable."
	<ASSERT-TEXT "dial stays at MORIARTY" <CO-RESUME ,CO "close box">>
	<ASSERT "The lid is closed without resetting the dial" <AND ,LOCKED-BOX-OPENED <NOT <FSET? ,LOCKED-BOX ,OPENBIT>>>>
	<ASSERT-TEXT "lid is shut" <CO-RESUME ,CO "examine box">>
	<ASSERT-TEXT "name-dial box sits shut" <CO-RESUME ,CO "look">>
	<ASSERT-TEXT "You lift the lid again" <CO-RESUME ,CO "open box">>
	<ASSERT-TEXT "ink feathers" <CO-RESUME ,CO "use magnifying glass on unsent letter">>
	<ASSERT-TEXT "pale rim" <CO-RESUME ,CO "use magnifying glass on poison bottle">>
	<ASSERT-TEXT "overdrawn" <CO-RESUME ,CO "read bank statement">>
	<ASSERT-TEXT "is empty" <CO-RESUME ,CO "look in box">>
	<CO-RESUME ,CO "put poison bottle in box">
	<ASSERT-TEXT "poison bottle" <CO-RESUME ,CO "look in box">>
	<CO-RESUME ,CO "take poison bottle from box">
	<CO-RESUME ,CO "close study door">
	<ASSERT-TEXT "hall to the south" <CO-RESUME ,CO "open study door">>
	<ASSERT "The statement is the fifth piece of evidence" <AND ,BANK-STATEMENT-FOUND <==? ,EVIDENCE-FOUND 5> <==? <LOC ,BANK-STATEMENT> ,ADVENTURER>>>
	<ASSERT "Down the hidden stair" <CO-RESUME ,CO "down" T> <==? ,HERE ,SECRET-PASSAGE>>
	<ASSERT-TEXT "hurried toward the study" <CO-RESUME ,CO "examine dust">> ;"The lit lantern shows the route"
	<ASSERT "Library" <CO-RESUME ,CO "west" T> <==? ,HERE ,LIBRARY>>
	<ASSERT "Hall again" <CO-RESUME ,CO "west" T> <==? ,HERE ,ASHWORTH-ENTRANCE-HALL>>

	;"The case for Lestrade"
	<ASSERT-TEXT "threat, the method, and the motive" <CO-RESUME ,CO "ask lestrade about case">>
	<ASSERT-TEXT "not yet an argument" <CO-RESUME ,CO "accuse moriarty">>
	<ASSERT-TEXT "first link" <CO-RESUME ,CO "show unsent letter to lestrade">>
	<ASSERT-TEXT "second link" <CO-RESUME ,CO "show poison bottle to lestrade">>
	<ASSERT-TEXT "crescent nicks meet" <CO-RESUME ,CO "show plaster cast to lestrade">>
	<ASSERT-TEXT "chain is complete" <CO-RESUME ,CO "show bank statement to lestrade">>
	<ASSERT "Threat, method and motive are presented" <AND ,LETTER-PRESENTED ,POISON-PRESENTED ,MOTIVE-PRESENTED>>
	<ASSERT-TEXT "Which proof leads the charge" <CO-RESUME ,CO "accuse moriarty">>
	<ASSERT-TEXT "clearest opening proof" <CO-RESUME ,CO "accuse moriarty with wax seal">>
	<ASSERT "Not won without a leading proof" <NOT ,GAME-WON>>
	<ASSERT-TEXT "THE LIMEHOUSE KILLINGS -- SOLVED" <CO-RESUME ,CO "accuse moriarty with unsent letter">>
	<ASSERT "WIN - Moriarty is accused with the right proof" <AND ,GAME-WON ,CORRECT-ACCUSATION ,KILLER-ACCUSED ,GAME-ENDED>>
	<ASSERT "Full score" <==? ,SCORE ,SCORE-MAX>>

	<ASSERT-TEXT "end this session" <CO-RESUME ,CO "look">>
>
