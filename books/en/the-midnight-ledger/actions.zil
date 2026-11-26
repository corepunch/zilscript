<ROUTINE V-VERSION ()
 <TELL "The Midnight Ledger|Studio Null, 2026|Release " N ,RELEASEID CR>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T)) <TELL "There is no score and no deadline." CR>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG COMPACT-ROOM-LISTS T> <SETG HERE ,VESTIBULE> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "You are the examiner the harbour auction house sends for when something goes missing, and tonight it has called you out through the rain. At the midnight weigh-in, Lot 9, a brass astrolabe, turned out to be gone from its sealed transit crate. The porter, Ives, is already being told to sign for the loss. Before anyone signs anything, the hearing wants your finding: where the astrolabe was taken, when, and by whom." CR CR>
 <TELL D ,HERE CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<SYNTAX HINT = V-BOOK-HINT>
<SYNTAX TURN OBJECT = V-SPIN>

<ROUTINE V-BOOK-HINT ()
 <COND (<OR <NOT ,SCALE-SEEN> <NOT ,LEDGER-READ>> <TELL "Compare the scale and the midnight ledger. One clock is untrustworthy." CR>) (<OR <NOT ,SEAL-SEEN> <NOT ,CAB-SEEN>> <TELL "The seal and cabinet explain how the crate can change without a dispatch mark breaking." CR>) (<NOT ,REG-READ> <TELL "Read the public shift register and compare who left with the interval of the loss." CR>) (<NOT ,CASE-READY> <TELL "Turn the evidence panel when all three columns are established." CR>) (T <TELL "Choose the named tab that matches the access and time evidence." CR>)>>

<ROUTINE VESTIBULE-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "You are in the vestibule of the auction house, a draughty entrance hall with wet [[footprints]] all over the tiles. In the corner, a [[coffee urn->urn]] has cooked down to mud, and nobody here has the authority to empty it. A damp [[notice]] is pinned to the wall. The hearing chamber is to the [[north]], and from it comes a low murmur of voices. The cloakroom, where the porter is waiting, is to the [[east]]." CR>)>>

<ROUTINE CHAMBER-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the hearing chamber, a panelled room with a long [[table]] and a ring of empty chairs. [[Clerk Venn->venn]] sits at the end of the table with the calm of someone paid by the hour. In the middle of the table stands the [[evidence panel->panel]], a hinged board on which the finding will be set out.">
 <COND (,CASE-READY <TELL " Two paper tabs now hang from it, one for an [[Ives verdict->ives tab]] and one for an [[Orr verdict->orr tab]].">)>
 <TELL " The weigh room is to the [[west]] and the records room to the [[east]]. The public registry is to the [[north]], and the vestibule is back to the [[south]]." CR>)>>

<ROUTINE CLOAKROOM-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the cloakroom, a narrow room lined with coat [[pegs]], every one of them empty, above a hissing radiator. [[Porter Ives->ives]], a broad, tired man, has hung his own wet [[coat]] on the wall so that his hands will stop searching its pockets. The vestibule is back to the [[west]]." CR>)>>

<ROUTINE SCALEHOUSE-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the weigh room, where every crate is weighed into the auction and out again. [[Dust]] lies over the floor, except in clean squares where crates were standing. The big platform [[weigh scale->scale]] has stopped swinging, and a paper strip hangs from its printer. A [[clock]] ticks on the wall above it. The hearing chamber is back to the [[east]]." CR>)>>

<ROUTINE RECORDS-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the records room, [[shelves]] of old record books under a leaking [[ceiling]]. Tonight's book, the [[midnight ledger->ledger]], lies face up under the one dry square of ceiling. A [[key cabinet->cabinet]] hangs on the wall, and it smells very faintly of oranges. Beyond an open [[grille]] to the [[north]], the transit cage is unlit. The hearing chamber is back to the [[west]]." CR>)>>

<ROUTINE CAGE-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the transit cage, a wire-walled room where sold lots wait to be shipped. It is dim in here, and the floor shifts a little underfoot. A [[syndicate seal->seal]] dangles crooked from an empty hook, and beside it a [[transit crate->crate]] gives a soft rattle whenever the floor moves. The lit records room is back to the [[south]]." CR>)>>

