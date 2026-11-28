<ROUTINE V-VERSION ()
 <TELL "The Midnight Ledger|Studio Null, 2026|Release " N ,RELEASEID CR>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T)) <TELL "There is no score and no deadline." CR>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG COMPACT-ROOM-LISTS T> <SETG HERE ,VESTIBULE> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "You are the examiner the harbour auction house sends for when something goes missing, and tonight it has called you out through the rain. At the midnight weigh-in, Lot 9, a brass astrolabe, turned out to be gone from its sealed transit crate. The porter, Ives, is already being told to sign for the loss. Before anyone signs anything, the hearing wants your finding: where the astrolabe was taken, when, and by whom. Ives can refuse to sign, but his wages will be held while the accusation stands. Every detail you put before the hearing may give him a way to contest it." CR CR>
 <TELL D ,HERE CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<SYNTAX HINT = V-BOOK-HINT>
<SYNTAX TURN OBJECT = V-SPIN>
; The classic rules only know ATTACK WITH a weapon; a hearing has none, so
; a bare "attack ives" reaches the actor's own reply.
<SYNTAX ATTACK OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ATTACK>
; SIT is a synonym of CLIMB, which wants an object; sitting down alone is
; answered by the room.
<SYNTAX CLIMB = V-LEDGER-SIT>

<ROUTINE V-LEDGER-SIT ()
 <COND (<EQUAL? ,HERE ,CHAMBER> <PERFORM ,V?CLIMB-ON ,MTABLE> <RTRUE>)
       (T <TELL "There is nothing here to sit on or climb, and the hearing is waiting." CR>)>>

<ROUTINE V-BOOK-HINT ()
 <COND (<OR <NOT ,SCALE-SEEN> <NOT ,LEDGER-READ>> <TELL "Compare the scale and the midnight ledger. One clock is untrustworthy." CR>) (<OR <NOT ,SEAL-SEEN> <NOT ,CAB-SEEN>> <TELL "The seal and cabinet explain how the crate can change without a dispatch mark breaking." CR>) (<NOT ,REG-READ> <TELL "Read the public shift register and compare who left with the interval of the loss." CR>) (<NOT ,CASE-READY> <TELL "Turn the evidence panel when all three columns are established." CR>) (T <TELL "Choose the named tab that matches the access and time evidence." CR>)>>

<ROUTINE VESTIBULE-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "You are in the vestibule of the auction house, a draughty entrance hall with wet footprints all over the tiles. In the corner, a coffee urn has cooked down to mud, and nobody here has the authority to empty it. A damp notice is pinned to the wall. The hearing chamber is to the north, and from it comes a low murmur of voices. The cloakroom, where the porter is waiting, is to the east." CR>)>>

<ROUTINE CHAMBER-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the hearing chamber. The backs of the empty chairs shine where generations of witnesses have gripped them. Clerk Venn sits at the head of the long table, her pen poised over a blank form. The hinged evidence panel is set where everyone must look at it.">
 <COND (,CASE-READY <TELL " Two paper tabs now hang from it, one for an Ives verdict and one for an Orr verdict.">)>
 <TELL " The weigh room is to the west and the records room to the east. The public registry is to the north, and the vestibule is back to the south." CR>)>>

<ROUTINE CLOAKROOM-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the narrow cloakroom. The hissing radiator has steamed up the wall behind the brass pegs. Porter Ives has hung up his wet coat to stop himself searching its pockets. His hands keep returning to the place in midair where those pockets used to be. The vestibule is back to the west." CR>)>>

<ROUTINE SCALEHOUSE-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the weigh room, where every crate is weighed into the auction and out again. Dust lies over the floor, except in clean squares where crates were standing. The big platform weigh scale has stopped swinging, and a paper strip hangs from its printer. A clock ticks on the wall above it. The hearing chamber is back to the east." CR>)>>

