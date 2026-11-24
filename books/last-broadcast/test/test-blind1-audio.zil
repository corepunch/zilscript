; Capture the actual opening before the first command, not a later casebook.
<INSERT-FILE "books/last-broadcast/last-broadcast">
<GLOBAL CO <CO-CREATE GO T>>
<ROUTINE RUN-TEST ()
 <ASSERT-TEXT "gull cough twice, then Ada's appeal to save the station: 'Even this old island can learn to speak.'" <CO-RESUME ,CO "">>
 <ASSERT-TEXT "two coughs" <CO-RESUME ,CO "read casebook">>
>
