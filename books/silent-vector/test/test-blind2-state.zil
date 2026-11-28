; State and parser responses from the second blind round.
<INSERT-FILE "books/silent-vector/silent-vector">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <SETG HERE ,WORKSHOP> <MOVE ,WINNER ,HERE> <CO-RESUME ,CO "take wrench">
 <SETG HERE ,CLINIC> <MOVE ,WINNER ,HERE> <CO-RESUME ,CO "take shears">
 <MOVE ,WAFER ,WINNER>
 <SETG POWER T> <SETG COOLING T> <SETG PROOF T> <SETG ORIGIN T> <SETG CONSENT T> <SETG ISOLATED T> <SETG EVAC T>
 <SETG HERE ,CORE> <MOVE ,WINNER ,HERE> <CO-RESUME ,CO "put wafer in archive">
 <ASSERT "sample is physically stored" <IN? ,WAFER ,COLD-ARCHIVE>>
 <ASSERT-TEXT "physically contained" <CO-RESUME ,CO "examine archive">>
 <ASSERT-NOT-TEXT "Put the recovered" <CO-RESUME ,CO "examine archive">>
 <CO-RESUME ,CO "take wafer">
 <ASSERT-TEXT "actual wafer" <CO-RESUME ,CO "erase console">>
 <ASSERT-NOT-TEXT "Compare the foil" <CO-RESUME ,CO "erase console">>
 <ASSERT-NOT-TEXT "beacon" <CO-RESUME ,CO "erase console">>
 <ASSERT "missing sample prevents erasure" <NOT ,RESOLVED>>
 <CO-RESUME ,CO "put wafer in archive"> <SETG EVAC <>>
 <ASSERT-TEXT "beacon" <CO-RESUME ,CO "preserve console">>
 <ASSERT-NOT-TEXT "Compare the foil" <CO-RESUME ,CO "preserve console">>
 <ASSERT-NOT-TEXT "actual wafer" <CO-RESUME ,CO "preserve console">>
 <ASSERT "unarmed beacon prevents preservation" <NOT ,RESOLVED>>
 <SETG CONSENT <>>
 <ASSERT-TEXT "Ivo" <CO-RESUME ,CO "erase console">>
 <ASSERT-NOT-TEXT "beacon" <CO-RESUME ,CO "erase console">>
 <ASSERT "missing consent prevents erasure" <NOT ,RESOLVED>>
 <ASSERT-TEXT "pair of ceramic shears" <CO-RESUME ,CO "inventory">>
 <ASSERT-NOT-TEXT "A ceramic shears" <CO-RESUME ,CO "inventory">>
>
