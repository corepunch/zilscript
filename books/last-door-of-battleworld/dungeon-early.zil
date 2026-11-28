<ROOM LANDING (DESC "The Heroes' Plain")>
<ROOM RIDGE (DESC "The Ridge")>
<OBJECT MAGNETO (DESC "Magneto") (SYNONYM MAGNETO)>
<OBJECT BW-WRECK (DESC "wreck") (SYNONYM WRECK MACHINE MACHINERY SHIP RING CIRCLE)>
<OBJECT COIL (DESC "copper coil") (SYNONYM COIL WIRE) (ADJECTIVE COPPER)>
<OBJECT RELAY (DESC "shield relay") (SYNONYM RELAY PANEL SOCKET) (ADJECTIVE SHIELD)>
<OBJECT RIDGE-ATTACK (DESC "villains") (SYNONYM VILLAINS KANG ATTACK)>
<ROUTINE MSG-EARLY-OPENING ()
 <TELL "A machine in Central Park snatched you from Earth. Now you're on Battleworld, and you hear cries for help." CR>>
<ROUTINE MSG-LANDING ()
 <TELL "Grass gives way to red stone on this wide plain. Magneto stands by the wreck. The cries come from beyond the ridge to the north." CR>>
<ROUTINE MSG-MAGNETO ()
 <TELL "'The Beyonder put me on your side,' says Magneto. 'He promised a prize if we beat our enemies. I say we help those people instead.' He points north." CR>>
<ROUTINE MSG-WRECK ()
 <TELL "It's the ring that brought you here. From it you saw two things: pieces of other worlds forming Battleworld, and a blast hurling Doom and Galactus away when they challenged the Beyonder." CR>>
<ROUTINE MSG-COIL ()
 <TELL "It's wire wound in a tight spiral. A tiny shield is stamped on one end." CR>>
<ROUTINE MSG-RIDGE ()
 <TELL "A shield relay stands on the ridge. ">
 <COND (,BW-SHIELD <TELL "A shield covers the path north to camp. ">)
       (T <TELL "Kang's shots hit the rocks on the path north to camp. ">)>
 <TELL "The plain lies south." CR>>
<ROUTINE MSG-RELAY ()
 <COND (,BW-SHIELD <MSG-RELAY-DONE>)
       (T <TELL "The relay makes a shield when it has power. Its empty slot is just the size of a small coil and has a shield mark." CR>)>>
<ROUTINE MSG-RELAY-FIXED ()
 <TELL "Click! A shield catches Kang's next shot. Magneto lifts a slab out of the way, and people run north to camp." CR> <MSG-EARLY-OBJECTIVE>>
<ROUTINE MSG-RELAY-DONE () <TELL "The shield hums steadily over the path. The camp is open to the north." CR>>
<ROUTINE MSG-ATTACK ()
 <TELL "Kang's shots block the path to camp. Fix the shield relay">
 <COND (<NOT ,BW-SHIELD-POWER-TRIED> <TELL " or type 'focus relay' to use your power">)>
 <TELL "." CR>>
<ROUTINE BW-EARLY-CHOICES ()
 <COND (<EQUAL? ,HERE ,LANDING>
        <CHOICE "bw.landing.magneto" "Talk with Magneto" "examine magneto" ,CHOICE-INVESTIGATE 95>
        <CHOICE "bw.landing.wreck" "Inspect the wreck" "examine wreck" ,CHOICE-INVESTIGATE 85>
        <COND (<IN? ,COIL ,LANDING> <CHOICE "bw.landing.coil" "Pick up the copper coil" "take coil" ,CHOICE-PROGRESS 100>)>
        <CHOICE "bw.landing.ridge" "Go to the ridge" "north" ,CHOICE-PROGRESS 90>)
       (<EQUAL? ,HERE ,RIDGE> <COND (<NOT ,BW-SHIELD>
                 <COND (<NOT ,BW-SHIELD-POWER-TRIED> <CHOICE "bw.ridge.power" "Protect the path with your power" "focus relay" ,CHOICE-PROGRESS 98>)>
                 <COND (<IN? ,COIL ,RIDGE> <CHOICE "bw.ridge.coil" "Pick up the coil" "take coil" ,CHOICE-PROGRESS 99>)>
                 <CHOICE "bw.ridge.relay" "Inspect the damaged relay" "examine relay" ,CHOICE-INVESTIGATE 95>
                 <COND (<IN? ,COIL ,WINNER> <CHOICE "bw.ridge.fix" "Fit the coil into the relay" "put coil in relay" ,CHOICE-PROGRESS 100>)>)
                (T <CHOICE "bw.ridge.camp" "Follow the sheltered path to camp" "north" ,CHOICE-PROGRESS 100>)>
          <CHOICE "bw.ridge.plain" "Return to the plain" "south" ,CHOICE-RETURN 60>)>>

<ROUTINE MSG-EARLY-OBJECTIVE () <TELL "Doom's face flashes above camp. 'My Loom will stitch shut your last door home!' The path north is safe now." CR>>
<ROUTINE MSG-SHIELD-POWER ()
 <COND (<EQUAL? ,RPG-PRESET-INDEX 1> <TELL "You spin a web canopy between the rocks, catching the incoming shots before they can reach the path." CR>)
       (<EQUAL? ,RPG-PRESET-INDEX 2> <TELL "You summon a circling wind that bends the shots harmlessly into the sky and shelters the path." CR>)
       (T <TELL "You redirect your armor's field into a broad barrier; Kang's shots flare against it and fade." CR>)>>
<ROUTINE MSG-SHIELD-FAIL () <TELL "Kang's shots break through. Try fitting the copper coil from the plain into the relay. There's time." CR>>
