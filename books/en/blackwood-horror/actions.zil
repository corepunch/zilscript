; === PSEUDO ROUTINES (scenery words for RECEPTION-ROOM) ===

<ROUTINE NEST-PSEUDO ()
    <COND (<VERB? EXAMINE>
           <TELL "An old bird's nest tucked into the fireplace grate. Long abandoned -- like everything else here." CR>)
          (<VERB? LOOK-INSIDE SEARCH>
           <TELL "Only a few grey feathers and the broken shell of an egg that never hatched." CR>)
          (<VERB? TAKE>
           <TELL "The nest would fall apart in your hand." CR>)
          (<VERB? RUB>
           <TELL "Dry twigs, and a lining of something soft and grey that might once have been hair." CR>)>>

<ROUTINE ASHES-PSEUDO ()
    <COND (<VERB? EXAMINE>
           <TELL "Cold grey ashes. Nothing of value." CR>)
          (<VERB? SEARCH>
           <TELL "You sift through the ashes. Just soot and old char." CR>)
          (<VERB? RUB>
           <TELL "The ashes are cold right to the bottom. No one has lit a fire here in a very long time." CR>)
          (<VERB? SMELL>
           <TELL "Old char, and under it something faintly sweet, like burnt paper." CR>)>>

; === DISCOVERY ===

"A glance takes in a container, not what lies in it. Shelves, tubs, lockers and
bins keep their contents to themselves until the player examines or searches
them, as Zork I lists the mailbox's contents only once it is open. UNCOVER
opens such a container and returns true the first time."

<ROUTINE UNCOVER (CONT)
    <COND (<FSET? .CONT ,OPENBIT> <RFALSE>)>
    <FSET .CONT ,OPENBIT>
    <FSET .CONT ,TOUCHBIT>
    <RTRUE>>

"The brass key lies under the reception papers, INVISIBLE until they are
searched, as Zork I hides the grating under the leaves."

<ROUTINE RECEPTION-PAPERS-F ()
    <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE LOOK-UNDER MOVE READ>
           <COND (<AND <FSET? ,BRASS-KEY ,INVISIBLE> <IN? ,BRASS-KEY ,RECEPTION-ROOM>>
                  <FCLEAR ,BRASS-KEY ,INVISIBLE>
                  <THIS-IS-IT ,BRASS-KEY>
                  <TELL "You sift through admission forms and invoices pulped by damp. Beneath them lies a small [[brass key->reception key]], cold to the touch." CR>)
                 (T
                  <TELL "Admission forms and invoices, pulped by damp. Nothing else hides among them." CR>)>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "The papers come apart in your hands, wet and grey." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "They smell of wet cardboard and mildew." CR>)
          (<VERB? RUB>
           <TELL "The paper is cold and slick, more pulp than page." CR>)>>

; === ROOM ACTION ROUTINES (Dynamic Descriptions) ===

<ROUTINE RECEPTION-ROOM-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "This is the old reception room, cramped and smelling of wet paper. A dusty [[oak desk->desk]] stands in front of a row of [[filing cabinets->cabinets]] whose drawers hang open like mouths.">
           <COND (<FSET? ,BOTTOM-DRAWER ,OPENBIT>
                  <TELL " The desk's [[bottom drawer]] stands open, and damp [[papers]] cover the floor.">)
                 (<AND <FSET? ,BRASS-KEY ,INVISIBLE> <IN? ,BRASS-KEY ,RECEPTION-ROOM>>
                  <TELL " Damp [[papers]] cover the floor, and something glints among them.">)
                 (T
                  <TELL " Damp [[papers]] cover the floor.">)>
           <TELL " In the cold [[fireplace]], a bird's [[nest]] sits on a bed of old [[ashes]]. The only way out is [[east]], back to the entrance hall." CR>)>>

<ROUTINE PATIENT-WARD-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "This is the patient ward, a long room lined with rusted [[bed frames->beds]]. Tattered [[curtains]] hang between them, and broken [[glass]] crunches under your feet.">
           <COND (<IN? ,CHILD-DRAWING ,PATIENT-WARD>
                  <TELL " A child's [[crayon drawing]] is pinned to the nearest frame.">)>
           <COND (,CHAINS-CUT-FLAG
                  <TELL " At the far end, the [[heavy door->door]] stands open on darkness to the [[north]].">)
                 (T
                  <TELL " At the far end, a [[heavy door->door]] is bound shut with [[chains and a leather strap->chains]].">)>
           <TELL " The entrance hall is back to the [[west]]." CR>)>>

<ROUTINE BASEMENT-CORRIDOR-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "This is the basement corridor, low and dim, with rusty [[pipes]] running the length of the ceiling.">
           <COND (<AND ,VALVE-TURNED-FLAG ,BOILER-LIT>
                  <TELL " Steam hisses from the pipes around a big wheel [[valve]], and the air is warm and wet.">)
                 (T <TELL " One pipe ends in a big wheel [[valve]], and cold [[water]] drips from the rust.">)>
           <TELL " Stone [[stairs]] climb [[up]] toward the hall. The smell of [[coal smoke]] comes from the boiler room to the [[east]], and the stores lie to the [[west]]. To the [[north]] the floor slopes down out of the light, toward the sound of water dripping into something deep." CR>)>>

<ROUTINE FLOODED-PASSAGE ()
    <COND (<CARRYING-LIGHT?> ,FLOODING-CHAMBER)
          (T
           <TELL "Beyond the last light, water laps against unseen steps. You stop at the threshold: you need a working light before entering the flooded chamber." CR>
           <RFALSE>)>>

"The flooded wing has no light of its own. Both ways into it ask for a lit
lantern in hand (one left burning on the floor behind does not light the way
ahead), and the lantern can be neither put out nor set down inside it, so the
player never stands in the dark."

<ROUTINE UNLIT-STAIRWAY ()
    <COND (<CARRYING-LIGHT?> ,ELECTROSHOCK-THEATER)
          (T
           <TELL "The stairwell drops into a blackness the deck's grey light does not reach. You need a working light before going down." CR>
           <RFALSE>)>>

<ROUTINE CARRYING-LIGHT? ()
    <AND ,LANTERN-LIT-FLAG <IN? ,OIL-LANTERN ,WINNER>>>

<ROUTINE UNLIT-WING? ()
    <NOT <FSET? ,HERE ,ONBIT>>>

<ROUTINE BOILER-ROOM-FCN (RARG)
    <COND (<AND <EQUAL? .RARG ,M-BEG> <VERB? BURN> <EQUAL? ,PRSO ,IRON-BOILER>>
           ;"Before the inherited flame check can answer for an unlit lantern."
           <V-IGNITE>
           <RTRUE>)
          (<EQUAL? .RARG ,M-LOOK>
           <TELL "This is the boiler room, thick with the old smells of tar and sulphur. Coal [[dust]] and soot lie black over everything.">
           <COND (,BOILER-LIT <TELL " The iron [[boiler]] is awake now, burning [[coal]] in its open firebox, and the room is warm at last.">)
                 (<IN? ,LUMP-OF-COAL ,IRON-BOILER> <TELL " The huge iron [[boiler]] has coal in its firebox, waiting for a flame.">)
                 (T <TELL " A huge iron [[boiler]] squats at the back of the room, stone cold.">)>
           <TELL " A [[coal bin->bin]] stands beside it, and a [[workbench]] stands across from it. The only way out is back [[west]] to the corridor." CR>)>>

<ROUTINE HYDROTHERAPY-ROOM-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "This is the hydrotherapy room. A row of stained porcelain [[tubs]] runs down the middle, each with a cracked rubber [[hose->hoses]] hanging above it, and the white [[tiles]] are streaked with rust.">
           <COND (<FSET? ,MEDICINE-CABINET ,OPENBIT>
                  <TELL " Across the room, the thawed [[medicine cabinet->cabinet]] stands open.">)
                 (,CABINET-THAWED
                  <TELL " Across the room, water runs down a [[medicine cabinet->cabinet]] where its [[frost]] has melted.">)
                 (T
                  <TELL " Across the room, a [[medicine cabinet->cabinet]] is sealed beneath a thick skin of white [[frost]], and the air is cold enough to sting.">)>
           <TELL " The only way out is [[west]], back to the flooded chamber." CR>)>>

<ROUTINE FLOODING-CHAMBER-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "You are in a vast, flooded chamber. Black [[water]] covers the floor to your ankles, so cold it aches, and every sound you make comes back from the dark.">
           <COND (,STEAM-DOOR-OPEN
                  <TELL " In the east wall, a metal [[door]] stands open, steam curling from its edges, and a tiled room lies beyond it to the [[east]].">)
                 (T
                  <TELL " In the east wall, a metal [[door]] is corroded shut in its frame.">)>
           <TELL " The way [[north]] narrows into the dark, and the basement corridor is back to the [[south]]." CR>)>>

<ROUTINE OVERGROWN-GARDEN-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "You are in an overgrown garden behind the sanitarium. Dead [[roses]] and waist-high [[weeds]] have swallowed the paths, and broken stone [[benches]] lie tipped among them. Over it all, a [[dead oak->tree]] holds up its bare branches.">
           <COND (<IN? ,PATIENT-189 ,OVERGROWN-GARDEN>
                  <TELL " [[Patient 189->patient]] stands among the dead [[roses]], perfectly still, watching you.">)>
           <TELL " At the end of a barely visible [[path]] to the [[north]] stands a small stone [[chapel]].">
           <COND (,CHAPEL-UNLOCKED
                  <TELL " Its oak [[door]] stands open on darkness.">)
                 (T
                  <TELL " Its oak [[door]] is held shut by a heavy iron [[lock]].">)>
           <TELL " The cafeteria is back to the [[south]]." CR>)>>

<ROUTINE OAK-DESK-DESC-F (RARG)
    <COND (<EQUAL? .RARG ,M-OBJDESC>
           <COND (<AND <FSET? ,BOTTOM-DRAWER ,OPENBIT> <FIRST? ,BOTTOM-DRAWER>>
                  <PRINT-CONT ,BOTTOM-DRAWER>)>
           <RTRUE>)>>

<ROUTINE DIRECTORS-OFFICE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "This is the director's office, the only room in the building that still looks cared for. A massive dark [[desk]] stands on a worn rug, its wood polished to a shine, and the damp has not been allowed to touch it.">
           <COND (<FSET? ,WALL-SAFE ,INVISIBLE> <TELL " Above it hangs a [[portrait of Dr. Mordecai->portrait]], whose painted eyes seem to follow you.">)
                 (T <TELL " Above it, the [[portrait]] hangs swung aside on its hinge, showing ">
                    <COND (<FSET? ,WALL-SAFE ,OPENBIT> <TELL "an open">) (T <TELL "a">)>
                    <TELL " [[wall safe->safe]] hidden behind it.">)>
           <TELL " The felt-lined [[door]] to the [[west]] leads back to the administrative wing." CR>)>>

; === ACTION HANDLERS ===

