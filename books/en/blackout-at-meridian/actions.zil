
<ROUTINE V-VERSION () <TELL "Blackout at Meridian|An original superhero adventure, AdventureArena 2026|Release " N ,RELEASEID CR>>

;"The score is the hero: the name and the character sheet. FINISH prints it
  under every ending."
<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <TELL "Hero: "> <HERO-PRINT-NAME>
 <COND (<0? ,HERO-CLASS> <TELL ", no profile registered yet." CR> <RTRUE>)>
 <TELL " (" > <HERO-PRINT-CLASS> <TELL ")" CR> <HERO-SHEET>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG COMPACT-ROOM-LISTS T> <SETG HERE ,DISPATCH> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <MOVE ,DOSSIER ,WINNER>
 <TELL "At nine o'clock the storm took Meridian's power, and then someone took the relay station that should have brought it back. A guard drone now holds the station, and on Meridian Bridge a tram full of passengers hangs from a broken cable over the river. You are the city's newest hero, and tonight is your first call. Register a profile at dispatch, then get to the bridge. (Type HELP at any time for how to play.)" CR CR>
 <TELL D ,HERE CR> <V-LOOK> <MAIN-LOOP> <AGAIN>>

<SYNTAX HELP = V-BOOK-HELP>
<SYNONYM HELP HINT HINTS>
<SYNTAX USE OBJECT = V-BOOK-USE>
<SYNTAX LISTEN = V-BOOK-LISTEN>

<ROUTINE V-BOOK-HELP ()
 <TELL "Type commands such as LOOK, EXAMINE BOARD or NORTH, or choose the linked words. Each hero action rolls d100 against one of your ranks, and higher rolls are better. A failure costs Health, and at 0 Health your night is over. READ SHEET shows your ranks, DIAGNOSE your Health and Karma, and NAME SHEET gives your hero a name." CR>
 <COND (<0? ,HERO-CLASS> <TELL "Right now: examine the profiles on the duty board and CHOOSE BULWARK, ARC or LENS." CR>)
       (<NOT ,RESCUED> <TELL "Right now: go north to the bridge and RESCUE the PASSENGERS." CR>)
       (T <TELL "Right now: in the relay station, STRIKE the DRONE or DISABLE the CONSOLE. USE KIT restores up to 20 Health once, for 10 Karma." CR>)>>

<ROUTINE V-BOOK-USE () <TELL "Say what you want to do with " THE ,PRSO "." CR>>

<ROUTINE V-BOOK-LISTEN ()
 <COND (<EQUAL? ,HERE ,DISPATCH> <TELL "Only the rain on the glass." CR>)
       (<EQUAL? ,HERE ,BRIDGE> <TELL "Rain, wind, and the cable creaking over the river." CR>)
       (,DISABLED <TELL "The deep hum of the console, and nothing else." CR>)
       (T <TELL "The deep hum of the console and the high whine of the drone's rotors." CR>)>>

;"READ stores the reply lowercase, so the name is capitalised word by word.
  A line with characters outside printable ASCII is refused rather than
  stored half; a blank line keeps the current name."
<ROUTINE HERO-NAME-STATUS ("AUX" (I 1) C (STATUS 1))
 <REPEAT ()
  <SET C <GETB ,P-INBUF .I>>
  <COND (<OR <0? .C> <G? .I 119>> <RETURN>)
        (<OR <L? .C 32> <G? .C 126>> <SET STATUS 0> <RETURN>)
        (<N==? .C 32> <SET STATUS 2>)>
  <SET I <+ .I 1>>>
 .STATUS>

;"Spaces are collapsed, and a name longer than the table is cut at the last
  whole word that fits."
<ROUTINE HERO-COPY-NAME ("AUX" (I 1) (J 0) C (CAP T) (SPACE 0))
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

<ROUTINE HERO-PRINT-NAME ("AUX" (I 0) C)
 <COND (<0? <GETB ,HERO-NAME 0>> <TELL "Meridian"> <RTRUE>)>
 <REPEAT () <SET C <GETB ,HERO-NAME .I>> <COND (<OR <0? .C> <G? .I 31>> <RETURN>)>
  <PRINTC .C> <SET I <+ .I 1>>>>

