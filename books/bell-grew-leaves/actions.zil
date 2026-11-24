<SYNTAX TURN OBJECT = V-SPIN>
<ROUTINE GO ()
 <SETG COMPACT-ROOM-LISTS T>
 <SETG HERE ,COURT> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "Three taps come up through the fog. That's the village across the hollow asking if your village is still there. For the first time, you're the one who gets to answer." CR CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<ROUTINE COURT-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "A [[root bell]] hangs low enough to touch. Its mouth is edged with pale roots.">
        <COND (<IN? ,WICK ,BELL> <TELL " A [[reed wick]] trails from one of them.">)>
        <COND (<FSET? ,SHUTTER ,OPENBIT> <TELL " A draft gets under the bell from the north.">)>
        <TELL " The reed store is [[east]]; the spring walk [[north]]." CR>)>>
<ROUTINE STORE-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "A painted [[signal tile]] stands where you'd expect a list of rules.">
        <COND (<IN? ,WICK ,STORE> <TELL " A [[reed wick]] has been laid underneath it.">)>
        <TELL " The court is [[west]]." CR>)>>
<ROUTINE SPRING-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "A [[turning spout]] runs beside a [[soaking bowl]].">
        <COND (,FLOWING <TELL " The bowl now holds a shaking picture of the sky.">)
              (T <TELL " The bowl holds nothing, though you can hear running water.">)>
        <TELL " The court is [[south]]; the shutter landing [[east]]." CR>)>>
<ROUTINE LANDING-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <COND (<FSET? ,SHUTTER ,OPENBIT>
               <TELL "At the open [[frost shutter]], a strand of fog comes apart on your sleeve.">)
              (T <TELL "White light shows at the corners of a closed [[frost shutter]].">)>
        <TELL " The spring walk is [[west]]." CR>)>>

<ROUTINE BELL-F ()
 <COND (<VERB? EXAMINE>
        <TELL "The rim is wood, not metal. A hole in the root is narrow enough for a wick.">
        <COND (<IN? ,WICK ,BELL> <TELL " The [[reed wick]] sits snugly in the hole.">)
              (<HELD? ,WICK> <TELL " The [[reed wick]] you are carrying would fit.">)>
        <CRLF>)
       (<VERB? LISTEN>
        <COND (<AND ,WET-WICK <IN? ,WICK ,BELL>> <TELL "You hear water climbing the wood. Its sound is smaller than rain." CR>)
              (T <TELL "With your ear to the wood you can hear your own pulse, then three very distant taps." CR>)>)
       (<AND <VERB? PUT> <EQUAL? ,PRSI ,BELL> <EQUAL? ,PRSO ,WICK>>
        <MOVE ,WICK ,BELL>
        <TELL "The root takes hold of the [[reed wick]]. There's enough left showing to pull it free again." CR>)
       (<VERB? RING>
        <COND (<NOT <IN? ,WICK ,BELL>> <TELL "Tuk. One pale root curls away as if it were a dry finger." CR>)
              (<NOT ,WET-WICK> <TELL "The dry [[reed wick]] rattles in its hole. The wood is thirsty, not loose." CR>)
              (<NOT <FSET? ,SHUTTER ,OPENBIT>>
               <TELL "A pale leaf pushes north and stops. Something square is holding the fog in." CR>)
              (T <TELL "Not a sound. Instead three leaves pass silently through the shutter. The first turns its white side up, then the second and third. Down in the fog, three white leaves turn over in answer. Someone there has been standing in the cold as long as you have." CR CR
                       "THE END -- THREE LEAVES FOR YES" CR>
                 <FINISH> <RTRUE>)>)>>
<ROUTINE WICK-F ()
 <COND (<VERB? EXAMINE>
        <COND (,WET-WICK <TELL "The reed is black with spring water. A little runs over your thumb if you squeeze it." CR>)
              (T <TELL "A length of dry pith, cut to fit the bell's root. A wick carries water uphill." CR>)>)>>
<ROUTINE TILE-F ()
 <COND (<VERB? EXAMINE READ>
        <SETG PATTERN-KNOWN T>
        <TELL "Three pictures, no writing: a wick standing in water; a wick tucked in a bell; three white leaves going out through an open shutter. Someone has drawn a fourth leaf underneath, then thought better of it and crossed it out." CR>)>>
<ROUTINE SPOUT-F ()
 <COND (<VERB? EXAMINE>
        <SETG SPOUT-SEEN T>
        <COND (,FLOWING <TELL "The brass mouth is pointing into the [[soaking bowl]]. It turns on a pin." CR>)
              (T <TELL "The brass mouth points past the [[soaking bowl]]. You could turn it to send the water into the bowl." CR>)>)
       (<VERB? SPIN>
        <SETG SPOUT-SEEN T>
        <COND (,FLOWING <SETG FLOWING <>> <TELL "You turn the spout away. The bowl drains through a hairline crack." CR>)
              (T <SETG FLOWING T> <TELL "The [[soaking bowl]] fills faster than the crack leaks." CR>)>)>>
<ROUTINE TROUGH-F ()
 <COND (<VERB? EXAMINE>
        <COND (,FLOWING <TELL "Clear water spills over the low edge. The bowl is just deep enough to soak a wick.">
               <COND (<HELD? ,WICK> <TELL " You hold the [[reed wick]] above the water.">)>
               <CRLF>)
              (T <TELL "Empty except for the hairline crack. The [[turning spout]] is near enough to fill it." CR>)>)
       (<AND <VERB? PUT> <EQUAL? ,PRSO ,WICK> <EQUAL? ,PRSI ,TROUGH>>
        <COND (,FLOWING <SETG WET-WICK T> <TELL "The [[reed wick]] goes dark from one end to the other. You lift it out before it can float away." CR>)
              (T <TELL "The bowl is empty. The reed wouldn't get any wetter here." CR>)>)>>
<ROUTINE SHUTTER-F ()
 <COND (<VERB? EXAMINE>
        <COND (<FSET? ,SHUTTER ,OPENBIT> <TELL "Fog moves in the gap. Out beyond it, the neighbors have lit a lamp." CR>)
              (T <TELL "The shutter keeps frost out in winter. It's held by a wooden peg you can lift from this side." CR>)>)
       (<VERB? OPEN>
        <COND (<FSET? ,SHUTTER ,OPENBIT> <TELL "It's already open." CR>)
              (T <FSET ,SHUTTER ,OPENBIT> <TELL "You lift the peg and open the shutter. Fog comes in as quietly as a cat." CR>)>)
       (<VERB? CLOSE>
        <COND (<FSET? ,SHUTTER ,OPENBIT>
               <FCLEAR ,SHUTTER ,OPENBIT> <TELL "The shutter fits snugly in its frame again." CR>)
              (T <TELL "It's already closed." CR>)>)>>
<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <COND (<AND <IN? ,WICK ,BELL> ,WET-WICK <FSET? ,SHUTTER ,OPENBIT>>
        <TELL "The bell has a clear path across the fog." CR>)
       (T <TELL "The neighboring village is listening patiently." CR>)>>