<SYNTAX SAY HELLO = V-SAY-HELLO>
<SYNTAX HINT = V-HINTS>
<SYNONYM HINT HINTS>
<SYNTAX PEEL OBJECT = V-MOVE PRE-MOVE>
<SYNTAX SCRAPE OBJECT = V-SCRAPE>
<SYNTAX SCRAPE OBJECT WITH OBJECT = V-SCRAPE>
<SYNTAX INJECT OBJECT WITH OBJECT = V-INJECT>
<SYNTAX SHOW OBJECT (HELD CARRIED HAVE) TO OBJECT = V-SHOW>
<SYNTAX KINDLE OBJECT WITH OBJECT = V-IGNITE>
<SYNTAX TURN OBJECT (FIND TURNBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-TURN-BARE>
<SYNTAX LISTEN = V-LISTEN-AROUND>
<SYNTAX SMELL = V-SMELL-AROUND>
<SYNTAX SITDOWN = V-SIT-DOWN>
<SYNTAX SITDOWN ON OBJECT = V-CLIMB-ON>
<SYNTAX SITDOWN IN OBJECT = V-CLIMB-ON>
<SYNTAX GREET = V-BARE-HELLO>
<SYNTAX GREET OBJECT = V-GREET-OBJECT>

<ROUTINE BRASS-PLAQUE-F ()
         <COND (<VERB? TAKE MOVE>
                <TELL "The plaque is bolted firmly to the iron gate." CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "Under your thumb the raised letters are sharp and cold, and the corrosion comes away as green dust." CR>)
          (<VERB? KNOCK KICK>
           <TELL "The plaque gives back a dull ring, and the whole gate shivers on its hinges." CR>)
          (<VERB? SMELL>
           <TELL "It smells of old pennies." CR>)>>

<ROUTINE CHILD-DRAWING-F ()
         <COND (<VERB? EXAMINE READ>
                <TELL "A child's crayon drawing is pinned to the bedframe: a yellow sun above a stick figure with outstretched arms, and the word “HOME” pressed so hard into the paper that the crayon tore through in places." CR>
                <RTRUE>)
               (<VERB? TAKE MOVE>
                <TELL "The brittle paper would crumble if you tried to remove it from the rusted pin." CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The crayon is waxy and thick where the word was pressed hardest." CR>)
          (<VERB? SMELL>
           <TELL "It smells faintly of wax, the only clean smell in the ward." CR>)>>

<ROUTINE FILING-CABINETS-F ()
         <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE OPEN>
                <COND (<EQUAL? ,HERE ,RECEPTION-ROOM>
                       <TELL "The reception cabinets stand open and empty. Their labels have faded, and damp has fused the remaining scraps of paper into gray pulp." CR>)
                      (T
                       <TELL "The overturned cabinets have been emptied. Bent drawers gape open among waterlogged administrative forms." CR>)>
                <RTRUE>)
          (<VERB? KNOCK KICK>
           <TELL "The metal booms hollowly. Every drawer is empty." CR>)
          (<VERB? PUSH MOVE>
           <TELL "The cabinets are rusted where they stand. They will not budge." CR>)
          (<VERB? SMELL>
           <TELL "Wet cardboard and rust." CR>)>>

<ROUTINE DESK-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE OPEN>
                <TELL "A thick skin of dust coats the oak. The desk has three drawers. The top two are broken and empty. The [[bottom drawer->drawer]] is intact">
                <COND (<FSET? ,BOTTOM-DRAWER ,OPENBIT> <TELL " and stands open.">)
                      (T <TELL " but locked; a number 3 is engraved beside its keyhole.">)>
                <CRLF>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "Your finger leaves a clean line through the dust. The oak beneath is still dark and good." CR>)
          (<VERB? KNOCK>
           <TELL "The desk sounds solid all over, except for the bottom drawer, which knocks back hollow." CR>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the desk there is only dust and a dead moth." CR>)
          (<VERB? PUSH MOVE>
           <TELL "The desk is too heavy to shift. Its feet have sunk into the soft floorboards." CR>)>>

<ROUTINE PATIENT-FILE-F ()
         <COND (<VERB? READ EXAMINE>
                <COND (<NOT ,PATIENT-FILE-LORE>
                       <SETG PATIENT-FILE-LORE T>
                       <SETG PATIENT-LORE <+ ,PATIENT-LORE 1>>)>
                <TELL "A file folder labeled “Patient 189 - CONFIDENTIAL”. Inside are medical records and notes. “Subject shows extraordinary resistance to pain. Mental state deteriorating. Recommending transfer to isolation wing. Dr. Mordecai has expressed personal interest in this case. Update: Patient transferred to chapel for experimental treatment. Nov 1, 1952.”" CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Old paper and stale cigarette smoke, as if someone read this file many times, late at night." CR>)
          (<VERB? RUB>
           <TELL "The folder is soft at one corner, worn by a thumb." CR>)>>

"The cabinet keeps its contents to itself until the player looks: its door is
ajar, so examining it swings the door wide, as opening it does."

<ROUTINE OPERATING-THEATER-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "You are in the old operating theater. Empty [[tiers]] of wooden benches rise in a ring around a stained [[operating table->table]], which waits under a [[dead lamp]] with its instrument [[trays]] beside it. The air still smells faintly of carbolic.">
           <COND (<FSET? ,METAL-CABINET ,OPENBIT>
                  <TELL " A [[metal cabinet->cabinet]] stands open beside the tiers.">)
                 (T
                  <TELL " A [[metal cabinet->cabinet]] stands beside the tiers, its door slightly ajar.">)>
           <TELL " The only way out is the sagging door to the [[south]], back to the entrance hall." CR>)>>

<ROUTINE CABINET-DESC-F (RARG)
    <COND (<EQUAL? .RARG ,M-OBJDESC>
           <COND (<FSET? ,METAL-CABINET ,OPENBIT>
                  <COND (<FIRST? ,METAL-CABINET>
                         <PRINT-CONT ,METAL-CABINET>)>)>
           <RTRUE>)>>

<ROUTINE CABINET-F ()
         <COND (<AND <VERB? OPEN>
                     <FSET? ,METAL-CABINET ,OPENBIT>>
                <TELL "The cabinet door already hangs wide." CR>
                <RTRUE>)
               (<VERB? EXAMINE LOOK-INSIDE OPEN SEARCH>
                <COND (<FSET? ,METAL-CABINET ,OPENBIT>
                       <TELL "The cabinet door hangs wide on stiff hinges. The shelves hold rusted [[medical instruments->instruments]]">)
                      (T
                       <FSET ,METAL-CABINET ,OPENBIT>
                       <FSET ,METAL-CABINET ,TOUCHBIT>
                       <TELL "You ease the cabinet door wide on its stiff hinges. The shelves hold rusted [[medical instruments->instruments]]">)>
                <COND (<OR <IN? ,SCALPEL ,METAL-CABINET> <IN? ,ETHER-BOTTLE ,METAL-CABINET>>
                       <TELL ", and among them">
                       <COND (<IN? ,SCALPEL ,METAL-CABINET> <TELL " a [[scalpel]]">)>
                       <COND (<AND <IN? ,SCALPEL ,METAL-CABINET> <IN? ,ETHER-BOTTLE ,METAL-CABINET>> <TELL " and">)>
                       <COND (<IN? ,ETHER-BOTTLE ,METAL-CABINET> <TELL " a [[bottle->ether bottle]]">)>)>
                <TELL "." CR>
                <RTRUE>)
               (<AND <VERB? CLOSE>
                     <FSET? ,METAL-CABINET ,OPENBIT>>
                <FCLEAR ,METAL-CABINET ,OPENBIT>
                <TELL "The door swings back on its warped frame and comes to rest slightly ajar." CR>
                <RTRUE>)
          (<VERB? KNOCK>
           <TELL "The thin metal booms, and something rattles on a shelf inside." CR>)
          (<VERB? SMELL>
           <TELL "Rust and the ghost of carbolic." CR>)>>

<ROUTINE HEAVYDOOR-F ()
         <COND (<VERB? THROUGH> <DO-WALK ,P?NORTH> <RTRUE>)
          (<AND <VERB? EXAMINE>
                     <NOT ,CHAINS-CUT-FLAG>>
                <TELL "A chain hangs slack around one handle. Its padlock has rusted through; an old [[leather restraint strap->chains]] has been knotted around both handles to keep the door shut. Deep fingernail scratches score the wood. A tarnished plaque reads “MORGUE”." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     ,CHAINS-CUT-FLAG>
                <TELL "The door stands open, chains lying in a heap on the floor. Beyond lies darkness." CR>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT ,CHAINS-CUT-FLAG>>
                <TELL "The chain is slack, but a [[leather restraint strap->chains]] binds the handles. You need to cut that fastening." CR>
                <RTRUE>)
               (<VERB? OPEN>
                <TELL "The door already stands open. The morgue lies to the [[north]]." CR>
                <RTRUE>)
               (<VERB? CLOSE>
                <COND (,CHAINS-CUT-FLAG
                       <TELL "The door has dropped on its hinges and will not swing back." CR>)
                      (T
                       <TELL "The door is already bound shut." CR>)>
                <RTRUE>)
               (<VERB? KNOCK>
                <TELL "You knock on the door. The sound echoes hollowly. No response comes from within." CR>
                <RTRUE>)
               (<VERB? LISTEN>
                <TELL "You press your ear to the door. From beyond comes an eerie silence—too complete, too absolute." CR>
                <RTRUE>)
          (<VERB? PUSH>
           <COND (,CHAINS-CUT-FLAG <TELL "The door has dropped on its hinges and will swing no further." CR>)
                 (T <TELL "The door gives a finger's width, and the strap creaks tight." CR>)>)
          (<VERB? RUB>
           <TELL "Your fingertips fit the scratches in the wood exactly. You take your hand away." CR>)
          (<VERB? KICK>
           <TELL "The door booms, and the sound runs the length of the ward and back." CR>)>>

<ROUTINE CHAINS-F ()
         <COND (<AND <VERB? ATTACK CUT> ,PRSI <NOT <EQUAL? ,PRSI ,SCALPEL>>>
                <TELL "That has no sharp edge fine enough to slice the leather fastening." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     <NOT ,CHAINS-CUT-FLAG>>
                <TELL "The iron chain hangs slack: the padlock has rusted through. What holds the handles together is a leather restraint strap, stiff with age and pulled tight around them. A narrow blade could slip beneath it." CR>
                <RTRUE>)
               (<AND <VERB? ATTACK CUT>
                     <NOT ,CHAINS-CUT-FLAG>
                     <NOT <IN? ,SCALPEL ,WINNER>>>
                <TELL "You cannot loosen the leather knot with your fingers. You need a sharp tool to cut the strap." CR>
                <RTRUE>)
               (<AND <VERB? ATTACK CUT>
                     <NOT ,CHAINS-CUT-FLAG>
                     <IN? ,SCALPEL ,WINNER>>
                <TELL "You slip the " D ,SCALPEL " beneath the leather strap and slice through it. The strap parts; the slack chains fall away with a crash. The heavy door creaks open, revealing a passage [[north]] into darkness." CR>
                <SETG CHAINS-CUT-FLAG T>
                <SCORE-OBJ ,CHAINS>
                <REMOVE ,CHAINS>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The chain is cold; the leather strap is stiff as wood under your fingers." CR>)
          (<VERB? MOVE>
           <TELL "The slack chain slides and clinks against the handles, but the strap holds the door shut." CR>)
          (<VERB? KICK>
           <TELL "The chain jangles and swings. The strap does not care." CR>)>>

<ROUTINE MORGUE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "This is the morgue, colder than any room above it, a cold that bites at your fingers. A steel [[dissection table->table]] stands in the middle of the floor, and banks of refrigerated [[drawers]] line the room on both sides.">
           <COND (<AND <FSET? ,REFRIGERATED-DRAWERS ,OPENBIT> <IN? ,STRANGE-SERUM ,REFRIGERATED-DRAWERS>>
                  <TELL " A green glow spills from the one drawer pulled open.">)
                 (<FSET? ,REFRIGERATED-DRAWERS ,OPENBIT>
                  <TELL " The opened drawers are dark.">)
                 (<IN? ,STRANGE-SERUM ,REFRIGERATED-DRAWERS>
                  <TELL " A faint glow leaks from the edge of one drawer.">)
                 (T
                  <TELL " The drawers are dark.">)>
           <TELL " The only way out is back [[south]] to the ward." CR>)>>

<ROUTINE DRAWERS-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE OPEN SEARCH>
                <UNCOVER ,REFRIGERATED-DRAWERS>
                <TELL "The refrigeration units line both walls. Most drawers are empty or hold only bones.">
                <COND (<IN? ,STRANGE-SERUM ,REFRIGERATED-DRAWERS>
                       <TELL " You pull out the one left ajar: inside, a vial of [[glowing serum->serum]] gives off an eerie luminescence.">)>
                <TELL CR>
                <RTRUE>)
               (<VERB? CLOSE>
                <TELL "The drawers' seals have long since perished; they will not stay shut." CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Cold metal and a sweetish chemical smell." CR>)
          (<VERB? LISTEN>
           <TELL "A thin electric hum comes from behind the drawers, though nothing here should still have power." CR>)
          (<VERB? KNOCK>
           <TELL "Each drawer answers with a flat, dull knock." CR>)>>

<ROUTINE DISTABLE-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The dissection table is made of stainless steel with drainage channels carved into its surface. Dark stains pool in the grooves.">
                <COND (<IN? ,CANVAS-BUNDLE ,DISSECTION-TABLE> <TELL " A human-shaped [[bundle]] lies under stained canvas.">)>
                <COND (<AND <IN? ,MORDECAI-JOURNAL ,MORGUE> <NOT <FSET? ,MORDECAI-JOURNAL ,TOUCHBIT>>>
                       <TELL " A small desk at the foot of the table holds a [[journal]].">)>
                <CRLF>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The steel is so cold it almost burns." CR>)
          (<VERB? SMELL>
           <TELL "Bleach, and under the bleach something that bleach could not remove." CR>)
          (<VERB? PUSH MOVE>
           <TELL "The table is bolted over the drain in the floor." CR>)>>

<ROUTINE JOURNAL-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "Dr. Mordecai's personal journal. The final entry is dated October 31, 1952. The handwriting becomes increasingly erratic: “The subject showed remarkable resilience. But the serum... it changed something fundamental. Patient 237 died on the table, yet I swear I saw movement hours later. The eyes... the eyes opened. I have made a terrible mistake. God forgive me, I must seal this place.”" CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Ink, damp, and a trace of pipe tobacco." CR>)
          (<VERB? RUB>
           <TELL "The cover is cold from lying in the morgue so long." CR>)>>

<ROUTINE PIPES-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The pipes are ancient and corroded. Water drips steadily from cracks in the metal. One pipe has a valve." CR>
                <RTRUE>)
          (<VERB? RUB>
           <COND (,BOILER-LIT <TELL "The pipe is warm now, and it trembles under your hand." CR>)
                 (T <TELL "The pipe is cold and slimy with rust." CR>)>)
          (<VERB? KNOCK KICK>
           <TELL "The pipe rings, and the note runs away along the ceiling toward the boiler room." CR>)
          (<VERB? LISTEN>
           <COND (<AND ,VALVE-TURNED-FLAG ,BOILER-LIT> <TELL "Steam knocks and hisses through the pipes, east to west." CR>)
                 (T <TELL "Only water, dripping from the joints." CR>)>)>>

<ROUTINE VALVE-F ()
         <COND (<AND <VERB? TURN TURN-BARE>
                     <NOT ,VALVE-TURNED-FLAG>>
                <TELL "You grip the wheel and turn with all your strength. It resists, then gives way with a shriek of metal.">
                <COND (,BOILER-LIT <TELL " Steam hisses into the pipes beyond the valve.">)
                      (T <TELL " There is no steam behind it yet; the pipes are cold.">)>
                <CRLF>
                <SETG VALVE-TURNED-FLAG T>
                <RTRUE>)
               (<AND <VERB? TURN TURN-BARE>
                     ,VALVE-TURNED-FLAG>
                <TELL "The valve is already open.">
                <COND (,BOILER-LIT <TELL " Steam hisses through the pipes.">)
                      (T <TELL " The pipes remain cold.">)>
                <CRLF>
                <RTRUE>)
               (<VERB? EXAMINE>
                <COND (,VALVE-TURNED-FLAG
                       <TELL "The pointer rests at OPEN. ">
                       <COND (,BOILER-LIT <TELL "The wheel trembles as steam passes behind it." CR>)
                             (T <TELL "The wheel is cold and still. No steam has reached it yet." CR>)>)
                      (T <TELL "A clean arc cuts through the rust under the wheel. An arrow stamped beside it shows which way to turn to let steam through." CR>)>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "Rust flakes off on your palm. Under it, the iron is cold." CR>)
          (<VERB? KICK>
           <TELL "The wheel will not be kicked round. It wants turning by hand." CR>)>>

<ROUTINE V-TURN-BARE ()
    <TELL "Turning " THE ,PRSO " has no effect." CR>
    <RTRUE>>

<ROUTINE BOILER-F ()
         <COND (<NOT <EQUAL? ,PRSO ,IRON-BOILER>> <RFALSE>)
               (<VERB? IGNITE>
                <V-IGNITE>
                <RTRUE>)
               (<AND <VERB? LAMP-ON> <EQUAL? ,PRSI ,OIL-LANTERN>>
                <V-IGNITE>
                <RTRUE>)
               (<VERB? EXAMINE LOOK-INSIDE>
                <COND (,BOILER-LIT
                       <TELL "The boiler roars with renewed life. Its pressure needle trembles in the yellow band, and heat pulses through the pipes toward the flooded wing." CR>)
                      (<IN? ,LUMP-OF-COAL ,IRON-BOILER>
                       <TELL "The boiler's open firebox contains fresh coal. It needs a steady flame to catch." CR>)
                      (T
                       <TELL "The boiler is a hulking iron beast. Its open firebox is black with soot and empty of usable fuel.">
                       <COND (<IN? ,COAL-SHOVEL ,IRON-BOILER>
                              <TELL " A [[coal shovel->shovel]] leans inside its mouth.">)>
                       <CRLF>)>
                <RTRUE>)
               (<VERB? BURN>
                <V-IGNITE>
                <RTRUE>)
               (<VERB? LAMP-ON>
                <COND (,BOILER-LIT
                       <TELL "The boiler is already burning steadily." CR>)
                      (T
                       <TELL "The boiler has no switch. It must be fueled and lit with a flame." CR>)>
                <RTRUE>)
          (<VERB? KNOCK KICK>
           <COND (,BOILER-LIT <TELL "The iron is far too hot to touch now. Even your knuckles near it feel the heat." CR>)
                 (T <TELL "The boiler booms like an empty bell, and the pipes overhead hum in answer." CR>)>)
          (<VERB? RUB>
           <COND (,BOILER-LIT <TELL "You hold your hand near the iron, not on it. The warmth is wonderful." CR>)
                 (T <TELL "The iron is cold and gritty with soot." CR>)>)
          (<VERB? LISTEN>
           <COND (,BOILER-LIT <TELL "The fire roars softly, and water knocks along the pipes." CR>)
                 (T <TELL "Somewhere inside, water ticks. The boiler is waiting." CR>)>)>>

<ROUTINE COAL-BIN-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH OPEN>
                <UNCOVER ,COAL-BIN>
                <COND (<IN? ,LUMP-OF-COAL ,COAL-BIN>
                       <TELL "Most of the coal has collapsed into wet black dust, but one solid [[lump of coal->coal]] could still burn. A shovel would keep the filthy slack off your hands." CR>)
                      (T
                       <TELL "Only damp coal dust remains in the bin. The last lump left a square of bare tin in the bottom." CR>)>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Wet coal and sulphur." CR>)
          (<VERB? KICK>
           <TELL "The bin clangs, and a little slide of black dust settles inside." CR>)>>

<ROUTINE COAL-F ()
         <COND (<AND <VERB? TAKE> <IN? ,LUMP-OF-COAL ,IRON-BOILER> ,BOILER-LIT>
                <TELL "The burning coal belongs in the firebox. You keep your hands clear." CR>
                <RTRUE>)
               (<AND <VERB? TAKE> <IN? ,LUMP-OF-COAL ,COAL-BIN>
                     <NOT <IN? ,COAL-SHOVEL ,WINNER>>>
                <TELL "The coal lies beneath wet, oily slack. You need something broad enough to scoop it free." CR>
                <RTRUE>)
               (<AND <VERB? TAKE> <IN? ,LUMP-OF-COAL ,COAL-BIN>>
                <TELL "Using the shovel, you pry a solid lump from the compacted coal and take it." CR>
                <MOVE ,LUMP-OF-COAL ,WINNER>
                <RTRUE>)
               (<AND <VERB? PUT> <EQUAL? ,PRSI ,IRON-BOILER>>
                <COND (<IN? ,LUMP-OF-COAL ,IRON-BOILER>
                       <TELL "The firebox already has enough coal." CR>)
                      (T
                       <TELL "You place the coal in the boiler's firebox." CR>
                       <MOVE ,LUMP-OF-COAL ,IRON-BOILER>)>
                <RTRUE>)
               (<VERB? EXAMINE>
                <TELL "A dense lump of old bituminous coal, dirty but dry at its center." CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Tar and sulphur." CR>)
          (<VERB? RUB>
           <TELL "It leaves your fingertips black and shiny." CR>)>>

<ROUTINE WORKBENCH-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
                <UNCOVER ,WORKBENCH>
                <TELL "The workbench is covered with ancient tools: hammers, wrenches, screwdrivers. Most are rusted solid.">
                <COND (<IN? ,FLASHLIGHT ,WORKBENCH>
                       <TELL " A [[flashlight]] lies among them.">)>
                <TELL CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The bench is greasy under its dust, scarred with old saw cuts." CR>)
          (<VERB? PUSH MOVE>
           <TELL "The workbench is bolted to the brick." CR>)
          (<VERB? LOOK-UNDER>
           <TELL "Only coal dust and a mouse that died a long time ago." CR>)>>

<ROUTINE STORAGE-ROOM-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "This is a storage room, small and sour-smelling. Sagging wooden [[shelves]] stand on every side">
           <COND (<FSET? ,SHELVES ,OPENBIT> <TELL ", and the damp [[linen]] hangs off them where you pulled it aside.">)
                 (T <TELL ", heaped with grey, damp [[linen]].">)>
           <TELL " Water has crept up the lowest shelves and left a dark tide line on the wood. The basement corridor is back to the [[east]]." CR>)>>