<ROUTINE HERO-PRINT-CLASS ()
 <COND (<==? ,HERO-CLASS 1> <TELL "Bulwark">)
       (<==? ,HERO-CLASS 2> <TELL "Arc">)
       (T <TELL "Lens">)>>

;"Damage from a failed or answered action: the cost, then the Health left,
  then the ending if nothing is left."
<ROUTINE HERO-HURT (AMOUNT)
 <HERO-DAMAGE .AMOUNT 0>
 <TELL " (Health " N ,HERO-HEALTH " of " N ,HERO-MAX-HEALTH ".)" CR>
 <HERO-LOSS-CHECK>>

<ROUTINE HERO-LOSS-CHECK ()
 <COND (<0? ,HERO-HEALTH>
        <CRLF>
        <COND (<EQUAL? ,HERE ,RELAY> <TELL "Your knees give way on the concrete floor. The rescue crew drags you out into the rain, and behind you the drone keeps its watch over the dark city.">)
              (T <TELL "Your grip fails and you fall against the rails. The crew pulls the passengers down without you and carries you off the bridge in their net.">)>
        <TELL " Meridian will need another hero tonight." CR CR "THE END: CARRIED FROM THE STORM" CR CR>
        <FINISH>)>>

;"JUMP with nothing to jump is fatal in the base wherever DOWN is a refusal
  string, as on the bridge; here it is only a thought."
<ROUTINE ROOM-BEG ()
 <COND (<AND <VERB? LEAP> <NOT ,PRSO>>
        <COND (<EQUAL? ,HERE ,BRIDGE> <TELL "You look down at the river and think better of it. The passengers need you up here." CR>)
              (T <TELL "You bounce on your heels, ready for anything." CR>)>)
       (<AND <VERB? SWIM> <NOT ,PRSO>> <PERFORM ,V?SWIM ,RIVER> <RTRUE>)>>



<ROUTINE DISPATCH-F (RARG)
 <COND (<EQUAL? .RARG ,M-BEG> <ROOM-BEG>)
       (<EQUAL? .RARG ,M-LOOK>
        <COND (<0? ,HERO-CLASS>
               <TELL "You are in Meridian's emergency dispatch office, a cramped room running on battery power. Rain runs in silver lines down the [[window]], and beyond it the whole [[city]] is dark. Three hero profiles are pinned to the [[duty board->board]]: [[Bulwark]], [[Arc]] and [[Lens]]. Choose one, and give your hero a name on your [[character sheet->sheet]] if you like. The street door leads [[north]] to Meridian Bridge.">)
              (T
               <TELL "You are in Meridian's emergency dispatch office, a cramped room running on battery power. Rain runs in silver lines down the [[window]], and beyond it the whole [[city]] is dark. Your profile is marked active on the [[duty board->board]]. The street door leads [[north]] to Meridian Bridge.">)>
        <CRLF>)>>

<ROUTINE BRIDGE-F (RARG)
 <COND (<EQUAL? .RARG ,M-BEG> <ROOM-BEG>)
       (<EQUAL? .RARG ,M-LOOK>
        <TELL "You are on Meridian Bridge, in the full force of the rain. ">
        <COND (,RESCUED <TELL "The empty [[tram]] still hangs through the broken [[rails]] from its overhead [[cable]], but its passengers are safe with the rescue [[crew]] below. The [[relay station->station]] stands at the east end of the bridge, its [[door]] forced open, and the way [[east]] is clear.">)
              (T <TELL "Halfway across, the front carriage of a [[tram]] has broken through the [[rails]] and hangs over the [[river]], held up only by a sagging overhead [[cable]]. People are still inside. Below, a rescue [[crew]] waits with a net. The [[relay station->station]] stands at the east end of the bridge, but the passengers come first.">)>
        <TELL " Dispatch is back to the [[south]]." CR>)>>