<ROUTINE REGISTRY-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the public registry, where everyone who comes or goes on the night shift signs the book. Rain dripping from the people who leaned over to sign has softened the pages of the [[shift register->register]]. Across the room, [[Assessor Orr->orr]], a neat, narrow man in a grey suit, keeps unbuttoning and rebuttoning one cuff. The hearing chamber is back to the [[south]]." CR>)>>

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
  (<VERB? SEARCH LOOK-INSIDE OPEN> <TELL "Ives watches you do it. The pockets hold a stub of dispatch chalk, a tram ticket and a boiled sweet. No key." CR>)
  (<VERB? SMELL> <TELL "Wet wool and chalk. No oranges." CR>)
  (<VERB? TAKE> <TELL "“That's mine,” Ives says, before your hand gets there." CR>)>>

<ROUTINE MIVES-F ()
 <COND
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
  (T <TELL "Venn caps her pen. “The papers are all out for you,” she says. “Turn the [[panel]] when you can show where, when and who so plainly that a liar couldn't tell the same story with them.”" CR>)>)
  (<VERB? LISTEN> <TELL "Her pen scratches steadily. She is writing down everything anyone says, including you." CR>)
  (<VERB? RUB> <TELL "Venn looks at your hand until you take it back." CR>)
  (<VERB? ATTACK KICK> <TELL "Striking the clerk of a hearing would make you the next case on the list." CR>)>>

<ROUTINE MORR-F ()
 <COND
  (<VERB? EXAMINE TELL> <COND (,CASE-READY <TELL "“I thought you were going to take his word against mine,” Orr says. He has stopped buttoning the cuff." CR>)
  (,REG-READ <TELL "“You'll see I signed out of the registry at eleven fifty-five,” Orr says. “Where I went after that? The register is not a diary.”" CR>)
  (T <TELL "Orr smiles thinly. “The porter had his chalk all over that crate,” he says. “That should be enough for any reasonable person.”" CR>)>)
  (<VERB? SMELL> <TELL "Expensive soap, and under it, very faintly, oranges." CR>)
  (<VERB? SEARCH> <TELL "“You have no authority to search an assessor,” Orr says, and tucks his long document sleeve more tightly under his arm." CR>)
  (<VERB? RUB> <TELL "He steps back. “Mind the suit.”" CR>)
  (<VERB? ATTACK KICK> <TELL "That would give Orr exactly the scene he wants." CR>)>>

<ROUTINE MSCALE-F ()
 <COND
  (<VERB? EXAMINE READ> <SETG SCALE-SEEN T> <TELL "The scale prints a paper strip for every weighing. Tonight's strip shows the same crate weighed twice, six minutes apart. The second time it was exactly eleven pounds lighter: the weight of the astrolabe and its felt tray. The times on the strip are stamped by a separate pulse sent down the speaking tube, not taken from the wall [[clock]]." CR>)
  (<VERB? CLIMB-ON CLIMB-FOO> <TELL "You step onto the platform. The needle swings round to your weight, and you step off again before the printer can make a record of you." CR>)
  (<VERB? PUSH MOVE> <TELL "The platform rocks under your hand; the needle twitches and settles back to zero." CR>)
  (<VERB? LISTEN> <TELL "The speaking tube beside the printer hisses faintly, and once a minute it gives a small click: the pulse that stamps the time." CR>)>>

<ROUTINE MCLOCK-F ()
 <COND
  (<VERB? EXAMINE READ> <SETG CLOCK-SEEN T> <TELL "The second hand still sweeps round, but the minute hand is missing; someone took it off for repairs. Only the hour hand is left, pointing at twelve, so for a whole hour this clock says twelve, whatever the minute. Nobody could tell the time to the minute by it." CR>)
  (<VERB? LISTEN> <TELL "It ticks loudly and steadily, as if nothing were wrong with it at all." CR>)
  (<VERB? WIND> <TELL "It is wound tight. The trouble isn't the spring; it's the missing hand." CR>)
  (<VERB? TAKE MOVE RUB> <TELL "It hangs high on the wall, above the scale, out of easy reach." CR>)>>

