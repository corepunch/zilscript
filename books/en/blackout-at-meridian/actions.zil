<SYNTAX STRIKE OBJECT = V-HERO-STRIKE>
<SYNTAX RESCUE OBJECT = V-HERO-RESCUE>
<SYNTAX DISABLE OBJECT = V-HERO-DISABLE>
<SYNTAX CHOOSE OBJECT = V-HERO-CHOOSE>
<SYNTAX FOCUS OBJECT = V-HERO-FOCUS>
<SYNTAX NAME OBJECT = V-HERO-NAME>

<ROUTINE V-VERSION () <TELL "Blackout at Meridian|Original superhero prototype|Release " N ,RELEASEID CR>>
<ROUTINE V-SCORE ("OPTIONAL" (ASK? T)) <HERO-SHEET>>
<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG COMPACT-ROOM-LISTS T> <SETG HERE ,DISPATCH> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <MOVE ,DOSSIER ,WINNER>
 <TELL D ,HERE CR> <V-LOOK> <MAIN-LOOP> <AGAIN>>

<ROUTINE HERO-COPY-NAME ("AUX" (I 0) C)
 <REPEAT ()
  <SET C <GETB ,P-INBUF <+ .I 1>>>
  <COND (<OR <0? .C> <G? .I 31> <L? .C 32> <G? .C 126>> <RETURN>)>
  <PUTB ,HERO-NAME .I .C> <SET I <+ .I 1>>>
 <PUTB ,HERO-NAME .I 0>>
<ROUTINE HERO-PRINT-NAME ("AUX" (I 0) C)
 <COND (<0? <GETB ,HERO-NAME 0>> <TELL "Meridian"> <RTRUE>)>
 <REPEAT () <SET C <GETB ,HERO-NAME .I>> <COND (<0? .C> <RETURN>)>
  <PRINTC .C> <SET I <+ .I 1>>>>

<ROUTINE DISPATCH-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK>
 <TELL "You are in a dispatch office. Rain draws silver lines on the window. The city has lost power, and a tram is hanging over the river. ">
 <COND (<0? ,HERO-CLASS> <TELL "Choose your profile: [[Bulwark]], [[Arc]] or [[Lens]]. Name your hero using the [[character sheet->sheet]].">)
 (T <TELL "Your [[character sheet->sheet]] is ready. The bridge is to the [[north]].">)> <CRLF>)>>
<ROUTINE BRIDGE-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK>
 <TELL "You are on the bridge. A rescue crew waits below the rails. ">
 <COND (,RESCUED <TELL "The passengers are safe. The relay station is to the [[east]].">)
 (T <TELL "A [[tram]] hangs over the river. Rescue its passengers.">)>
 <TELL " Dispatch is to the [[south]]." CR>)>>
<ROUTINE RELAY-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK>
 <TELL "You are inside the city's relay station. A [[guard drone->drone]] blocks the [[relay console->console]]. An [[emergency kit->kit]] sits by the door. The bridge is to the [[west]]." CR>)>>

<ROUTINE PROFILE-F ()
 <COND (<VERB? EXAMINE> <COND (<EQUAL? ,PRSO ,VANGUARD> <TELL "Heavy rescue and close combat.">)
 (<EQUAL? ,PRSO ,ARC> <TELL "Fast movement and electrical projection.">)
 (T <TELL "Analysis and kinetic fields.">)> <CRLF> <RTRUE>)
 (<VERB? HERO-CHOOSE>
 <COND (<NOT <0? ,HERO-CLASS>> <TELL "Your profile is already registered." CR> <RTRUE>)>
 <COND (<EQUAL? ,PRSO ,VANGUARD> <HERO-INIT 30 10 40 40 6 10 10 30> <SETG HERO-CLASS 1>)
 (<EQUAL? ,PRSO ,ARC> <HERO-INIT 20 40 10 20 20 20 10 40> <SETG HERO-CLASS 2>)
 (T <HERO-INIT 10 20 10 20 40 30 20 30> <SETG HERO-CLASS 3>)>
 <TELL "Profile registered. The bridge is to the [[north]]." CR> <HERO-SHEET> <RTRUE>)>>
<ROUTINE SHEET-F ()
 <COND (<VERB? EXAMINE READ> <HERO-PRINT-NAME> <CRLF> <HERO-SHEET> <RTRUE>)
 (<VERB? HERO-NAME> <TELL "Type your hero name (up to 32 ASCII characters)." CR>
 <READ ,P-INBUF ,P-LEXV> <HERO-COPY-NAME> <TELL "Registered: "> <HERO-PRINT-NAME> <CRLF> <RTRUE>)>>

