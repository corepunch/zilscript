<INSERT-FILE "books/blackwood-horror/blackwood-horror">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
	<CO-RESUME ,CO "look">
	<SETG HERE ,BOILER-ROOM> <MOVE ,WINNER ,HERE>
	<MOVE ,OIL-LANTERN ,WINNER>
	<CO-RESUME ,CO "light lantern">
	<MOVE ,LUMP-OF-COAL ,IRON-BOILER>
	<ASSERT "A lit lantern satisfies the native flame predicate" <FLAMING? ,OIL-LANTERN>>
	<ASSERT-TEXT "deep metallic thud" <CO-RESUME ,CO "burn boiler with lantern">>
	<ASSERT "BURN lights the fueled boiler" ,BOILER-LIT>
>