<ROUTINE SHELVES-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH OPEN>
                <UNCOVER ,SHELVES>
                <TELL "You search through the shelves. Beneath the sour linen, rust has eaten through most of the equipment.">
                <COND (<OR <IN? ,OIL-LANTERN ,SHELVES> <IN? ,MEDICAL-BAG ,SHELVES> <IN? ,MEDICAL-RECORDS ,SHELVES>>
                       <TELL " Among the debris, you find">
                       <COND (<IN? ,OIL-LANTERN ,SHELVES> <TELL " a [[lantern]]">)>
                       <COND (<AND <IN? ,OIL-LANTERN ,SHELVES> <IN? ,MEDICAL-BAG ,SHELVES>> <TELL " and">)>
                       <COND (<IN? ,MEDICAL-BAG ,SHELVES> <TELL " a [[medical bag->bag]]">)>
                       <COND (<AND <OR <IN? ,OIL-LANTERN ,SHELVES> <IN? ,MEDICAL-BAG ,SHELVES>> <IN? ,MEDICAL-RECORDS ,SHELVES>> <TELL " and">)>
                       <COND (<IN? ,MEDICAL-RECORDS ,SHELVES> <TELL " some old [[medical records]]">)>
                       <TELL ".">)>
                <TELL CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The wood is swollen and soft. Your thumb sinks into it." CR>)
          (<VERB? SMELL>
           <TELL "Sour linen and mildew." CR>)
          (<VERB? PUSH MOVE>
           <TELL "The shelves lurch and creak but stay standing, just." CR>)>>

<ROUTINE MEDICAL-BAG-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The doctor’s bag opens along a hinged metal jaw. Two straps inside are just the right width for small bottles.">
                <COND (<FSET? ,MEDICAL-BAG ,OPENBIT>
                       <TELL " Looking inside, you can see">
                       <COND (<IN? ,BANDAGES ,MEDICAL-BAG>
                              <TELL " some [[bandages]]">)>
                       <COND (<AND <IN? ,MORPHINE-VIAL ,MEDICAL-BAG>
                                   <IN? ,BANDAGES ,MEDICAL-BAG>>
                              <TELL " and">)>
                       <COND (<IN? ,MORPHINE-VIAL ,MEDICAL-BAG>
                              <TELL " a [[vial->morphine]]">)>
                       <TELL ".">)>
                <CRLF>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Old leather and iodine." CR>)
          (<VERB? RUB>
           <TELL "The leather is cracked like dry mud." CR>)>>

<ROUTINE BANDAGES-F ()
         <COND (<VERB? EXAMINE>
                <TELL "Yellowed cloth bandages, surprisingly clean despite their age. They might still be useful." CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Clean cotton, and faintly, carbolic." CR>)
          (<VERB? RUB>
           <TELL "The cloth is soft and dry." CR>)>>

<ROUTINE MORPHINE-VIAL-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A small glass vial labeled “Morphine Sulfate - 10mg”. The seal is intact." CR>
                <RTRUE>)
               (<VERB? DRINK>
                <TELL "You're not desperate enough to start taking random drugs from an abandoned sanitarium." CR>
                <RTRUE>)
          (<VERB? SHAKE>
           <TELL "The clear liquid slides inside the glass." CR>)>>

<ROUTINE STANDING-WATER-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The water is cold and murky. You can't see the bottom through the darkness." CR>
                <RTRUE>)
               (<VERB? DRINK>
                <TELL "The water smells foul. You decide against it." CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "So cold it aches to the bone. Your hand comes out numb." CR>)
          (<VERB? LISTEN>
           <TELL "Out in the dark, the water laps against something. A ripple reaches your ankles and passes." CR>)
          (<VERB? SEARCH LOOK-INSIDE>
           <TELL "You feel through silt and cold. Nothing but stone." CR>)>>

<ROUTINE SEALED-DOOR-F ()
         <COND (<VERB? THROUGH> <DO-WALK ,P?EAST> <RTRUE>)
          (<AND <VERB? EXAMINE>
                     <NOT ,STEAM-DOOR-OPEN>>
                <TELL "Corrosion has sealed the metal door in its frame. Steam might loosen it." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     ,STEAM-DOOR-OPEN>
                <TELL "The " D ,SEALED-DOOR " stands open. Rust lies in wet flakes where the steam freed the frame." CR>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT ,STEAM-DOOR-OPEN>
                     <NOT ,VALVE-TURNED-FLAG>>
                <TELL "The " D ,SEALED-DOOR " won't budge. It's corroded shut." CR>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT ,STEAM-DOOR-OPEN>
                     <OR <NOT ,BOILER-LIT> <L? ,BOILER-HEAT 2>>>
                <TELL "The metal is still cold. Opening the valve is not enough; the boiler must send steam through the pipes." CR>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT ,STEAM-DOOR-OPEN>
                     ,VALVE-TURNED-FLAG>
                <TELL "The steam from the opened " D ,VALVE " has loosened the corrosion. With effort, you wrench the " D ,SEALED-DOOR " open. Beyond it, to the [[east]], lies a hydrotherapy room." CR>
                <SETG STEAM-DOOR-OPEN T>
                <RTRUE>)
          (<VERB? KNOCK KICK>
           <TELL "The metal gives back a dull clang, and flakes of rust fall into the water." CR>)
          (<VERB? RUB>
           <COND (,STEAM-DOOR-OPEN <TELL "The metal is warm and wet with steam." CR>)
                 (T <TELL "The door is ice cold, and rough with corrosion along the seam." CR>)>)
          (<VERB? LISTEN>
           <TELL "Behind the door, something drips." CR>)>>

<ROUTINE TUBS-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH OPEN>
                <UNCOVER ,PORCELAIN-TUBS>
                <TELL "The tubs are large enough to immerse a full-grown person. Leather restraints are bolted to the sides. Dark stains ring the waterline.">
                <COND (<IN? ,SOGGY-NOTEBOOK ,PORCELAIN-TUBS>
                       <TELL " In the last tub, a [[soggy notebook->notebook]] lies in an inch of rust-brown water.">)>
                <TELL CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The porcelain is slick and cold, like the inside of a shell." CR>)
          (<VERB? SMELL>
           <TELL "Stale water and rust." CR>)
          (<VERB? LISTEN>
           <TELL "Drip... drip... into the last tub." CR>)>>

<ROUTINE MEDICINE-CABINET-F ()
         <COND (<VERB? SCRAPE>
                <V-SCRAPE>
                <RTRUE>)
               (<AND <VERB? EXAMINE LOOK-INSIDE>
                     <NOT ,CABINET-THAWED>>
                <TELL "Frost has welded the medicine cabinet shut. Through the clouded glass you can just make out a syringe. Scraping removes only powder before the ice hardens again; the pipes behind the wall would have to warm." CR>
                <RTRUE>)
               (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "Meltwater runs down the cabinet door.">
                <COND (<IN? ,SYRINGE ,MEDICINE-CABINET>
                       <COND (<FSET? ,MEDICINE-CABINET ,OPENBIT>
                              <TELL " Among ruined dressings, a glass [[syringe]] remains usable.">)
                             (T <TELL " Through the glass you can see a syringe among ruined dressings. The thawed door can now be opened.">)>)
                      (T <TELL " Only ruined dressings remain on its shelves.">)>
                <CRLF>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT ,CABINET-THAWED>>
                <TELL "The frost holds the door more firmly than any lock." CR>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     ,CABINET-THAWED
                     <NOT <FSET? ,MEDICINE-CABINET ,OPENBIT>>>
                <TELL "You pull the thawed cabinet open. Meltwater patters onto the tile.">
                <COND (<IN? ,SYRINGE ,MEDICINE-CABINET> <TELL " A glass [[syringe]] rests on the shelf.">)>
                <CRLF>
                <FSET ,MEDICINE-CABINET ,OPENBIT>
                <RTRUE>)
          (<VERB? RUB>
           <COND (,CABINET-THAWED <TELL "The glass is wet and cold, but your fingers no longer stick to it." CR>)
                 (T <TELL "So cold that your fingertips stick for a moment. You pull them free." CR>)>)
          (<VERB? KNOCK>
           <COND (,CABINET-THAWED <TELL "The cabinet rattles; something glass rolls on a shelf." CR>)
                 (T <TELL "The frost rings like glass, and a few white flakes fall." CR>)>)>>

<ROUTINE CELL-DOORS-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "Each door is solid metal with a small barred window. The cells beyond are empty save for scratches covering every surface. Someone marked time here, day after agonizing day." CR>
                <RTRUE>)
          (<VERB? KNOCK>
           <TELL "Your knock rolls down the row of empty cells. From the far end, something knocks back once." CR>)
          (<VERB? LISTEN>
           <TELL "You press your ear to the bars. Inside, the silence is total." CR>)
          (<VERB? PUSH MOVE>
           <TELL "The doors are rusted where they stand." CR>)
          (<VERB? OPEN UNLOCK ENTER THROUGH PULL>
           <TELL "You try the nearest handle, then the next. Every cell is locked, and the keyholes have rusted solid. Through the bars you can see there is nothing inside but the scratches." CR>)>>

<ROUTINE WALL-SCRATCHES-F ()
         <COND (<VERB? EXAMINE COUNT>
                <TELL "The scratches are too numerous to count. They cover every inch of the cell walls. Some form words: “HELP ME” “NO MORE” “PLEASE”. One message is larger than the rest: “PATIENT 189 STILL ALIVE IN THE CHAPEL”." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You run your fingers over the scratches. They're deep—gouged by fingernails over years of desperation." CR>
                <RTRUE>)
               (<VERB? READ>
                <TELL "Among the chaos of scratches, you can make out words: “HELP ME” “NO MORE” “PLEASE”. The largest message reads: “PATIENT 189 STILL ALIVE IN THE CHAPEL”.">
                <TELL " And then, in a corner, smaller and more recent: the date “1947” and a single word—“remember”—carved with unusual precision." CR>
                <SCORE-OBJ ,WALL-SCRATCHES>
                <COND (<NOT ,WALL-SCRATCHES-LORE>
                       <SETG WALL-SCRATCHES-LORE T>
                       <SETG PATIENT-LORE <+ ,PATIENT-LORE 1>>)>
                <RTRUE>)>>

<ROUTINE SHOCK-CHAIR-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The chair is bolted to the floor. Leather restraints hang from the arms and legs, polished smooth where wrists and ankles fought them. Electrodes wait at temple height; beneath one, the metal has been bitten through." CR>
                <RTRUE>)
               (<VERB? CLIMB-ON SIT>
                <TELL "You have no desire to sit in that terrible chair." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You touch the cold metal armrest. The leather restraints feel disturbingly well-worn. You pull your hand away quickly." CR>
                <RTRUE>)
               (<VERB? PUSH MOVE>
                <TELL "The chair is bolted firmly to the floor. It doesn't budge." CR>
                <RTRUE>)
          (<VERB? LOOK-UNDER>
           <TELL "A black stain spreads over the concrete beneath the seat." CR>)
          (<VERB? SMELL>
           <TELL "Old leather and sweat." CR>)>>

<ROUTINE SHOCK-MACHINE-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The machine has various dials and switches. Labels indicate voltage levels up to dangerous levels. The electrodes are stained dark." CR>
                <RTRUE>)
               (<VERB? TURN TURN-BARE SWITCH-ON LAMP-ON>
                <TELL "You throw the switch. A blue arc cracks between the empty electrodes, filling the room with the smell of scorched dust. You shut it off before the ancient wiring can do worse." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You touch one of the electrodes. It's cold and stained with something dark. You feel a faint tingle and quickly pull your hand away." CR>
                <RTRUE>)
          (<VERB? LISTEN>
           <TELL "A faint hum comes from deep inside the cabinet, though no cable is plugged in." CR>)
          (<VERB? KICK>
           <TELL "You stop yourself. Whatever is left in its wiring, you do not want it angry." CR>)>>

<ROUTINE PADDING-F ()
         <COND (<VERB? EXAMINE READ>
                <TELL "The padding is torn and moldering. On one wall, written in what appears to be dried blood, are the words: “THE CHAPEL BEYOND THE GARDEN. HE WAITS THERE. PATIENT 189.”" CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You touch the rotting padding. It's damp and spongy, falling apart at the slightest pressure." CR>
                <RTRUE>)
               (<VERB? SMELL>
                <TELL "The padding reeks of mildew, decay, and something else—the sour smell of old fear." CR>
                <RTRUE>)
               (<VERB? MOVE>
                <TELL "The padding tears away in chunks when you pull it, but there's nothing behind it but more rot." CR>
                <RTRUE>)
          (<VERB? KNOCK KICK>
           <TELL "Your blow sinks into the padding without a sound. That was the point of it." CR>)>>

<ROUTINE STRAITJACKET-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A heavy canvas straitjacket with multiple leather buckles and straps. Dark stains cover the fabric. On the collar—a name tag, the ink nearly faded.">
                <COND (<NOT ,STRAITJACKET-LORE>
                       <SETG STRAITJACKET-LORE T>
                       <SETG PATIENT-LORE <+ ,PATIENT-LORE 1>>
                       <TELL " You can make out a few letters, a date. The handwriting seems... familiar.">)
                      (T
                       <TELL " The name on the tag is illegible now, but the date is clear: 1947.">)>
                <TELL CR>
                <RTRUE>)
               (<VERB? READ>
                <TELL "The tag reads a name—the ink is smeared, but the date is unmistakable. 1947. Five years before the sanitarium closed. You stare at it longer than you meant to." CR>
                <RTRUE>)
               (<VERB? WEAR>
                <TELL "You'd rather not." CR>
                <RTRUE>)
               (<VERB? SMELL>
                <TELL "The straitjacket smells of sweat, fear, and something metallic—perhaps old blood." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "The canvas is rough and stiff. The stains feel crusty under your fingers." CR>
                <RTRUE>)>>

<ROUTINE MIRROR-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <COND (<G? ,PATIENT-LORE 0>
                       <TELL "Through the mirror, you can see the electroshock theater below. The shock chair sits in the center.">
                       <TELL " In the glass, your reflection is barely visible—a dark shape that seems to shift when you try to focus on it. You look away." CR>)
                      (T
                       <TELL "Through the mirror, you can see the electroshock theater below. The shock chair sits in the center like a throne of suffering." CR>)>
                <RTRUE>)
          (<VERB? KNOCK>
           <TELL "The glass is thick; your knock barely makes a sound. Down below, nothing looks up." CR>)
          (<VERB? RUB>
           <TELL "The glass is cold, and your fingers leave a smear that slowly fades." CR>)>>

<ROUTINE OBSERVATION-LOGBOOK-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "The logbook contains clinical observations of treatments. One entry stands out: “Session 47 - Patient 189. Subject required maximum voltage. Seizure lasted 4 minutes. Memory loss total. Subject claims to be someone else now. Dr. Mordecai pleased with results. Proceeding to next phase.”" CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Pencil shavings and damp." CR>)
          (<VERB? RUB>
           <TELL "The pages are ruled in neat columns, pressed hard enough to dent." CR>)>>

