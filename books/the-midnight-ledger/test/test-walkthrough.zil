<INSERT-FILE "books/the-midnight-ledger/the-midnight-ledger">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <CO-RESUME ,CO "look" T>
 <CO-RESUME ,CO "examine auction notice">
 <CO-RESUME ,CO "east">
 <CO-RESUME ,CO "examine porter ives">
 <CO-RESUME ,CO "west">
 <CO-RESUME ,CO "north">
 <ASSERT-TEXT "WHEN is blank" <CO-RESUME ,CO "spin evidence panel">>
 <CO-RESUME ,CO "west">
 <CO-RESUME ,CO "examine weigh scale">
 <CO-RESUME ,CO "examine wall clock">
 <CO-RESUME ,CO "east">
 <CO-RESUME ,CO "east">
 <CO-RESUME ,CO "read midnight ledger">
 <CO-RESUME ,CO "examine key cabinet">
 <CO-RESUME ,CO "north">
 <CO-RESUME ,CO "examine syndicate seal">
 <CO-RESUME ,CO "examine transit crate">
 <CO-RESUME ,CO "south">
 <CO-RESUME ,CO "west">
 <CO-RESUME ,CO "north">
 <CO-RESUME ,CO "read shift register">
 <CO-RESUME ,CO "examine assessor orr">
 <CO-RESUME ,CO "south">
 <ASSERT-TEXT "three columns together" <CO-RESUME ,CO "spin evidence panel">>
 <ASSERT-TEXT "put the loss on Ives" <CO-RESUME ,CO "examine ives tab">>
 <ASSERT-TEXT "put the loss on Orr" <CO-RESUME ,CO "examine orr tab">>
 <ASSERT-TEXT "Ives releases the breath" <CO-RESUME ,CO "spin ives tab">>
 <ASSERT-TEXT "THE END: THE WEIGHT OF THE RECORD" <CO-RESUME ,CO "spin orr tab">>>