<ROUTINE RELAY-F (RARG)
 <COND (<EQUAL? .RARG ,M-BEG> <ROOM-BEG>)
       (<EQUAL? .RARG ,M-LOOK>
        <TELL "You are inside the relay station, a concrete hall that hums with stolen power. All of Meridian's power runs through the [[relay console->console]] at the far end. ">
        <COND (,DISABLED <TELL "The [[guard drone->drone]] lies dark on the floor in front of it. ">)
              (T <TELL "A [[guard drone->drone]] hovers in front of it, its red eye following you. ">)>
        <COND (,BOOSTED <TELL "The [[emergency kit->kit]] hangs open and empty beside the [[door]], which leads back [[west]] to the bridge." CR>)
              (T <TELL "An [[emergency kit->kit]] is clipped to the wall beside the [[door]], which leads back [[west]] to the bridge." CR>)>)>>

<ROUTINE PROFILE-F ()
 <COND (<VERB? EXAMINE READ>
        <COND (<EQUAL? ,PRSO ,VANGUARD> <TELL "Bulwark is built for heavy rescue and close combat: great Strength and Endurance, but little Reason. Health 120, Karma 26.">)
              (<EQUAL? ,PRSO ,ARC> <TELL "Arc moves fast and throws lightning: top Agility and Power, light on Strength. Health 90, Karma 50.">)
              (T <TELL "Lens reads machines and bends kinetic fields: high Reason and Intuition, but fragile in a fight. Health 60, Karma 90.">)>
        <COND (<==? ,HERO-CLASS <PROFILE-CLASS ,PRSO>> <TELL " This is your profile.">)
              (<0? ,HERO-CLASS> <TELL " To take it on, choose it.">)>
        <CRLF> <RTRUE>)
       (<VERB? TAKE> <TELL "The card stays pinned to the board. Choose it, and dispatch sends that hero." CR>)
       (<VERB? HERO-CHOOSE BOOK-USE>
        <COND (<NOT <0? ,HERO-CLASS>>
               <TELL "You are already registered as "> <HERO-PRINT-CLASS>
               <TELL ". Dispatch does not change heroes in the middle of a call." CR> <RTRUE>)>
        <COND (<EQUAL? ,PRSO ,VANGUARD> <HERO-INIT 30 10 40 40 6 10 10 30>)
              (<EQUAL? ,PRSO ,ARC> <HERO-INIT 20 40 10 20 20 20 10 40>)
              (T <HERO-INIT 10 20 10 20 40 30 20 30>)>
        <SETG HERO-CLASS <PROFILE-CLASS ,PRSO>>
        <TELL "Dispatch registers you as "> <HERO-PRINT-CLASS> <TELL ". Your ranks:" CR>
        <HERO-SHEET>
        <TELL "The bridge is to the [[north]]." CR> <RTRUE>)
       (<VERB? HERO-STRIKE> <TELL "Tearing up the duty board will not get anyone off the bridge." CR>)>>

<ROUTINE PROFILE-CLASS (OBJ)
 <COND (<EQUAL? .OBJ ,VANGUARD> 1) (<EQUAL? .OBJ ,ARC> 2) (T 3)>>

<ROUTINE DUTY-BOARD-F ()
 <COND (<VERB? EXAMINE READ>
        <COND (<0? ,HERO-CLASS> <TELL "Three profile cards are pinned to the board, one for each kind of hero dispatch can send: [[Bulwark]], [[Arc]] and [[Lens]]." CR>)
              (<==? ,HERO-CLASS 1> <TELL "The [[Bulwark]] card is marked ACTIVE in red pen. The [[Arc]] and [[Lens]] cards wait for another night." CR>)
              (<==? ,HERO-CLASS 2> <TELL "The [[Arc]] card is marked ACTIVE in red pen. The [[Bulwark]] and [[Lens]] cards wait for another night." CR>)
              (T <TELL "The [[Lens]] card is marked ACTIVE in red pen. The [[Bulwark]] and [[Arc]] cards wait for another night." CR>)>)
       (<VERB? TAKE MOVE PUSH> <TELL "The board is screwed to the wall. The cards are what matter." CR>)
       (<VERB? HERO-STRIKE> <TELL "Tearing up the duty board will not get anyone off the bridge." CR>)>>