<ROUTINE SCATTERED-PAPERS-F ()
         <COND (<VERB? EXAMINE READ SEARCH>
                <TELL "You sort through the papers. Most are mundane: supply orders, staff schedules, building maintenance. One [[memo]] catches your eye: “All staff reminded - Subject 189 is NOT to be released under any circumstances. Chapel is OFF LIMITS.”" CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Damp paper and old ink." CR>)
          (<VERB? KICK>
           <TELL "The papers lift and settle again with a wet slap." CR>)>>

<ROUTINE MASSIVE-DESK-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The dark wood is polished to a shine. Empty folders and pens fill the drawers.">
                <COND (<AND <IN? ,HOLLOW-BOOK ,DIRECTORS-OFFICE> <NOT <FSET? ,HOLLOW-BOOK ,TOUCHBIT>>>
                       <TELL " A row of medical texts lines the back of the desk. One red [[tome->book]] has no title.">)>
                <CRLF>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The polish is smooth as glass. Someone kept this desk shining while the rest of the building rotted." CR>)
          (<VERB? KNOCK>
           <TELL "The desk is solid; the books along its back hardly stir." CR>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the desk there is only a worn rug, scuffed where a chair turned and turned." CR>)
          (<VERB? OPEN SEARCH>
           <TELL "You pull the drawers out one by one: empty folders, dried pens, a blotter with nothing written on it. Mordecai kept nothing in his desk that he wanted kept.">
           <COND (<AND <IN? ,HOLLOW-BOOK ,DIRECTORS-OFFICE> <NOT <FSET? ,HOLLOW-BOOK ,TOUCHBIT>>>
                  <TELL " Along the back, between the labeled medical texts, a red [[tome->book]] has no title.">)>
           <CRLF>
           <RTRUE>)
          (<VERB? CLOSE>
           <TELL "You push the drawers shut. They glide home without a sound." CR>)
          (<VERB? SMELL>
           <TELL "Beeswax and stale pipe tobacco." CR>)>>

<ROUTINE HOLLOW-BOOK-F ()
         <COND (<AND <VERB? EXAMINE>
                     <NOT <FSET? ,HOLLOW-BOOK ,OPENBIT>>>
                <TELL "A red leather tome with a blank spine where all others are labeled. It has a small [[brass latch->red book]] on the edge, not a proper binding." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     <FSET? ,HOLLOW-BOOK ,OPENBIT>>
                <TELL "Someone glued the [[pages->glued pages]] together, then cut a hollow through them. ">
                <COND (<IN? ,SAFE-KEY ,HOLLOW-BOOK> <TELL "The small [[safe key]] fits the hollow exactly." CR>)
                      (T <TELL "A rusty [[outline->glued pages]] shows where the key lay." CR>)>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT <FSET? ,HOLLOW-BOOK ,OPENBIT>>>
                <TELL "You flip the brass latch and open the book. The pages are glued solid—it's not a book at all, but a hollow hiding place. Inside you find a small [[key->safe key]]." CR>
                <FSET ,HOLLOW-BOOK ,OPENBIT>
                <RTRUE>)
               (<VERB? READ>
                <TELL "The pages are glued together. It's a hollow hiding place, not a real book." CR>
                <RTRUE>)
          (<VERB? SHAKE>
           <COND (<IN? ,SAFE-KEY ,HOLLOW-BOOK> <TELL "Something small slides inside and clicks against the cover." CR>)
                 (T <TELL "Nothing moves inside." CR>)>)
          (<VERB? RUB>
           <TELL "The leather is smooth and warm, oddly warm." CR>)>>

"The safe is INVISIBLE behind the portrait until the portrait is examined or
moved: its frame sits proud of the paneling, and it swings on a hinge."

<ROUTINE REVEAL-SAFE ()
    <FCLEAR ,WALL-SAFE ,INVISIBLE>
    <FSET ,MORDECAI-PORTRAIT ,TOUCHBIT>
    <THIS-IS-IT ,WALL-SAFE>>

<ROUTINE PORTRAIT-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The portrait shows Dr. Mordecai, a gaunt man with piercing eyes and a cruel mouth. The [[nameplate]] reads: “Dr. Heinrich Mordecai - Director 1935-1952”. His eyes seem to follow you around the room.">
                <COND (<FSET? ,WALL-SAFE ,INVISIBLE>
                       <REVEAL-SAFE>
                       <TELL " The frame sits proud of the paneling. You tug its edge, and the portrait swings aside on a hinge, revealing a [[wall safe->safe]].">)>
                <CRLF>
                <RTRUE>)
               (<VERB? MOVE PUSH LOOK-BEHIND OPEN RAISE>
                <COND (<FSET? ,WALL-SAFE ,INVISIBLE>
                       <REVEAL-SAFE>
                       <TELL "The portrait swings aside on a hidden hinge, revealing a [[wall safe->safe]] set into the paneling." CR>)
                      (T
                       <TELL "The portrait already hangs swung aside from the safe." CR>)>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You reach out to touch the portrait. The paint feels oddly warm. You could swear the eyes moved." CR>
                <RTRUE>)
               (<VERB? TAKE>
                <TELL "The portrait is securely fastened to the wall. Besides, you have no desire to carry that man's visage with you." CR>
                <RTRUE>)
               (<VERB? ATTACK>
                <TELL "You consider defacing the portrait, but something stops you. Those painted eyes seem to dare you to try." CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Oil paint. It smells far too fresh." CR>)>>

<ROUTINE WALL-SAFE-F ()
         <COND (<AND <VERB? OPEN UNLOCK> ,PRSI <NOT <EQUAL? ,PRSI ,SAFE-KEY>>>
                <TELL "That does not fit the safe's lock." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     <FSET? ,WALL-SAFE ,OPENBIT>>
                <TELL "The safe is open. Its green felt lining is worn through around the key hooks." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE> ,SAFE-UNLOCKED>
                <TELL "The safe is closed but unlocked. The handle will turn without the key." CR>)
               (<VERB? EXAMINE>
                <TELL "The safe is locked. Scratches run down from the keyhole, as though someone kept trying to find it in the dark." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <FSET? ,WALL-SAFE ,OPENBIT>>
                <TELL "The safe is already open." CR>
                <RTRUE>)
               (<VERB? CLOSE>
                <COND (<FSET? ,WALL-SAFE ,OPENBIT>
                       <FCLEAR ,WALL-SAFE ,OPENBIT>
                       <TELL "You swing the safe shut. The bolt is still drawn back." CR>)
                      (T <TELL "The safe is already closed." CR>)>)
               (<AND <VERB? OPEN UNLOCK> ,SAFE-UNLOCKED>
                <FSET ,WALL-SAFE ,OPENBIT>
                <TELL "The safe swings open again." CR>
                <COND (<FIRST? ,WALL-SAFE> <PRINT-CONT ,WALL-SAFE>)
                      (T <TELL "It is empty." CR>)>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <AND <HELD? ,SAFE-KEY> <ACCESSIBLE? ,SAFE-KEY>>>>
                <TELL "The safe is locked. You need the key." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <FSET? ,WALL-SAFE ,OPENBIT>>
                     <AND <HELD? ,SAFE-KEY> <ACCESSIBLE? ,SAFE-KEY>>>
                <TELL "You unlock the " D ,WALL-SAFE " with the " D ,SAFE-KEY ". Inside are Dr. Mordecai's [[private notes]] and a [[chapel key]]." CR>
                <SETG SAFE-UNLOCKED T>
                <FSET ,WALL-SAFE ,OPENBIT>
                <RTRUE>)
          (<VERB? KNOCK>
           <TELL "Thick steel. The knock dies in it." CR>)
          (<VERB? RUB>
           <TELL "The steel is cold and smooth, scratched below the keyhole." CR>)>>

<ROUTINE SAFE-KEY-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A small brass key with a [[numbered tag]] reading “S-001”. It looks like a safe key." CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The key is small and smooth, worn by one hand for a long time." CR>)>>

<ROUTINE MORDECAI-NOTES-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "The notes are written in a shaking hand: “October 30, 1952 - Patient 189 has transcended death itself. The screaming never stops. When I uncovered the silver cross, he became still enough for me to approach with the syringe. A second dose of Compound 237 made the green light falter. I withdrew the needle. After everything I have done, I could not make myself finish. The chapel must remain locked.” Beneath this, pressed almost through the paper: “What I've created must never escape.”" CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Ink and pipe tobacco." CR>)>>

<ROUTINE CHAPEL-KEY-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A heavy iron key with a cross engraved on its head. The key feels unnaturally cold." CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "However long you hold it, it does not warm." CR>)>>

<ROUTINE LOCKERS-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH OPEN>
                <UNCOVER ,LOCKERS>
                <TELL "Most lockers are empty or hold rotted clothing. One still holds a nurse's [[uniform]]">
                <COND (<IN? ,PHOTOGRAPH ,LOCKERS>
                       <TELL ", and tucked behind it, a [[photograph]]">)>
                <TELL ".">
                <TELL CR>
                <RTRUE>)
          (<VERB? KNOCK KICK>
           <TELL "The lockers clang one after another down the row, like doors slamming." CR>)
          (<VERB? SMELL>
           <TELL "Mothballs and old sweat." CR>)
          (<VERB? PUSH MOVE>
           <TELL "The bank of lockers rocks and settles back with a groan." CR>)>>

<ROUTINE STAFF-UNIFORM-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
           <TELL "A starched nurse's uniform, grey with mildew. The name tape over the pocket has been unpicked, leaving only a row of needle holes." CR>)
          (<VERB? TAKE WEAR MOVE PULL>
           <TELL "The cloth splits at the shoulder seam as soon as you lift it from its hook. You let it hang where it was." CR>)
          (<VERB? SMELL>
           <TELL "Mildew, and under it the ghost of starch." CR>)
          (<VERB? RUB>
           <TELL "The fabric is stiff and damp, like paper left out in the rain." CR>)>>

<ROUTINE PHOTOGRAPH-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The photograph shows the sanitarium staff posed outside the building. Dr. Mordecai stands in the center, unsmiling. Written on the back: “Staff photo 1950. Two years before they closed us down. Two years before everything went wrong.”" CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The surface is cracked into tiny squares. Someone has rubbed one face in the back row nearly away." CR>)>>

<ROUTINE COUNTER-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE READ>
                <TELL "The serving counter is thick with dust. Old menus are still posted on the wall: “Monday - Mystery Meat”.">
                <COND (<IN? ,BELL ,SERVING-COUNTER> <TELL " A [[bell]] for summoning kitchen staff sits on the counter.">)>
                <CRLF>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "Your finger leaves a track in the dust. Underneath, the counter is scored with knife marks." CR>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the counter, a stack of tin plates and a dead rat." CR>)
          (<VERB? SMELL>
           <TELL "Old grease and dust." CR>)
          (<VERB? KNOCK>
           <TELL "The counter booms. In the empty kitchen behind it, something rolls a little way and stops." CR>)>>

