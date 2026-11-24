<ROUTINE V-VERSION () <TELL "The Midnight Ledger, release 1. An original story by Studio Null." CR>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T)) <TELL "There is no score and no deadline." CR>>

<ROUTINE GO ()
 <SETG COMPACT-ROOM-LISTS T> <SETG HERE ,VESTIBULE> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<SYNTAX HINT = V-BOOK-HINT>
<SYNTAX TURN OBJECT = V-SPIN>

<ROUTINE V-BOOK-HINT ()
 <COND (<OR <NOT ,SCALE-SEEN> <NOT ,LEDGER-READ>> <TELL "Compare the scale and the midnight ledger. One clock is untrustworthy." CR>) (<OR <NOT ,SEAL-SEEN> <NOT ,CAB-SEEN>> <TELL "The seal and cabinet explain how the crate can change without a dispatch mark breaking." CR>) (<NOT ,REG-READ> <TELL "Read the public shift register and compare who left with the interval of the loss." CR>) (<NOT ,CASE-READY> <TELL "Turn the evidence panel when all three columns are established." CR>) (T <TELL "Choose the named tab that matches the access and time evidence." CR>)>>

<ROUTINE VESTIBULE-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "The [[notice]] is damp enough to fold with a thumb. Inside the [[hearing room->north]], a chair scrapes. Coffee turns to mud in an urn no one has the authority to empty. The [[cloakroom->east]] is still open." CR>)>>

<ROUTINE CHAMBER-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "[[Clerk Venn->venn]] listens with the calm of a person paid by the hour. The [[evidence panel->panel]] is within reach of every chair.">
 <COND (,CASE-READY <TELL " Two paper tabs hang down for an [[Ives verdict->ives tab]] and an [[Orr verdict->orr tab]].">)>
 <TELL " The [[cloakroom->south]] is through the vestibule; the [[weigh room->west]] opens beside the [[records room->east]] and the [[registry->north]]." CR>)>>

<ROUTINE CLOAKROOM-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "Steam rises off an empty row of pegs. [[Porter Ives->ives]] has hooked his own coat through the wall-ring so his hands will stop finding its pockets. The [[vestibule->west]] is through the swing door." CR>)>>

<ROUTINE SCALEHOUSE-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "Dust lifts in the squares where crates were standing. The [[weigh scale->scale]] has stopped swinging; a [[clock]] ticks on the wall. The [[hearing chamber->east]] is just across the threshold." CR>)>>

<ROUTINE RECORDS-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "The [[midnight ledger->ledger]] lies face up under a dry square in the ceiling. The [[key cabinet->cabinet]] smells very faintly of oranges. The [[cage->north]] is unlit beyond the open grill. Return [[west]] to the hearing chamber." CR>)>>

<ROUTINE CAGE-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "A [[syndicate seal->seal]] hangs crooked from an empty hook. The [[transit crate->crate]] beside it gives a soft rattle when the floor moves. The [[records room->south]] is still lit." CR>)>>

<ROUTINE REGISTRY-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "Wet coats have softened the [[shift register->register]] where people leaned over it to sign. At the other desk, [[Assessor Orr->orr]] unbuttons and rebuttons one cuff. The [[hearing chamber->south]] is behind you." CR>)>>

<ROUTINE MNOTICE-F ()
 <COND
  (<VERB? EXAMINE READ> <TELL "Lot 9, a brass astrolabe, was put inside a transit crate after the public viewing. At the midnight weigh-in it was gone. Porter Ives is being asked to sign the loss. A public finding must cite where, when, and who, not merely who needed the money." CR>)>>

<ROUTINE MIVES-F ()
 <COND
  (<VERB? EXAMINE TELL> <COND (,CASE-READY <TELL "'Make them say whose hand was on the latch,' Ives says. 'I can endure a lot, but not another sentence about my character.'" CR>)
  (,CLOCK-SEEN <TELL "'I said twelve by the clock in the weighing room. If it says twelve twice that is the clock's fault, not mine.'" CR>)
  (T <TELL "'The chalk in my pocket is for the dispatch marks,' he says. 'I did my turn at the scale, then I never took a key.' He offers you an angry silence to cross-examine." CR>)>)>>

<ROUTINE MVENN-F ()
 <COND
  (<VERB? EXAMINE TELL> <COND (,CASE-READY <TELL "'The finding is your name on paper, not mine. Mark the appropriate tab.'" CR>)
  (,SEAL-SEEN <TELL "'A copied impression can make one of us look guilty. Work out who could actually reach the crate when it changed weight.'" CR>)
  (T <TELL "'The papers are out for you. Turn the [[panel]] only when a liar could not tell the same story with them.'" CR>)>)>>

<ROUTINE MORR-F ()
 <COND
  (<VERB? EXAMINE TELL> <COND (,CASE-READY <TELL "'I thought you were going to take his word against mine,' Orr says. He has stopped buttoning the cuff." CR>)
  (,REG-READ <TELL "'You will notice I was at the registry at eleven fifty-five. Afterwards? The register is not a diary.'" CR>)
  (T <TELL "'The porter had his chalk all over the crate,' he says. 'That should be enough for a reasonable person.'" CR>)>)>>

