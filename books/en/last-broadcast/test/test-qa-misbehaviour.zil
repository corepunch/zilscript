<INSERT-FILE "books/en/last-broadcast/last-broadcast">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<CO-RESUME ,CO "look" T>
	;"ENTER STATION used to pick the station clock by its adjective."
	<ASSERT-NOT-TEXT "hit your head" <CO-RESUME ,CO "enter station">>
	<ASSERT "Entering the station walks into the hall" <EQUAL? ,HERE ,LB-HALL>>
	<CO-RESUME ,CO "south">
	<ASSERT-TEXT "squat stone house" <CO-RESUME ,CO "examine station">>
	<ASSERT-TEXT "9:35" <CO-RESUME ,CO "examine station clock">>
	<CO-RESUME ,CO "north">
	<CO-RESUME ,CO "east">
	;"Witnesses answer greetings, gifts, violence and handling in the story's voice."
	<ASSERT-NOT-TEXT "bows his head" <CO-RESUME ,CO "hello ruth">>
	<ASSERT-TEXT "short nod" <CO-RESUME ,CO "hello ruth">>
	<ASSERT-NOT-TEXT "kiss a pig" <CO-RESUME ,CO "kiss ruth">>
	<ASSERT-TEXT "witness, not an exhibit" <CO-RESUME ,CO "take ruth">>
	<ASSERT-NOT-TEXT "You're nuts" <CO-RESUME ,CO "follow ruth">>
	<ASSERT-NOT-TEXT "refuses it politely" <CO-RESUME ,CO "give casebook to ruth">>
	;"HEATER is the word on the lamp's plate; asking about it must parse."
	<ASSERT-TEXT "thought the red meant live" <CO-RESUME ,CO "ask ruth about heater">>
	<ASSERT-TEXT "pencilled arrow" <CO-RESUME ,CO "read heater plate">>
	;"TURN is V-SPIN in this book; the routing switch must still answer it."
	<CO-RESUME ,CO "east">
	<ASSERT-NOT-TEXT "spin that" <CO-RESUME ,CO "turn switch">>
	<ASSERT-TEXT "wax witness mark" <CO-RESUME ,CO "turn switch">>
	<CO-RESUME ,CO "north">
	<CO-RESUME ,CO "open cutter">
	<CO-RESUME ,CO "take counterweight">
	<CO-RESUME ,CO "south">
	<CO-RESUME ,CO "west">
	<ASSERT-NOT-TEXT "suicidal" <CO-RESUME ,CO "attack ruth with counterweight">>
	<ASSERT-NOT-TEXT "ducks" <CO-RESUME ,CO "throw counterweight at ruth">>
	<ASSERT "A refused throw keeps the weapon in hand" <IN? ,LB-WEIGHT ,WINNER>>
	<CO-RESUME ,CO "west">
	<CO-RESUME ,CO "north">
	<ASSERT-TEXT "past answering" <CO-RESUME ,CO "attack body with counterweight">>
	<ASSERT-NOT-TEXT "good surface" <CO-RESUME ,CO "put counterweight on body">>
	<ASSERT "The weapon stays in hand" <IN? ,LB-WEIGHT ,WINNER>>
	;"Tea belongs to the cups, not the table."
	<CO-RESUME ,CO "south">
	<CO-RESUME ,CO "west">
	<ASSERT-NOT-TEXT "kitchen table" <CO-RESUME ,CO "drink tea">>
	<ASSERT-TEXT "not yours" <CO-RESUME ,CO "drink tea">>
	;"Giving an exhibit to a witness shows it."
	<CO-RESUME ,CO "east">
	<CO-RESUME ,CO "up">
	<ASSERT-TEXT "balance an arm" <CO-RESUME ,CO "give counterweight to ada">>
	<ASSERT-TEXT "edge of the nearest bunk" <CO-RESUME ,CO "sit on chair">>
	;"PUT STYLUS IN/ON the gramophone mounts it, and PUT DISC ON it loads the platter."
	<CO-RESUME ,CO "down">
	<CO-RESUME ,CO "east">
	<CO-RESUME ,CO "east">
	<CO-RESUME ,CO "north">
	<CO-RESUME ,CO "east">
	<CO-RESUME ,CO "open sleeve">
	<CO-RESUME ,CO "take disc">
	<CO-RESUME ,CO "west">
	<CO-RESUME ,CO "south">
	<CO-RESUME ,CO "south">
	<CO-RESUME ,CO "take stylus">
	<CO-RESUME ,CO "north">
	<CO-RESUME ,CO "put disc on gramophone">
	<ASSERT "PUT ON loads the disc onto the platter" <IN? ,LB-DISC ,LB-PLAYER>>
	<ASSERT-TEXT "You are carrying the playback stylus" <CO-RESUME ,CO "play gramophone">>
	<ASSERT-TEXT "fit the sapphire stylus" <CO-RESUME ,CO "put stylus in gramophone">>
	<ASSERT "PUT IN mounts the stylus" <IN? ,LB-STYLUS ,LB-PLAYER>>
	<ASSERT-TEXT "Even this old island" <CO-RESUME ,CO "play gramophone">>
	<ASSERT "The recording was heard" ,LB-SOUND>
>