<ROUTINE BELL-F ()
         <COND (<VERB? RING PUSH>
                <TELL "You ring the bell. The tinny sound carries through the empty rooms. No one comes." CR>
                <RTRUE>)
               (<VERB? EXAMINE>
                <TELL "Years of thumbs have polished the [[small button->service bell]] bright. A little hammer waits under the [[brass dome]]." CR>
                <RTRUE>)
               (<VERB? LISTEN>
                <TELL "The bell makes a clear ringing sound when struck." CR>
                <RTRUE>)
               (<VERB? SHAKE>
                <TELL "You shake the bell. It rings with a cheerful tone that seems out of place in this dead building." CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The brass is cold and greenish, except for the button, worn bright." CR>)>>

<ROUTINE DEAD-GARDEN-F ()
         <COND (<VERB? EXAMINE SEARCH>
                <TELL "The dead roses still cling to their stems. Fallen petals hang from the thorns like scraps of brown paper. Among the weeds, you can see broken stone benches and a crumbling fountain." CR>
                <RTRUE>)
               (<AND <VERB? DIG>
                     <IN? ,COAL-SHOVEL ,WINNER>>
                <TELL "You dig into the dead earth with the shovel. The soil is dry and lifeless. After a few moments, you give up—nothing but rocks and roots here." CR>
                <RTRUE>)
               (<AND <VERB? DIG>
                     <NOT <IN? ,COAL-SHOVEL ,WINNER>>>
                <TELL "You'd need a shovel or similar tool to dig here." CR>
                <RTRUE>)
               (<VERB? SMELL>
                <TELL "The garden smells of decay and rot, with an underlying odor of something else—something chemical and wrong." CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "A thorn pricks your thumb. One bead of blood, very red against all that grey." CR>)
          (<VERB? TAKE>
           <TELL "The rose crumbles to brown dust in your fingers." CR>)>>

<ROUTINE CHAPEL-DOOR-F ()
         <COND (<VERB? THROUGH> <DO-WALK ,P?NORTH> <RTRUE>)
          (<VERB? READ> <TELL "HE WHO ENTERS ABANDONS HOPE." CR>)
          (<AND <VERB? OPEN UNLOCK> ,PRSI <NOT <EQUAL? ,PRSI ,CHAPEL-KEY>>>
                <TELL "That does not fit the chapel lock." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     <NOT ,CHAPEL-UNLOCKED>>
                <TELL "The door is made of thick oak bound with iron straps. A large iron lock secures it. Above the door, [[carved words->chapel door]] read: “HE WHO ENTERS ABANDONS HOPE”." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     ,CHAPEL-UNLOCKED>
                <TELL "The door stands open. Green candle wax has dripped across the threshold from inside." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT ,CHAPEL-UNLOCKED>
                     <NOT <IN? ,CHAPEL-KEY ,WINNER>>>
                <TELL "The door is locked. You need the " D ,CHAPEL-KEY "." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT ,CHAPEL-UNLOCKED>
                     <IN? ,CHAPEL-KEY ,WINNER>>
                <TELL "You insert the " D ,CHAPEL-KEY " into the lock. It turns with a heavy clunk. The door swings open slowly, revealing darkness beyond. A foul wind rushes out, carrying the scent of decay." CR>
                <SETG CHAPEL-UNLOCKED T>
                <RTRUE>)
               (<VERB? READ>
                <TELL "The words carved above the door read: “HE WHO ENTERS ABANDONS HOPE”." CR>
                <RTRUE>)
               (<VERB? KNOCK>
                <TELL "You knock on the heavy oak door. The sound echoes dully, and you think you hear something shift on the other side." CR>
                <RTRUE>)
               (<VERB? LISTEN>
                <TELL "You press your ear against the door. From within comes a faint sound—breathing? Or just the wind?" CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The oak is cold, and the iron straps are colder." CR>)>>

<ROUTINE BLACKWOOD-AT-HAND? (OBJ)
    <AND <HELD? .OBJ> <ACCESSIBLE? .OBJ>>>

<ROUTINE PATIENT-189-RESOLUTION-F ()
    <COND (<NOT <IN? ,PATIENT-189 ,CHAPEL>>
           <TELL "Patient 189 drifts back a pace for each one you take, always toward the chapel door. Whatever is to be done will be done at the altar." CR>
           <RTRUE>)
          (<AND <BLACKWOOD-AT-HAND? ,ANCIENT-RELIC>
                <BLACKWOOD-AT-HAND? ,STRANGE-SERUM>
                <BLACKWOOD-AT-HAND? ,SYRINGE>>
           <TELL "You hold out the relic. Patient 189 stills completely. You draw the serum into the syringe and step forward—every instinct screaming—and inject it." CR>
           <TELL "The green light in its eyes gutters. Patient 189 shudders, mouth opening in a soundless cry. The green flames around the chapel gutter and die." CR>
           <TELL "Then it speaks, in a voice like someone remembering how: “I remember... who I was.”" CR>
           <COND (<G? ,PATIENT-LORE 4>
                  <TELL "It looks into you, and the missing years return—not as a story you learned, but as your own memory: the straps, Mordecai's voice, the name Patient 189 replacing yours. The figure is not your double. It is the pain they cut away from you and locked here. When you take its hand, it folds into your shadow, and for the first time since 1947 you are whole." CR>)
                 (<G? ,PATIENT-LORE 2>
                  <TELL "It looks at you with recognition—not as a stranger, but as someone who understands what it endured. It crumbles to ash." CR>)
                 (T
                  <TELL "Its eyes pass over you without recognition. You freed it, but it never knew you. It crumbles to ash." CR>)>
           <TELL "The candles go out. The air suddenly smells like rain and grass—ordinary, living air. You're free." CR>
           <SETG GAME-WON T>
           <SETG PATIENT-STATE 3>
           <SCORE-UPD 5> ;"rooms 43 + things 20 + this = SCORE-MAX"
           <REMOVE ,PATIENT-189>
           <FINISH>)
          (<AND <BLACKWOOD-AT-HAND? ,ANCIENT-RELIC> <BLACKWOOD-AT-HAND? ,STRANGE-SERUM>>
           <TELL "The relic glows warm and Patient 189 stills, its eyes on the vial of serum. But you have nothing to deliver the dose with." CR>
           <RTRUE>)
          (<BLACKWOOD-AT-HAND? ,ANCIENT-RELIC>
           <TELL "The relic glows warm. Patient 189 shivers, eyes flickering. But something still binds it. The serum—if returned to its source..." CR>
           <RTRUE>)
          (<G? ,PATIENT-STATE 1>
           <TELL "Patient 189 acknowledges you—a slight inclination of the head. But words alone won't end this. You need the means to free it." CR>
           <RTRUE>)
          (T
           <TELL "Patient 189 tilts its head. Green light flares in its eyes. Something cold reaches into your chest. You are not ready." CR>
           <RTRUE>)>>

<ROUTINE SHOW-HINT (KEY ATTENTION DIRECTION ACTION COMMAND)
    <COND (<EQUAL? ,HINT-KEY .KEY>
           <COND (<L? ,HINT-LEVEL 4>
                  <SETG HINT-LEVEL <+ ,HINT-LEVEL 1>>)>)
          (T
           <SETG HINT-KEY .KEY>
           <SETG HINT-LEVEL 1>)>
    <COND (<EQUAL? ,HINT-LEVEL 1> <TELL .ATTENTION CR>)
          (<EQUAL? ,HINT-LEVEL 2> <TELL .DIRECTION CR>)
          (<EQUAL? ,HINT-LEVEL 3> <TELL .ACTION CR>)
          (T <TELL .COMMAND CR>)>
    <RTRUE>>

<ROUTINE V-HINTS ()
    <COND (<NOT ,CHAINS-CUT-FLAG>
           <SHOW-HINT 1
              "The chained morgue door is meant to be opened."
              "The operating theater contains a cutting instrument."
              "Take the scalpel and use it on the chains."
              "ATTACK CHAINS WITH SCALPEL">)
          (<NOT ,VALVE-TURNED-FLAG>
           <SHOW-HINT 2
              "The sealed eastern door needs more than muscle."
              "Follow the basement pipes back toward their valve."
              "Open the valve in the basement corridor to release steam."
              "TURN VALVE">)
          (<NOT ,CABINET-THAWED>
           <SHOW-HINT 3
              "The syringe is visible, but the frozen cabinet will not open."
              "The boiler-room pipes run toward hydrotherapy."
              "Use the shovel to recover coal, put it in the boiler, then kindle it with the lit lantern."
              "TAKE SHOVEL; TAKE COAL; PUT COAL IN BOILER; LIGHT LANTERN; KINDLE BOILER WITH LANTERN; WAIT">)
          (<NOT ,CHAPEL-UNLOCKED>
           <SHOW-HINT 4
              "The chapel key was kept somewhere only Mordecai could reach."
              "Search the director's office carefully."
              "A conspicuous book hides the safe key; the safe contains the chapel key."
              "OPEN BOOK; TAKE SAFE KEY; UNLOCK SAFE WITH SAFE KEY; TAKE CHAPEL KEY">)
          (<NOT <FSET? ,WOODEN-BOX ,OPENBIT>>
           <SHOW-HINT 5
              "Patient 189 keeps looking toward the altar."
              "Examine the wooden box beneath it."
              "The scalpel can pry the rusted clasp apart."
              "OPEN BOX">)
          (<NOT ,GAME-WON>
           <SHOW-HINT 6
              "Three objects connect Mordecai's experiment to Patient 189."
              "You need the relic, the serum, and the syringe."
              "Carry all three to Patient 189 and use the syringe."
              "INJECT PATIENT WITH SYRINGE">)
          (T
           <TELL "The ordinary night air is answer enough." CR>)>>

<ROUTINE V-SCRAPE ()
    <COND (<EQUAL? ,PRSO ,MEDICINE-CABINET>
           <COND (,CABINET-THAWED
                  <TELL "The remaining frost wipes away beneath your fingers." CR>)
                 (T
                  <TELL "You scrape away a patch of frost, but new crystals creep across the exposed metal almost immediately. The cabinet needs sustained heat." CR>)>)
          (T
           <TELL "Scraping it accomplishes nothing." CR>)>
    <RTRUE>>

<ROUTINE V-SHOW ()
    <TELL "No one here is in any state to look at " THE ,PRSO "." CR>
    <RTRUE>>

<ROUTINE V-INJECT ()
    <COND (<NOT <EQUAL? ,PRSI ,SYRINGE>>
           <TELL "That is not suitable for an injection." CR>)
          (<NOT <EQUAL? ,PRSO ,WINNER ,ME ,PATIENT-189>>
           <TELL "You have no reason to inject " THE ,PRSO "." CR>)
          (<NOT <BLACKWOOD-AT-HAND? ,SYRINGE>>
           <TELL "You need to be holding the syringe." CR>)
          (<EQUAL? ,PRSO ,WINNER ,ME>
           <COND (<BLACKWOOD-AT-HAND? ,STRANGE-SERUM>
                  <JIGS-UP "The serum enters your vein like ice. For one lucid instant you remember the chapel from inside its locked door; then a green light opens behind your eyes and never closes.">)
                 (T <TELL "The syringe is empty. You lower it without using it." CR>)>)
          (<NOT <IN? ,PATIENT-189 ,CHAPEL>>
           <PATIENT-189-RESOLUTION-F>)
          (<NOT <BLACKWOOD-AT-HAND? ,STRANGE-SERUM>>
           <TELL "The syringe's glass chamber is empty. You have nothing to fill it with." CR>)
          (<NOT <BLACKWOOD-AT-HAND? ,ANCIENT-RELIC>>
           <TELL "You raise the needle. Green light flares in Patient 189's eyes and the cold drives you back before you are within arm's reach. Something must hold it still first." CR>)
          (T
           <PATIENT-189-RESOLUTION-F>)>
    <RTRUE>>

<ROUTINE V-IGNITE ()
    <COND (<NOT <EQUAL? ,PRSO ,IRON-BOILER>>
           <TELL "You cannot safely ignite " THE ,PRSO "." CR>)
          (<NOT <EQUAL? ,PRSI ,OIL-LANTERN>>
           <TELL "That will not provide a steady flame." CR>)
          (<NOT <IN? ,LUMP-OF-COAL ,IRON-BOILER>>
           <TELL "The [[boiler]]'s firebox needs coal first." CR>)
          (<NOT ,LANTERN-LIT-FLAG>
           <TELL "The [[lantern]] must be lit first." CR>)
          (,BOILER-LIT
           <TELL "The boiler is already burning steadily." CR>)
          (T
           <TELL "You hold the lantern flame to the coal. Smoke rolls from the firebox; then orange light catches underneath. The boiler answers with a deep metallic thud as water begins moving through long-dead pipes." CR>
           <SETG BOILER-LIT T>
           <FSET ,LUMP-OF-COAL ,NDESCBIT>
           <SETG BOILER-HEAT 0>)>
    <RTRUE>>

<ROUTINE V-SAY-HELLO ()
    <COND (<AND <EQUAL? ,HERE ,CHAPEL>
                <IN? ,PATIENT-189 ,CHAPEL>>
           <PATIENT-189-RESOLUTION-F>)
          (T
           <TELL "Your greeting receives no answer, but at least the building does not mistake it for a farewell." CR>)>>

<ROUTINE V-HELLO ()
    <V-SAY-HELLO>>

<ROUTINE V-BARE-HELLO ()
    <TELL "Your greeting receives no answer, but at least the building does not mistake it for a farewell. If you mean to address someone, try SAY HELLO." CR>
    <RTRUE>>

<ROUTINE V-GREET-OBJECT ()
    <COND (<FSET? ,PRSO ,ACTORBIT>
           <TELL THE ,PRSO " bows his head to you in greeting." CR>)
          (T
           <TELL "Your greeting is wasted on " THE ,PRSO "." CR>)>
    <RTRUE>>

<ROUTINE V-LISTEN-AROUND ()
    <COND (,GAME-WON
           <TELL "For the first time, the building is quiet: no whispers, no footsteps, only wind moving through broken glass." CR>)
          (<EQUAL? ,HERE ,BOILER-ROOM>
           <TELL "Water ticks in the pipes and coal shifts softly in the bin." CR>)
          (<EQUAL? ,HERE ,OVERGROWN-GARDEN ,SANITARIUM-GATE>
           <TELL "The crows make no sound. Far off, branches scrape against stone." CR>)
          (T
           <TELL "Beyond your breathing, the sanitarium answers with a distant creak and something that might be a footstep." CR>)>
    <RTRUE>>

<ROUTINE V-SMELL-AROUND ()
    <COND (,GAME-WON
           <TELL "Rain, wet stone, and grass—the ordinary smells of a night outside." CR>)
          (<EQUAL? ,HERE ,SANITARIUM-ENTRANCE>
           <TELL "Mildew, wet plaster, and the mineral chill of a long-sealed building." CR>)
          (<EQUAL? ,HERE ,STORAGE-ROOM>
           <TELL "Moldy linen and a sour medicinal residue catch at the back of your throat." CR>)
          (<EQUAL? ,HERE ,PADDED-CELL>
           <TELL "Wet padding, rust, and the copper trace of old blood." CR>)
          (T
           <TELL "The air smells of damp stone, dust, and something antiseptic that decades have not erased." CR>)>
    <RTRUE>>

<ROUTINE V-SIT-DOWN ()
    <COND (<EQUAL? ,HERE ,CHAPEL>
           <TELL "You sit briefly on a pew; the carved wood is cold enough to drive you back to your feet." CR>)
          (T
           <TELL "You lower yourself for a moment, then decide this is no place to become comfortable." CR>)>
    <RTRUE>>

<ROUTINE CHAPEL-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <COND (,GAME-WON
                  <TELL "This is the chapel. The green [[candles]] are dark now, and the [[altar]] is bare. Grey light falls across the [[pews]] from outside, and the air smells of rain. The garden is back to the [[south]]." CR>)
                 (<AND <IN? ,WOODEN-BOX ,CHAPEL> <FSET? ,WOODEN-BOX ,OPENBIT> <FSET? ,WOODEN-BOX ,NDESCBIT>>
                  <TELL "You are inside the chapel. Rows of rotting [[pews]] face a stone [[altar]], and green [[candles]] burn all around it with flames that give no warmth. The open [[box]] lies at the foot of the altar">
                  <COND (<IN? ,PATIENT-189 ,CHAPEL>
                         <SETG PATIENT-STATE 1>
                         <TELL ", beneath a motionless [[figure->patient]].">)
                        (T <TELL ", and the place before it stands empty.">)>
                  <TELL " The garden is back outside to the [[south]]." CR>)
                 (T
                  <TELL "You are inside the chapel. Rows of rotting [[pews]] face a stone altar, and green [[candles]] burn all around it with flames that give no warmth. The light makes your own hands look dead." CR>
                  <COND (<NOT <IN? ,PATIENT-189 ,CHAPEL>>
                         <TELL "The place before the [[altar]] stands empty.">)
                        (<NOT ,PATIENT-STATE>
                         <SETG PATIENT-STATE 1>
                         <TELL "[[Something->patient]] is standing at the [[altar]], perfectly still.">)
                        (T
                         <TELL "A [[figure->patient]] stands motionless at the [[altar]], its eyes glowing faintly as they follow you.">)>
                  <TELL " The garden is back outside to the [[south]]." CR>)>
           <RTRUE>)>>

<ROUTINE PEWS-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The pews are ancient and rotting. Strange [[symbols->carved symbols]] are carved into the wood—symbols that hurt to look at.">
                <COND (<AND <IN? ,WOODEN-BOX ,CHAPEL> <NOT <FSET? ,WOODEN-BOX ,TOUCHBIT>>>
                       <TELL " From the front pew you can just see a wooden [[box]] tucked under the altar.">)>
                <CRLF>
                <RTRUE>)
               (<VERB? CLIMB-ON SIT>
                <TELL "You sit on one of the pews. The wood is cold and uncomfortable. The symbols carved into it seem to pulse beneath your hands, and you quickly stand back up." CR>
                <RTRUE>)
               (<VERB? PRAY>
                <TELL "You bow your head and try to pray, but the words die in your throat. This place mocks faith." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You run your fingers over the carved symbols. They're strangely warm to the touch, and you quickly pull your hand away." CR>
                <RTRUE>)
          (<VERB? KNOCK>
           <TELL "The pew answers with a hollow knock that the chapel repeats a moment too late." CR>)
          (<VERB? SMELL>
           <TELL "Rotting wood and cold wax." CR>)>>

<ROUTINE GREEN-CANDLES-F ()
         <COND (,GAME-WON
                <COND (<VERB? EXAMINE>
                       <TELL "The candles are cold and dark now, their green glow extinguished forever. Ordinary wax, nothing more." CR>
                       <RTRUE>)
                      (<VERB? LAMP-OFF BLOW>
                       <TELL "The candles are already dark. There's nothing to extinguish." CR>
                       <RTRUE>)
                      (<VERB? LAMP-ON>
                       <TELL "The candles will never burn again." CR>
                       <RTRUE>)>)
               (<VERB? EXAMINE>
                <TELL "The candles burn with green flames that give off no heat. The light makes everything look diseased." CR>
                <RTRUE>)
               (<VERB? LAMP-OFF>
                <TELL "You try to extinguish the candles, but the green flames resist. No amount of blowing can put them out. They burn with an unnatural persistence." CR>
                <RTRUE>)
               (<VERB? BLOW>
                <TELL "You try to blow out the candles, but the green flames refuse to be extinguished." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You reach toward the flame, expecting heat. Instead, you feel only cold—a deep, bone-chilling cold that makes you recoil." CR>
                <RTRUE>)
               (<VERB? TAKE>
                <TELL "The candles seem fixed in place, as if welded to their holders. They won't budge." CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "No smoke, no wax. Only the smell of the inside of a cold room." CR>)
          (<VERB? LISTEN>
           <TELL "The flames make no sound at all, not even the tiny hiss of a burning wick." CR>)>>

