;"The RPG kernel: what every tabletop system shares, with no language, no
  story and no system's numbers. A system (rulesets/<system>/system.zil)
  supplies the routines SYSTEM-ROLL, SYSTEM-GRADE and SYSTEM-DERIVE, the
  tables SHEET-LAYOUT and STATUS-LAYOUT and its attribute constants; a
  language (rulesets/rpg/<lang>.zil and rulesets/<system>/<lang>.zil)
  supplies the words: ATTR-NAME, TIER-NAME, CHECK-TERMS (the system's names),
  OF-WORD, NAME-PROMPT and the SAY-NO-* replies (the language's).

  A character is a table of CHARACTER-SIZE words. Slot 0 holds the archetype
  the character became (0: none yet). Attributes are numbered 1 to 15 by the
  system; attribute A's maximum, if it is a resource, lives in slot A+16."

<CONSTANT CHARACTER-SIZE 32>
<CONSTANT MAX-OFFSET 16>
;"A resource with this maximum has no ceiling and is shown without one."
<CONSTANT NO-LIMIT 9999>

;"The player. Opponents are characters too: <GLOBAL OGRE-STATS <ITABLE 32 0>>."
<GLOBAL HERO <ITABLE 32 0>>
<GLOBAL HERO-NAME <ITABLE 33 (BYTE) 0>>
<GLOBAL LAST-ROLL 0>
<GLOBAL LAST-TIER 0>

;"Attributes and resources"
<ROUTINE STAT (TBL ATTR) <GET .TBL .ATTR>>
<ROUTINE SET-STAT (TBL ATTR N) <PUT .TBL .ATTR .N> .N>
<ROUTINE MAX-STAT (TBL ATTR) <GET .TBL <+ .ATTR ,MAX-OFFSET>>>

;"A resource starts full."
<ROUTINE SET-RESOURCE (TBL ATTR MAX)
 <PUT .TBL <+ .ATTR ,MAX-OFFSET> .MAX>
 <PUT .TBL .ATTR .MAX>
 .MAX>

;"Spending refuses (false) when the resource is short or N is not positive."
<ROUTINE SPEND (TBL ATTR N)
 <COND (<OR <L? .N 1> <L? <STAT .TBL .ATTR> .N>> <RFALSE>)
       (T <SET-STAT .TBL .ATTR <- <STAT .TBL .ATTR> .N>> <RTRUE>)>>

;"Gaining stops at the maximum and returns what was gained."
<ROUTINE GAIN (TBL ATTR N "AUX" ROOM)
 <SET ROOM <- <MAX-STAT .TBL .ATTR> <STAT .TBL .ATTR>>>
 <COND (<L? .N .ROOM> <SET ROOM .N>)>
 <COND (<L? .ROOM 0> <SET ROOM 0>)>
 <SET-STAT .TBL .ATTR <+ <STAT .TBL .ATTR> .ROOM>>
 .ROOM>

;"Losing stops at zero and returns what was lost."
<ROUTINE LOSE (TBL ATTR N "AUX" HAVE)
 <SET HAVE <STAT .TBL .ATTR>>
 <COND (<L? .N 0> <SET N 0>)>
 <COND (<L? .HAVE .N> <SET N .HAVE>)>
 <SET-STAT .TBL .ATTR <- .HAVE .N>>
 .N>

;"Dice: COUNT rolls of a SIDES-sided die, summed. RANDOM keeps seeded play
  replayable."
<ROUTINE ROLL (COUNT SIDES "AUX" (TOTAL 0))
 <REPEAT ()
  <COND (<L? .COUNT 1> <RETURN>)>
  <SET TOTAL <+ .TOTAL <RANDOM .SIDES>>>
  <SET COUNT <- .COUNT 1>>>
 .TOTAL>

;"The system rolls and grades; the language reports; the check is true when
  the tier reaches REQUIRED. DIFFICULTY means what the system says it means."
<ROUTINE CHECK (TBL ATTR DIFFICULTY REQUIRED "AUX" ROLL TIER)
 <SET ROLL <SYSTEM-ROLL .TBL .ATTR .DIFFICULTY>>
 <SET TIER <SYSTEM-GRADE .TBL .ATTR .DIFFICULTY .ROLL>>
 <SETG LAST-ROLL .ROLL>
 <SETG LAST-TIER .TIER>
 <REPORT-CHECK .TBL .ATTR .DIFFICULTY .ROLL .TIER>
 <COND (<L? .TIER .REQUIRED> <RFALSE>) (T <RTRUE>)>>

;"The language's report of a check, e.g. 'Rank 30; d100 57; success.': the
  system's names for what was rolled against (CHECK-TERMS), the roll, and the
  tier's name (TIER-NAME)."
<ROUTINE REPORT-CHECK (TBL ATTR DIFFICULTY ROLL TIER)
 <CHECK-TERMS .TBL .ATTR .DIFFICULTY>
 <TELL " " N .ROLL "; ">
 <TIER-NAME .TIER>
 <TELL "." CR>>

;"An archetype is an LTABLE of starting values for attributes 1, 2, ...
  BECOME copies them, remembers the archetype, and lets the system derive the
  rest (resources, maxima)."
<ROUTINE BECOME (TBL KIND "AUX" (I 1) N)
 <SET N <GET .KIND 0>>
 <REPEAT ()
  <COND (<G? .I .N> <RETURN>)>
  <PUT .TBL .I <GET .KIND .I>>
  <SET I <+ .I 1>>>
 <PUT .TBL 0 .KIND>
 <SYSTEM-DERIVE .TBL>
 .TBL>

<ROUTINE BECAME? (TBL) <NOT <0? <GET .TBL 0>>>>
<ROUTINE KIND-OF (TBL) <GET .TBL 0>>

;"The sheet shows SHEET-LAYOUT's attributes, two to a line, by the
  language's names. A resource with a ceiling shows 'now/max'."
;"An attribute with a maximum, below NO-LIMIT, is a resource with a ceiling."
<ROUTINE CEILING? (TBL ATTR)
 <AND <G? <MAX-STAT .TBL .ATTR> 0> <L? <MAX-STAT .TBL .ATTR> ,NO-LIMIT>>>

<ROUTINE PRINT-SHEET-ENTRY (TBL ATTR)
 <ATTR-NAME .ATTR>
 <TELL ": " N <STAT .TBL .ATTR>>
 <COND (<CEILING? .TBL .ATTR> <TELL "/" N <MAX-STAT .TBL .ATTR>>)>>

<ROUTINE PRINT-SHEET (TBL "AUX" (I 1) N)
 <SET N <GET ,SHEET-LAYOUT 0>>
 <REPEAT ()
  <COND (<G? .I .N> <RETURN>)>
  <PRINT-SHEET-ENTRY .TBL <GET ,SHEET-LAYOUT .I>>
  <COND (<NOT <G? <+ .I 1> .N>> <TELL ", "> <PRINT-SHEET-ENTRY .TBL <GET ,SHEET-LAYOUT <+ .I 1>>>)>
  <CRLF>
  <SET I <+ .I 2>>>>

;"The status line shows STATUS-LAYOUT's attributes: 'Health 3 of 10, Karma 7'."
<ROUTINE PRINT-STATUS (TBL "AUX" (I 1) N A)
 <SET N <GET ,STATUS-LAYOUT 0>>
 <REPEAT ()
  <COND (<G? .I .N> <RETURN>)>
  <SET A <GET ,STATUS-LAYOUT .I>>
  <COND (<G? .I 1> <TELL ", ">)>
  <ATTR-NAME .A>
  <TELL " " N <STAT .TBL .A>>
  <COND (<CEILING? .TBL .A> <OF-WORD> <TELL N <MAX-STAT .TBL .A>>)>
  <SET I <+ .I 1>>>
 <TELL ".">>

;"The hero's name: a line the reader types, kept in HERO-NAME. READ stores
  the reply lowercase, so the name is capitalised word by word. A line with
  characters outside printable ASCII is refused rather than stored half; a
  blank line keeps the current name."
<ROUTINE NAME-STATUS ("AUX" (I 1) C (STATUS 1))
 <REPEAT ()
  <SET C <GETB ,P-INBUF .I>>
  <COND (<OR <0? .C> <G? .I 119>> <RETURN>)
        (<OR <L? .C 32> <G? .C 126>> <SET STATUS 0> <RETURN>)
        (<N==? .C 32> <SET STATUS 2>)>
  <SET I <+ .I 1>>>
 .STATUS>

;"Spaces are collapsed, and a name longer than the table is cut at the last
  whole word that fits."
<ROUTINE COPY-NAME ("AUX" (I 1) (J 0) C (CAP T) (SPACE 0))
 <REPEAT ()
  <SET C <GETB ,P-INBUF .I>>
  <COND (<OR <0? .C> <G? .I 119>> <RETURN>)
        (<G? .J 31>
         <COND (<AND <N==? .C 32> <G? .SPACE 0>> <SET J .SPACE>)>
         <RETURN>)>
  <COND (<AND <==? .C 32> <OR <0? .J> <==? <GETB ,HERO-NAME <- .J 1>> 32>>>)
        (T
         <COND (<==? .C 32> <SET SPACE .J>)>
         <COND (<AND .CAP <NOT <L? .C 97>> <NOT <G? .C 122>>> <SET C <- .C 32>>)>
         <SET CAP <EQUAL? .C 32 45>>
         <PUTB ,HERO-NAME .J .C>
         <SET J <+ .J 1>>)>
  <SET I <+ .I 1>>>
 <COND (<AND <G? .J 0> <==? <GETB ,HERO-NAME <- .J 1>> 32>> <SET J <- .J 1>>)>
 <PUTB ,HERO-NAME .J 0>>

<ROUTINE NAMED? () <NOT <0? <GETB ,HERO-NAME 0>>>>

<ROUTINE PRINT-NAME ("AUX" (I 0) C)
 <REPEAT () <SET C <GETB ,HERO-NAME .I>> <COND (<0? .C> <RETURN>)>
  <PRINTC .C> <SET I <+ .I 1>>>>

;"Asks for a name (the language's prompt), stores it, and returns 0 when the
  line was refused, 1 when it was blank and 2 when the name was stored."
<ROUTINE ASK-NAME ("AUX" STATUS)
 <NAME-PROMPT>
 <READ ,P-INBUF ,P-LEXV>
 <SET STATUS <NAME-STATUS>>
 <COND (<==? .STATUS 2> <COPY-NAME>)>
 .STATUS>

;"The generic actions. A story's objects answer them in their ACTION
  routines; these run when no object does, with the language's reply."
<ROUTINE V-RPG-ATTACK () <SAY-NO-TARGET>>
<ROUTINE V-RPG-POWER () <SAY-NO-POWER>>
<ROUTINE V-RPG-RESCUE () <SAY-NO-RESCUE>>
<ROUTINE V-RPG-DISABLE () <SAY-NO-CONTROL>>
<ROUTINE V-RPG-CHOOSE () <SAY-NO-PROFILE>>
<ROUTINE V-RPG-NAME () <SAY-NO-NAME>>
<ROUTINE V-RPG-STATUS ()
 <COND (<BECAME? ,HERO> <PRINT-STATUS ,HERO> <CRLF>)
       (T <SAY-NO-STATUS>)>>

;"The story calls this once, after it has accepted the player's character.
  Selection, previews and naming are setup, so play starts at turn zero."
<GLOBAL RPG-STARTED <>>

<ROUTINE RPG-PREPARE () <SETG CLOCK-PAUSED T>>

<ROUTINE RPG-BEGIN (OPENING)
 <COND (,RPG-STARTED <RFALSE>)>
 <SETG RPG-STARTED T>
 <SETG CLOCK-PAUSED <>>
 <SETG CLOCK-WAIT T>
 <APPLY .OPENING>
 <RTRUE>>

;"Report the same ordered rows and live resources used by PRINT-SHEET.
  The host owns the export format and escaping."
<ROUTINE EXPORT-SHEET-RANKS (TBL "OPTIONAL" ROW "AUX" (I 1) N A)
 <SET N <GET ,SHEET-LAYOUT 0>>
 <REPEAT ()
  <COND (<G? .I .N> <RETURN>)>
  <SET A <GET ,SHEET-LAYOUT .I>>
  <COND (.ROW <APPLY .ROW .TBL .A>)
        (T <ATTR-NAME .A>
           <SHEET-ROW <TAKE-OUTPUT> <STAT .TBL .A>
             <COND (<CEILING? .TBL .A> <MAX-STAT .TBL .A>) (T 0)>>)>
  <SET I <+ .I 1>>>>
