<INSERT-FILE "books/en/bell-grew-leaves/bell-grew-leaves">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <ASSERT-TEXT "root bell" <CO-RESUME ,CO "look">>
 <ASSERT-TEXT "Tuk" <CO-RESUME ,CO "ring root bell">>
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "three white leaves" <CO-RESUME ,CO "read signal tile">>
 <CO-RESUME ,CO "take reed wick">
 <ASSERT "wick carried" <HELD? ,WICK>>
 <CO-RESUME ,CO "west">
 <CO-RESUME ,CO "put wick in bell">
 <ASSERT-TEXT "wood is thirsty" <CO-RESUME ,CO "ring bell">>
 <CO-RESUME ,CO "take wick">
 <ASSERT "unfit dry wick" <HELD? ,WICK>>
 <CO-RESUME ,CO "north">
 <ASSERT-TEXT "bowl is empty" <CO-RESUME ,CO "put wick in bowl">>
 <ASSERT "unchanged" <NOT ,WET-WICK>>
 <CO-RESUME ,CO "turn spout">
 <ASSERT "bowl fills" ,FLOWING>
 <ASSERT-TEXT "goes dark" <CO-RESUME ,CO "put wick in bowl">>
 <ASSERT "soaked but retained" <AND ,WET-WICK <HELD? ,WICK>>>
 <CO-RESUME ,CO "turn spout">
 <ASSERT "draining doesn't undo soaked wick" <AND <NOT ,FLOWING> ,WET-WICK>>
 <CO-RESUME ,CO "south">
 <CO-RESUME ,CO "put wick in bell">
 <ASSERT-TEXT "holding the fog in" <CO-RESUME ,CO "ring bell">>
 <ASSERT "failed ring kept wick" <IN? ,WICK ,BELL>>
 <CO-RESUME ,CO "north"> <CO-RESUME ,CO "east">
 <ASSERT-TEXT "you lift the peg" <CO-RESUME ,CO "open shutter">>
 <CO-RESUME ,CO "close shutter">
 <ASSERT "closure physical" <NOT <FSET? ,SHUTTER ,OPENBIT>>>
 <CO-RESUME ,CO "open shutter"> <CO-RESUME ,CO "west"> <CO-RESUME ,CO "south">
 <ASSERT-TEXT "THE END -- THREE LEAVES FOR YES" <CO-RESUME ,CO "ring bell">>>