<ROUTINE WOODEN-BOX-F ()
         <COND (<AND <VERB? OPEN> ,PRSI <NOT <EQUAL? ,PRSI ,SCALPEL>>>
                <TELL "That is too broad to slip beneath the clasp. You need a thin, rigid blade." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     <NOT <FSET? ,WOODEN-BOX ,OPENBIT>>>
                <TELL "A small wooden box sits beneath the altar. It's locked tight with an [[iron clasp->wooden box]]." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     <FSET? ,WOODEN-BOX ,OPENBIT>>
                <TELL "The clasp has left a rusty print on the lid. ">
                <COND (<IN? ,ANCIENT-RELIC ,WOODEN-BOX> <TELL "Inside is an [[ancient relic]], a silver cross fitted into the [[lining->box lining]]." CR>)
                      (T <TELL "A cross-shaped hollow remains in the [[lining->box lining]]." CR>)>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT <FSET? ,WOODEN-BOX ,OPENBIT>>
                     <NOT <IN? ,SCALPEL ,WINNER>>>
                <TELL "The lock is rusted but holds fast. You need something to pry it open." CR>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT <FSET? ,WOODEN-BOX ,OPENBIT>>
                     <IN? ,SCALPEL ,WINNER>>
                <TELL "You use the scalpel to pry open the rusted clasp. The box opens with a creak, revealing an [[ancient relic]]." CR>
                <FSET ,WOODEN-BOX ,OPENBIT>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The carved symbols are worn smooth, as if fingers have traced them for years." CR>)
          (<VERB? KNOCK>
           <TELL "Something inside answers with a faint metallic note." CR>)
          (<VERB? SMELL>
           <TELL "Old cedar and tarnish." CR>)>>

<ROUTINE ANCIENT-RELIC-F ()
         <COND (<VERB? EXAMINE>
                <TELL "An ancient silver cross, tarnished black with age. A [[silver etching]] runs down its surface. The lines seem to writhe when you look directly at them. Despite its age, it radiates a strange warmth." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "The cross feels unnaturally warm in your hand. The symbols seem to pulse under your touch." CR>
                <RTRUE>)
               (<VERB? PRAY>
                <TELL "You clutch the cross and try to pray. The symbols grow warmer, almost hot, as if responding to your faith—or mocking it." CR>
                <RTRUE>)
               (<VERB? THROW>
                <TELL "The cross seems too important to discard." CR>
                <RTRUE>)
               (<VERB? GIVE>
                <COND (<EQUAL? ,PRSI ,PATIENT-189>
                       <RFALSE>)
                      (T
                       <TELL "The cross seems too important to give away." CR>
                       <RTRUE>)>)
          (<VERB? LISTEN>
           <TELL "Held close to your ear, the cross hums, faint and high, like a wet finger on the rim of a glass." CR>)
          (<VERB? SMELL>
           <TELL "Tarnish and, oddly, warm bread, like a kitchen long ago." CR>)>>

"A reader who cannot type a topic names it by showing what records it: the
journal for Mordecai, the logbook for the treatment, the straitjacket for a
lost name."

<ROUTINE PATIENT-TOPIC (OBJ)
    <COND (<EQUAL? .OBJ ,TOPIC-MORDECAI ,MORDECAI-JOURNAL ,PHOTOGRAPH> ,TOPIC-MORDECAI)
          (<EQUAL? .OBJ ,TOPIC-TREATMENT ,STRANGE-SERUM ,OBSERVATION-LOGBOOK> ,TOPIC-TREATMENT)
          (<EQUAL? .OBJ ,TOPIC-IDENTITY ,STRAITJACKET ,PATIENT-FILE> ,TOPIC-IDENTITY)
          (<EQUAL? .OBJ ,TOPIC-SANITARIUM ,PATIENT-LEDGER ,MEDICAL-RECORDS ,SOGGY-NOTEBOOK> ,TOPIC-SANITARIUM)
          (<EQUAL? .OBJ ,TOPIC-CHAPEL ,CHAPEL-KEY ,WOODEN-BOX> ,TOPIC-CHAPEL)>>

<ROUTINE PATIENT-189-F ("AUX" TOPIC)
         <COND (<VERB? TELL> <SET TOPIC <PATIENT-TOPIC ,PRSI>>)>
         <COND (<VERB? INJECT>
                <V-INJECT>
                <RTRUE>)
               (<VERB? GREET-OBJECT>
                <TELL "You raise a hand. Patient 189 inclines its head, waiting for words you do not yet have." CR>
                <RTRUE>)
               (<VERB? EXAMINE>
                <TELL "PATIENT 189 stands impossibly still. Its skin is pale as death, its eyes glowing faintly green.">
                <COND (<G? ,PATIENT-STATE 1>
                       <TELL " Its gaze follows you now, tracking your movements with a terrible patience.">)
                      (T
                       <TELL " It watches you with an intelligence that is distinctly not human.">)>
                <TELL CR>
                <RTRUE>)
               (<AND <VERB? TELL>
                     <EQUAL? .TOPIC ,TOPIC-MORDECAI>>
                <COND (<NOT <FSET? ,TOPIC-MORDECAI ,TOUCHBIT>>
                       <FSET ,TOPIC-MORDECAI ,TOUCHBIT>
                       <TELL "You speak Mordecai's name. Patient 189's eyes flare, the green intensifying. Its jaw works soundlessly, as if trying to form words long forgotten." CR>
                       <SETG PATIENT-LORE <+ ,PATIENT-LORE 1>>)
                      (T
                       <TELL "Patient 189 responds to the name again—a spasm, quickly suppressed, as if even remembering is painful." CR>)>
                <SETG PATIENT-STATE 2>
                <RTRUE>)
               (<AND <VERB? TELL>
                     <EQUAL? .TOPIC ,TOPIC-TREATMENT>>
                <COND (<NOT <FSET? ,TOPIC-TREATMENT ,TOUCHBIT>>
                       <FSET ,TOPIC-TREATMENT ,TOUCHBIT>
                       <TELL "At the mention of the treatment, Patient 189 shudders. Its hands—claw-like, translucent—rise to its temples. You realize it is miming the electrode placement. A memory. A very bad one." CR>
                       <SETG PATIENT-LORE <+ ,PATIENT-LORE 1>>)
                      (T
                       <TELL "Patient 189 lowers its hands slowly. Its expression never changes, but something in the tilt of its head conveys a bottomless weariness." CR>)>
                <SETG PATIENT-STATE 2>
                <RTRUE>)
               (<AND <VERB? TELL>
                     <EQUAL? .TOPIC ,TOPIC-IDENTITY>>
                <COND (<NOT <FSET? ,TOPIC-IDENTITY ,TOUCHBIT>>
                       <FSET ,TOPIC-IDENTITY ,TOUCHBIT>
                       <TELL "You ask what name it had before the number. Patient 189 stills completely. Its lips part. A sound emerges—not a word, but a tone, a single note held impossibly long like a tuning fork. It fades. Then, almost inaudibly: “...remember...”" CR>
                       <SETG PATIENT-LORE <+ ,PATIENT-LORE 1>>)
                      (T
                       <TELL "Patient 189 watches you silently. Whatever it might have said is gone now, lost in years of isolation." CR>)>
                <SETG PATIENT-STATE 2>
                <RTRUE>)
               (<AND <VERB? TELL>
                     <EQUAL? .TOPIC ,TOPIC-SANITARIUM>>
                <COND (<NOT <FSET? ,TOPIC-SANITARIUM ,TOUCHBIT>>
                       <FSET ,TOPIC-SANITARIUM ,TOUCHBIT>
                       <TELL "You speak of the sanitarium and what was done in it. Patient 189 tilts its head toward the chapel ceiling, toward the building beyond. When it looks back at you, there is something new in those green eyes—a plea, perhaps. Or an accusation." CR>
                       <SETG PATIENT-LORE <+ ,PATIENT-LORE 1>>)
                      (T
                       <TELL "Patient 189's gaze drifts upward, then returns to you. The silent exchange is complete: you both know what this place is." CR>)>
                <SETG PATIENT-STATE 2>
                <RTRUE>)
               (<AND <VERB? TELL>
                     <EQUAL? .TOPIC ,TOPIC-CHAPEL>>
                <COND (<NOT <FSET? ,TOPIC-CHAPEL ,TOUCHBIT>>
                       <FSET ,TOPIC-CHAPEL ,TOUCHBIT>
                       <TELL "You speak of the chapel and its locked door. Patient 189 gestures—the first real movement you've seen—toward the altar and the wooden box that belongs beneath it. The meaning is clear: what that box held matters." CR>
                       <SETG PATIENT-LORE <+ ,PATIENT-LORE 1>>)
                      (T
                       <TELL "Patient 189's eyes return to the altar. Whatever waits there, it has waited a very long time." CR>)>
                <SETG PATIENT-STATE 2>
                <RTRUE>)
               (<AND <VERB? TELL>
                     <EQUAL? ,PRSI ,MORDECAI-NOTES>>
                <TELL "You repeat Mordecai's words. Patient 189 folds its arms across its chest, the way a patient might hold a hospital gown closed. When you stop reading, it is still waiting." CR>
                <RTRUE>)
               (<VERB? TELL>
                <TELL "Patient 189 listens without looking at what you name. Its fingers tighten around the edge of the altar, then slowly release it." CR>
                <RTRUE>)
               (<AND <VERB? ATTACK KILL MUNG KICK>
                     <NOT ,GAME-WON>>
                <TELL "You cannot bring yourself to approach it. Some primal instinct holds you back." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You reach toward Patient 189, but stop yourself. The air around it feels wrong—cold and electric." CR>
                <RTRUE>)
               (<VERB? GIVE SHOW>
                <COND (<EQUAL? ,PRSO ,ANCIENT-RELIC>
                       <PATIENT-189-RESOLUTION-F>)
                      (T
                       <TELL "Patient 189 shows no interest in that. It simply watches you with those glowing eyes." CR>
                       <RTRUE>)>)
          (<VERB? LISTEN>
           <TELL "It does not breathe. In the silence around it you hear your own heartbeat, slightly out of time." CR>)
          (<VERB? SMELL>
           <TELL "Cold earth and antiseptic, the smell of the whole building gathered in one place." CR>)>>

<ROUTINE DRAWER-F ()
         <COND (<AND <VERB? OPEN UNLOCK> ,PRSI <NOT <EQUAL? ,PRSI ,BRASS-KEY>>>
                <TELL "That does not fit the numbered drawer lock." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     <NOT <FSET? ,BOTTOM-DRAWER ,OPENBIT>>>
                <COND (,DRAWER-UNLOCKED
                       <TELL "The bottom drawer is closed, but its lock is open." CR>)
                      (T <TELL "The bottom drawer of the desk is locked. The keyhole has the number “3” engraved beside it." CR>)>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
                <TELL "The drawer stands open.">
                <COND (<FIRST? ,BOTTOM-DRAWER> <CRLF> <PRINT-CONT ,BOTTOM-DRAWER>)
                      (T <TELL " It is empty." CR>)>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
                <TELL "The drawer is already unlocked and open." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK> ,DRAWER-UNLOCKED>
                <FSET ,BOTTOM-DRAWER ,OPENBIT>
                <TELL "The drawer slides open again." CR>
                <COND (<FIRST? ,BOTTOM-DRAWER> <PRINT-CONT ,BOTTOM-DRAWER>)
                      (T <TELL "It is empty." CR>)>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <IN? ,BRASS-KEY ,WINNER>>>
                <TELL "The drawer is locked. You need a key." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
                     <IN? ,BRASS-KEY ,WINNER>>
                <TELL "You insert the brass key into the lock. It turns smoothly. The drawer slides open, revealing a leather-bound [[ledger]] and a [[patient file->file]] inside." CR>
                <SETG DRAWER-UNLOCKED T>
                <FSET ,BOTTOM-DRAWER ,OPENBIT>
                <RTRUE>)
          (<VERB? KNOCK>
           <TELL "The drawer answers with a muffled knock. Something inside shifts." CR>)
          (<VERB? RUB>
           <TELL "The brass around the keyhole is worn bright by fingers." CR>)>>

<ROUTINE LEDGER-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "The ledger contains patient records spanning decades. The entries become more disturbing toward the end. The final entry reads: “Patient 237 - Treatment discontinued. Subject expired during procedure. Dr. Mordecai. May God have mercy on us all.”" CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Damp leather and mildew." CR>)
          (<VERB? RUB>
           <TELL "The swollen leather gives under your fingers like something living." CR>)>>

<ROUTINE SCALPEL-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The scalpel's blade is rusty but still razor-sharp along one edge. The handle is stained with something dark." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You carefully touch the blade. It's still very sharp—sharp enough to cut." CR>
                <RTRUE>)
               (<VERB? THROW>
                <TELL "You're not about to throw away a potentially useful tool." CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Rust and old iron." CR>)>>

<ROUTINE ETHER-F ()
         <COND (<NOT <EQUAL? ,PRSO ,ETHER-BOTTLE>> <RFALSE>)
               (<VERB? EXAMINE>
                <TELL "A glass bottle with a faded label reading “Ether - Handle with Care”. About a quarter of the liquid remains." CR>
                <RTRUE>)
               (<VERB? DRINK>
                <TELL "That would be an extremely bad idea." CR>
                <RTRUE>)
               (<VERB? SMELL>
                <TELL "You carefully sniff the bottle. The sweet, sickly smell of ether makes your head spin. You quickly cap it again." CR>
                <RTRUE>)
               (<VERB? OPEN>
                <TELL "You carefully uncap the bottle. The smell of ether wafts out." CR>
                <RTRUE>)
          (<VERB? SHAKE>
           <TELL "The liquid sloshes, thin and quick. The cap holds." CR>)>>

<ROUTINE BUNDLE-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A human-shaped bundle wrapped in stained canvas. The fabric is rotted and discolored. You'd rather not investigate further, though part of you wonders if this is Patient 237." CR>
                <RTRUE>)
               (<VERB? OPEN>
                <TELL "You have no desire to see what lies within. Some mysteries are better left undisturbed." CR>
                <RTRUE>)
               (<VERB? TAKE>
                <TELL "You can't bring yourself to touch it." CR>
                <RTRUE>)
               (<VERB? SMELL>
                <TELL "Even from here, the smell of decay is overwhelming. You step back, fighting nausea." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "Your hand stops inches from the bundle. Every instinct screams at you not to touch it." CR>
                <RTRUE>)
               (<VERB? PUSH>
                <TELL "You cannot bring yourself to push the bundle. The thought of touching it fills you with dread." CR>
                <RTRUE>)
          (<VERB? LISTEN>
           <TELL "You hold your breath and listen. Nothing. You are almost sure it is nothing." CR>)>>

<ROUTINE SERUM-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A glass vial containing a faintly glowing liquid. The label reads “Compound 237 - DO NOT USE”. The serum pulses with an unnatural light." CR>
                <RTRUE>)
               (<VERB? DRINK>
                <TELL "You bring the vial to your lips but your survival instinct stops you. This substance killed Patient 237. You lower the vial, hands trembling." CR>
                <RTRUE>)
          (<VERB? SHAKE>
           <TELL "The glow swirls and settles, slower than any liquid should." CR>)
          (<VERB? SMELL>
           <TELL "Even sealed, the vial gives off a faint smell of almonds." CR>)
          (<VERB? RUB>
           <TELL "The glass is cold as ice, and the light inside seems to lean toward your fingertip." CR>)>>

<ROUTINE SHOVEL-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A heavy coal shovel with a wooden handle. The blade is caked with ancient coal dust." CR>
                <RTRUE>)
               (<VERB? SWING>
                <TELL "You swing the shovel experimentally. It's heavy but well-balanced—could work as a weapon if needed." CR>
                <RTRUE>)
               (<AND <VERB? DIG> <EQUAL? ,PRSO ,COAL-SHOVEL>>
                <TELL "You'd need to specify what you want to dig. The shovel is ready." CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The handle is worn smooth by years of hands." CR>)>>

<ROUTINE FLASHLIGHT-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A heavy metal flashlight. The switch clicks but produces no light. The batteries are long dead." CR>
                <RTRUE>)
               (<VERB? LAMP-ON>
                <TELL "The batteries are dead. The flashlight doesn't work." CR>
                <RTRUE>)
          (<VERB? SHAKE>
           <TELL "Something rattles inside: corroded batteries. Still no light." CR>)
          (<VERB? RUB>
           <TELL "The metal is cold and dented, and the switch is stiff with rust." CR>)>>

<ROUTINE LANTERN-F ()
         <COND (<NOT <EQUAL? ,PRSO ,OIL-LANTERN>> <RFALSE>)
               (<AND <VERB? LAMP-ON>
                     <NOT ,LANTERN-LIT-FLAG>>
                <TELL "You turn the lantern's built-in striker. The wick catches; a warm glow pushes back the darkness." CR>
                <SETG LANTERN-LIT-FLAG T>
                <FSET ,OIL-LANTERN ,ONBIT>
                <RTRUE>)
               (<AND <VERB? LAMP-ON>
                     ,LANTERN-LIT-FLAG>
                <TELL "The " D ,OIL-LANTERN " is already lit." CR>
                <RTRUE>)
               (<VERB? PUT>
                <TELL "The lantern is better carried by its handle than shut away." CR>
                <RTRUE>)
               (<AND <VERB? LAMP-OFF DROP THROW GIVE>
                     ,LANTERN-LIT-FLAG
                     <UNLIT-WING?>>
                <TELL "Not here. The lantern is the only light in this wing, and you mean to keep it burning in your hand." CR>
                <RTRUE>)
               (<AND <VERB? LAMP-OFF>
                     ,LANTERN-LIT-FLAG>
                <TELL "You extinguish the " D ,OIL-LANTERN "." CR>
                <SETG LANTERN-LIT-FLAG <>>
                <FCLEAR ,OIL-LANTERN ,ONBIT>
                <RTRUE>)
               (<VERB? EXAMINE>
                <TELL "A brass oil lantern with a glass chimney and a striker beside its wick. It still contains fuel.">
                <COND (,LANTERN-LIT-FLAG <TELL " Its steady flame could kindle a larger fire.">)
                      (T <TELL " Once lit, its steady flame could kindle a larger fire.">)>
                <CRLF>
                <RTRUE>)
               (<VERB? SHAKE>
                <TELL "You shake the lantern gently. You can hear oil sloshing inside." CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Lamp oil, thick and sweet." CR>)
          (<VERB? RUB>
           <COND (,LANTERN-LIT-FLAG <TELL "The chimney is too hot to touch; the brass handle is only warm." CR>)
                 (T <TELL "You wipe the dust from the glass chimney with your sleeve." CR>)>)>>

<ROUTINE RECORDS-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "You flip through the water-damaged records. A dosage sheet remains legible: “Patient 189 - unusual resistance to sedation. Morphine suppresses movement, not awareness.” A storage instruction is underlined twice: “Keep Compound 237 in the refrigerated morgue drawers. Return the reusable syringe to the hydrotherapy cabinet after each session.”" CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Mildew and old ink." CR>)>>

<ROUTINE SOGGY-NOTEBOOK-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "The notebook is badly water-damaged. You can make out fragments: “...water treatment...patients submerged for hours...screaming finally stopped...Dr. M approved extended sessions...”" CR>
                <RTRUE>)
          (<VERB? SMELL>
           <TELL "Rust-water and rot." CR>)
          (<VERB? RUB>
           <TELL "The pages are pulp. Ink comes off on your fingers." CR>)>>

<ROUTINE SYRINGE-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A medical syringe with a sharp steel needle. The glass chamber is empty." CR>
                <RTRUE>)
          (<VERB? RUB>
           <TELL "The needle is still very sharp. You keep your fingers away from its point." CR>)>>

; === NEW DOOR ACTION HANDLERS ===