<ROUTINE WINDOW-F ()
 <COND (<VERB? EXAMINE LOOK-INSIDE>
        <TELL "Through the streaked glass the city is a black shape under the clouds. Out over the river, the red warning light of a stalled [[tram]] swings in the wind." CR>)
       (<VERB? OPEN> <TELL "The window is painted shut, and the storm can stay outside." CR>)
       (<VERB? CLOSE> <TELL "It is already shut." CR>)
       (<VERB? RUB> <TELL "The glass is cold. The rain is on the other side of it." CR>)
       (<VERB? HERO-STRIKE> <TELL "Dispatch has enough to repair tonight." CR>)>>

<ROUTINE SHEET-F ()
 <COND (<VERB? EXAMINE READ>
        <TELL "Hero: "> <HERO-PRINT-NAME>
        <COND (<0? ,HERO-CLASS> <TELL CR "No profile registered yet. Choose [[Bulwark]], [[Arc]] or [[Lens]] at the duty board." CR> <RTRUE>)>
        <TELL " (" > <HERO-PRINT-CLASS> <TELL ")" CR> <HERO-SHEET> <RTRUE>)
       (<VERB? HERO-NAME>
        <TELL "Type your hero name (up to 32 plain letters, digits or punctuation)." CR>
        <READ ,P-INBUF ,P-LEXV>
        <COND (<0? <HERO-NAME-STATUS>> <TELL "The dispatch board shows only plain letters, digits and punctuation. Your name stays "> <HERO-PRINT-NAME> <TELL "." CR>)
              (<==? <HERO-NAME-STATUS> 1> <TELL "No name entered. Dispatch will keep calling you "> <HERO-PRINT-NAME> <TELL "." CR>)
              (T <HERO-COPY-NAME> <TELL "Registered hero name: "> <HERO-PRINT-NAME> <CRLF>)>
        <RTRUE>)
       (<VERB? DROP PUT PUT-ON GIVE THROW>
        <TELL "You keep your character sheet. Dispatch needs it to know who you are." CR>)
       (<VERB? HERO-STRIKE> <TELL "Your sheet is the only paperwork you have tonight. Keep it in one piece." CR>)>>

<ROUTINE HERO-RESCUE-RANK ()
 <COND (<==? ,HERO-CLASS 1> <TELL "Strength check. "> ,HERO-STRENGTH)
       (<==? ,HERO-CLASS 2> <TELL "Agility check. "> ,HERO-AGILITY)
       (T <TELL "Power check. "> ,HERO-POWER)>>

<ROUTINE TRAM-F ()
 <COND (<VERB? EXAMINE LOOK-INSIDE>
        <COND (,RESCUED <TELL "The empty carriage creaks on its cable. Nobody is inside now." CR>)
              (T <TELL "The front carriage has jumped the rails and hangs nose-down over the river. Only the [[cable]] holds it. People are still inside, waving at you." CR>)>)
       (<VERB? LISTEN>
        <COND (,RESCUED <TELL "Only the cable, creaking." CR>)
              (T <TELL "Over the rain you hear a child crying and someone counting out loud to stay calm." CR>)>)
       (<VERB? PUSH> <TELL "Push it, and it falls. The passengers need it held, not pushed." CR>)
       (<VERB? HERO-STRIKE> <TELL "There are people inside it." CR>)
       (<VERB? HERO-RESCUE PULL MOVE RAISE CLIMB-ON CLIMB-FOO THROUGH TAKE BOOK-USE>
        <COND (<0? ,HERO-CLASS> <TELL "Register a profile at dispatch first." CR> <RTRUE>)>
        <COND (,RESCUED <TELL "Everyone is already safe." CR>)
              (<HERO-CHECK <HERO-RESCUE-RANK> 1>
               <SETG RESCUED T> <HERO-REWARD 10>
               <TELL "You steady the carriage and pass the passengers down, one by one, to the crew's net. The last of them, a boy in a yellow raincoat, will not let go of your hand until his feet are on the ground. (Karma +10.) The way [[east]] to the relay station is open." CR>)
              (T <TELL "The cable slips and the carriage lurches. You take a hit, but the crew's net holds below."> <HERO-HURT 5>)>
        <RTRUE>)>>

