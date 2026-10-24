<INSERT-FILE "books/blackwood-horror/blackwood-horror">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
	<CO-RESUME ,CO "look">
	<MOVE ,SCALPEL ,WINNER> <MOVE ,COAL-SHOVEL ,WINNER>
	<MOVE ,BRASS-KEY ,WINNER> <FCLEAR ,BRASS-KEY ,INVISIBLE>
	<MOVE ,SAFE-KEY ,WINNER> <MOVE ,CHAPEL-KEY ,WINNER>
	<SETG HERE ,PATIENT-WARD> <MOVE ,WINNER ,HERE>
	<ASSERT-TEXT "sharp edge" <CO-RESUME ,CO "attack chains with shovel">>
	<ASSERT "An explicitly wrong tool cannot cut the chains" <NOT ,CHAINS-CUT-FLAG>>
	<ASSERT-TEXT "fall away" <CO-RESUME ,CO "attack chains with scalpel">>
	<SETG HERE ,RECEPTION-ROOM> <MOVE ,WINNER ,HERE>
	<CO-RESUME ,CO "examine desk">
	<ASSERT-TEXT "does not fit" <CO-RESUME ,CO "open bottom drawer with safe key">>
	<ASSERT "Owning the right key does not make the wrong key fit" <NOT <FSET? ,BOTTOM-DRAWER ,OPENBIT>>>
	<CO-RESUME ,CO "open bottom drawer with brass key">
	<ASSERT "The numbered brass key still opens the drawer" <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
	<SETG HERE ,DIRECTORS-OFFICE> <MOVE ,WINNER ,HERE>
	<CO-RESUME ,CO "move portrait">
	<ASSERT-TEXT "does not fit" <CO-RESUME ,CO "open safe with brass key">>
	<ASSERT "The drawer key cannot open the safe" <NOT <FSET? ,WALL-SAFE ,OPENBIT>>>
	<CO-RESUME ,CO "open safe with safe key">
	<ASSERT "The safe key opens its safe" <FSET? ,WALL-SAFE ,OPENBIT>>
	<SETG HERE ,OVERGROWN-GARDEN> <MOVE ,WINNER ,HERE>
	<ASSERT-TEXT "does not fit" <CO-RESUME ,CO "open chapel door with safe key">>
	<ASSERT "The safe key cannot open the chapel" <NOT ,CHAPEL-UNLOCKED>>
	<CO-RESUME ,CO "open chapel door with chapel key">
	<ASSERT "The chapel key opens the chapel" ,CHAPEL-UNLOCKED>
	<SETG HERE ,CHAPEL> <MOVE ,WINNER ,HERE>
	<ASSERT-TEXT "too broad" <CO-RESUME ,CO "open wooden box with shovel">>
	<ASSERT "The shovel does not substitute for the scalpel at the clasp" <NOT <FSET? ,WOODEN-BOX ,OPENBIT>>>
	<CO-RESUME ,CO "open wooden box with scalpel">
	<ASSERT "The scalpel pries the clasp" <FSET? ,WOODEN-BOX ,OPENBIT>>
>