<ROUTINE THEATER-DOOR-F ()
         <COND (<VERB? THROUGH> <DO-WALK ,P?NORTH> <RTRUE>)
          (<VERB? EXAMINE>
                <TELL "The door to the operating theater has sagged on its hinges and jammed half-open. The gap is wide enough to pass through." CR>
                <RTRUE>)
               (<VERB? OPEN>
                <TELL "The door is jammed half-open. You can squeeze through to the [[north]]." CR>
                <RTRUE>)
               (<VERB? CLOSE>
                <TELL "You try to shift it, but the sagging door is wedged firmly against the floor. It remains half-open." CR>
                <RTRUE>)
          (<VERB? PUSH MOVE>
           <TELL "You put your shoulder to it. The door does not move an inch; it is wedged half-open for good." CR>)
          (<VERB? KNOCK>
           <TELL "Your knock echoes through the theater beyond and around the empty tiers, as if an audience were tapping back." CR>)
          (<VERB? LISTEN>
           <TELL "Beyond the gap: a slow drip, and the tick of old wood settling." CR>)>>

<ROUTINE PADCELL-DOOR-F ()
         <COND (<VERB? THROUGH> <DO-WALK ,P?WEST> <RTRUE>)
          (<VERB? EXAMINE>
                <TELL "A heavy steel door, its frame reinforced. It stands ajar, and you can make out a padded cell beyond." CR>
                <RTRUE>)
               (<VERB? OPEN>
                <TELL "The door is already open. The padded cell lies to the west." CR>
                <RTRUE>)
               (<VERB? CLOSE>
                <TELL "The warped door will not fit its frame. It remains open." CR>
                <RTRUE>)
          (<VERB? KNOCK>
           <TELL "The steel gives back a flat, heavy note." CR>)
          (<VERB? LISTEN>
           <TELL "From the padded cell, nothing. It was built so that nothing would come out." CR>)>>

<ROUTINE CORRIDOR-DOOR-F ()
         <COND (<VERB? THROUGH> <DO-WALK ,P?NORTH> <RTRUE>)
          (<VERB? EXAMINE>
                <TELL "A heavy wooden door leading to the administrative wing. It hangs open, as if someone left in a hurry." CR>
                <RTRUE>)
               (<VERB? OPEN>
                <TELL "The door is already open. The administrative wing lies to the north." CR>
                <RTRUE>)
               (<VERB? CLOSE>
                <TELL "The warped door will not fit its frame. It remains open." CR>
                <RTRUE>)
          (<VERB? KNOCK>
           <TELL "Your knock echoes down the corridor beyond." CR>)>>

<ROUTINE OFFICE-DOOR-F ()
         <COND (<VERB? THROUGH> <DO-WALK ,P?WEST> <RTRUE>)
          (<VERB? EXAMINE>
                <TELL "Someone has stuffed felt into the crack around the office door. From the corridor, a visitor could knock without hearing a word spoken inside." CR>
                <RTRUE>)
               (<VERB? OPEN>
                <TELL "The door is already open. The corridor lies to the west." CR>
                <RTRUE>)
               (<VERB? CLOSE>
                <TELL "The warped door will not fit its frame. It remains open." CR>
                <RTRUE>)>>

<ROUTINE GARDEN-DOOR-F ()
         <COND (<VERB? THROUGH> <DO-WALK ,P?NORTH> <RTRUE>)
          (<VERB? EXAMINE>
                <TELL "A wooden door with a cracked window pane. Through it you can see the overgrown garden beyond." CR>
                <RTRUE>)
               (<VERB? OPEN>
                <TELL "The door swings open. The garden lies to the north." CR>
                <RTRUE>)
               (<VERB? CLOSE>
                <TELL "The warped door will not fit its frame. It remains open." CR>
                <RTRUE>)
          (<VERB? KNOCK>
           <TELL "The cracked pane buzzes in its frame." CR>)
          (<VERB? LOOK-INSIDE>
           <TELL "Through the cracked pane, the dead garden lies grey in the dark." CR>)>>

<ROUTINE ESCAPE-DOOR-F ()
         <COND (<VERB? THROUGH> <DO-WALK ,P?EAST> <RTRUE>)
          (<VERB? EXAMINE>
                <TELL "A heavy door, solid and imposing from this side. It's the only way out of this cell." CR>
                <RTRUE>)
               (<VERB? OPEN>
                <TELL "The door is already open. The electroshock theater lies to the east." CR>
                <RTRUE>)
               (<VERB? CLOSE>
                <TELL "You'd rather not trap yourself in here." CR>
                <RTRUE>)
          (<VERB? KNOCK>
           <TELL "Your knock is dull and flat. From the other side, no one knocks back." CR>)
          (<VERB? LISTEN>
           <TELL "Out in the theater, a faint electric hum." CR>)>>

<ROUTINE INSTRUMENTS-PSEUDO ()
    <COND (<VERB? EXAMINE>
           <TELL "Rusty forceps and clamps lie scattered across trays. Long abandoned, like everything else here." CR>)
          (<VERB? TAKE>
           <TELL "They are rusted into one lump with the trays." CR>)
          (<VERB? COUNT>
           <TELL "You count eleven clamps and four forceps, then stop counting." CR>)
          (<VERB? RUB>
           <TELL "The steel is pitted and cold. Something dark has dried into the hinges." CR>)>>

<ROUTINE TRAYS-PSEUDO ()
    <COND (<VERB? EXAMINE>
           <TELL "Cold metal instrument trays sit on carts, their contents rusted and useless." CR>)
          (<VERB? PUSH MOVE>
           <TELL "The cart of trays squeals on one bad wheel and stops. The squeal goes on a moment longer in the tiers." CR>)
          (<VERB? RUB>
           <TELL "Your fingers come away orange with rust." CR>)>>