<ROUTINE HERO-RESCUE-RANK ()
 <COND (<==? ,HERO-CLASS 1> ,HERO-STRENGTH)
 (<==? ,HERO-CLASS 2> ,HERO-AGILITY) (T ,HERO-POWER)>>
<ROUTINE TRAM-F ()
 <COND (<VERB? EXAMINE> <TELL "The front carriage is caught on a cable. People are still inside." CR> <RTRUE>)
 (<VERB? HERO-RESCUE>
 <COND (<0? ,HERO-CLASS> <TELL "Register a profile at dispatch first." CR> <RTRUE>)>
 <COND (,RESCUED <TELL "Everyone is already safe." CR>)
 (<HERO-CHECK <HERO-RESCUE-RANK> 1>
 <SETG RESCUED T> <HERO-REWARD 10>
 <TELL "You steady the carriage and guide the last passenger to the crew. The relay station is to the [[east]]." CR>)
 (T <HERO-DAMAGE 5 0> <TELL "The cable slips. You take a hit, but the crew holds the tram." CR> <HERO-LOSS-CHECK>)> <RTRUE>)>>
<ROUTINE HERO-LOSS-CHECK ()
 <COND (<0? ,HERO-HEALTH> <TELL "The rescue crew carries you to safety. The city will need another hero tonight." CR> <QUIT>)>>
<ROUTINE DRONE-F ()
 <COND (<VERB? EXAMINE> <TELL "Drone integrity: " N ,DRONE-HP CR> <RTRUE>)
 (<VERB? HERO-STRIKE>
 <COND (<0? ,HERO-CLASS> <TELL "Register a profile at dispatch first." CR> <RTRUE>)>
 <COND (,DISABLED <TELL "The drone is inactive." CR>)
 (<HERO-CHECK ,HERO-FIGHTING 1>
 <SETG DRONE-HP <- ,DRONE-HP ,HERO-POWER>>
 <COND (<NOT <G? ,DRONE-HP 0>> <SETG DRONE-HP 0> <SETG DISABLED T> <TELL "The drone drops. The [[console]] is unguarded." CR>)
 (T <TELL "The drone staggers." CR>)>)
 (T <TELL "Your attack misses." CR>)>
 <COND (<NOT ,DISABLED> <HERO-DAMAGE 10 0> <TELL "The drone counters." CR> <HERO-LOSS-CHECK>)> <RTRUE>)>>
<ROUTINE CONSOLE-F ()
 <COND (<VERB? EXAMINE> <TELL "A manual bypass could cut the rogue control signal." CR> <RTRUE>)
 (<VERB? HERO-DISABLE>
 <COND (<0? ,HERO-CLASS> <TELL "Register a profile at dispatch first." CR> <RTRUE>)>
 <COND (<OR ,DISABLED <HERO-CHECK ,HERO-REASON 2>>
 <SETG DISABLED T> <SETG DRONE-HP 0> <HERO-REWARD 20>
 <TELL "The relay returns to local control. Across the river, the windows light up one by one. Dispatch calls your name: ">
 <HERO-PRINT-NAME> <TELL ". Meridian is safe." CR> <HERO-SHEET> <QUIT>)
 (T <HERO-DAMAGE 10 0> <TELL "The drone intercepts you before you reach the bypass." CR> <HERO-LOSS-CHECK>)> <RTRUE>)>>
<ROUTINE KIT-F ()
 <COND (<VERB? EXAMINE> <TELL "A single-use emergency recovery kit costs 10 Karma to activate." CR> <RTRUE>)
 (<VERB? HERO-FOCUS>
 <COND (<0? ,HERO-CLASS> <TELL "Register a profile at dispatch first." CR> <RTRUE>)>
 <COND (,BOOSTED <TELL "The kit is empty." CR>)
 (<HERO-SPEND 10> <SETG BOOSTED T> <SETG HERO-HEALTH <+ ,HERO-HEALTH 20>>
 <COND (<G? ,HERO-HEALTH ,HERO-MAX-HEALTH> <SETG HERO-HEALTH ,HERO-MAX-HEALTH>)>
 <TELL "You recover up to 20 Health." CR>)
 (T <TELL "Not enough Karma." CR>)> <RTRUE>)>>
<ROUTINE V-HERO-NAME () <TELL "Use the character sheet to register a name." CR>>
<ROUTINE V-HERO-STRIKE () <TELL "That is not a target." CR>>
<ROUTINE V-HERO-RESCUE () <TELL "Nobody needs rescuing there." CR>>
<ROUTINE V-HERO-DISABLE () <TELL "That is not a control system." CR>>
<ROUTINE V-HERO-CHOOSE () <TELL "That is not a profile." CR>>
<ROUTINE V-HERO-FOCUS () <TELL "That does not help." CR>>
