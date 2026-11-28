<ROOM LANDING (DESC "The Heroes' Plain")>
<ROOM RIDGE (DESC "The Ridge")>
<OBJECT MAGNETO (DESC "Magneto") (SYNONYM MAGNETO)>
<OBJECT COIL (DESC "copper coil") (SYNONYM COIL WIRE) (ADJECTIVE COPPER)>
<OBJECT RELAY (DESC "shield relay") (SYNONYM RELAY PANEL SOCKET) (ADJECTIVE SHIELD)>
<OBJECT RIDGE-ATTACK (DESC "villains") (SYNONYM VILLAINS KANG ATTACK)>
<ROUTINE MSG-EARLY-OPENING ()
 <TELL "In Central Park, a strange circle of machinery rose among the trees. When you stepped inside, Earth vanished. Through a second circle across the darkness you glimpsed Doctor Doom, Kang and other dangerous figures. Then the stars went out, and pieces of distant worlds came together around a single sun." CR CR
 "The Beyonder spoke from somewhere beyond the sky and offered a reward for destroying your enemies. Galactus and Doom challenged its owner; both were flung away. Now the circle carries you down toward the newly made world. You have another idea: find the people who need help." CR>>
<ROUTINE MSG-LANDING ()
 <TELL "You stand on a wide plain where grass ends suddenly at red stone. Magneto watches the ridge. ">
 <COND (<IN? ,COIL ,LANDING> <TELL "Beside broken machinery lies a copper coil. ">)>
 <TELL "To the north, a ridge hides the land beyond." CR>>
<ROUTINE MSG-MAGNETO ()
 <TELL "Magneto folds his arms. 'The voice chose me as it chose you. That does not mean either of us has to obey it.' A flash passes over the ridge. He turns toward it. 'There are people on the other side. That broken machinery may be useful.'" CR>>
<ROUTINE MSG-COIL ()
 <TELL "The copper wire is neatly wound around a little ceramic core. Its two ends are clean, and a shield symbol is stamped on the core." CR>>
<ROUTINE MSG-RIDGE ()
 <TELL "From the ridge you can see a makeshift camp to the north. ">
 <COND (,BW-SHIELD <TELL "A pale shield holds Kang's villains at a distance. ">)
       (T <TELL "Kang's villains crest another rise, carrying weapons from a fortress they have already found. ">)>
 <TELL "A shield relay stands by the path. ">
 <COND (<IN? ,COIL ,RIDGE> <TELL "The coil lies nearby. ">)>
 <TELL "The plain lies south." CR>>
<ROUTINE MSG-RELAY ()
 <COND (,BW-SHIELD <MSG-RELAY-DONE>)
       (T <TELL "The relay's open panel has an empty cradle marked with a shield. Two contacts wait at either end, just the right distance apart for a small coil. A diagram shows the relay projecting a shelter across the path to the camp." CR>)>>
<ROUTINE MSG-RELAY-FIXED ()
 <TELL "The coil clicks into the cradle. A pale shield unfolds across the path as Kang's first shot splashes harmlessly against it. Beyond the glow, people hurry toward the camp. Magneto holds a second piece of debris out of their way. The path north is safe to follow." CR> <MSG-EARLY-OBJECTIVE>>
<ROUTINE MSG-RELAY-DONE () <TELL "The shield hums steadily over the path. The camp is open to the north." CR>>
<ROUTINE MSG-ATTACK () <TELL "Kang's party is too far away to reach safely. Their weapons flash against the rocks. The damaged relay might shelter the path without anyone having to fight." CR>>
<ROUTINE BW-EARLY-CHOICES ()
 <COND (<EQUAL? ,HERE ,LANDING>
        <CHOICE "bw.landing.magneto" "Talk with Magneto" "examine magneto" ,CHOICE-INVESTIGATE 95>
        <COND (<IN? ,COIL ,LANDING> <CHOICE "bw.landing.coil" "Pick up the copper coil" "take coil" ,CHOICE-PROGRESS 100>)>
        <CHOICE "bw.landing.ridge" "Go to the ridge" "north" ,CHOICE-PROGRESS 90>)
       (<EQUAL? ,HERE ,RIDGE> <COND (<NOT ,BW-SHIELD>
                 <COND (<NOT ,BW-SHIELD-POWER-TRIED> <CHOICE "bw.ridge.power" "Protect the path with your power" "focus relay" ,CHOICE-PROGRESS 98>)>
                 <COND (<IN? ,COIL ,RIDGE> <CHOICE "bw.ridge.coil" "Pick up the coil" "take coil" ,CHOICE-PROGRESS 99>)>
                 <CHOICE "bw.ridge.relay" "Inspect the damaged relay" "examine relay" ,CHOICE-INVESTIGATE 95>
                 <COND (<IN? ,COIL ,WINNER> <CHOICE "bw.ridge.fix" "Fit the coil into the relay" "put coil in relay" ,CHOICE-PROGRESS 100>)>)
                (T <CHOICE "bw.ridge.camp" "Follow the sheltered path to camp" "north" ,CHOICE-PROGRESS 100>)>
          <CHOICE "bw.ridge.plain" "Return to the plain" "south" ,CHOICE-RETURN 60>)>>

<ROUTINE MSG-EARLY-OBJECTIVE () <TELL "Above the camp, Doom's green image declares that his Loom will close the last door home. The image fades, but the people below still need help." CR>>
<ROUTINE MSG-SHIELD-POWER ()
 <COND (<EQUAL? ,RPG-PRESET-INDEX 1> <TELL "You spin a web canopy between the rocks, catching the incoming shots before they can reach the path." CR>)
       (<EQUAL? ,RPG-PRESET-INDEX 2> <TELL "You summon a circling wind that bends the shots harmlessly into the sky and shelters the path." CR>)
       (T <TELL "You redirect your armor's field into a broad barrier; Kang's shots flare against it and fade." CR>)>>
<ROUTINE MSG-SHIELD-FAIL () <TELL "The shots scatter your first attempt before you can shelter the path. The relay's empty cradle is marked with a shield; perhaps the copper coil on the plain would fit. There is time to repair it." CR>>