<ROUTINE MSCALE-F ()
 <COND
  (<VERB? EXAMINE> <SETG SCALE-SEEN T> <TELL "The paper strip records two visits by the same crate, six minutes apart. In the second, precisely eleven pounds are gone: the weight of the instrument and its felt tray. The mechanism stamps from the separate pulse in the speaking tube; it never used the room [[clock]]." CR>)>>

<ROUTINE MCLOCK-F ()
 <COND
  (<VERB? EXAMINE> <SETG CLOCK-SEEN T> <TELL "The sweep hand ticks, but someone pocketed the minute hand for repairs. The minute it appears to show was cut into the face above the maker's address. Nobody could tell twelve by this." CR>)>>

<ROUTINE MLEDGER-F ()
 <COND
  (<VERB? EXAMINE READ SEARCH> <SETG LEDGER-READ T> <TELL "The scale clerk copied both time stamps: 11:57, with eleven extra pounds; 12:03, without. The bracket in the margin is signed by Ives, but it records two WEIGHINGS, not two entries to the cage." CR>)>>

<ROUTINE MCAB-F ()
 <COND
  (<VERB? EXAMINE SEARCH> <SETG CAB-SEEN T> <TELL "Every cage key is on a brass tag. Ives's is still chained to the wall under the rule: a porter must remain beside the scale. Orr's tag is stained with the orange oil on fresh hinge pins." CR>)>>

<ROUTINE MSEAL-F ()
 <COND
  (<VERB? EXAMINE> <SETG SEAL-SEEN T> <TELL "A signed paper hangs from a legitimate seal: it is the ASSAY seal, through the inside hinge. The chalked dispatch mark lies elsewhere. It was possible to lift the lid without disturbing Ives's chalk, but not without an assessor's key." CR>)>>

<ROUTINE MCRATE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The box still holds two felt corners. On the newly exposed edge there is a half-circle of oil from the hinge. Chalk on the outside didn't have to move." CR>)>>

<ROUTINE MREG-F ()
 <COND
  (<VERB? EXAMINE READ> <SETG REG-READ T> <TELL "11:55: Orr signs out of the registry. 12:06: Orr signs back in. The crossing guard initialed Ives in the weighing room throughout. The assessor's cage key is marked OUT for the whole interval. It was not the porter's to borrow." CR>)>>

<ROUTINE MPANEL-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The [[panel]] has three columns: WHERE, WHEN, WHO. Turning it publishes a provisional reconstruction before anybody signs." CR>)
  (<VERB? TURN SPIN> <COND (,CASE-READY <TELL "The [[Ives tab->ives tab]] and [[Orr tab->orr tab]] are exposed. The choice is still yours." CR>)
     (<OR <NOT ,SCALE-SEEN> <NOT ,LEDGER-READ>> <TELL "WHEN is blank. Compare the [[weigh room->west]] with the original [[record->east]]." CR>)
     (<OR <NOT ,SEAL-SEEN> <NOT ,CAB-SEEN>> <TELL "WHERE is incomplete. Examine the access and the object that should have shown a break. The [[records room->east]] is a good start." CR>)
     (<NOT ,REG-READ> <TELL "WHO is blank. Check who signed out and when at the [[registry->north]]." CR>)
     (T <SETG CASE-READY T> <FCLEAR ,MIVES-TAB ,INVISIBLE> <FCLEAR ,MORR-TAB ,INVISIBLE>
      <TELL "You lay the three columns together. The crate got lighter between 11:57 and 12:03. Opening it needn't disturb a dispatch mark. The assay latch needed a key out for that whole interval. Venn slides down an [[Ives tab]] and an [[Orr tab]], each with a mark for your thumb." CR>)>)>>

<ROUTINE MIVES-TAB-F ()
 <COND
  (<VERB? EXAMINE> <TELL "This tab would record that Ives removed the astrolabe. Venn waits for you to turn it if that is your finding." CR>)
  (<VERB? TURN SPIN> <TELL "Ives made the chalk mark, not the inner seal. Where could he have got a key? Venn leaves both tabs open and the finding unsigned." CR>)>>

<ROUTINE MORR-TAB-F ()
 <COND
  (<VERB? EXAMINE> <TELL "This tab would record that Orr removed the astrolabe. Venn waits for you to turn it if that is your finding." CR>)
  (<VERB? TURN SPIN> <COND (,CASE-READY <SETG CASE-DONE T>
    <TELL "The registry's signature outside its times proved nothing. The key, the unbroken dispatch mark, and the missing eleven pounds proved enough. Orr fits the long brass instrument from his document sleeve onto the table as neatly as if entering it in a column. Ives pulls his coat down at last. He does not thank you until you are both under the same rain." CR CR "THE END: THE WEIGHT OF THE RECORD" CR> <FINISH>)
    (T <TELL "No finding is available yet." CR>)>)>>
