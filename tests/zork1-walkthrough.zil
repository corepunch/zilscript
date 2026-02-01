<INSERT-FILE "zork1/globals">
<INSERT-FILE "zork1/clock">
<INSERT-FILE "zork1/parser">
<INSERT-FILE "zork1/verbs">
<INSERT-FILE "zork1/actions">
<INSERT-FILE "zork1/syntax">
<INSERT-FILE "zork1/dungeon">
<INSERT-FILE "zork1/actions">
<INSERT-FILE "zork1/main">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    <ASSERT-TEXT "Opening the small mailbox reveals a leaflet." <CO-RESUME ,CO "open mailbox">>
    <print "Tests are completed" CR>>