<ROUTINE MLEDGER-F ()
 <COND
  (<VERB? EXAMINE READ SEARCH> <SETG LEDGER-READ T> <TELL "Tonight's entries, in the scale clerk's neat hand. He copied both time stamps from the scale strip: at 11:57 the crate weighed eleven pounds more; at 12:03, the same crate weighed without them. In the margin a bracket joins the two lines, and Ives has signed it. The bracket records two WEIGHINGS of the crate, not two visits to the cage." CR>)
  (<VERB? RUB> <TELL "Ives's signature is pressed in hard, with a little chalk dust caught in the letters." CR>)
  (<VERB? SMELL> <TELL "Damp paper and ink. This one, at least, has stayed dry." CR>)
  (<VERB? TAKE> <TELL "The ledger is evidence, and it stays in the records room where the clerk can vouch for it." CR>)>>

<ROUTINE MCAB-F ()
 <COND
  (<VERB? EXAMINE SEARCH LOOK-INSIDE> <SETG CAB-SEEN T> <TELL "Every cage key hangs on its own brass tag. Ives's key is still chained to the wall, under a printed rule that a porter must stay beside the scale during a weigh-in. The assessor's tag, Orr's, is back on its hook now, and it is smeared with the orange-scented oil used on fresh hinge pins." CR>)
  (<VERB? OPEN> <TELL "It isn't locked. The keys inside clink on their hooks as the door swings." CR>)
  (<VERB? SMELL> <TELL "Oranges, sharpest close to one of the hooks." CR>)
  (<VERB? RUB> <TELL "Your fingertips come away slightly oily." CR>)
  (<VERB? TAKE MOVE> <TELL "It is screwed to the wall." CR>)>>

<ROUTINE MSEAL-F ()
 <COND
  (<VERB? EXAMINE> <SETG SEAL-SEEN T> <TELL "A wax seal on a signed paper tag. But it is the ASSAY seal, the one fixed through the crate's inside hinge, not the dispatch seal. Ives's chalked dispatch mark is on the lid, somewhere else entirely. So the lid could be lifted from the hinge side without disturbing Ives's chalk, but not without an assessor's key." CR>)
  (<VERB? RUB> <TELL "The wax is cracked clean through, the way wax cracks when a hinge is swung, not when it is cut." CR>)
  (<VERB? SMELL> <TELL "Sealing wax, and a faint smell of oranges." CR>)
  (<VERB? TAKE> <TELL "It is evidence. You leave it hanging where it was found." CR>)>>

<ROUTINE MCRATE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The crate is empty except for two felt corners from the astrolabe's tray. On the hinge edge, newly exposed, is a half-circle of oil. Ives's chalk mark on the outside of the lid is unbroken; nobody had to touch it." CR>)
  (<VERB? OPEN LOOK-INSIDE SEARCH> <TELL "You lift the lid. Inside are only the two felt corners, and a smell of oranges." CR>)
  (<VERB? SMELL> <TELL "Pine shavings and, unmistakably, oranges." CR>)
  (<VERB? PUSH MOVE> <TELL "It rattles softly. Something small and loose is still inside: a felt corner sliding about." CR>)
  (<VERB? KICK ATTACK> <TELL "It is evidence, and there are witnesses." CR>)>>

<ROUTINE MREG-F ()
 <COND
  (<VERB? EXAMINE READ> <SETG REG-READ T> <TELL "The night's signatures. At 11:55, Orr signs out of the registry; at 12:06, he signs back in. Beside those lines, the crossing guard has initialled Ives as present in the weigh room the whole time. And the assessor's cage key is marked OUT for that same interval. It was not a key the porter could have borrowed." CR>)
  (<VERB? RUB> <TELL "The ink has blurred where wet sleeves dragged across it, but the times can still be read." CR>)
  (<VERB? TAKE> <TELL "The register is chained to its desk, as public registers are." CR>)>>