<ROUTINE RECORDS-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the records room, shelves of old record books under a leaking ceiling. Tonight's book, the midnight ledger, lies face up under the one dry square of ceiling. A key cabinet hangs on the wall, and it smells very faintly of oranges. Beyond an open grille to the north, the transit cage is unlit. The hearing chamber is back to the west." CR>)>>

<ROUTINE CAGE-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the transit cage, where sold lots wait to go out on the morning boats. The wire walls throw a net of shadows across the boards. A syndicate seal dangles crooked from a hook above a transit crate, which">
       <COND (,CRATE-CLOSED <TELL " sits with its lid down.">)
             (T <TELL " has its lid resting at a slant.">)>
       <TELL " The lit records room is back to the south." CR>)>>

<ROUTINE REGISTRY-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the public registry, where everyone who comes or goes on the night shift signs the book. Rain dripping from the people who leaned over to sign has softened the pages of the shift register. Across the room, Assessor Orr, a neat, narrow man in a grey suit, keeps unbuttoning and rebuttoning one cuff, a long document sleeve clamped under his other arm. The hearing chamber is back to the south." CR>)>>

<ROUTINE MNOTICE-F ()
 <COND
  (<VERB? EXAMINE READ> <TELL "A typed notice from the auction syndicate. Lot 9, a brass astrolabe, was packed into a transit crate after the public viewing. At the midnight weigh-in it was gone, and Porter Ives is to sign for the loss. Below, the clerk has added in ink: a public finding must state where, when and by whom the lot was taken, not merely who needed the money." CR>)
  (<VERB? RUB> <TELL "The paper is damp enough to fold with a thumb. The ink of the clerk's note has run a little." CR>)
  (<VERB? SMELL> <TELL "Wet paper and stale coffee." CR>)
  (<VERB? TAKE> <TELL "It is posted for the public, and it stays posted." CR>)>>

<ROUTINE MURN-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A tall steel coffee urn. Its last cups have boiled down to a black mud at the bottom. A card taped to it says it may be emptied only on the clerk's instruction." CR>)
  (<VERB? RUB> <TELL "Still warm. Somebody kept it switched on all night and nobody drank from it." CR>)
  (<VERB? SMELL> <TELL "Burnt coffee, the smell of every long night at the auction house." CR>)
  (<VERB? OPEN LOOK-INSIDE> <TELL "You lift the lid on an inch of black sludge, and put it back." CR>)
  (<VERB? DRINK TAKE> <TELL "Even after a night like this, you aren't that desperate." CR>)>>

<ROUTINE MCOAT-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Ives's heavy coat, soaked through and dripping onto the floor. White chalk dust is ground into both pockets." CR>)
  (<VERB? SEARCH LOOK-INSIDE OPEN>
   <FCLEAR ,MPOCKETS ,INVISIBLE>
   <TELL "Ives watches you do it. The pockets hold a stub of dispatch chalk, a tram ticket and a boiled sweet. No key." CR>)
  (<VERB? RUB> <TELL "You press a fold of the wool. Water runs down onto your wrist; the coat would take all night to dry." CR>)
  (<VERB? MOVE> <TELL "Ives catches the coat by its collar before it slides. “It's the only dry hook,” he says, though the coat is wet through." CR>)
  (<VERB? SMELL> <TELL "Wet wool and chalk. No oranges." CR>)
  (<VERB? TAKE> <TELL "“That's mine,” Ives says, before your hand gets there." CR>)>>

