<INSERT-FILE "infocom/zork1/zork1">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    <ASSERT "Reach North of House" <CO-RESUME ,CO "walk around the house" T> <==? ,HERE ,NORTH-OF-HOUSE>>
    <TELL CR "Forward ACTION routine regression completed!" CR>>
