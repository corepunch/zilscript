; "The routines of this book that replace the world's own (and so must come
  after the language base in every edition): the version line, the score, the
  opening and USE. They say nothing themselves; the editions' MSG-* do."
<SETG RPG-PRESETS ,MERIDIAN-PRESETS>

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
 <RPG-PREPARE>
 <COND (<G? ,RPG-PRESET-INDEX 0>
        <SETG HERO-CLASS ,RPG-PRESET-INDEX>
        <RPG-BEGIN ,OPEN-MISSION> <SETG CLOCK-WAIT <>>)
       (T <TELL D ,HERE CR> <MSG-SETUP> <CRLF>)>
 <MAIN-LOOP> <AGAIN>>

<ROUTINE OPEN-MISSION ()
 <CRLF> <MSG-OPENING> <V-LOOK>>

<ROUTINE RPG-EXPORT-SHEET ("AUX" NAME PROFILE)
 <COND (<NOT ,RPG-STARTED> <RFALSE>)>
 <HERO-PRINT-CLASS> <SET PROFILE <TAKE-OUTPUT>>
 <COND (<NAMED?> <PRINT-NAME> <SET NAME <TAKE-OUTPUT>>)
       (T <SET NAME .PROFILE>)>
 <SHEET-IDENTITY .NAME .PROFILE>
 <EXPORT-SHEET-RANKS ,HERO ,FASERIP-SHEET-ROW>
 <RTRUE>>

<ROUTINE V-USE () <MSG-USE>>

;"Optional portrait asset key. Use the book's stable preset ID rather
  than its translated class name or the player's custom character name."
<ROUTINE RPG-PORTRAIT ("AUX" ENTRY)
 <COND (<NOT ,RPG-STARTED> <RFALSE>)>
 <SET ENTRY <RPG-PRESET-AT ,HERO-CLASS>>
 <COND (<NOT .ENTRY> <RFALSE>)>
 <TELL <GET .ENTRY 0>>
 <TAKE-OUTPUT>>