<ROUTINE MIVES-F ()
 <COND
  (<AND <VERB? TELL> <EQUAL? ,PRSI ,MCOAT ,MPOCKETS>>
   <TELL "“One piece of chalk for a whole shift.” Ives holds finger and thumb an inch apart. “If I'd taken the crate apart, don't you think I'd have had more than that in my pockets?”" CR>)
  (<AND <VERB? TELL> <EQUAL? ,PRSI ,MRADIATOR>>
   <TELL "“It bangs all night,” Ives says. “The clock goes wrong, the pipes complain. Somehow only the porter ever gets written up.”" CR>)
  (<VERB? EXAMINE TELL> <COND (,CASE-READY <TELL "“Make them say whose hand was on the latch,” Ives says. “I can stand a lot, but not another sentence about my character.”" CR>)
  (,CLOCK-SEEN <TELL "“I told them it was twelve by the clock in the weigh room,” Ives says. “If that clock says twelve twice, that's the clock's fault, not mine.”" CR>)
  (T <TELL "Ives folds his big arms. “The chalk in my pocket is for the dispatch marks,” he says. “I chalk every crate when it's packed. I did my turn at the scale all night, and I never touched a key.” He waits, angry and silent, for you to try to catch him out." CR>)>)
  (<VERB? SMELL> <TELL "Wet wool and chalk dust." CR>)
  (<VERB? RUB> <TELL "He flinches away. “Ask me what you like. Don't pat me like a horse.”" CR>)
  (<VERB? ATTACK KICK> <TELL "The hearing has been hard enough on him without you." CR>)>>

<ROUTINE MVENN-F ()
 <COND
  (<VERB? EXAMINE TELL> <COND (,CASE-READY <TELL "“The finding goes on paper under your name, not mine,” Venn says. “Turn the tab that matches it.”" CR>)
  (,SEAL-SEEN <TELL "“A borrowed seal can make one of us look guilty,” Venn says. “Work out who could actually reach the crate at the moment it changed weight.”" CR>)
  (T <TELL "Venn caps her pen. “The papers are all out for you,” she says. “Turn the panel when you can show where, when and who so plainly that a liar couldn't tell the same story with them.”" CR>)>)
  (<VERB? LISTEN> <TELL "Her pen scratches steadily. She is writing down everything anyone says, including you." CR>)
  (<VERB? RUB> <TELL "Venn looks at your hand until you take it back." CR>)
  (<VERB? ATTACK KICK> <TELL "Striking the clerk of a hearing would make you the next case on the list." CR>)>>

<ROUTINE MORR-F ()
 <COND
  (<AND <VERB? TELL> <EQUAL? ,PRSI ,MREG>>
   <COND (,REG-READ
          <TELL "Orr puts a finger just above his 11:55 signature. “This records when I left the room, not where I went.” He leaves a clean gap between his finger and the line for the missing key." CR>)
         (T <TELL "Orr turns the shift register to face you. “The entries are public. Read the times for yourself.”" CR>)>)
  (<AND <VERB? TELL> <EQUAL? ,PRSI ,MSLEEVE>>
   <TELL "Orr pinches the buckle shut. “Valuations.” Something hard taps the buckle from inside; he does not offer to let you check." CR>)
  (<VERB? EXAMINE TELL> <COND (,CASE-READY <TELL "“I thought you were going to take his word against mine,” Orr says. He has stopped buttoning the cuff." CR>)
  (,REG-READ <TELL "“You'll see I signed out of the registry at eleven fifty-five,” Orr says. “Where I went after that? The register is not a diary.”" CR>)
  (T <TELL "Orr smiles thinly. “The porter had his chalk all over that crate,” he says. “That should be enough for any reasonable person.”" CR>)>)
  (<VERB? SMELL> <TELL "Expensive soap, and under it, very faintly, oranges." CR>)
  (<VERB? SEARCH> <TELL "“You have no authority to search an assessor,” Orr says, and tucks his long document sleeve more tightly under his arm." CR>)
  (<VERB? RUB> <TELL "He steps back. “Mind the suit.”" CR>)
  (<VERB? ATTACK KICK> <TELL "That would give Orr exactly the scene he wants." CR>)>>

