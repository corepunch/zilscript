; QA regressions: book adjectives must not take over the base verbs.
; INSPECTION shared INSPECT's six-letter entry and EXAMINATION shared
; EXAMINE's, which stripped the verb from X, INSPECT, DESCRIBE and WHAT; the
; breaker's PUSH adjective did the same to PRESS. The crew's own names were
; adjectives too, so GIVE IVO WRENCH read "ivo wrench" as one noun.
<INSERT-FILE "books/silent-vector/silent-vector">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
 <ASSERT-TEXT "tripped, not broken" <CO-RESUME ,CO "x breaker">>
 <ASSERT-TEXT "tripped, not broken" <CO-RESUME ,CO "inspect breaker">>
 <ASSERT-TEXT "tripped, not broken" <CO-RESUME ,CO "describe switch">>
 <ASSERT-TEXT "needle quivers" <CO-RESUME ,CO "x gauge">>
 <ASSERT-TEXT "four places" <CO-RESUME ,CO "x frame">>
 <ASSERT-NOT-TEXT "no verb" <CO-RESUME ,CO "x padding">>
 <ASSERT-TEXT "breaker catches" <CO-RESUME ,CO "press breaker">>
 <ASSERT "pressing resets the breaker" ,POWER>
 <SETG HERE ,CLINIC> <MOVE ,WINNER ,HERE>
 <ASSERT-TEXT "unscented soap" <CO-RESUME ,CO "x exam bed">>
 <ASSERT-TEXT "unscented soap" <CO-RESUME ,CO "x bed">>
 <ASSERT-TEXT "thumbnail marks" <CO-RESUME ,CO "what is mara">>
 <SETG HERE ,QUARANTINE> <MOVE ,WINNER ,HERE>
 <ASSERT-TEXT "black bar" <CO-RESUME ,CO "x flags">>
 <ASSERT-TEXT "black bar" <CO-RESUME ,CO "x interlock flags">>
 <ASSERT-TEXT "black bar" <CO-RESUME ,CO "read inspection flags">>
 <ASSERT-TEXT "far end of the bench" <CO-RESUME ,CO "sit on bench">>
 ;"Giving is showing: the crew hand the item back, in either word order."
 <MOVE ,WRENCH ,WINNER>
 <SETG HERE ,GALLEY> <MOVE ,WINNER ,HERE>
 <ASSERT-TEXT "Still the right tool" <CO-RESUME ,CO "give wrench to ivo">>
 <ASSERT-TEXT "Still the right tool" <CO-RESUME ,CO "give ivo wrench">>
 <ASSERT "Ivo hands the wrench back" <IN? ,WRENCH ,WINNER>>
 <ASSERT-NOT-TEXT "refuses it politely" <CO-RESUME ,CO "give wrench to ivo">>
 <MOVE ,STRIP ,WINNER> <SETG PROOF T>
 <ASSERT-TEXT "I consent to evacuation" <CO-RESUME ,CO "give strip to ivo">>
 <ASSERT "giving the measured strip records consent" ,CONSENT>
 <ASSERT "the strip comes back" <IN? ,STRIP ,WINNER>>
>