<ROUTINE BENCHES-PSEUDO ()
    <COND (<VERB? EXAMINE SIT>
           <TELL "Tiers of wooden benches circle the operating theater, where students once observed procedures. The wood is dark with age and moisture." CR>)
          (<VERB? LISTEN>
           <TELL "For a moment you could swear you hear an audience shuffling into the tiers. Then the room is silent." CR>)
          (<VERB? RUB>
           <TELL "The wood is soft with damp. Someone carved a set of initials into the rail, long ago." CR>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the lowest tier there is only dust and darkness." CR>)>>

<ROUTINE GARDEN-BENCHES-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Broken stone benches, half-consumed by ivy and moss, stand around a crumbling fountain choked with dead leaves. Whatever respite this garden once offered ended decades ago." CR>)
          (<VERB? CLIMB-ON>
           <TELL "You perch on the least broken bench. The cold of the stone comes straight through your clothes, and you stand again." CR>)
          (<VERB? RUB>
           <TELL "The stone is cold and furred with moss." CR>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the nearest bench, ivy has grown over a broken teacup." CR>)>>

; === LOCAL-GLOBALS ACTION HANDLERS ===

<ROUTINE SANITARIUM-BUILDING-F ()
    <COND (<VERB? EXAMINE>
           <COND (,CHAPEL-UNLOCKED
                  <TELL "The sanitarium looms against the darkened sky. Now that you've been deep inside -- seen what lurks in the chapel -- the building feels different. Less abandoned. More watchful." CR>)
                 (T
                  <TELL "The sanitarium's Victorian facade is crumbling but still imposing. Rows of broken windows stare down like hollow eye sockets. Whatever happened here, the building seems reluctant to forget it." CR>)>
           <RTRUE>)
          (<VERB? THROUGH>
           <COND (<EQUAL? ,HERE ,SANITARIUM-GATE> <DO-WALK ,P?NORTH>)
                 (<EQUAL? ,HERE ,SANITARIUM-ENTRANCE> <TELL "You are already inside. The operating theater is north through the sagging door." CR>)
                 (T <TELL "There is no entrance on this side. The cafeteria is back to the south." CR>)>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "Nothing moves behind the windows. Then, very faintly, somewhere deep inside, a door closes." CR>)
          (<VERB? KNOCK>
           <TELL "You rap on the stone. Something scratches once behind the nearest pane, much too high to be an answer to your hand." CR>)
          (<VERB? SMELL>
           <TELL "Even from here the building breathes out damp plaster and something like old medicine." CR>)
          (<VERB? COUNT>
           <TELL "You count the windows twice and get a different number each time." CR>)>>

<ROUTINE DEAD-OAK-TREE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The oak is dead clear to the crown. Where a branch split off, its exposed wood has dried to the color of chalk. The crows make the bare branches bow. Not one calls." CR>
           <RTRUE>)
          (<VERB? CLIMB CLIMB-FOO CLIMB-UP>
           <TELL "The lower branches are too high to reach, and you have no desire to scramble up a dead tree in an abandoned sanitarium grounds." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "The crows in the upper branches are utterly silent. They watch you." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "Where the bark has peeled away, the wood is smooth and cold as bone." CR>)
          (<VERB? KICK PUSH>
           <TELL "A dry crack runs up the trunk. The crows shift on their branches and settle again, watching." CR>)
          (<VERB? LOOK-UNDER SEARCH>
           <TELL "Among the roots lie a few black feathers laid out by the rain. One is white at the tip. The crows overhead are all black." CR>)
          (<VERB? SMELL>
           <TELL "The cleft in the trunk smells of wet leaves, though there hasn't been a leaf on it for years." CR>)
          (<VERB? KNOCK>
           <TELL "Your knuckle strikes hollow wood. Somewhere above your hand a crow folds one wing, very slowly." CR>)>>

<ROUTINE IRON-GATES-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The rusted iron gates stand open. Flakes of old black paint cling to bars bent by years of weather." CR>)
          (<VERB? THROUGH>
           <DO-WALK ,P?NORTH>
           <RTRUE>)
          (<VERB? CLIMB-ON CLIMB-FOO CLIMB-UP>
           <TELL "You put a boot on the first bar. The whole gate shudders. There is a gap wide enough to walk through." CR>)
          (<VERB? OPEN>
           <TELL "The gates are already open." CR>)
          (<VERB? CLOSE>
           <TELL "The hinges resist your weight. You leave the gates as you found them." CR>)
          (<VERB? PUSH MOVE>
           <TELL "The gate swings a few inches and stops with a groan that carries all the way up to the dark windows." CR>)
          (<VERB? RUB>
           <TELL "Rust comes off on your palm, orange and gritty." CR>)
          (<VERB? LISTEN>
           <TELL "The wind moves through the bars with a thin, whistling note, like someone breathing through their teeth." CR>)
          (<VERB? KICK KNOCK>
           <TELL "The bars ring dully. In the dead oak, every crow turns its head toward you, and not one of them flies." CR>)>>

<ROUTINE GRAND-STAIRCASE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The grand staircase climbs toward a collapsed landing. The safe routes through the sanitarium lie east, west, north, and down." CR>)
          (<VERB? CLIMB-FOO CLIMB-UP>
           <TELL "You climb as far as the treads hold. Above them hangs only the collapsed landing and its splintered joists; there is no way up." CR>)
          (<VERB? LOOK-UNDER LOOK-BEHIND>
           <TELL "Under the stairs the dark is full of fallen plaster. Something small has been nesting there, and left long ago." CR>)
          (<VERB? LISTEN>
           <TELL "Up on the broken landing a board creaks, like weight shifting from one foot to the other. Then nothing." CR>)
          (<VERB? RUB>
           <TELL "The banister is sticky with damp, and your hand comes away grey." CR>)
          (<VERB? KICK>
           <TELL "A tread gives under your shoe, and plaster sifts down from the landing above. Better not." CR>)>>

<ROUTINE WALLPAPER-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The Victorian pattern repeats every few feet: a shepherd, three sheep, a tree. Wherever the pattern peels, the mold has eaten the shepherd first." CR>)
          (<VERB? READ>
           <TELL "No words, only the same three sheep over and over. In the strip nearest the door, somebody penciled in a fourth." CR>)
          (<VERB? RUB>
           <TELL "The paper is soft as wet skin and slides under your fingers." CR>)
          (<VERB? SMELL>
           <TELL "Sweet, rotten mold. It catches at the back of your throat." CR>)
          (<VERB? MOVE LOOK-BEHIND>
           <TELL "You lift a loose strip of wallpaper. Water beads on the plaster underneath. The strip settles back when you let go." CR>)>>

<ROUTINE COAL-DUST-F ()
    <COND (<VERB? EXAMINE RUB>
           <TELL "Fine coal dust coats the brick and leaves a black crescent on your fingertip." CR>)
          (<VERB? TAKE>
           <TELL "The damp dust is useless as fuel; the coal bin may hold something better." CR>)
          (<VERB? SMELL>
           <TELL "Damp soot. It makes you want to cough." CR>)>>

; === CLOCK-DRIVEN ATMOSPHERIC ROUTINES ===

;"CLOCKER stops a multi-turn WAIT at the first reported event. Silent
   rescheduling or a change the player cannot perceive is not an event."

<ROUTINE I-WHISPER ()
	<QUEUE I-WHISPER 8>
	<COND (<AND <NOT ,GAME-WON>
	            <EQUAL? ,HERE ,SANITARIUM-ENTRANCE ,PATIENT-WARD ,MORGUE ,CHAPEL>>
	       <TELL <PICK-ONE ,WHISPER-TABLE> CR> <RTRUE>)>
    <RFALSE>>

<ROUTINE I-FOOTSTEPS ()
	<QUEUE I-FOOTSTEPS 12>
	<COND (<AND <NOT ,GAME-WON>
	            <EQUAL? ,HERE ,SANITARIUM-ENTRANCE ,RECEPTION-ROOM ,OPERATING-THEATER>>
	       <TELL "Distant footsteps echo from somewhere above you." CR> <RTRUE>)>
    <RFALSE>>

<ROUTINE I-FLICKERING ()
	<QUEUE I-FLICKERING 10>
	<COND (<AND <NOT ,GAME-WON>
	            ,LIT
	            <EQUAL? ,HERE ,BASEMENT-STAIRS ,BOILER-ROOM ,MORGUE>>
	       <TELL "The shadows seem to flicker and move of their own accord." CR> <RTRUE>)>
    <RFALSE>>

<ROUTINE I-COLD-DRAFT ()
	<QUEUE I-COLD-DRAFT 15>
	<COND (<AND <NOT ,GAME-WON>
	            <EQUAL? ,HERE ,MORGUE ,CHAPEL ,PATIENT-WARD>>
	       <TELL "A cold draft makes you shiver, though there are no open windows." CR> <RTRUE>)>
    <RFALSE>>

<ROUTINE I-CREAKING ()
    <QUEUE I-CREAKING 9>
    <COND (<AND <NOT ,GAME-WON>
                <EQUAL? ,HERE ,OPERATING-THEATER ,PATIENT-WARD ,ELECTROSHOCK-THEATER>>
           <TELL "The building settles with a deep structural groan, as if exhaling." CR> <RTRUE>)>
    <RFALSE>>

<ROUTINE I-BOILER-HEAT ()
    <QUEUE I-BOILER-HEAT 1>
    <COND (<AND ,BOILER-LIT <L? ,BOILER-HEAT 3>>
           <SETG BOILER-HEAT <+ ,BOILER-HEAT 1>>
           <COND (<EQUAL? ,BOILER-HEAT 1>
                  <COND (<EQUAL? ,HERE ,BOILER-ROOM>
                         <TELL "The boiler gives a rolling cough. One by one, the pipes begin to tick." CR> <RTRUE>)>)
                 (<EQUAL? ,BOILER-HEAT 2>
                  <COND (<EQUAL? ,HERE ,BASEMENT-CORRIDOR ,FLOODING-CHAMBER>
                         <TELL "A tremor passes through the pipes. Rust flakes fall as warmth travels east." CR> <RTRUE>)>)
                 (<EQUAL? ,BOILER-HEAT 3>
                  <SETG CABINET-THAWED T>
                  <COND (<EQUAL? ,HERE ,HYDROTHERAPY-ROOM>
                         <TELL "Behind the wall, a pipe clangs. Frost slides from the medicine cabinet in translucent sheets." CR> <RTRUE>)
                        (<EQUAL? ,HERE ,BOILER-ROOM ,BASEMENT-CORRIDOR ,FLOODING-CHAMBER>
                         <TELL "Farther along the pipework, ice breaks loose with a brittle crash." CR> <RTRUE>)>)>)>
    <RFALSE>>

<GLOBAL BLACKWOOD-COLD-WARNINGS
    <LTABLE <TABLE 8 "The cold has worked through your clothes. Your fingers are beginning to stiffen.">
            <TABLE 16 "Your teeth chatter hard enough to hurt. Staying here much longer would be dangerous.">>>

<ROUTINE I-COLD-EXPOSURE ()
    <QUEUE I-COLD-EXPOSURE 1>
    <HORROR-COLD-TURN
        <OR <EQUAL? ,HERE ,MORGUE>
            <AND <EQUAL? ,HERE ,FLOODING-CHAMBER ,HYDROTHERAPY-ROOM>
                 <NOT ,CABINET-THAWED>>>
        ,BLACKWOOD-COLD-WARNINGS 25
        "The shivering stops. The tiles against your cheek feel almost warm; that is how you know the cold has won."
        <COND (<AND <EQUAL? ,HERE ,BOILER-ROOM> ,BOILER-LIT>
               "Heat from the boiler works the numbness from your hands.")
              (<NOT <L? ,COLD-EXPOSURE 8>>
               "Out of the worst of the cold, feeling slowly returns to your fingers.")>>>

<ROUTINE I-PATIENT-AUTONOMY ("AUX" (SPOKE <>))
    <QUEUE I-PATIENT-AUTONOMY 4>
    <COND (<AND <NOT ,GAME-WON>
                <G? ,PATIENT-STATE 0>
                <LOC ,PATIENT-189>>
           <COND (<AND <EQUAL? ,PATIENT-STATE 1>
                       <G? ,PATIENT-LORE 2>>
                  <SETG PATIENT-STATE 2>
                  <COND (<IN? ,PATIENT-189 ,HERE>
                         <TELL "[[Patient 189->patient]]'s gaze sharpens. Something you uncovered elsewhere has reached it; recognition flickers behind the green light." CR>
                         <SET SPOKE T>)>)>
           <COND (<AND <IN? ,PATIENT-189 ,CHAPEL>
                       <EQUAL? ,HERE ,OVERGROWN-GARDEN>>
                  <MOVE ,PATIENT-189 ,OVERGROWN-GARDEN>
                  <TELL "Bare feet whisper over stone behind you. [[Patient 189->patient]] has followed you into the garden." CR>
                  <SET SPOKE T>)
                 (<AND <IN? ,PATIENT-189 ,OVERGROWN-GARDEN>
                       <EQUAL? ,HERE ,CHAPEL>>
                  <MOVE ,PATIENT-189 ,CHAPEL>
                  <TELL "[[Patient 189->patient]] glides past you and resumes its place before the altar." CR>
                  <SET SPOKE T>)
                 (<AND <IN? ,PATIENT-189 ,OVERGROWN-GARDEN>
                       <NOT <EQUAL? ,HERE ,OVERGROWN-GARDEN ,CHAPEL>>>
                  <MOVE ,PATIENT-189 ,CHAPEL>)>)>
    .SPOKE>

; === SCORING ===

"A thing is worth its VALUE once: taking it scores it, and so does the deed
that stands in for taking what cannot be carried (the cut strap, the message
read from the wall). TAKE sets TOUCHBIT before it scores, so the bit is no
test of whether the points were given; the VALUE, zeroed, is."

<ROUTINE SCORE-OBJ (OBJ "AUX" TEMP)
     <COND (<G? <SET TEMP <GETP .OBJ ,P?VALUE>> 0>
            <SCORE-UPD .TEMP>
            <PUTP .OBJ ,P?VALUE 0>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
    <TELL "Score: " N ,SCORE " of " N ,SCORE-MAX " points, in " N ,MOVES>
    <COND (<1? ,MOVES> <TELL " move.">) (T <TELL " moves.">)>
    <CRLF>
    <TELL "Rank: " <GET ,RANKINGS <+ </ ,SCORE 20> 1>> "." CR>
    ,SCORE>

; === ENTRY POINT ===

<ROUTINE V-VERSION ()
	<TELL "Sanitarium|Studio Null, 2024|Release " N ,RELEASEID CR>>

<ROUTINE GO ()
	<TELL "For three weeks the same dream has woken you before dawn: a pair of iron gates, a dead oak full of silent crows, and a voice in a dark building asking you to remember. Tonight you found the place at the end of a forest road, a sanitarium that has stood empty for longer than anyone in the village can say. You told no one you were coming. The gates were already open." CR CR>
	<V-VERSION> <CRLF>
	<SETG COMPACT-ROOM-LISTS T>
	<SETG HERE ,SANITARIUM-GATE>
	<SETG VERBOSE T>
	;"Investigation rewards collecting records; Zork's random hand-limit is not a puzzle here."
	<SETG FUMBLE-PROB 0>
	<THIS-IS-IT ,BRASS-PLAQUE>
	<SETG LIT T>
	<SETG WINNER ,ADVENTURER>
	<SETG PLAYER ,WINNER>
	<VOC-EXACT-FIRST "SIT" "SITDOWN">
	<VOC-EXACT-FIRST "HELLO" "GREET">
	<VOC-EXACT "SCALPELS" "INSTRUMENTS">
	<MOVE ,WINNER ,HERE>
	<ENABLE <QUEUE I-WHISPER 8>>
	<ENABLE <QUEUE I-FOOTSTEPS 12>>
	<ENABLE <QUEUE I-FLICKERING 10>>
	<ENABLE <QUEUE I-COLD-DRAFT 15>>
	<ENABLE <QUEUE I-CREAKING 9>>
	<ENABLE <QUEUE I-BOILER-HEAT 1>>
	<ENABLE <QUEUE I-COLD-EXPOSURE 1>>
	<ENABLE <QUEUE I-PATIENT-AUTONOMY 4>>
      <TELL D ,HERE CR>
      <V-LOOK>
      <MAIN-LOOP>
	<AGAIN>>

<ROUTINE BOOK-HOLLOW-F ()
    <COND (<VERB? EXAMINE>
           <COND (<IN? ,SAFE-KEY ,HOLLOW-BOOK> <TELL "The cut edges hug the teeth of the key. A little crescent by the round end leaves room for a fingertip." CR>) (T <TELL "The stain has three little steps along one edge. You could draw the teeth of the missing key from that mark." CR>)>)>>

<ROUTINE CROSS-LINING-F ()
    <COND (<VERB? EXAMINE>
           <COND (<IN? ,ANCIENT-RELIC ,WOODEN-BOX> <TELL "A fringe of green velvet curls up over the tips of the cross. It has lain in exactly that position for a long time." CR>) (T <TELL "Deep in the hollow the velvet is still green. All around it, the exposed cloth has faded to grey." CR>)>)>>

<ROUTINE DETAIL-MEMO-F ()
    <COND (<VERB? READ> <TELL "All staff reminded - Subject 189 is NOT to be released under any circumstances. Chapel is OFF LIMITS." CR>)>>

<ROUTINE DETAIL-NAMEPLATE-F ()
    <COND (<VERB? READ> <TELL "Dr. Heinrich Mordecai - Director 1935-1952." CR>)>>

<ROUTINE KEY-TAG-F ()
    <COND (<VERB? READ> <TELL "S-001." CR>)
          (<VERB? RUB> <TELL "Your thumb catches on two raised zeroes and the straight back of the one." CR>)>>

<ROUTINE DETAIL-CARVED-SYMBOLS-F ()
    <COND (<VERB? READ> <TELL "Each row starts with the same hook. You can follow the rows, though you cannot put them into words." CR>)
          (<VERB? RUB> <TELL "Your fingertip catches in the first deep cut and slides over the worn ends." CR>)>>

<ROUTINE CROSS-ETCHING-F ()
    <COND (<VERB? READ> <TELL "Starting at the foot of the cross, you can follow a single engraved line all the way round to its beginning." CR>)
          (<VERB? RUB> <TELL "The line feels like a fine groove even where the silver makes it look raised." CR>)>>

<ROUTINE DETAIL-BRASS-DOME-F ()
    <COND (<VERB? RING> <PERFORM ,V?RING ,BELL>)>>

<ROUTINE CORRIDOR-STEPS-F ()
    <COND (<VERB? CLIMB-FOO CLIMB-UP> <DO-WALK ,P?UP>)>>

<ROUTINE THEATER-STEPS-F ()
    <COND (<VERB? CLIMB-FOO CLIMB-UP> <DO-WALK ,P?EAST>)>>

<ROUTINE DECK-STEPS-F ()
    <COND (<VERB? CLIMB-FOO CLIMB-DOWN> <DO-WALK ,P?WEST>)>>

<ROUTINE GRAVEL-PATH-F ()
    <COND
          (<VERB? LISTEN>
           <TELL "The gravel crunches under your shoes. When you stop, the silence closes in at once." CR>)
          (<VERB? SEARCH LOOK-UNDER>
           <TELL "Only stones and weeds. No tracks but yours, and the old ruts." CR>)>>

<ROUTINE BROKEN-GLASS-F ()
    <COND
          (<VERB? RUB TAKE>
           <TELL "You pick up a shard, think better of it, and drop it. The edges are still sharp." CR>)
          (<VERB? KICK>
           <TELL "The glass skitters away under the beds with a sound like small teeth." CR>)>>

<ROUTINE STONE-STEPS-F ()
    <COND
          (<VERB? RUB>
           <TELL "The stone is slick and cold with wet." CR>)
          (<VERB? LISTEN>
           <TELL "From below comes the slow drip of water, and once a soft splash." CR>)>>

<ROUTINE BASEMENT-SMOKE-F ()
    <COND
          (<VERB? SMELL>
           <TELL "Old coal smoke, stale and sour, drifting from the east." CR>)>>

<ROUTINE PIPE-DRIP-F ()
    <COND
          (<VERB? LISTEN>
           <TELL "Drip... drip... Each drop lands in deeper water somewhere to the north." CR>)
          (<VERB? RUB DRINK>
           <TELL "The water is ice cold and tastes of rust." CR>)>>

<ROUTINE RUBBER-HOSES-F ()
    <COND
          (<VERB? MOVE>
           <TELL "The hose stretches and creaks, then springs back. Nothing comes out." CR>)
          (<VERB? RUB>
           <TELL "The rubber is stiff and cracks under your thumb." CR>)
          (<VERB? SMELL>
           <TELL "Perished rubber and stale water." CR>)>>

<ROUTINE SCORCHED-CONCRETE-F ()
    <COND
          (<VERB? RUB>
           <TELL "Soot comes off on your fingers, greasy and black." CR>)
          (<VERB? SMELL>
           <TELL "Burnt dust, and something like singed hair." CR>)>>

<ROUTINE OBSERVATION-DESK-F ()
    <COND
          (<VERB? RUB>
           <TELL "The edge is worn smooth by an observer's forearms." CR>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the desk, a pencil stub and a crumpled cigarette packet." CR>)>>

<ROUTINE STAFF-BEDS-F ()
    <COND
          (<VERB? RUB>
           <TELL "The springs are cold and give a little, still holding the shape of someone tired." CR>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the beds there is only dust and a single lost hairpin." CR>)
          (<VERB? CLIMB-ON>
           <TELL "You sit on the edge of the nearest bed. The springs complain loudly, and somewhere down the corridor something answers with a creak of its own. You get up." CR>)>>

<ROUTINE DEAD-LAMP-F ()
    <COND
          (<VERB? PUSH MOVE>
           <TELL "The lamp swings on its arm. Its shadow sweeps the table and swings back." CR>)>>

<ROUTINE BRASS-KEY-F ()
    <COND
          (<VERB? RUB>
           <TELL "However long you hold it, the key stays cold." CR>)>>

<ROUTINE OPERATING-TABLE-F ()
    <COND
          (<VERB? RUB>
           <TELL "The metal is cold and pitted. Your fingers find the gouges and stop." CR>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the table, a drain in the floor is crusted brown." CR>)
          (<VERB? SMELL>
           <TELL "Rust and carbolic, and under them something older." CR>)
          (<VERB? PUSH MOVE>
           <TELL "The table is bolted to the floor." CR>)>>

<ROUTINE BED-FRAMES-F ()
    <COND
          (<VERB? LOOK-UNDER>
           <TELL "Under the nearest bed, a whole pane of [[wire mesh]] glass lies where it fell." CR>)
          (<VERB? RUB>
           <TELL "The springs are cold and give a little under your hand." CR>)
          (<VERB? PUSH MOVE>
           <TELL "The frame screeches across the floor. The sound runs the length of the ward and comes back." CR>)>>

; === SCENERY NAMED BY THE ROOM DESCRIPTIONS ===

<ROUTINE HALL-DUST-F ()
    <COND (<VERB? EXAMINE SEARCH>
           <TELL "Fallen plaster lies over the floor like flour. The only footprints in it are yours, coming in from the gates." CR>)
          (<VERB? RUB>
           <TELL "It is fine and cold, and it clings to your fingertips like chalk." CR>)
          (<VERB? KICK>
           <TELL "A white cloud puffs up and settles slowly. When it clears, your footprints are blurred, as if someone had stepped in them after you." CR>)>>

<ROUTINE RECEPTION-FIREPLACE-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE>
           <TELL "A small iron fireplace, black with old soot. A bird's [[nest]] sits on the grate over cold [[ashes]]." CR>)
          (<VERB? LISTEN>
           <TELL "Wind moans faintly down the chimney, rising and falling like slow breathing." CR>)
          (<VERB? RUB>
           <TELL "The iron is cold and gritty with soot." CR>)
          (<VERB? BOARD CLIMB-ON CLIMB-FOO CLIMB-UP THROUGH>
           <TELL "You crouch at the grate and peer up. The flue narrows to a slot no wider than your hand, furred with soot, and the wind breathes down it into your face." CR>)>>

<ROUTINE THEATER-EXIT-F ()
    <COND (<VERB? THROUGH> <DO-WALK ,P?SOUTH> <RTRUE>)
          (<VERB? EXAMINE>
           <TELL "The door to the entrance hall has sagged on its hinges and jammed half-open. Scrape marks on the floor show how far it once swung." CR>)
          (<VERB? OPEN>
           <TELL "It is jammed half-open, wide enough to pass through to the [[south]]." CR>)
          (<VERB? CLOSE PUSH MOVE>
           <TELL "The door is wedged firmly against the floor. It will not move." CR>)
          (<VERB? KNOCK>
           <TELL "Your knock rolls around the empty tiers and dies away." CR>)>>

<ROUTINE WARD-CURTAINS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Grey cloth hangs in strips from rails between the beds. Once they gave each patient a little privacy. Now they only stir when you pass." CR>)
          (<VERB? MOVE LOOK-BEHIND SEARCH OPEN>
           <TELL "You draw a curtain aside. Behind it is only another empty bed frame, and the next curtain, swaying a little." CR>)
          (<VERB? RUB SMELL>
           <TELL "The cloth is damp and smells of mildew. It tears at a touch." CR>)>>

<ROUTINE HYDRO-TILES-F ()
    <COND (<VERB? EXAMINE>
           <TELL "White tiles cover the walls to shoulder height. Rust runs down them in long brown streaks from every tap and bolt." CR>)
          (<VERB? RUB KNOCK>
           <TELL "The tiles are cold and slick. One rings hollow; the plaster behind it has long since rotted away." CR>)>>

<ROUTINE OFFICE-RUG-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A good rug, red and blue, worn down to the threads in a path between the door and the desk." CR>)
          (<VERB? LOOK-UNDER MOVE RAISE>
           <TELL "You lift a corner. Under it there is only clean, dry floorboard. Someone kept even this spot swept." CR>)
          (<VERB? RUB>
           <TELL "The wool is dry and soft, the only dry thing you have touched in this building." CR>)>>

<ROUTINE CAFETERIA-FURNITURE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Wooden chairs stand upside down on the long tables, their legs in the air, waiting for a floor to be mopped." CR>)
          (<VERB? TAKE MOVE PUSH>
           <TELL "You lift one chair down. It is so quiet afterward that you put it back exactly as it was." CR>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the tables there is only dust and one glass marble, which you leave where it lies." CR>)>>

<ROUTINE GARDEN-PATH-F ()
    <COND (<VERB? EXAMINE FOLLOW>
           <TELL "Flat stones, mostly buried in weeds, run in a crooked line toward the chapel to the [[north]]. The weeds along it have been pressed down, as if someone walks it often." CR>)
          (<VERB? SEARCH LOOK-UNDER>
           <TELL "Between the stones you find only weeds and wet earth, and one print of a bare foot, narrow and long." CR>)>>

<ROUTINE CHAPEL-EXTERIOR-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A small chapel of grey stone, with a slate roof and one narrow window. The window glows faintly green from inside.">
           <COND (,CHAPEL-UNLOCKED <TELL " Its [[door]] stands open." CR>)
                 (T <TELL " Its oak [[door]] is locked." CR>)>)
          (<VERB? LISTEN>
           <TELL "From the chapel comes nothing at all. Even the wind seems to go around it." CR>)
          (<VERB? THROUGH>
           <DO-WALK ,P?NORTH>)>>