<ROUTINE MSCALE-F ()
 <COND
  (<VERB? EXAMINE READ SEARCH> <SETG SCALE-SEEN T> <TELL "The scale prints a paper strip for every weighing. Tonight's strip shows the same crate weighed twice, six minutes apart. The second time it was exactly eleven pounds lighter: the weight of the astrolabe and its felt tray. The times on the strip are stamped by a separate pulse sent down the speaking tube, not taken from the wall clock." CR>)
  (<VERB? TAKE> <TELL "The strip stays on the printer until the clerk tears it off for the record." CR>)
  (<VERB? CLIMB-ON CLIMB-FOO> <TELL "You step onto the platform. The needle swings round to your weight, and you step off again before the printer can make a record of you." CR>)
  (<VERB? PUSH MOVE> <TELL "The platform rocks under your hand; the needle twitches and settles back to zero." CR>)
  (<VERB? LISTEN> <TELL "The speaking tube beside the printer hisses faintly, and once a minute it gives a small click: the pulse that stamps the time." CR>)
  (<VERB? KNOCK> <TELL "The platform gives a hollow note. The printer sits on its own bracket and doesn't even tremble." CR>)
  (<VERB? LOOK-UNDER>
   <TELL "Under the platform a spring settles against its stop. There is nowhere to conceal eleven pounds of brass without putting their weight back on the scale." CR>)
  (<VERB? RUB> <TELL "Two bright arcs run across the platform where heavy crates have been dragged on and off." CR>)>>

<ROUTINE MCLOCK-F ()
 <COND
  (<VERB? EXAMINE READ> <SETG CLOCK-SEEN T> <TELL "The second hand still sweeps round, but the minute hand is missing; someone took it off for repairs. Only the hour hand is left, pointing at twelve, so for a whole hour this clock says twelve, whatever the minute. Nobody could tell the time to the minute by it." CR>)
  (<VERB? LISTEN> <TELL "It ticks loudly and steadily, as if nothing were wrong with it at all." CR>)
  (<VERB? SPIN TURN> <TELL "There is no dial you can turn from the floor. Setting the hour hand would still leave the minute hand missing." CR>)
  (<VERB? WIND> <TELL "It is wound tight. The trouble isn't the spring; it's the missing hand." CR>)
  (<VERB? TAKE MOVE RUB> <TELL "It hangs high on the wall, above the scale, out of easy reach." CR>)>>

<ROUTINE MLEDGER-F ()
 <COND
  (<VERB? EXAMINE READ SEARCH> <SETG LEDGER-READ T> <TELL "Tonight's entries, in the scale clerk's neat hand. He copied both time stamps from the scale strip: at 11:57 the crate weighed eleven pounds more; at 12:03, the same crate weighed eleven pounds less. In the margin a bracket joins the two lines, and Ives has signed it. The bracket records two WEIGHINGS of the crate, not two visits to the cage." CR>)
  (<VERB? RUB> <TELL "Ives's signature is pressed in hard, with a little chalk dust caught in the letters." CR>)
  (<VERB? SMELL> <TELL "Damp paper and ink. This one, at least, has stayed dry." CR>)
  (<VERB? TAKE> <TELL "The ledger is evidence, and it stays in the records room where the clerk can vouch for it." CR>)
  (<VERB? LOOK-INSIDE OPEN> <PERFORM ,V?EXAMINE ,MLEDGER> <RTRUE>)
  (<VERB? CLOSE> <TELL "You bring the cover halfway down. Wet air beads on the cloth, so you leave the book open to dry at tonight's page." CR>)>>

<ROUTINE MCAB-F ()
 <COND
  (<VERB? EXAMINE SEARCH LOOK-INSIDE> <SETG CAB-SEEN T> <TELL "Every cage key hangs on its own brass tag. Ives's key is still chained to the wall, under a printed rule that a porter must stay beside the scale during a weigh-in. The assessor's tag, Orr's, is back on its hook now, and it is smeared with the orange-scented oil used on fresh hinge pins." CR>)
  (<VERB? OPEN> <TELL "It isn't locked. The keys inside clink on their hooks as the door swings." CR>)
  (<VERB? CLOSE> <TELL "You push the door to. It swings open again an inch; the catch has long since worn smooth." CR>)
  (<VERB? SMELL> <TELL "Oranges, sharpest close to one of the hooks." CR>)
  (<VERB? RUB> <TELL "Your fingertips come away slightly oily." CR>)
  (<VERB? TAKE MOVE> <TELL "It is screwed to the wall." CR>)>>