<ROUTINE CREW-F ()
 <COND (<VERB? EXAMINE>
        <COND (,RESCUED <TELL "The crew is wrapping the passengers in foil blankets on the riverbank. The chief gives you a thumbs-up." CR>)
              (T <TELL "Firefighters in yellow coats stand below the bridge with a net, shouting up to you through the rain." CR>)>)
       (<VERB? TELL HELLO ANSWER YELL>
        <COND (,RESCUED <TELL "The chief shouts up: \"Everybody's out! That drone came from the relay station. Go and shut it down!\"" CR>)
              (T <TELL "The chief cups her hands: \"We'll catch them, but that cable won't hold for long. Get them out!\"" CR>)>
        <SETG P-CONT <>> <SETG QUOTE-FLAG <>> <RTRUE>)
       (<VERB? HERO-STRIKE> <TELL "They are on your side." CR>)
       (<VERB? LISTEN> <TELL "Radios crackle and somebody counts down the strands left on the cable." CR>)>>

<ROUTINE RAILS-F ()
 <COND (<VERB? EXAMINE> <TELL "The steel rails are bent outward where the carriage went through. Beyond the gap there is only rain and the river." CR>)
       (<VERB? LEAP> <PERFORM ,V?SWIM ,RIVER> <RTRUE>)
       (<VERB? CLIMB-ON CLIMB-FOO CLIMB-UP> <TELL "You lean out over the gap. It is a long way down to the river." CR>)
       (<VERB? TAKE PULL MOVE PUSH RAISE> <TELL "The rails are bolted into the bridge and bent past repair." CR>)
       (<VERB? RUB> <TELL "Cold, wet steel, still humming with the strain of the carriage." CR>)
       (<VERB? HERO-STRIKE> <TELL "The rails have taken enough damage tonight." CR>)>>

<ROUTINE CABLE-F ()
 <COND (<VERB? EXAMINE>
        <COND (,RESCUED <TELL "With the carriage empty, the overhead cable has stopped singing in the wind." CR>)
              (T <TELL "The overhead cable sags under the carriage. As you watch, another strand snaps." CR>)>)
       (<VERB? LISTEN> <TELL "It creaks and sings in the wind." CR>)
       (<VERB? RUB> <TELL "It is dead. No power runs through it tonight, which is the one piece of luck in this storm." CR>)
       (<VERB? HERO-STRIKE> <TELL "That cable is all that holds the tram up." CR>)
       (<VERB? TAKE PULL MOVE RAISE CLIMB-ON CLIMB-FOO CLIMB-UP HERO-RESCUE>
        <COND (,RESCUED <TELL "The cable can hang there until the city has power to repair it." CR>)
              (T <PERFORM ,V?HERO-RESCUE ,TRAM>)>
        <RTRUE>)>>

;"A failed or answered strike lets the drone counter while it still flies."
<ROUTINE DRONE-F ()
 <COND (<VERB? EXAMINE>
        <COND (,DISABLED <TELL "The drone lies on its back, rotors still. Its red eye has gone dark." CR>)
              (T <TELL "A black guard drone the size of a car door, hovering on four rotors. Its red eye tracks every move you make. Integrity " N ,DRONE-HP " of 40." CR>)>)
       (<VERB? LISTEN>
        <COND (,DISABLED <TELL "Silence." CR>) (T <TELL "Its rotors whine, high and steady." CR>)>)
       (<VERB? TELL HELLO ANSWER YELL>
        <COND (,DISABLED <TELL "It says nothing at all." CR>)
              (T <TELL "The drone answers with a burst of static: \"RESTRICTED AREA. LEAVE NOW.\"" CR>)>
        <SETG P-CONT <>> <SETG QUOTE-FLAG <>> <RTRUE>)
       (<VERB? TAKE RUB PUSH PULL MOVE>
        <COND (,DISABLED <TELL "It is heavier than it looks, and the police will want it. Leave it where it fell." CR>)
              (T <TELL "It slides out of reach and its eye flares red. You would have to fight it." CR>)>)
       (<VERB? HERO-DISABLE>
        <COND (,DISABLED <TELL "It is already out of action." CR>) (T <PERFORM ,V?HERO-STRIKE ,DRONE>)> <RTRUE>)
       (<VERB? HERO-STRIKE>
        <COND (<0? ,HERO-CLASS> <TELL "Register a profile at dispatch first." CR> <RTRUE>)>
        <COND (,DISABLED <TELL "The drone is already out of action." CR> <RTRUE>)>
        <TELL "Fighting check. ">
        <COND (<HERO-CHECK ,HERO-FIGHTING 1>
               <SETG DRONE-HP <- ,DRONE-HP ,HERO-POWER>>
               <COND (<NOT <G? ,DRONE-HP 0>>
                      <SETG DRONE-HP 0> <SETG DISABLED T> <HERO-REWARD 10>
                      <TELL "The drone crashes to the floor and its red eye goes dark. (Karma +10.) The [[console]] is unguarded." CR>)
                     (T <TELL "Your blow lands and the drone staggers, sparks pouring from one rotor. Integrity " N ,DRONE-HP " of 40." CR>)>)
              (T <TELL "The drone slides aside, and your blow meets only air." CR>)>
        <COND (<NOT ,DISABLED> <TELL "Its stun beam catches you."> <HERO-HURT 10>)>
        <RTRUE>)>>

