; Blind-round parser regressions, with each action and postcondition separate.
<INSERT-FILE "books/en/silent-vector/silent-vector">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <MOVE ,WRENCH ,WINNER> <MOVE ,SHEARS ,WINNER> <MOVE ,SPOOL ,WINNER>
 <SETG HERE ,COOLANT> <MOVE ,WINNER ,HERE>
 <ASSERT-TEXT "calibrated torque wrench" <CO-RESUME ,CO "turn pump with shears">>
 <ASSERT "wrong tool does not restore cooling" <NOT ,COOLING>>
 <ASSERT-TEXT "calibrated click" <CO-RESUME ,CO "turn pump with wrench">>
 <ASSERT "wrench restores cooling" ,COOLING>
 <SETG HERE ,RELAY> <MOVE ,WINNER ,HERE>
 <CO-RESUME ,CO "fit bus to spool">
 <ASSERT "fitting terminates the bus" ,TERMINATED>
 <ASSERT "spool is physically fitted" <IN? ,SPOOL ,BUS>>
 <SETG HERE ,CORE> <MOVE ,WINNER ,HERE>
 <ASSERT-TEXT-OCCURRENCES "No commitment is made." 1 <CO-RESUME ,CO "preserve console">>
 <ASSERT "premature preserve does not commit" <NOT ,RESOLVED>>
 <ASSERT-TEXT-OCCURRENCES "No commitment is made." 1 <CO-RESUME ,CO "erase console">>
 <ASSERT "premature erase does not commit" <NOT ,RESOLVED>>
 <SETG PROOF T> <SETG HERE ,QUARANTINE> <MOVE ,WINNER ,HERE>
 <ASSERT-TEXT "would have been thirty-one" <CO-RESUME ,CO "ask senn about daughter">>
 <SETG HERE ,RELAY> <MOVE ,WINNER ,HERE> <CO-RESUME ,CO "cut bus with shears">
 <SETG HERE ,QUARANTINE> <MOVE ,WINNER ,HERE>
 <ASSERT-TEXT "daughter" <CO-RESUME ,CO "look">>
 <ASSERT-TEXT "again" <CO-RESUME ,CO "look">>
 <ASSERT-TEXT "Lena died at nine" <CO-RESUME ,CO "ask senn about daughter">>
 <ASSERT "testimony discloses the source" ,SENN-DISCLOSED>
 <ASSERT-TEXT "hands closed" <CO-RESUME ,CO "examine senn">>
 <MOVE ,STRIP ,WINNER> <MOVE ,WAFER ,WINNER> <SETG ORIGIN <>>
 <ASSERT-TEXT "makes no sound" <CO-RESUME ,CO "listen to wafer">>
 <ASSERT "listening cannot read provenance" <NOT ,ORIGIN>>
 <SETG CONSENT T> <SETG HERE ,CLINIC> <MOVE ,WINNER ,HERE>
 <ASSERT-TEXT "clinical count" <CO-RESUME ,CO "show strip to mara">>
 <ASSERT-TEXT "Custody is a longer promise" <CO-RESUME ,CO "show wafer to mara">>
 <ASSERT-NOT-TEXT "Show Ivo" <CO-RESUME ,CO "show wafer to mara">>
 <ASSERT-TEXT "Custody is a longer promise" <CO-RESUME ,CO "ask mara about wafer">>
 <ASSERT-TEXT "Ivo agreed" <CO-RESUME ,CO "ask mara about crew">>
 <SETG HERE ,CORE> <MOVE ,WINNER ,HERE>
 <ASSERT-TEXT "guarded custody" <CO-RESUME ,CO "examine console">>
 <ASSERT-TEXT "Erasure destroys" <CO-RESUME ,CO "examine console">>
 <SETG HERE ,LAUNCH> <MOVE ,WINNER ,HERE>
 <ASSERT-TEXT "actual memory wafer" <CO-RESUME ,CO "push beacon">>
 <ASSERT-NOT-TEXT "compare physical foil" <CO-RESUME ,CO "push beacon">>
 <ASSERT "refusal does not arm beacon" <NOT ,EVAC>>
 <SETG HERE ,HUB> <MOVE ,WINNER ,HERE> <SETG HUB-MILESTONE -1>
 <ASSERT-TEXT "compulsive half-heard" <CO-RESUME ,CO "look">>
 <ASSERT-TEXT "junction tastes" <CO-RESUME ,CO "look">>
 <ASSERT-NOT-TEXT "compulsive half-heard" <CO-RESUME ,CO "look">>
>