<ROUTINE MKEYS-F ()
 <COND
  (<VERB? EXAMINE SEARCH READ> <SETG CAB-SEEN T> <TELL "Each cage key hangs from its own brass tag inside the cabinet. Ives's key is chained to the wall, under a printed rule that a porter must stay beside the scale during a weigh-in. Orr's tag hangs back on its hook, smeared with the orange-scented oil used on fresh hinge pins." CR>)
  (<VERB? SMELL> <TELL "Oranges, strongest on Orr's tag." CR>)
  (<VERB? RUB> <TELL "Your fingertips come away slightly oily from Orr's tag. The others are dry." CR>)
  (<VERB? TAKE MOVE PULL> <TELL "The keys stay on their hooks. Orr's tag is evidence now, and so is the oil on it." CR>)>>

<ROUTINE MPOCKETS-F ()
 <COND
  (<VERB? EXAMINE READ> <TELL "A stub of white dispatch chalk, worn flat on one side, a tram ticket punched for the last car home, and a boiled sweet still in its paper. Nothing in Ives's pockets would open a lock." CR>)
  (<VERB? EAT> <TELL "“Leave a man his sweet,” Ives says. You put it back in the coat." CR>)
  (<VERB? TAKE> <TELL "“Those are mine,” Ives says. You put his things back in the coat." CR>)
  (<VERB? SMELL> <TELL "Chalk and peppermint. No oranges." CR>)>>

<ROUTINE MRADIATOR-F ()
 <COND
  (<VERB? EXAMINE> <TELL "An iron radiator under the empty pegs, hissing and steaming. Ives's coat drips on it and the drops fizz." CR>)
  (<VERB? RUB TAKE> <TELL "It is too hot to touch for long." CR>)
  (<VERB? LISTEN> <TELL "It ticks and hisses like an impatient clerk." CR>)>>

<ROUTINE MPAPERS-F ()
 <COND
  (<VERB? EXAMINE READ> <TELL "Venn's papers are squared at the end of the table: a blank finding form with WHERE, WHEN and WHO left empty, and her notes of everything said tonight, in a hand too small to read upside down." CR>)
  (<VERB? TAKE> <TELL "Venn puts her pen down on top of them. “Mine,” she says." CR>)>>

<ROUTINE MTUBE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A brass speaking tube runs down beside the scale's printer. Once a minute it clicks, and the printer stamps the time from that click, not from the wall clock." CR>)
  (<VERB? LISTEN> <TELL "It hisses faintly, and once a minute it gives a small click: the pulse that stamps the time." CR>)
  (<VERB? TELL> <TELL "Nobody answers. The tube only carries the time." CR>)>>

<ROUTINE MFELT-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Two green felt corners, torn from the astrolabe's tray as it was lifted out in a hurry." CR>)
  (<VERB? TAKE> <TELL "They are evidence. You leave them in the crate." CR>)
  (<VERB? SMELL> <TELL "Pine shavings and oranges." CR>)>>

<ROUTINE MOIL-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A half-circle of oil on the crate's hinge edge, where a freshly oiled hinge pin was swung through it. It smells of oranges." CR>)
  (<VERB? RUB> <TELL "It is still tacky. Whoever oiled that hinge did it tonight." CR>)
  (<VERB? SMELL> <TELL "Oranges, sharp and fresh." CR>)>>