<ROUTINE MPANEL-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The [[panel]] is a hinged board with three columns, headed WHERE, WHEN and WHO. When all three can be filled in, turning it lays out a reconstruction of the theft for the whole room to see, before anyone signs a finding." CR>)
  (<VERB? TURN SPIN> <COND (,CASE-READY <TELL "The [[Ives tab->ives tab]] and [[Orr tab->orr tab]] already hang from it. The choice is still yours." CR>)
     (<OR <NOT ,SCALE-SEEN> <NOT ,LEDGER-READ>> <TELL "WHEN is blank. You need to know when the crate lost its weight: compare the scale in the [[weigh room->west]] with the original [[record->east]]." CR>)
     (<OR <NOT ,SEAL-SEEN> <NOT ,CAB-SEEN>> <TELL "WHERE is incomplete. Find out how the crate could be opened, and why nothing that should have broken did. The [[records room->east]] and the cage beyond it are the place to start." CR>)
     (<NOT ,REG-READ> <TELL "WHO is blank. Find out who signed out, and when, at the [[registry->north]]." CR>)
     (T <SETG CASE-READY T> <FCLEAR ,MIVES-TAB ,INVISIBLE> <FCLEAR ,MORR-TAB ,INVISIBLE>
      <TELL "You lay the three columns together. WHEN: the crate got eleven pounds lighter between 11:57 and 12:03. WHERE: it was opened through the assay hinge, which needn't disturb a dispatch mark. WHO: that latch needed the assessor's key, and the key was out for the whole interval. Venn slides down two paper tabs, an [[Ives tab]] and an [[Orr tab]], each with a mark for your thumb." CR>)>)
  (<VERB? RUB> <TELL "The hinge is stiff, and the board is warm from the lamp above it." CR>)
  (<VERB? PUSH MOVE> <TELL "It doesn't slide. It is made to be turned, once you are ready." CR>)>>

<ROUTINE MIVES-TAB-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Turning this tab would record that Ives removed the astrolabe. Venn waits for you to turn it, if that is your finding." CR>)
  (<VERB? TURN SPIN> <TELL "You hesitate. Ives made the chalk mark, not the inner seal, so where could he have got a key? Venn leaves both tabs open and the finding unsigned." CR>)>>

<ROUTINE MORR-TAB-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Turning this tab would record that Orr removed the astrolabe. Venn waits for you to turn it, if that is your finding." CR>)
  (<VERB? TURN SPIN> <COND (,CASE-READY <SETG CASE-DONE T>
    <TELL "Orr signing out of the registry proved nothing on its own. The key, the unbroken dispatch mark and the missing eleven pounds prove enough. Without a word, Orr draws the long brass instrument out of his document sleeve and lays it on the table, as neatly as if he were entering it in a column. Ives takes his coat down from the wall at last. He does not thank you until you are both out under the same rain." CR CR "THE END: THE WEIGHT OF THE RECORD" CR> <FINISH>)
    (T <TELL "No finding is available yet." CR>)>)>>

<ROUTINE MFOOT-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Dozens of wet footprints criss-cross the tiles: heavy boots, neat shoes, one set of bare feet that turns out to be a dog's. Most of them lead north, into the hearing." CR>)
  (<VERB? FOLLOW> <TELL "They lead everywhere at once, which is no help at all." CR>)>>

<ROUTINE MTABLE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A long oak table ringed with empty chairs. The [[evidence panel->panel]] stands in the middle, and Venn's papers are squared neatly at one end." CR>)
  (<VERB? KNOCK> <TELL "Venn looks up. “Order,” she says mildly, and goes back to writing." CR>)
  (<VERB? CLIMB-ON CLIMB-FOO> <TELL "You pull out a chair and sit for a moment. It is the first time you have sat down all night." CR>)>>

<ROUTINE MPEGS-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A row of brass coat pegs, all empty. Everyone else at the auction kept their coats on. Beneath them, the radiator hisses and steams." CR>)
  (<VERB? RUB> <TELL "The radiator is too hot to touch for long." CR>)
  (<VERB? LISTEN> <TELL "The radiator ticks and hisses like an impatient clerk." CR>)>>

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
  (<VERB? RUB> <TELL "Its hinges are freshly oiled, and the oil smells of oranges." CR>)>>