<ROUTINE CONSOLE-F ()
 <COND (<VERB? EXAMINE>
        <TELL "A wall of dark screens around a single manual bypass lever, the only control that still answers by hand. Pull it, and the city takes back its own power.">
        <COND (<NOT ,DISABLED> <TELL " The drone hovers between you and it.">)>
        <CRLF>)
       (<VERB? RUB LISTEN> <TELL "It is warm and trembling under the load it should not be carrying." CR>)
       (<VERB? TAKE> <TELL "It is bolted into the concrete." CR>)
       (<VERB? HERO-STRIKE> <TELL "Smash the console and the city stays dark for weeks. The lever will do." CR>)
       (<VERB? HERO-DISABLE PULL MOVE PUSH TURN OPEN BOOK-USE>
        <COND (<0? ,HERO-CLASS> <TELL "Register a profile at dispatch first." CR> <RTRUE>)>
        <COND (<OR ,DISABLED <HERO-CHECK-REASON>>
               <SETG DISABLED T> <SETG DRONE-HP 0> <HERO-REWARD 20>
               <TELL "You throw the bypass lever. The hum of the hall drops to a murmur, the screens wake one by one, and the relay returns to local control. Across the river, Meridian lights up street by street. (Karma +20.)" CR CR "Your radio crackles, and dispatch calls your name: ">
               <HERO-PRINT-NAME> <TELL ". Meridian is safe." CR CR "THE END: THE LIGHTS OF MERIDIAN" CR CR>
               <FINISH>)
              (T <TELL "The drone's beam catches you before you reach the lever."> <HERO-HURT 10>)>
        <RTRUE>)>>

<ROUTINE HERO-CHECK-REASON ()
 <TELL "Reason check, strong success needed. ">
 <HERO-CHECK ,HERO-REASON 2>>

<ROUTINE KIT-F ()
 <COND (<VERB? EXAMINE>
        <COND (,BOOSTED <TELL "The kit hangs open and empty." CR>)
              (T <TELL "A red emergency recovery kit, clipped to the wall. It works once, costs 10 Karma to activate, and restores up to 20 Health." CR>)>)
       (<VERB? TAKE> <TELL "It is clipped to the wall. Use it where it hangs." CR>)
       (<VERB? HERO-STRIKE> <TELL "You may need what is inside it." CR>)
       (<VERB? HERO-FOCUS BOOK-USE OPEN>
        <COND (<0? ,HERO-CLASS> <TELL "Register a profile at dispatch first." CR> <RTRUE>)>
        <COND (,BOOSTED <TELL "The kit is empty." CR>)
              (<NOT <L? ,HERO-HEALTH ,HERO-MAX-HEALTH>> <TELL "You are unhurt. Keep the kit for when you need it." CR>)
              (<HERO-SPEND 10>
               <SETG BOOSTED T>
               <TELL "You crack the kit open and press the patch to your ribs. You recover " N <HERO-HEAL 20> " Health. (Health " N ,HERO-HEALTH " of " N ,HERO-MAX-HEALTH ", Karma " N ,HERO-KARMA ".)" CR>)
              (T <TELL "Activating the kit takes 10 Karma, and you have " N ,HERO-KARMA "." CR>)>
        <RTRUE>)>>

