"Wondertown round 4: a reader who asks for the dawn countdown and runs out
of night sees the toys fall asleep, not fall silent forever."

<INSERT-FILE "books/en/wondertown/wondertown">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    <CO-RESUME ,CO "look">
    <CO-RESUME ,CO "easy">
    <ASSERT "Countdown requested" ,TIMER-ACTIVE>
    <SETG TICK-COUNT 1>
    <CO-RESUME ,CO "look">
    <ASSERT-TEXT "fall fast asleep" <CO-RESUME ,CO "look">>>
