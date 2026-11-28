<INSERT-FILE "books/en/borrowed-tomorrows/borrowed-tomorrows">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <ASSERT-TEXT "folding room" <CO-RESUME ,CO "look">>
 <ASSERT "cabinet starts closed" <NOT <FSET? ,CASE ,OPENBIT>>>
 <CO-RESUME ,CO "open lending cabinet">
 <ASSERT "cabinet is open" <FSET? ,CASE ,OPENBIT>>
 <ASSERT-TEXT "Through the open door" <CO-RESUME ,CO "read leaf">>
 <ASSERT "reading no longer borrows by implicit TAKE" <AND <IN? ,LEAF ,CASE> <NOT ,ON-LOAN>>>
 <ASSERT-TEXT "records your name" <CO-RESUME ,CO "take tomorrow leaf">>
 <ASSERT "borrow physically" <AND ,ON-LOAN <HELD? ,LEAF>>>
 <CO-RESUME ,CO "north">
 <ASSERT-TEXT "backed out" <CO-RESUME ,CO "look">>
 <ASSERT-TEXT "SUN THE VILLAGE CAN'T USE" <CO-RESUME ,CO "read loan receipt">>
 <CO-RESUME ,CO "east">
 <ASSERT-TEXT "won't reach" <CO-RESUME ,CO "put leaf in frame">>
 <ASSERT "narrow leaf kept" <HELD? ,LEAF>>
 <CO-RESUME ,CO "south">
 <ASSERT-TEXT "will there be bread in the morning" <CO-RESUME ,CO "listen to folding room">>
 <ASSERT-TEXT "OPEN THE OLD FOLDS" <CO-RESUME ,CO "read folding board">>
 <ASSERT-TEXT "width of your arms" <CO-RESUME ,CO "put page on board">>
 <ASSERT "widened leaf remains held" <AND ,WIDE-LOAN <HELD? ,LEAF>>>
 <CO-RESUME ,CO "west">
 <ASSERT-TEXT "extra stripe" <CO-RESUME ,CO "put leaf in cabinet">>
 <ASSERT "explicit return clears loan and fold" <AND <IN? ,LEAF ,CASE> <NOT ,ON-LOAN> <NOT ,WIDE-LOAN>>>
 <CO-RESUME ,CO "take leaf">
 <CO-RESUME ,CO "east">
 <CO-RESUME ,CO "drop leaf"> <ASSERT "page is retrievable" <IN? ,LEAF ,FOLDING>>
 <CO-RESUME ,CO "take leaf">
 <CO-RESUME ,CO "put leaf in board">
 <CO-RESUME ,CO "north">
 <ASSERT-TEXT "tomorrow leaf" <CO-RESUME ,CO "inventory">>
 <ASSERT-TEXT "Both clips hold" <CO-RESUME ,CO "put leaf in frame">>
 <ASSERT "leaf is mounted" <IN? ,LEAF ,FRAME>>
 <CO-RESUME ,CO "take leaf"> <ASSERT "mount is reversible" <HELD? ,LEAF>>
 <ASSERT-TEXT "The word stays here" <CO-RESUME ,CO "read leaf">>
 <CO-RESUME ,CO "put leaf in frame">
 <ASSERT-TEXT "THE END -- ROOM FOR EVERY NAME" <CO-RESUME ,CO "read leaf">>>
