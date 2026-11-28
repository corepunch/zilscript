"Completion fixture: verbs that require the object to be in hand."
<CONSTANT RELEASEID 1>
<VERSION ZIP>
<INSERT-FILE "rulesets.classic.en">

;"FIX is shorter than nothing, but as long as PUT: a story synonym must not
replace the ruleset's own verb for V-PUT-ON in completion."
<SYNTAX FIX OBJECT (HELD HAVE) ON OBJECT = V-PUT-ON PRE-PUT>
;"TAKE HAVE: the parser takes a takeable object first, so it is eligible for completion."
<SYNTAX TWIRL OBJECT (TAKE HAVE) = V-TWIRL>

<ROUTINE V-TWIRL () <TELL "You twirl " T ,PRSO "." CR>>

<DIRECTIONS NORTH SOUTH EAST WEST>

<ROOM YARD (DESC "Yard") (IN ROOMS) (FLAGS RLANDBIT ONBIT) (ACTION YARD-F)>

<OBJECT PEBBLE (IN YARD) (DESC "pebble") (SYNONYM PEBBLE)
 (FLAGS TAKEBIT) (ACTION PEBBLE-F)>

<OBJECT BOULDER (IN YARD) (DESC "boulder") (SYNONYM BOULDER)
 (FLAGS NDESCBIT) (ACTION BOULDER-F)>

<OBJECT SHELF (IN YARD) (DESC "shelf") (SYNONYM SHELF)
 (FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT) (CAPACITY 20) (ACTION SHELF-F)>

<ROUTINE YARD-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "A bare yard. A pebble lies by a boulder under a shelf." CR>)>>

<ROUTINE PEBBLE-F ()
 <COND (<VERB? SHAKE> <TELL "The pebble rattles in your fist." CR>)
       (<VERB? TWIRL> <TELL "You twirl the pebble." CR>)
       (<VERB? PUT-ON> <RFALSE>)>>

<ROUTINE SHELF-F ()
 <COND (<VERB? EXAMINE> <TELL "A plank shelf." CR>)>>

<ROUTINE BOULDER-F ()
 <COND (<VERB? SHAKE> <TELL "You can't lift it to shake it." CR>)
       (<VERB? TWIRL> <TELL "It is far too heavy." CR>)>>

<ROUTINE GO ()
 <SETG HERE ,YARD> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>
