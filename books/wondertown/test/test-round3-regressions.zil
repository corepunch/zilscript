<INSERT-FILE "books/wondertown/wondertown">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
	<CO-RESUME ,CO "look">
	<SETG HERE ,FOX-DEN>
	<MOVE ,WINNER ,FOX-DEN>
	<ASSERT-NOT-TEXT "manual" <CO-RESUME ,CO "tell fox">>
	<CO-RESUME ,CO "give yarn to fox">
	<CO-RESUME ,CO "take workshop key">
	<ASSERT "Key was actually handed over" <IN? ,WORKSHOP-KEY ,WINNER>>
	<ASSERT-NOT-TEXT "ticks faintly around her neck" <CO-RESUME ,CO "look">>
	<ASSERT-NOT-TEXT "hangs from a string" <CO-RESUME ,CO "examine fox">>
	<ASSERT-NOT-TEXT "hugs the key" <CO-RESUME ,CO "tell fox about workshop key">>
	<ASSERT-TEXT "loft" <CO-RESUME ,CO "tell fox">>
	<ASSERT-TEXT "wind" <CO-RESUME ,CO "tell fox">>
	<SETG NUTMEG-TRUST -1>
	<ASSERT-NOT-TEXT "trust now" <CO-RESUME ,CO "examine fox">>
	<ASSERT-NOT-TEXT "key is still around her neck" <CO-RESUME ,CO "examine fox">>
	<SETG NUTMEG-TRUST 2>
	<SETG HERE ,STORAGE-LOFT>
	<MOVE ,WINNER ,STORAGE-LOFT>
	<SETG OLD-TICK-HEARD T>
	<ASSERT-TEXT "wind" <CO-RESUME ,CO "tell clock">>
	<CO-RESUME ,CO "wind clock">
	<ASSERT "Repeating clock wind opens real passage" ,STUDY-ACCESS>
	<SETG HERE ,SCRAP-YARD>
	<MOVE ,WINNER ,SCRAP-YARD>
	<CO-RESUME ,CO "examine cart">
	<CO-RESUME ,CO "search piles">
	<CO-RESUME ,CO "take head">
	<CO-RESUME ,CO "give head to headless doll">
	<ASSERT "Returning matched head clears cart gate" ,CART-MOVED>
	<ASSERT "Cart receives matched head for its doll" <IN? ,DOLL-HEAD ,SCRAP-CART>>
	<SETG HERE ,WORKSHOP-HEART>
	<MOVE ,WINNER ,WORKSHOP-HEART>
	<MOVE ,TIN-SOLDIER ,WINNER>
	<MOVE ,MUSIC-BOX ,WINNER>
	<SETG KEY-WOUND T>
	<CO-RESUME ,CO "position soldier">
	<ASSERT "Soldier and Nutmeg each contribute once" <EQUAL? ,COMPANION-COUNT 2>>
	<CO-RESUME ,CO "position soldier">
	<ASSERT "Repositioning same soldier adds no companion" <EQUAL? ,COMPANION-COUNT 2>>
	<ASSERT "Repeated offering cannot win" <NOT ,GAME-WON>>
	<CO-RESUME ,CO "take soldier">
	<ASSERT "A companion stays with the heart it is sustaining" <IN? ,TIN-SOLDIER ,WORKSHOP-HEART>>
	<CO-RESUME ,CO "position soldier">
	<ASSERT "Taking and replacing cannot duplicate a contribution" <EQUAL? ,COMPANION-COUNT 2>>
	<CO-RESUME ,CO "position music box">
	<ASSERT "Distinct second toy completes the heart" ,GAME-WON>
>