<ROUTINE MWIRE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Walls of heavy wire mesh, bolted floor to ceiling. Nobody could reach a crate in here from outside; you come in through the grille from the records room or not at all." CR>)
  (<VERB? CLIMB-ON CLIMB-FOO CLIMB-UP> <TELL "The mesh is too fine for a toehold." CR>)
  (<VERB? RUB PUSH> <TELL "It rings faintly and holds." CR>)>>

<ROUTINE MSLEEVE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A long leather document sleeve, the kind an assessor carries his valuations in. It is fatter than valuations would make it, and Orr keeps it clamped under his arm." CR>)
  (<VERB? TAKE OPEN SEARCH LOOK-INSIDE> <TELL "Orr turns his shoulder. “Papers of the syndicate,” he says. “Unless you have a finding, they stay with me.”" CR>)
  (<VERB? LISTEN> <TELL "Something inside gives a little clink when he changes his grip. Whatever it is, it isn't paper." CR>)
  (<VERB? RUB> <TELL "Orr puts his thumb over the round bulge by the catch. “I take it you have something against a well-made case?”" CR>)
  (<VERB? SMELL> <TELL "Leather, and oranges." CR>)>>

<ROUTINE MSEAL-F ()
 <COND
  (<VERB? EXAMINE> <SETG SEAL-SEEN T> <TELL "A wax seal on a signed paper tag. But it is the ASSAY seal, the one fixed through the crate's inside hinge, not the dispatch seal. Ives's chalked dispatch mark is on the lid, somewhere else entirely. So the lid could be lifted from the hinge side without disturbing Ives's chalk, but not without an assessor's key." CR>)
  (<VERB? RUB> <TELL "The wax is cracked clean through, the way wax cracks when a hinge is swung, not when it is cut." CR>)
  (<VERB? SMELL> <TELL "Sealing wax, and a faint smell of oranges." CR>)
  (<VERB? TAKE> <TELL "It is evidence. You leave it hanging where it was found." CR>)>>

<ROUTINE MCRATE-F ()
 <COND
  (<VERB? EXAMINE>
   <COND (,CRATE-CLOSED
    <TELL "The lid is down. The chalk mark on the lid is intact.">
    <COND (<NOT <FSET? ,MOIL ,INVISIBLE>> <TELL " The oil is on the hinge edge, away from the dispatch mark.">)>
    <CRLF>)
    (T
     <SETG CRATE-INSPECTED T> <FCLEAR ,MFELT ,INVISIBLE> <FCLEAR ,MOIL ,INVISIBLE>
     <TELL "The crate is empty except for two felt corners from the astrolabe's tray. On the hinge edge, newly exposed, is a half-circle of oil. Ives's chalk mark on the outside of the lid is unbroken; nobody had to touch it." CR>)>)
  (<VERB? OPEN LOOK-INSIDE SEARCH>
   <SETG CRATE-INSPECTED T> <SETG CRATE-CLOSED <>>
   <FCLEAR ,MFELT ,INVISIBLE> <FCLEAR ,MOIL ,INVISIBLE>
   <TELL "You lift the lid. Inside are only the two felt corners, a half-circle of oil by the hinge, and a smell of oranges." CR>)
  (<VERB? CLOSE>
   <COND (,CRATE-CLOSED <TELL "The lid is already down." CR>)
         (T <SETG CRATE-CLOSED T> <FSET ,MFELT ,INVISIBLE>
            <TELL "You let the lid down gently. Ives's chalk mark stays unbroken." CR>)>)
  (<VERB? TAKE> <TELL "It is evidence, and it is heavier than it looks even empty. It stays in the cage." CR>)
  (<VERB? SMELL> <TELL "Pine shavings and, unmistakably, oranges." CR>)
  (<VERB? PUSH MOVE LISTEN>
   <COND (,CRATE-INSPECTED <TELL "A loose felt corner scrapes along the boards with a dry whisper." CR>)
         (T <TELL "A dry whisper under the lid. Whatever shifted in there was much lighter than brass." CR>)>)
  (<VERB? KNOCK>
   <COND (,CRATE-CLOSED <TELL "You tap a knuckle against the lid. The sound is too hollow for eleven pounds of brass." CR>)
         (T <TELL "You tap a knuckle against the raised lid. The boards sound too hollow for eleven pounds of brass." CR>)>)
  (<VERB? RUB> <TELL "You brush dust from the edge with your sleeve, careful to leave the dispatch chalk alone." CR>)
  (<VERB? KICK ATTACK> <TELL "It is evidence, and there are witnesses." CR>)>>

