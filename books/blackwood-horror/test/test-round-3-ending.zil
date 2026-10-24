<INSERT-FILE "books/blackwood-horror/blackwood-horror">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
	<CO-RESUME ,CO "look">
	<SETG HERE ,CHAPEL> <MOVE ,WINNER ,HERE>
	<MOVE ,ANCIENT-RELIC ,WINNER>
	<MOVE ,STRANGE-SERUM ,WINNER>
	<MOVE ,SYRINGE ,WINNER>
	<SETG PATIENT-LORE 5>
	<ASSERT-NOT-TEXT "crumbles to ash" <CO-RESUME ,CO "inject patient with syringe">>
	<ASSERT "Recognition still frees the patient" ,GAME-WON>
	<ASSERT "The resolved patient is no longer a separate actor" <NOT <LOC ,PATIENT-189>>>
	<ASSERT-TEXT "end this session" <CO-RESUME ,CO "look">>
>