<ROUTINE RAIN-F ()
 <COND (<VERB? EXAMINE>
        <COND (<EQUAL? ,HERE ,DISPATCH> <TELL "Rain runs down the window in silver lines." CR>)
              (<EQUAL? ,HERE ,BRIDGE> <TELL "The rain comes sideways across the bridge, cold enough to sting." CR>)
              (T <TELL "Rain drums on the concrete roof of the hall." CR>)>)
       (<VERB? LISTEN> <TELL "A steady roar, broken only by thunder." CR>)
       (<VERB? SMELL> <TELL "Wet stone and the sharp smell of burned wiring." CR>)
       (<VERB? TAKE RUB> <TELL "It runs through your fingers." CR>)>>

<ROUTINE CITY-F ()
 <COND (<VERB? EXAMINE> <TELL "Meridian is dark from the river to the hills: no streetlights, no lit windows, only the storm." CR>)
       (<VERB? LISTEN> <TELL "Car alarms, far away, and nothing else but the rain." CR>)>>

<ROUTINE RIVER-F ()
 <COND (<VERB? EXAMINE> <TELL "The river is high and fast, brown with the storm." CR>)
       (<VERB? SWIM LEAP THROUGH> <TELL "The current would take you under the bridge in seconds. The city needs you dry and alive." CR>)
       (<VERB? DRINK> <TELL "Not tonight, and not ever." CR>)
       (<VERB? LISTEN> <TELL "It roars against the piers of the bridge." CR>)>>

<ROUTINE BRIDGE-SPAN-F ()
 <COND (<VERB? EXAMINE>
        <COND (<EQUAL? ,HERE ,DISPATCH> <TELL "Meridian Bridge is a short run north through the rain." CR>)
              (<EQUAL? ,HERE ,BRIDGE> <TELL "An old steel bridge with tram rails down the middle, running out over the river to the relay station." CR>)
              (T <TELL "Through the door, the bridge runs west into the rain." CR>)>)
       (<VERB? THROUGH CLIMB-ON WALK-TO>
        <COND (<EQUAL? ,HERE ,DISPATCH> <DO-WALK ,P?NORTH>)
              (<EQUAL? ,HERE ,RELAY> <DO-WALK ,P?WEST>)
              (T <TELL "You are standing on it." CR>)>
        <RTRUE>)
       (<VERB? LEAP> <PERFORM ,V?SWIM ,RIVER> <RTRUE>)>>

<ROUTINE DISTANT-TRAM-F ()
 <COND (<VERB? EXAMINE> <TELL "From here it is only a red warning light, swinging over the river. The bridge is to the [[north]]." CR>)
       (<VERB? HERO-RESCUE> <TELL "It is out on the bridge, to the [[north]]." CR>)>>

<ROUTINE STATION-F ()
 <COND (<VERB? EXAMINE>
        <COND (<EQUAL? ,HERE ,RELAY> <TELL "You are inside it. All of the city's power runs through this hall." CR>)
              (T <TELL "A squat concrete building at the east end of the bridge, humming with power it should not have. Its steel [[door]] has been forced open." CR>)>)
       (<VERB? THROUGH WALK-TO>
        <COND (<EQUAL? ,HERE ,RELAY> <TELL "You are already inside." CR>) (T <DO-WALK ,P?EAST>)>
        <RTRUE>)
       (<VERB? LISTEN> <TELL "A deep electric hum, louder than the rain." CR>)>>

<ROUTINE STATION-DOOR-F ()
 <COND (<VERB? EXAMINE> <TELL "The steel door of the relay station has been torn off its lock from the inside." CR>)
       (<VERB? CLOSE LOCK> <TELL "It is wrecked and will not close." CR>)
       (<VERB? OPEN> <TELL "It is already open, and it will stay that way." CR>)
       (<VERB? KNOCK> <TELL "Nobody inside is going to answer." CR>)
       (<VERB? THROUGH>
        <COND (<EQUAL? ,HERE ,RELAY> <DO-WALK ,P?WEST>) (T <DO-WALK ,P?EAST>)>
        <RTRUE>)>>