<ROUTINE MREG-F ()
 <COND
  (<VERB? EXAMINE READ OPEN LOOK-INSIDE SEARCH> <SETG REG-READ T> <TELL "The night's signatures. At 11:55, Orr signs out of the registry; at 12:06, he signs back in. Beside those lines, the crossing guard has initialled Ives as present in the weigh room the whole time. And the assessor's cage key is marked OUT for that same interval. It was not a key the porter could have borrowed." CR>)
  (<VERB? RUB> <TELL "The ink has blurred where wet sleeves dragged across it, but the times can still be read." CR>)
  (<VERB? CLOSE> <TELL "You hold the covers together for a moment. The wet pages begin to stick, so you leave the signatures open to the air." CR>)
  (<VERB? TAKE> <TELL "The register is chained to its desk, as public registers are." CR>)>>

<ROUTINE MPANEL-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The panel is a hinged board with three columns, headed WHERE, WHEN and WHO. When all three can be filled in, turning it lays out a reconstruction of the theft for the whole room to see, before anyone signs a finding." CR>)
  (<VERB? TURN SPIN> <COND (,CASE-READY <TELL "The Ives tab and Orr tab already hang from it. The choice is still yours." CR>)
     (<OR <NOT ,SCALE-SEEN> <NOT ,LEDGER-READ>> <TELL "WHEN is blank. You need to know when the crate lost its weight: compare the scale in the weigh room with the original record." CR>)
     (<OR <NOT ,SEAL-SEEN> <NOT ,CAB-SEEN>> <TELL "WHERE is incomplete. Find out how the crate could be opened, and why nothing that should have broken did. The records room and the cage beyond it are the place to start." CR>)
     (<NOT ,REG-READ> <TELL "WHO is blank. Find out who signed out, and when, at the registry." CR>)
     (T <SETG CASE-READY T> <FCLEAR ,MIVES-TAB ,INVISIBLE> <FCLEAR ,MORR-TAB ,INVISIBLE>
      <TELL "You lay the three columns together. WHEN: the crate got eleven pounds lighter between 11:57 and 12:03. WHERE: it was opened through the assay hinge, which needn't disturb a dispatch mark. WHO: that latch needed the assessor's key, and the key was out for the whole interval. Venn slides down two paper tabs, an Ives tab and an Orr tab, each with a mark for your thumb. Turn the tab you think the evidence supports." CR>)>)
  (<VERB? RUB> <TELL "The hinge is stiff, and the board is warm from the lamp above it." CR>)
  (<VERB? TAKE> <TELL "Venn steadies the board. “The record stays here. If you have enough to make a finding, turn it where we can all see.”" CR>)
  (<VERB? KNOCK> <TELL "Three light knocks, one for each column. Venn sets down her pen, then picks it up again when you don't speak." CR>)
  (<VERB? PUSH MOVE> <TELL "It doesn't slide. It is made to be turned, once you are ready." CR>)>>

<ROUTINE MIVES-TAB-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Turning this tab would record that Ives removed the astrolabe. Venn waits for you to turn it, if that is your finding. The mark would put the loss on Ives and make him answer for it." CR>)
  (<VERB? TURN SPIN> <TELL "You hesitate. Ives made the chalk mark, not the inner seal, so where could he have got a key? Venn leaves both tabs open and the finding unsigned. Across the table Ives releases the breath he was holding; Orr looks down at the sleeve in his lap. The evidence still needs an explanation, not a convenient name." CR>)>>

