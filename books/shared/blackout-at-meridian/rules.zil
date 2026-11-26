; "The routines of this book that replace the world's own (and so must come
  after the language base in every edition): the version line, the score, the
  opening and USE. They say nothing themselves; the editions' MSG-* do."
<ROUTINE V-VERSION () <MSG-VERSION>>

;"The score is the hero: the name and the character sheet. FINISH prints it
  under every ending."
<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <MSG-SCORE-HERO> <HERO-PRINT-NAME>
 <COND (<0? ,HERO-CLASS> <MSG-SCORE-UNREGISTERED> <RTRUE>)>
 <MSG-SCORE-OPEN-CLASS> <HERO-PRINT-CLASS> <MSG-SCORE-CLOSE-CLASS> <PRINT-SHEET ,HERO>>

<ROUTINE GO ()
 <V-VERSION> <CRLF> <SETUP-EDITION>
 <SETG HERE ,DISPATCH> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <MOVE ,DOSSIER ,WINNER>
 <SET-RESOURCE ,DRONE-STATS ,A-HEALTH 40>
 <MSG-OPENING>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<ROUTINE V-USE () <MSG-USE>>