<ROUTINE MORR-TAB-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Turning this tab would record that Orr removed the astrolabe. Venn waits for you to turn it, if that is your finding. The mark would put the loss on Orr and make him answer for it." CR>)
  (<VERB? TURN SPIN> <COND (,CASE-READY <SETG CASE-DONE T>
    <TELL "Orr signing out of the registry proved nothing on its own. The key, the unbroken dispatch mark and the missing eleven pounds prove enough. Without a word, Orr draws the long brass instrument out of his document sleeve and lays it on the table, as neatly as if he were entering it in a column. Ives takes his coat down from the wall at last. He does not thank you until you are both out under the same rain." CR CR "THE END: THE WEIGHT OF THE RECORD" CR> <FINISH>)
    (T <TELL "No finding is available yet." CR>)>)>>

<ROUTINE MFOOT-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Dozens of wet footprints criss-cross the tiles: heavy boots, neat shoes, one set of bare feet that turns out to be a dog's. Most of them lead north, into the hearing." CR>)
  (<VERB? FOLLOW>
   <TELL "The dog went to the hearing chamber. Somebody with very narrow shoes doubled back toward the door. Rain tracked in since has softened the edges; you could not swear to which prints came first." CR>)
  (<VERB? RUB> <TELL "Your shoe smudges the next print. You step back. An examiner ought to leave no extra evidence." CR>)>>

<ROUTINE MTABLE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A long oak table ringed with empty chairs. The evidence panel stands in the middle, and Venn's papers are squared neatly at one end." CR>)
  (<VERB? KNOCK> <TELL "Venn looks up. “Order,” she says mildly, and goes back to writing." CR>)
  (<VERB? CLIMB-ON CLIMB-FOO> <TELL "You pull out a chair and sit for a moment. It is the first time you have sat down all night." CR>)>>

<ROUTINE MPEGS-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Ives's coat has the middle peg. Rain has darkened the wood beneath it; all the other pegs are dry. Beneath them, the radiator hisses and steams." CR>)
  (<VERB? RUB> <TELL "Cold brass, smoothed by years of coats." CR>)
  (<VERB? TAKE> <TELL "They are screwed into the panelling." CR>)
  (<VERB? KNOCK> <TELL "The pegs answer in thin, bright notes. Ives's coat muffles the middle one." CR>)>>

<ROUTINE MDUST-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Grey dust everywhere, except in clean squares where crates stood until they were moved. One square, nearest the scale, is still sharp at the edges." CR>)
  (<VERB? RUB> <TELL "It comes away on your fingertip, fine and grey. Under it, the boards are scored by crate corners." CR>)>>

<ROUTINE MSHELVES-F ()
 <COND
  (<VERB? EXAMINE SEARCH> <TELL "Shelf after shelf of old record books, years of auctions in faded cloth bindings. Only tonight's book matters, and it lies apart from them, under the one dry square of ceiling." CR>)
  (<VERB? SMELL> <TELL "Mildew and old glue." CR>)
  (<VERB? TAKE> <TELL "None of them covers tonight. The midnight ledger does." CR>)>>

<ROUTINE MCEILING-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The ceiling leaks in a dozen places. There is a single dry square of plaster, and the midnight ledger has been laid exactly under it." CR>)
  (<VERB? LISTEN> <TELL "Drip. Drip. Drip, into a bucket somewhere behind the shelves." CR>)>>

<ROUTINE MGRILLE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A folding iron grille that closes off the transit cage. It stands open now, and the cage beyond it is dark." CR>)
  (<VERB? CLOSE> <TELL "You leave it open. The cage is part of the evidence." CR>)
  (<VERB? OPEN> <TELL "It is already open, folded back against the wall." CR>)
  (<VERB? RUB> <TELL "Its hinges are freshly oiled, and the oil smells of oranges." CR>)>>
