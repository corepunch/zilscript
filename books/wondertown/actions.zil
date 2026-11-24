<SYNTAX TURN OBJECT = V-SPIN>

; === CUSTOM SYNTAX ===

<SYNTAX WIND OBJECT = V-WIND>
<SYNTAX WIND OBJECT WITH OBJECT (HELD CARRIED) = V-WIND>
<SYNTAX LUBRICATE OBJECT = V-OIL>
<SYNTAX LUBRICATE OBJECT WITH OBJECT (HELD CARRIED) = V-OIL>
<SYNTAX HINT = V-HINTS>
<SYNTAX EASY = V-EASY-TOGGLE>
<SYNONYM HINT HINTS>

<ROUTINE STORAGE-LOFT-LOOK (RARG)
	<COND (<AND <EQUAL? .RARG ,M-LOOK> <FSET? ,TOY-BOX ,OPENBIT>>
		<TELL "In the storage loft, the old cuckoo [[clock]] ">
		<COND (,OLD-TICK-HEARD <TELL "ticks steadily">) (T <TELL "sits silent">)>
		<TELL " above the open [[box]] by the [[cobwebs]] and [[ladder]] back [[down]]." CR>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
    <TELL "Score: " N ,SCORE " of " N ,SCORE-MAX " points, in " N ,MOVES>
    <COND (<1? ,MOVES> <TELL " move.">) (T <TELL " moves.">)>
    <CRLF>
    <TELL "Rank: " <GET ,RANKINGS <+ </ ,SCORE 25> 1>> "." CR>
    <TELL "Companions lending strength: " N ,COMPANION-COUNT "." CR>
    ,SCORE>

<ROUTINE SCORE-OBJ (OBJ "AUX" TEMP)
     <COND (<NOT <FSET? .OBJ ,TOUCHBIT>>
           <COND (<G? <SET TEMP <GETP .OBJ ,P?VALUE>> 0>
                 <SCORE-UPD .TEMP>
                 <PUTP .OBJ ,P?VALUE 0>
                 <FSET .OBJ ,TOUCHBIT>)>)>>

; === ENTRY POINT ===

<ROUTINE GO ()
	<SETG COMPACT-ROOM-LISTS T>
    <SETG HERE ,WORKSHOP-FLOOR>
    <SETG VERBOSE T>
    ;"Pip's pockets hold every toy-sized thing in the book: the base game's
      random “holding too many things” fumble would strand a links-only
      player who cannot guess that dropping something helps."
    <SETG FUMBLE-NUMBER 100>
    <THIS-IS-IT ,KEY-HOOK>
    <SETG LIT T>
    <SETG WINNER ,ADVENTURER>
    <SETG PLAYER ,WINNER>
    <MOVE ,WINNER ,HERE>
    <COND (,TIMER-ACTIVE
           <ENABLE <QUEUE I-TICK 1>>)>
    <ENABLE <QUEUE I-DAWN-WARNING 25>>
    <ENABLE <QUEUE I-NUTMEG-AUTONOMY 8>>
    <V-LOOK>
    <MAIN-LOOP>
    <AGAIN>>

; === CLOCK DAEMONS ===

<ROUTINE I-TICK ()
    <QUEUE I-TICK 1>
    <COND (,GAME-WON <RTRUE>)>
    <COND (<L? ,TICK-COUNT 1>
           <TELL "The sun rises over Wrenfold. The last tick fades into silence. The magic is gone. The workshop is still. Pip stands alone -- but Pip tried. Pip tried." CR>
           <SETG TICK-COUNT 0>
           <JIGS-UP "The dawn has come, and the toys have fallen silent forever.">)
          (T
           <SETG TICK-COUNT <- ,TICK-COUNT 1>>)>
    <RTRUE>>

<ROUTINE I-DAWN-WARNING ()
    <QUEUE I-DAWN-WARNING 25>
    <COND (,GAME-WON <RTRUE>)>
    <COND (<L? ,TICK-COUNT 6>
           <TELL "Sunlight is touching the rooftops of Wrenfold. Pip has minutes, not hours. Hurry!" CR>)
          (<L? ,TICK-COUNT 11>
           <TELL "All over Wrenfold the toys are growing still -- their magic waning. Hurry!" CR>)
          (<L? ,TICK-COUNT 21>
           <TELL "Golden light is creeping over the eastern horizon. Dawn is close now." CR>)
          (<L? ,TICK-COUNT 31>
           <TELL "The sky over Wrenfold shows the first grey hint of approaching dawn." CR>)
          (<L? ,TICK-COUNT 51>
           <TELL "Somewhere a clock chimes, more urgently. Half the night is gone." CR>)
          (<L? ,TICK-COUNT 101>
           <TELL "Somewhere a clock chimes softly. Plenty of night left -- but the hours pass." CR>)>
    <RTRUE>>

<ROUTINE I-NUTMEG-AUTONOMY ()
    <QUEUE I-NUTMEG-AUTONOMY 8>
    <COND (,GAME-WON <RTRUE>)
          (<AND <IN? ,NUTMEG ,FOX-DEN>
                <EQUAL? ,NUTMEG-TRUST 0>>
           <COND (<EQUAL? ,HERE ,FOX-DEN>
                  <TELL "The fox toy shifts in her nest, watching Pip warily." CR>)>)
          (<AND <IN? ,NUTMEG ,FOX-DEN>
                <EQUAL? ,NUTMEG-TRUST 1>>
           <COND (<EQUAL? ,HERE ,FOX-DEN>
                  <TELL "Nutmeg's ears twitch. She seems to be waiting for you to say something." CR>)>)
          (<AND <IN? ,NUTMEG ,FOX-DEN>
                <EQUAL? ,NUTMEG-TRUST 2>>
           <COND (<EQUAL? ,HERE ,FOX-DEN>
                  <TELL "Nutmeg looks at Pip with something almost like hope in her button eyes." CR>)>)
          (<AND <EQUAL? ,NUTMEG-TRUST -1>
                <L? ,NUTMEG-KEY-METHOD 2>>
           <COND (<EQUAL? ,HERE ,FOX-DEN>
                  <TELL "In the corner, Nutmeg's breathing has slowed. She is falling asleep." CR>)>)>
    <RTRUE>>

; === ROOM ACTION ROUTINES ===

<ROUTINE WORKSHOP-FLOOR-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Grandfather's key [[hook]] is empty">
           <COND (<AND <FSET? ,OIL-CAN ,INVISIBLE> <IN? ,OIL-CAN ,WORKSHOP-FLOOR>>
                  <TELL ", but something glints under his [[workbench]] beside the [[loft ladder->loft ladder]].">)
                 (<AND <IN? ,OIL-CAN ,WORKSHOP-FLOOR> <NOT <FSET? ,OIL-CAN ,TOUCHBIT>>>
                  <TELL ", but a copper [[oil can->can]] sits under his [[workbench]] by the [[loft ladder->loft ladder]].">)
                 (T <TELL " above his [[workbench]] beside the [[loft ladder->loft ladder]].">)>
           <COND (,STUDY-ACCESS <TELL " The [[pet door->door]] leads [[north]], the bench lies [[east]], and [[stairs]] behind the open [[clock]] lead [[into the study->in]].">)
                 (T <TELL " The [[pet door->door]] leads [[north]], the tool bench [[east]].">)>
           <CRLF>)>>

<ROUTINE WORKBENCH-TOP-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Among the [[half-finished toys->toys]], Pip can hardly see the floor [[below->down]].">
           <COND (,REPAIR-BOOK-OPEN
                  <TELL " A paper workshop rises from the open [[repair book->book]].">)
                 (T
                  <TELL " Tolliver's [[repair book->book]] rests closed.">)>
           <TELL CR>)>>

<ROUTINE WORKBENCH-DOWN-EXIT ()
    <COND (,REPAIR-BOOK-OPEN
           <TELL "The paper workshop trembles in the open book. Pip cannot leave it balanced like that; the heavy cover must be closed first." CR>
           <RFALSE>)
          (T
           <RETURN ,WORKSHOP-FLOOR>)>>

<ROUTINE SCRAP-YARD-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <COND (<AND <FSET? ,DOLL-HEAD ,INVISIBLE> <IN? ,DOLL-HEAD ,SCRAP-YARD>>
                  <TELL "By the [[track]] from the square [[north]], something pale shows through the snowy [[piles]]">)
                 (<AND <IN? ,DOLL-HEAD ,SCRAP-YARD> <FSET? ,DOLL-HEAD ,NDESCBIT>>
                  <TELL "By the [[track]] from the square [[north]], a porcelain [[doll head->head]] rests on the snowy [[piles]]">)
                 (T <TELL "The [[track]] from the square [[north]] runs between snowy [[piles]]">)>
           <COND (,CART-MOVED <TELL " beside the open [[gate]] to the [[east]]." CR>)
                 (T <TELL " beside the iron [[gate]] blocking the way east." CR>)>)>>

"The doll head lies INVISIBLE in the scrap piles until Pip searches them."

<ROUTINE SCRAP-PILES-F ()
    <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE DIG MOVE LOOK-UNDER>
           <COND (<AND <IN? ,TOY-HORSE ,SCRAP-YARD> <NOT <FSET? ,TOY-HORSE ,TOUCHBIT>>> <TELL "A three-legged [[horse]] lies on its side. ">)>
           <COND (<AND <FSET? ,DOLL-HEAD ,INVISIBLE> <IN? ,DOLL-HEAD ,SCRAP-YARD>>
                  <FCLEAR ,DOLL-HEAD ,INVISIBLE>
                  <THIS-IS-IT ,DOLL-HEAD>
                  <TELL "Pip brushes the snow from the nearest pile. Beneath a tangle of tin and ribbon lies a porcelain [[doll head->head]] with painted eyes." CR>)
                 (T
                  <TELL "Only broken things the cart has not reached yet: tin wheels, a snapped drumstick, a kite with no string." CR>)>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "The piles are far too big for Pip to carry, and frozen together besides." CR>
           <RTRUE>)>>

; === DYNAMIC OBJECT DESCRIPTIONS ===

<ROUTINE BERTRAND-DESC-F (RARG)
    <COND (<EQUAL? .RARG ,M-OBJDESC>
           <COND (,BERTRAND-WOUND
                  <TELL "Captain [[Bertrand]] salutes beside the clear way [[up]]." CR>)
                 (<NOT <IN? ,BERTRAND-KEY ,TOOL-BENCH>>
                  <TELL "A [[nutcracker]] stands frozen on the [[chair seat]]." CR>)
                 (T
                  <TELL "A [[nutcracker]] stands frozen on the [[chair seat]], a [[key->winding key]] in his back." CR>)>
           <RTRUE>)>>

<ROUTINE MARZIPAN-DESC-F (RARG)
    <COND (<EQUAL? .RARG ,M-OBJDESC>
           <COND (,MARZIPAN-BUTTON
                  <TELL "[[Marzipan]] hums, her two mismatched button eyes shining." CR>)
                 (T
                  <TELL "A [[rag doll->ragdoll]] with one [[button eye]] hums." CR>)>
           <RTRUE>)>>

<ROUTINE OLD-TICK-DESC-F (RARG)
    <COND (<EQUAL? .RARG ,M-OBJDESC>
           <COND (<FSET? ,TOY-BOX ,OPENBIT> <RTRUE>)>
           <COND (,OLD-TICK-HEARD
                  <TELL "The old cuckoo [[clock]] ticks steadily." CR>)
                 (T
                  <TELL "An old cuckoo [[clock]] sits silent." CR>)>
           <RTRUE>)>>

<ROUTINE SCRAP-CART-DESC-F (RARG)
    <COND (<EQUAL? .RARG ,M-OBJDESC>
           <COND (,CART-MOVED
                  <TELL "The scrap [[cart]] rests beside the [[track]]." CR>)
                 (T
                  <TELL "A scrap-metal [[cart]] creaks along a rusted [[track]]." CR>)>
           <RTRUE>)>>

<ROUTINE NUTMEG-DESC-F (RARG)
    <COND (<EQUAL? .RARG ,M-OBJDESC>
           <COND (<EQUAL? ,NUTMEG-TRUST -1>
                  <TELL "[[Nutmeg]] curls in the farthest corner with her back to Pip." CR>)
                 (,KEY-FOUND
                  <TELL "[[Nutmeg]] watches Pip with soft button eyes." CR>)
                 (T
                  <TELL "A patchy [[fox]] curls up as the workshop [[key->workshop key]] ticks faintly around her neck." CR>)>
           <RTRUE>)>>

; === V-WIND HANDLER ===

<ROUTINE V-WIND ()
    <COND (<EQUAL? ,PRSO ,BERTRAND>
           <COND (,BERTRAND-WOUND
                  <TELL "Bertrand is already wound -- and rather full of himself because of it." CR>)
                 (<OR <IN? ,BERTRAND-KEY ,WINNER>
                      <IN? ,BERTRAND-KEY ,TOOL-BENCH>>
                  <COND (<IN? ,BERTRAND-KEY ,WINNER>
                         <TELL "Pip inserts the tiny brass key into the nutcracker's back and winds.">)
                        (T
                         <TELL "Pip grips the little wings of the brass key in the nutcracker's back and winds. The key comes away in Pip's hand as the spring takes hold.">)>
                  <TELL " Bertrand's jaw snaps shut with a sharp CLACK, then opens wide. “At last! A proper winding! I have been stuck in this ridiculous pose for hours. Captain Bertrand of the Nutcracker Brigade, at your service!” He clicks his heels and steps aside with a smart salute. The way [[up]] is clear." CR>
                  <SETG BERTRAND-WOUND T>
                  <MOVE ,BERTRAND-KEY ,WINNER>
                  <FCLEAR ,BERTRAND-KEY ,NDESCBIT>)
                 (T
                  <TELL "Bertrand needs his tiny brass winding key, and Pip is not carrying it." CR>)>
           <RTRUE>)
          (<EQUAL? ,PRSO ,CLOCK-WINDING>
           <COND (,TOWER-WOUND
                  <TELL "The clock tower is already wound. Time is flowing as slowly as it can." CR>)
                 (<IN? ,TIN-SOLDIER ,WINNER>
                  <TELL "Pip climbs onto the tin soldier's shoulders and reaches the winding mechanism. With all Pip's strength, the brass wheel turns. The clock tower's ticking slows to a deep, ponderous beat. Time itself stretches, buying precious extra hours." CR>
                  <SETG CLOCK-SLOWED T>
                  <SETG TICK-COUNT <+ ,TICK-COUNT 100>>
                  <SETG TOWER-WOUND T>)
                 (T
                  <TELL "The winding mechanism is just out of reach. Pip needs something tall and sturdy to stand on. Perhaps one of the larger toys could help." CR>)>
           <RTRUE>)
          (<EQUAL? ,PRSO ,OLD-TICK>
           <COND (<NOT ,OLD-TICK-HEARD>
                  <TELL "Pip reaches up and winds the old cuckoo clock. Its hands shudder and begin to move. A tiny wooden bird emerges from its door and chimes: “The hour of reckoning comes. My brother on the workshop wall guards the way, but only the fox knows how to open it.”" CR>
                  <SETG OLD-TICK-HEARD T>
                  <SETG OLD-TICK-RIDDLES <+ ,OLD-TICK-RIDDLES 1>>)
                 (T
                  <TELL "Old Tick chimes again, its wooden bird peering at Pip. “You have wound me twice, small one. Few show such patience. The latch behind me opens my brother downstairs -- but it needs a small paw to reach it. Have you made a fox-friend?”" CR>
                  <SETG OLD-TICK-RIDDLES <+ ,OLD-TICK-RIDDLES 1>>)>
           <RELEASE-STUDY-LATCH>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,MUSIC-BOX>
                <IN? ,MUSIC-BOX ,DISPLAY-CASE>
                <NOT <FSET? ,DISPLAY-CASE ,OPENBIT>>>
           <TELL "The music box sits behind the glass. Pip cannot reach its crank until the case is open." CR>
           <RTRUE>)
          (<EQUAL? ,PRSO ,MUSIC-BOX>
           <TELL "Pip turns the tiny crank on the music box. A soft melody fills the air -- a lullaby Grandfather Tolliver used to hum while he worked. The sound is sweet and sad. For one brief moment, it feels as if he is standing beside Pip." CR>
           <SETG MUSIC-BOX-PLAYED T>
           <RTRUE>)
          (<EQUAL? ,PRSO ,HEART-MECH>
           <COND (<NOT ,KEY-FOUND>
                  <TELL "The heart mechanism is silent. Its keyhole is dark and empty. The workshop key is needed to bring it back to life." CR>)
                 (,KEY-WOUND
                  <TELL "The heart is already turning. Its gears are moving -- but too slowly. It needs companions now, not more winding." CR>)
                 (<NOT <IN? ,WORKSHOP-KEY ,WINNER>>
                  <TELL "Pip must be holding the workshop key to wind the heart." CR>)
                 (T
                  <TELL "Pip inserts the workshop key into the brass keyhole. It fits perfectly -- a click, then a deep shudder runs through the chamber. Gears begin to turn, slowly at first, then faster. The heart is beating." CR>
                   <TELL "But something is still missing. The heart is turning, but it needs more than mechanical power to truly beat. It needs the love the toys carry -- the companions you have made along your journey. Each friend you have helped can lend their strength.">
                   ;"Name what Pip carries that can stand by the heart, so the
                     next step is in the prose and not only in the inventory."
                   <COND (<IN? ,TIN-SOLDIER ,WINNER>
                          <TELL " In Pip's arms the [[tin soldier]] straightens, as if he has heard an order.">)>
                   <COND (<IN? ,MUSIC-BOX ,WINNER>
                          <TELL " The silver [[music box]] gives one soft, hopeful note.">)>
                   <COND (<IN? ,DOLL-ARM ,WINNER>
                          <TELL " The porcelain [[doll arm->porcelain arm]] feels warm in Pip's pocket.">)>
                   <COND (<IN? ,BUTTON ,WINNER>
                          <TELL " The spare [[button->spare button]] grows warm too.">)>
                   <CRLF>
                   <SETG KEY-WOUND T>
                   <MOVE ,WORKSHOP-KEY ,WORKSHOP-HEART>
                   <FCLEAR ,WORKSHOP-KEY ,TAKEBIT>
                   <FSET ,WORKSHOP-KEY ,NDESCBIT>
                   <SCORE-UPD 5>
                   <THIS-IS-IT ,HEART-MECH>)>
           <RTRUE>)
           (T
            <TELL "There is nothing to wind there." CR>)>>

; === V-OIL HANDLER ===

<ROUTINE V-OIL ()
    <COND (<EQUAL? ,PRSO ,LADDER-MECH>
           <COND (,LADDER-OILED
                  <TELL "The mechanism is already well-oiled and working smoothly." CR>)
                 (<IN? ,OIL-CAN ,WINNER>
                  <TELL "Pip works oil from the tiny copper can into the rusty joints. With a satisfying creak, the mechanism loosens. The folding loft ladder can rise now." CR>
                  <SETG LADDER-OILED T>
                  <SCORE-UPD 5>)
                 (T
                  <TELL "The mechanism needs oil. An oil can may be waiting somewhere in the workshop." CR>)>
           <RTRUE>)
          (<EQUAL? ,PRSO ,LOFT-LADDER>
           <COND (,LADDER-OILED
                  <TELL "The folding loft ladder is already working smoothly." CR>)
                 (<IN? ,OIL-CAN ,WINNER>
                  <TELL "Pip oils the folding ladder's lifting mechanism. It loosens with a satisfying creak." CR>
                  <SETG LADDER-OILED T>
                  <SCORE-UPD 5>)
                 (T
                  <TELL "The iron needs oil. The workbench may be hiding a can." CR>)>
           <RTRUE>)
           (T
            <TELL "That does not need oiling." CR>)>>

; === V-HINTS HANDLER ===

<ROUTINE V-HINTS ()
    <COND (<AND <EQUAL? ,HERE ,FOX-DEN>
                <NOT ,KEY-FOUND>
                <NOT <EQUAL? ,NUTMEG-TRUST -1>>>
           <COND (<L? ,HINT-LEVEL 4>
                  <SETG HINT-LEVEL <+ ,HINT-LEVEL 1>>)>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "The fox has been alone a very long time. She needs kindness, not demands." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "Try giving her something -- the red scarf from the mailbox corner, or tell her about Tolliver." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "Gifts and kind words build trust. She needs to know someone cares." CR>)
                 (T <TELL "GIVE SCARF TO FOX. TELL FOX ABOUT TOLLIVER. Then ask her for the key." CR>)>
           <RTRUE>)
          (<AND <EQUAL? ,HERE ,SCRAP-YARD>
                <NOT ,CART-MOVED>>
           <COND (<L? ,HINT-LEVEL 4>
                  <SETG HINT-LEVEL <+ ,HINT-LEVEL 1>>)>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "The cart is not hostile. Look at it more carefully." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "The cart carries broken toys. One doll is missing its head. Search the piles." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "Give the doll head to the cart. Show compassion, not force." CR>)
                 (T <TELL "TAKE DOLL HEAD. GIVE HEAD TO CART." CR>)>
           <RTRUE>)
          (<AND ,KEY-FOUND
                <NOT ,STUDY-ACCESS>>
           <COND (<L? ,HINT-LEVEL 4>
                  <SETG HINT-LEVEL <+ ,HINT-LEVEL 1>>)>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "Now that you have the key, the cuckoo clock seems different. Try interacting with it." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "Old Tick on the wall spoke of something behind him." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "Wind Old Tick in the workshop. Nutmeg or the tin soldier can reach the hidden latch." CR>)
                 (T <TELL "WIND CLOCK in the workshop. A small paw or the tin soldier's bayonet can reach the latch behind it." CR>)>
           <RTRUE>)
          (,KEY-WOUND
           <COND (<L? ,HINT-LEVEL 4>
                  <SETG HINT-LEVEL <+ ,HINT-LEVEL 1>>)>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "The heart is turning, but it needs more than mechanical power." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "The toys you have helped can lend their strength." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "Place your companions around the heart. Each one adds their love to the magic." CR>)
                 (T <TELL "POSITION TIN SOLDIER. POSITION MUSIC BOX. Nutmeg and Bertrand will help if you were kind to them." CR>)>
           <RTRUE>)
          (<NOT ,BERTRAND-WOUND>
           <COND (<L? ,HINT-LEVEL 4>
                  <SETG HINT-LEVEL <+ ,HINT-LEVEL 1>>)>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "That nutcracker is blocking the way. He looks... stuck." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "Examine the nutcracker closely. He has something in his back." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "Take the winding key from his back, then wind him up." CR>)
                 (T <TELL "TAKE KEY. WIND NUTCRACKER." CR>)>
           <RTRUE>)
          (<NOT ,LADDER-OILED>
           <COND (<L? ,HINT-LEVEL 4>
                  <SETG HINT-LEVEL <+ ,HINT-LEVEL 1>>)>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "The folding loft ladder will not rise. Something is rusted." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "The lifting mechanism needs oil. Search under the workbench." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "Take the oil can from under the workbench, then oil the mechanism." CR>)
                 (T <TELL "LOOK UNDER WORKBENCH. TAKE OIL CAN. OIL MECHANISM." CR>)>
           <RTRUE>)
            (T
             <TELL "The workshop feels different tonight. The key hook on the wall is empty -- its magic gone. Something is wrong. You should investigate." CR>)>>

; === V-EASY-TOGGLE HANDLER ===

<ROUTINE V-EASY-TOGGLE ()
    <SETG TIMER-ACTIVE <>>
    <DISABLE <QUEUE I-TICK>>
    <DISABLE <QUEUE I-DAWN-WARNING>>
    <TELL "The dawn countdown has been disabled. Explore Wrenfold at your own pace. You can type EASY again to re-enable it if you wish." CR>>

; === WORKSHOP-FLOOR OBJECT HANDLERS ===

<ROUTINE KEY-HOOK-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The brass key hook on the wall holds no key.">
           <COND (<AND <IN? ,KEY-STRING ,WORKSHOP-FLOOR> <NOT <FSET? ,KEY-STRING ,TOUCHBIT>>>
                  <TELL " Only a frayed [[string]] dangles from it.">)>
           <TELL " The hook itself is cold -- no magic left in it at all." CR>)
           (<VERB? TAKE>
            <TELL "The hook is fixed firmly to the wall.">
            <COND (<AND <IN? ,KEY-STRING ,WORKSHOP-FLOOR> <NOT <FSET? ,KEY-STRING ,TOUCHBIT>>>
                   <TELL " But the [[string]] dangling from it looks like it might come free.">)>
            <CRLF>)>>

<ROUTINE WORKBENCH-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE LOOK-UNDER SEARCH>
           <COND (<VERB? LOOK-UNDER>
                  <TELL "Pip peers under the workbench.">)
                 (T
                  <TELL "Tiny tools and half-finished toys crowd the workbench.">)>
           <COND (<AND <EQUAL? ,HERE ,WORKSHOP-FLOOR> <IN? ,SWEEP-BROOM ,WORKSHOP-FLOOR> <NOT <FSET? ,SWEEP-BROOM ,TOUCHBIT>>>
                  <TELL " Pip's [[broom]] leans against one leg in the [[sawdust]].">)>
           <COND (<AND <EQUAL? ,HERE ,WORKSHOP-FLOOR> <IN? ,OIL-CAN ,WORKSHOP-FLOOR> <NOT <FSET? ,OIL-CAN ,TOUCHBIT>>>
                  <FCLEAR ,OIL-CAN ,INVISIBLE>
                  <THIS-IS-IT ,OIL-CAN>
                  <TELL " Underneath, in the shadows, sits a tiny copper [[oil can->can]].">)
                 (<VERB? LOOK-UNDER>
                  <TELL " There is nothing else under it.">)>
           <CRLF>
           <RTRUE>)
          (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,WORKBENCH>>
           <TELL "The workbench top is far above Pip's head. Nothing can be set on it from down here." CR>
           <RTRUE>)
          (<VERB? CLIMB CLIMB-FOO CLIMB-UP>
           <TELL "Pip scrambles up the carved workbench leg, using drawer handles and wooden joints as footholds. At last one hand catches the tabletop. Pip swings over the edge and lands among curls of cedar shavings." CR>
           <GOTO ,WORKBENCH-TOP>
           <RTRUE>)>>

<ROUTINE OIL-CAN-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A tiny copper oil can, no bigger than Pip's thumb. It is about half full. The label reads: “Tolliver's Finest -- For Squeaks and Stiff Joints.”" CR>)
          (<VERB? SHAKE>
           <TELL "Pip shakes the can gently. Oil sloshes inside -- enough for a few uses." CR>)>>

<ROUTINE SAWDUST-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Soft golden sawdust covers the floorboards. It smells of cedar and old wood. Pip would sweep it on any other night, but tonight there are more important things." CR>)
          (<VERB? TAKE>
           <TELL "The sawdust slips through Pip's fingers. There is not enough to carry." CR>)>>

<ROUTINE PET-DOOR-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A small pet door is cut into the bottom of the workshop's main door. It is just the right size for a workshop gnome -- or a fox toy. Moonlight and cold air seep through the flap." CR>)
          (<VERB? OPEN>
           <TELL "The pet door flap swings freely. It is just wide enough for Pip to slip into the snowy night." CR>)>>

<ROUTINE SWEEP-BROOM-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Pip's tiny broom has worn bristles and a handle smooth from use. It was one of the first things Tolliver ever made for his apprentice." CR>)>>

<ROUTINE CLOCK-FACE-F ()
    <COND (<VERB? THROUGH CLIMB-FOO CLIMB-UP>
           <COND (,STUDY-ACCESS
                  <TELL "Pip slips behind the open clock and climbs the narrow staircase." CR>
                  <GOTO ,TOLLIVER-STUDY>)
                 (T
                  <TELL "The clock sits flush against the wall. There is no way behind it yet." CR>)>
           <RTRUE>)
          (<VERB? EXAMINE>
           <TELL "An old cuckoo clock hangs on the workshop wall. It ticks softly -- a steady, reassuring sound. The hands show it is nearly midnight.">
           <COND (<AND ,KEY-FOUND <NOT ,STUDY-ACCESS>>
                  <TELL " Now that Pip has the key, the clock seems to tick with more urgency. Its twin in the loft may know how to release it.">)>
           <COND (,STUDY-ACCESS
                  <TELL " The clock has swung open, revealing a narrow staircase leading [[into the study->in]].">)>
           <TELL CR>)
          (<VERB? LISTEN>
           <TELL "Pip presses an ear to the clock. Tick, tick, tick -- steady as a heartbeat. Beneath it comes another rhythm, deeper and farther away, like a second heart below the workshop." CR>)>>

<ROUTINE KEY-STRING-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A frayed piece of string, once used to hang the workshop key. The ends are chewed -- by small sharp teeth, from the look of it." CR>)>>

<ROUTINE LOFT-LADDER-F ()
    <COND (<VERB? CLIMB CLIMB-FOO CLIMB-UP>
           <COND (,LADDER-OILED
                  <TELL "Pip raises the folding ladder and climbs its broad wooden rungs into the loft." CR>
                  <GOTO ,STORAGE-LOFT>)
                 (T
                  <TELL "The ladder will not rise. Its rusty lifting mechanism needs oil first." CR>)>
           <RTRUE>)
          (<VERB? OIL> <V-OIL>)
          (<VERB? EXAMINE>
           <COND (,LADDER-OILED
                  <TELL "A folding wooden ladder with broad, Pip-sized rungs. With its [[mechanism]] oiled, it rises smoothly past the cuckoo [[clock]] to the storage loft." CR>)
                  (T
                   <TELL "The ladder folds against the wall beneath the cuckoo [[clock]]. Its lifting [[mechanism]] is rusted solid. A drop of oil might free it." CR>)>)>>

<ROUTINE LADDER-MECH-F ()
    <COND (<VERB? OIL> <V-OIL>)
          (<VERB? EXAMINE>
           <COND (,LADDER-OILED
                  <TELL "The iron lifting mechanism is well-oiled now. It moves freely, allowing the loft ladder to rise." CR>)
                 (T
                  <TELL "The rusty iron lifting mechanism is frozen with rust. It needs oil -- badly." CR>)>
           <RTRUE>)
          (<VERB? TURN>
           <COND (,LADDER-OILED
                  <TELL "The mechanism turns smoothly under Pip's hands. The folding ladder rises toward the loft." CR>)
                 (T
                  <TELL "Pip strains against the mechanism, but it is rusted solid. The iron needs oil first." CR>)>
           <RTRUE>)>>

; === TOOL-BENCH OBJECT HANDLERS ===

"What Pip can show a toy to ask about Grandfather Tolliver: his name, his
coat, and the pages in his handwriting."

<ROUTINE TOLLIVER-TOPIC? (OBJ)
    <OR <EQUAL? .OBJ ,TOPIC-TOLLIVER ,TOLLIVER-COAT ,LETTER>
        <EQUAL? .OBJ ,TOLLIVER-JOURNAL ,STUDY-JOURNAL>>>

<ROUTINE BERTRAND-F ()
    <COND (<VERB? WIND> <V-WIND>)
          (<VERB? EXAMINE>
           <COND (,BERTRAND-WOUND
                  <TELL "Captain Bertrand of the Nutcracker Brigade stands at attention, positively radiating self-importance. His jaw, now fully operational, is clamped in what he probably considers a dignified expression. The way to the countertop is clear." CR>)
                 (T
                  <TELL "A painted wooden nutcracker stands frozen mid-stride, one foot raised. His jaw is clamped tight -- whether in a grimace or a smile, it is hard to say.">
                  <COND (<IN? ,BERTRAND-KEY ,TOOL-BENCH>
                         <TELL " There is a tiny brass winding [[key->winding key]] in his back.">)
                        (T
                         <TELL " The winding socket in his back is empty.">)>
                  <CRLF>)>)
          (<VERB? PUSH>
           <COND (,BERTRAND-WOUND
                  <TELL "Captain Bertrand does not appreciate being pushed. He glares at Pip but steps aside anyway." CR>)
                 (T
                  <TELL "Bertrand is far too heavy to push. Besides, Pip would never want to be rude to a nutcracker." CR>)>)
          (<VERB? TALK-TO ASK TELL>
           <COND (,BERTRAND-WOUND
                  <COND (<OR <EQUAL? ,PRSI ,WORKSHOP-KEY ,TOPIC-KEY> <EQUAL? ,PRSI ,KEY-HOOK ,KEY-STRING>>
                         <TELL "“The master's key? Gone from its hook, I noticed. Most irregular. I would have investigated myself, but...” He gestures at his wooden legs. “Limited mobility, I am afraid.”" CR>)
                        (<EQUAL? ,PRSI ,BERTRAND-KEY>
                         <TELL "“My winding key! Keep it safe, small apprentice. A captain is only as good as his spring, and the Grandfather is not here to wind me at six.”" CR>)
                        (<TOLLIVER-TOPIC? ,PRSI>
                         <TELL "“The Grandfather? Finest toymaker in three counties. He wound me himself, every evening at six.” His voice softens. “He has not come down tonight. I am... concerned.”" CR>)
                        (T
                         <TELL "“I am Captain Bertrand of the Nutcracker Brigade. State your business, small apprentice.” He salutes, then tips his painted hat toward the stacked books. “The countertop is open for inspection.”" CR>)>)
                  (T
                   <TELL "His painted mouth stays clamped shut. He looks like he has plenty to say, if only someone would wind him up." CR>)>)>>

<ROUTINE BERTRAND-KEY-F ()
    <COND (<VERB? SPIN>
           <COND (<AND <EQUAL? ,HERE ,TOOL-BENCH> <IN? ,BERTRAND ,TOOL-BENCH>> <PERFORM ,V?WIND ,BERTRAND>)
                 (T <TELL "Pip rolls the key between two fingers. Its square tip fits the socket in Bertrand’s back." CR>)>)
          (<VERB? EXAMINE>
           <COND (<IN? ,BERTRAND-KEY ,TOOL-BENCH>
                  <TELL "A tiny brass winding key protrudes from the nutcracker's back. Its little wings are made for Pip's fingers; one good winding would wake the captain." CR>)
                  (T
                   <TELL "A tiny brass winding key. It is the exact size for winding a nutcracker -- or any other clockwork toy." CR>)>)>>

<ROUTINE VARNISH-POT-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE>
           <TELL "A pot of varnish, left open. The contents have gone thick and tacky -- useless for fine work now. The smell is faintly sweet and chemical." CR>)
          (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,VARNISH-POT>>
           <TELL "Anything dropped into that tacky varnish would never come out clean. Pip thinks better of it." CR>
           <RTRUE>)>>

<ROUTINE TOOL-RACK-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Grandfather cut a notch for each tool.">
           <COND (<AND <IN? ,TOY-CHISELS ,TOOL-BENCH> <FSET? ,TOY-CHISELS ,NDESCBIT>> <TELL " Tiny [[chisels]] hang in a row.">)>
           <COND (<AND <IN? ,TOY-FILES ,TOOL-BENCH> <FSET? ,TOY-FILES ,NDESCBIT>> <TELL " The [[needle-files]] share one notch.">)>
           <COND (<AND <IN? ,DETAIL-HAMMER ,TOOL-BENCH> <FSET? ,DETAIL-HAMMER ,NDESCBIT>> <TELL " A jeweller's [[hammer]] hangs by its head.">)>
           <TELL " An open [[varnish pot->pot]] stands beneath the rack." CR>)>>

<ROUTINE MAKESHIFT-STEPS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A low packing crate makes the first step. From there Pip can reach the seat of an old chair, then climb three broad repair books stacked flat against its back. The final step reaches the countertop without wobbling or overhang.">
           <COND (<NOT ,BERTRAND-WOUND>
                  <TELL " The frozen nutcracker stands squarely in the middle of the chair seat.">)>
           <CRLF>
           <RTRUE>)
          (<VERB? CLIMB CLIMB-FOO CLIMB-UP>
           <COND (,BERTRAND-WOUND
                  <TELL "Pip climbs from crate to chair, steps carefully up the broad books, and pulls onto the countertop." CR>
                  <GOTO ,COUNTERTOP>)
                 (T
                  <TELL "Captain Bertrand's frozen wooden boots block the chair seat. Pip cannot reach the books until he moves." CR>)>
           <RTRUE>)>>
; === WORKBENCH TOP OBJECT HANDLERS ===

<ROUTINE REPAIR-BOOK-F ()
    <COND (<VERB? EXAMINE>
           <COND (,REPAIR-BOOK-OPEN
                  <TELL "The open book is a miniature workshop made from paper: gears, stairs, benches, and doors all folded into one another. A mouse with an oil can stands beside a pencilled path that winds toward a second heart beneath the floor." CR>)
                 (T
                  <TELL "An enormous green leather book with battered brass corners. Grandfather Tolliver stamped a tiny gear and paintbrush into the cover. Pip has seen him sketch repairs in it, but never opened it alone." CR>)>
           <RTRUE>)
          (<AND <VERB? READ LOOK-INSIDE> ,REPAIR-BOOK-OPEN>
           <TELL "Pip reads the margin again. Beside the mouse with the oil can, Grandfather has written: “When the workshop loses its way, follow the ticking beneath the ticking.”" CR>
           <RTRUE>)
          (<VERB? OPEN READ LOOK-INSIDE>
           <COND (,REPAIR-BOOK-OPEN
                  <TELL "The repair book is already open to Tolliver's paper workshop." CR>)
                 (T
                  <TELL "Pip plants both boots against the book and heaves. The wooden cover opens with a breath of cedar dust. Pages spring upright in little paper gears and staircases. In the margin, Grandfather has drawn a mouse no bigger than Pip, holding an oil can high like a lantern. Beneath it he has written: “When the workshop loses its way, follow the ticking beneath the ticking.”" CR>
                  <SETG REPAIR-BOOK-OPEN T>
                  <FSET ,REPAIR-BOOK ,OPENBIT>
                  <SCORE-UPD 2>)>
           <RTRUE>)
          (<VERB? CLOSE>
           <COND (,REPAIR-BOOK-OPEN
                  <TELL "Pip lowers the heavy cover. The paper workshop folds itself quietly between the pages." CR>
                  <SETG REPAIR-BOOK-OPEN <>>
                  <FCLEAR ,REPAIR-BOOK ,OPENBIT>)
                 (T
                  <TELL "The repair book is already closed." CR>)>
           <RTRUE>)>>

<ROUTINE HALF-FINISHED-TOYS-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE>
           <TELL "Pip walks between Grandfather's unfinished inventions: a [[sailboat]] waiting for its mast, a [[train->wooden train]] with careful red wheels, and a [[wooden duck]] whose missing wheel leaves it tilted as if listening. Nothing here is discarded. Everything is waiting for Tolliver to return." CR>
           <RTRUE>)>>
; === COUNTERTOP OBJECT HANDLERS ===

<ROUTINE MARZIPAN-F ()
    <COND (<VERB? EXAMINE>
           <COND (,MARZIPAN-BUTTON
                  <TELL "The rag doll -- Marzipan -- now has both button eyes. They are mismatched, but somehow that makes her expression warmer. She hums softly, a tune full of secrets." CR>)
                 (T
                  <TELL "A rag doll with one button eye and a stitched smile. Her fabric is patched in places, but she is carefully mended -- Tolliver's handiwork. She hums a soft, meandering tune.">
                  <COND (<AND <IN? ,BUTTON ,COUNTERTOP> <NOT <FSET? ,BUTTON ,TOUCHBIT>>> <TELL " A spare [[button]] lies by her foot.">)>
                  <CRLF>)>)
          (<VERB? ASK TELL>
           <COND (,MARZIPAN-BUTTON
                  <COND (<EQUAL? ,PRSI ,NUTMEG ,TOPIC-FOX ,FOOTPRINTS>
                         <TELL "Marzipan sings: “Foxy, foxy, all alone / Colder than a stepping stone / Give her something warm and red / And she might trust a word you have said.”" CR>)
                        (<OR <EQUAL? ,PRSI ,WORKSHOP-KEY ,TOPIC-KEY> <EQUAL? ,PRSI ,KEY-HOOK ,KEY-STRING>>
                         <TELL "She tilts her head and sings: “The key that ticks, the key that tocks / Gone with fox through snowy blocks / Through the door where cold winds blow / That is where you need to go.”" CR>)
                        (T
                         <TELL "Marzipan looks at you with both eyes now. She sings: “Behind the ticking, ticking clock / A door that needs no key or lock / But small paws only fit the crack / To push the hidden latch way back.”" CR>)>)
                  (T
                   <TELL "Marzipan tilts her head and sings: “Fox feet, fox feet, left the shop / Through the door with a hop and a hop / Key round neck and heart so sore / Find her where the broken toys snore.”" CR>)>)>>

<ROUTINE DISPLAY-CASE-F ()
    <COND (<VERB? EXAMINE>
           <COND (<FSET? ,DISPLAY-CASE ,OPENBIT>
                  <TELL "The glass display case is open.">
                  <COND (<OR <IN? ,TIN-SOLDIER ,DISPLAY-CASE> <IN? ,MUSIC-BOX ,DISPLAY-CASE>>
                         <TELL " Inside, you can see">
                         <COND (<IN? ,TIN-SOLDIER ,DISPLAY-CASE> <TELL " a brave [[tin soldier->soldier]]">)>
                         <COND (<AND <IN? ,TIN-SOLDIER ,DISPLAY-CASE> <IN? ,MUSIC-BOX ,DISPLAY-CASE>> <TELL " and">)>
                         <COND (<IN? ,MUSIC-BOX ,DISPLAY-CASE> <TELL " a silver [[music box->box]]">)>
                         <TELL ".">)
                        (T
                         <TELL " It is empty.">)>
                  <TELL CR>)
                 (T
                  <TELL "A dusty glass display case.">
                  <COND (<OR <IN? ,TIN-SOLDIER ,DISPLAY-CASE> <IN? ,MUSIC-BOX ,DISPLAY-CASE>>
                         <TELL " Through the glass, you can see">
                         <COND (<IN? ,TIN-SOLDIER ,DISPLAY-CASE> <TELL " a [[tin soldier->soldier]]">)>
                         <COND (<AND <IN? ,TIN-SOLDIER ,DISPLAY-CASE> <IN? ,MUSIC-BOX ,DISPLAY-CASE>> <TELL " and">)>
                         <COND (<IN? ,MUSIC-BOX ,DISPLAY-CASE> <TELL " a silver [[music box->box]]">)>
                         <TELL ".">)>
                  <TELL " The case has a small [[brass latch]]." CR>)>)
          (<AND <VERB? OPEN>
                <NOT <FSET? ,DISPLAY-CASE ,OPENBIT>>>
           <FSET ,DISPLAY-CASE ,OPENBIT>
           <TELL "Pip opens the display case.">
           <COND (<IN? ,TIN-SOLDIER ,DISPLAY-CASE> <TELL " The [[tin soldier->soldier]] stands at attention.">)>
           <COND (<IN? ,MUSIC-BOX ,DISPLAY-CASE> <TELL " The silver [[music box->box]] is within reach.">)>
           <CRLF>
           <RTRUE>)
           (<AND <VERB? OPEN>
                 <FSET? ,DISPLAY-CASE ,OPENBIT>>
           <TELL "The display case is already open." CR>
           <RTRUE>)>>

<ROUTINE TIN-SOLDIER-F ()
    <COND (<VERB? PLACE-HEART> <V-PLACE-HEART>)
          (<VERB? EXAMINE>
           <TELL "A brave tin soldier, painted in bright red and blue. There is a spot of rust on his bayonet, but his painted eyes are steady. He stands at attention, as if waiting for orders." CR>)>>

<ROUTINE MUSIC-BOX-F ()
    <COND (<VERB? SPIN> <V-WIND>)
          (<VERB? WIND> <V-WIND>)
          (<VERB? PLACE-HEART> <V-PLACE-HEART>)
          (<VERB? EXAMINE>
           <COND (<AND <IN? ,MUSIC-BOX ,WORKSHOP-HEART> <NOT <FSET? ,MUSIC-BOX ,TAKEBIT>>>
                  <TELL "Pip watches the crank go round all by itself. Each time the heart ticks, a little [[brass tooth]] plucks the next note." CR>)
                 (,MUSIC-BOX-PLAYED
                  <TELL "A silver music box. Its crank has been turned recently, and the echo of its melody still seems to linger." CR>)
                  (T
                   <TELL "A small silver music box with a tiny crank on its side. It looks like it would play a tune if wound." CR>)>)>>

<ROUTINE SHOP-WINDOW-F ()
    <COND (<VERB? EXAMINE LOOK-THROUGH>
           <TELL "Through the frosted shop window, Pip can see the snowy street outside. The clock tower's face is pale in the moonlight, and the snow is deeper than Pip is tall.">
           <COND (<L? ,TICK-COUNT 31>
                  <TELL " The sky is noticeably lighter now. Dawn is approaching.">)>
           <TELL CR>)>>

<ROUTINE TOY-BUTTON-F ()
    <COND (<VERB? GIVE-TO> <V-GIVE-TO>)
          (<VERB? PLACE-HEART> <V-PLACE-HEART>)
          (<VERB? EXAMINE>
           <TELL "A spare black button, just the right size for a doll's missing eye. It is smooth and slightly warm, as if someone has been holding it." CR>)>>

; === STORAGE-LOFT OBJECT HANDLERS ===

<ROUTINE RELEASE-STUDY-LATCH ()
    <COND (,STUDY-ACCESS <RFALSE>)
          (<G? ,NUTMEG-TRUST 0>
           <TELL "Suddenly, Nutmeg pads forward from the shadows. “I can reach it,” she says quietly. “I know the way. I followed him once -- the old man -- when he went upstairs.” She slips behind Old Tick and reaches for a hidden latch. A soft click answers from below. “The other clock,” she whispers. “On the workshop floor. It has swung open. The study stairs are behind it. That is where he went.”" CR>
           <SETG STUDY-ACCESS T>
           <SCORE-UPD 5> <RTRUE>)
          (<AND <EQUAL? ,NUTMEG-TRUST -1>
                <IN? ,TIN-SOLDIER ,WINNER>>
           <TELL "Without Nutmeg's help, Pip improvises. The tin soldier's bayonet hooks the latch behind Old Tick. A click answers from the workshop floor below: the other clock has swung open, revealing the study stairs." CR>
           <SETG STUDY-ACCESS T>
           <SCORE-UPD 5> <RTRUE>)>>

<ROUTINE OLD-TICK-F ()
    <COND (<VERB? OPEN PUSH>
           <COND (,STUDY-ACCESS <TELL "The latch is up. The study stairs are open behind the other clock downstairs." CR>)
                 (<AND ,OLD-TICK-HEARD <RELEASE-STUDY-LATCH>> <RTRUE>)
                 (<NOT ,OLD-TICK-HEARD> <TELL "The bird is asleep behind its door. Wind Old Tick to wake it." CR>)
                 (T <TELL "Pip slips a hand behind the clock. The gap is too narrow to reach the latch. A little fox paw might fit." CR>)>)
          (<VERB? WIND SPIN> <V-WIND>)
          (<VERB? EXAMINE>
           <COND (,OLD-TICK-HEARD
                  <TELL "The old cuckoo clock is awake now. Its hands move steadily, and the little wooden bird peers out from its door with bright painted eyes. It has the air of something very old and very patient." CR>)
                 (T
                  <TELL "An old cuckoo clock, the twin of the one downstairs. It is dusty and still, its hands frozen at five to midnight. Odd -- it seems to be waiting for Pip to do something." CR>)>)
           (<VERB? ASK TELL>
            <COND (<AND ,OLD-TICK-HEARD
                        <TOLLIVER-TOPIC? ,PRSI>>
                   <TELL "Old Tick's wooden bird tilts its head. “The toymaker? Ah. He visited me every night at midnight. Wound me with care, always with that little smile. He said I was his oldest friend. The night he disappeared, he came up here earlier than usual. He was worried -- said the key was losing power, that he needed to mend the heart himself. He took nothing with him. Not his coat. Not his tea. I have not seen him since.”" CR>)
                  (<AND ,OLD-TICK-HEARD <NOT ,STUDY-ACCESS>>
                   <TELL "Old Tick's bird leans out. “A little more winding, Pip. My latch is stiff, and my fox-friend must hear me call. Wind me again when you have earned her trust.”" CR>)
                  (,OLD-TICK-HEARD
                   <TELL "Old Tick's wooden bird emerges. “The answers you seek are already in your pockets, small one. The key, the friends, the heart -- you have everything you need. Now use it.”" CR>)
                  (T
                   <TELL "The clock remains silent. It seems to be waiting for a more... mechanical form of attention." CR>)>)
          (<VERB? LISTEN>
           <COND (,OLD-TICK-HEARD
                  <TELL "Pip listens. The clock ticks with a deep, resonant tone -- almost like a heartbeat. Beneath it comes the distant echo of another mechanism, somewhere below." CR>)
                 (T
                  <TELL "Pip presses an ear to the old clock. Silence. But then -- was that a faint tick? It is hard to tell. The clock seems to need winding before it will speak." CR>)>)>>

<ROUTINE TOY-BOX-F ()
    <COND (<VERB? EXAMINE>
           <COND (<AND <IN? ,TOLLIVER-JOURNAL ,STORAGE-LOFT> <NOT <FSET? ,TOLLIVER-JOURNAL ,TOUCHBIT>>> <TELL "A leather [[journal]] lies beside the box. ">)>
           <COND (<FSET? ,TOY-BOX ,OPENBIT>
                  <TELL "A dusty cardboard box labelled “Broken -- For Repair”. It is open.">
                  <COND (<IN? ,DOLL-ARM ,TOY-BOX>
                         <TELL " Inside, a [[porcelain doll arm->arm]] lies among other broken pieces.">)>
                  <TELL CR>)
                 (T
                  <TELL "A dusty cardboard box labelled “Broken -- For Repair”. The flaps are tucked shut." CR>)>)
           (<AND <VERB? OPEN>
                 <NOT <FSET? ,TOY-BOX ,OPENBIT>>>
            <TELL "Pip opens the cardboard box. Inside are broken toy parts: a [[porcelain doll arm->arm]], a wooden wheel, and some springs. Tolliver always meant to fix them." CR>
            <FSET ,TOY-BOX ,OPENBIT>
            <RTRUE>)
           (<AND <VERB? OPEN>
                 <FSET? ,TOY-BOX ,OPENBIT>>
            <TELL "The box is already open." CR>
            <RTRUE>)>>

<ROUTINE DOLL-ARM-F ()
    <COND (<VERB? PLACE-HEART> <V-PLACE-HEART>)
          (<VERB? EXAMINE>
           <TELL "A delicate porcelain doll arm from Tolliver's repair box. The fingers are curled gently, as if reaching for something. He kept even this little broken piece; it was still worth saving." CR>)>>

<ROUTINE TOLLIVER-JOURNAL-F ()
    <COND (<VERB? READ EXAMINE>
           <COND (<NOT ,JOURNAL-READ>
                  <SETG JOURNAL-READ T>
                  <SCORE-UPD 3>)>
           <TELL "You open the leather journal. Tolliver's handwriting is neat but growing shakier with each entry. October 14th -- “The workshop key grows weaker. I must wind it more often now. The magic in this town depends on it.” October 20th -- “Old Tick tells me the heart needs attention. I will see to it tonight.” October 21st -- “I could not reach the heart alone. Something blocks the way. I must find another path. The toys need me. Pip needs me.” The rest of the pages are blank." CR>)>>

<ROUTINE COBWEBS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Dusty cobwebs drape the rafters like grey curtains. They have been here a long time -- nothing disturbs the dust up here. Or almost nothing." CR>)>>

; === SNOWY-ALLEY OBJECT HANDLERS ===

<ROUTINE FOOTPRINTS-F ()
    <COND (<VERB? FOLLOW>
           <COND (<EQUAL? ,HERE ,MAILBOX-CORNER> <DO-WALK ,P?WEST>)
                 (T <DO-WALK ,P?EAST>)>)
          (<VERB? EXAMINE>
           <COND (<EQUAL? ,HERE ,MAILBOX-CORNER>
                  <TELL "Two tracks overlap here. The little fox came to the post, turned, and put a paw almost exactly in her own print going back [[west]]. From there, they lead south toward the scrap-yard." CR>)
                 (T
                  <TELL "Tiny fox footprints in the snow -- unmistakably toy-sized. They lead [[east]] through the alley, toward the clock square. Someone small and fast came this way, and not long ago." CR>)>)>>

<ROUTINE STREETLAMP-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A streetlamp -- really a toy lantern mounted on a pole. Its flame flickers weakly, but it still casts a warm circle of light on the snow. Someone cared enough to keep it lit." CR>)
          (<VERB? LAMP-ON>
           <TELL "The streetlamp is already lit. Its flame has been burning a long time." CR>)>>

<ROUTINE SNOW-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Fresh snow blankets the cobblestones. It sparkles around the fox footprints, and its cold reaches even through Pip's woollen clothes." CR>)
          (<VERB? TAKE>
           <TELL "The snow melts in Pip's tiny hands. There is no useful way to carry it." CR>)>>

; === CLOCK-SQUARE OBJECT HANDLERS ===

<ROUTINE CLOCK-TOWER-F ()
    <COND (<VERB? EXAMINE>
           <COND (,TOWER-WOUND
                  <TELL "The clock tower stands over the square, its great face now ticking with a slow, steady beat. Time feels stretched -- Pip has bought precious extra hours." CR>)
                  (T
                   <TELL "The giant clock tower dominates the square. Its face shows the hours until dawn -- each tick of its great hand a reminder that time is running out. A brass winding mechanism sits at the base, too high for Pip to reach alone." CR>)>)>>

<ROUTINE CLOCK-WINDING-DESC-F (RARG)
    <COND (<EQUAL? .RARG ,M-OBJDESC>
           <COND (,TOWER-WOUND
                  <TELL "The brass winding [[mechanism]] at the clock tower's base turns with a slow, deliberate rhythm." CR>)
                 (T
                  <TELL "At its base the winding [[mechanism]] is just out of reach." CR>)>
           <RTRUE>)>>

<ROUTINE CLOCK-WINDING-F ()
    <COND (<VERB? SPIN> <V-WIND>)
          (<VERB? WIND> <V-WIND>)
          (<VERB? EXAMINE>
           <COND (,TOWER-WOUND
                  <TELL "A small wheel catches a tooth, lifts it, and lets it drop. That little drop makes the tick Pip hears from the square." CR>)
                  (T
                   <TELL "A brass winding mechanism at the tower's base. It is just out of reach -- Pip needs something to stand on." CR>)>)>>

<ROUTINE BAKER-TOY-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A wooden baker toy stands in the bakery window, frozen in the act of kneading dough. His painted smile is cheerful, but his eyes are still -- no magic left in him." CR>)>>

<ROUTINE TOY-LAMPS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Tin toy lamps dot the cobblestones, their light weak and flickering. Like everything else in Wrenfold, they are running out of magic. Soon they will go dark too." CR>)>>

; === MAILBOX-CORNER OBJECT HANDLERS ===

<ROUTINE MAILBOX-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A red tin mailbox, painted with fading flowers. Its flap hangs open like a mouth, and every now and then it shivers as if trying to speak.">
           <COND (<AND <IN? ,LETTER ,MAILBOX-CORNER> <NOT <FSET? ,LETTER ,TOUCHBIT>>> <TELL " A crumpled [[envelope]] pokes through the snow.">)>
           <COND (<AND <IN? ,SCARF ,MAILBOX-CORNER> <NOT <FSET? ,SCARF ,TOUCHBIT>>> <TELL " A wool [[scarf]] lies at its foot.">)>
           <CRLF>)
          (<VERB? LOOK-INSIDE>
           <TELL "Inside the mailbox, a bundle of unsent letters sits waiting. They are addressed to toys -- invitations to tea parties, thank-you notes, a crayon drawing from a child." CR>)
          (<VERB? OPEN>
           <TELL "The mailbox flap is already open. It hangs loose, like a mouth ready to speak." CR>
           <RTRUE>)
          (<VERB? CLOSE>
           <TELL "Pip tries to close the flap, but it swings open again immediately -- as if the mailbox has something to say." CR>
           <RTRUE>)
          (<VERB? ASK TELL>
           <COND (<EQUAL? ,PRSI ,NUTMEG ,TOPIC-FOX>
                  <TELL "The mailbox shivers. Its flap moves: “F-f-fox? Yes. Passed this way. Heading to the scrap-yard, south of the square. She looked... cold. Cold and lonely.”" CR>)
                 (<EQUAL? ,PRSI ,FOOTPRINTS>
                  <TELL "The mailbox trembles. “Tracks in the snow. Fox tracks. Back west to the square, then south to the scrap-yard. Poor dear. Nobody writes her letters.”" CR>)
                 (<EQUAL? ,PRSI ,SCARF>
                  <TELL "The flap flutters. “R-red. Warm. It has lain in my snow all night, and nobody came back for it. Somebody cold would be glad of it.”" CR>)
                 (<EQUAL? ,PRSI ,LETTER>
                  <TELL "The flap clatters softly. “The old toymaker's hand. He meant to post it to you, little one. He was in such a hurry. It never reached my slot.”" CR>)
                 (T
                  <TELL "The mailbox shivers but cannot form words. It seems to only know about the things it has seen from its corner." CR>)>)
          (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,MAILBOX>>
           <TELL "The mailbox is stuffed full of unsent letters. There is no room for anything more." CR>
           <RTRUE>)>>

<ROUTINE LETTER-F ()
    <COND (<VERB? READ EXAMINE>
           <COND (<NOT ,LETTER-READ>
                  <SETG LETTER-READ T>
                  <SCORE-UPD 3>)>
           <TELL "A crumpled envelope. Inside is a letter in Tolliver's handwriting: “My dear Pip -- The heart is failing. I must go and mend it myself. Do not worry. Take care of the toys while I am gone. Wind the key at midnight if I do not return. I am proud of you, little apprentice. -- Grandfather Tolliver.” The letter is dated three days ago." CR>)>>

<ROUTINE SCARF-F ()
    <COND (<VERB? GIVE-TO> <V-GIVE-TO>)
          (<VERB? EXAMINE>
           <TELL "A red wool scarf, dropped in the snow. It is well-made and still warm -- whoever lost it cannot have gone far. It looks like it would fit a small toy perfectly." CR>)>>

<ROUTINE MAILBOX-LETTERS-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "A bundle of unsent letters inside the mailbox. They are addressed to toys -- invitations to tea parties, thank-you notes, a crayon drawing from a child. One envelope simply says “For Nutmeg” in wobbly letters. It has never been opened." CR>)>>

; === SCRAP-YARD OBJECT HANDLERS ===

<ROUTINE SCRAP-CART-F ()
    <COND (<VERB? EXAMINE>
           <COND (,CART-MOVED
                  <TELL "The scrap cart has rolled aside, its bed still full of rescued toys. It rests peacefully now, its work done for the night." CR>)
                 (T
                   <TELL "A scrap-metal cart on rusted wheels, its open bed edged with low iron rails. It creaks along a track, collecting broken toys. But look closer: someone has carefully repaired the cart's wheels, oiled its [[axles]]. This cart is not destroying toys. It is rescuing them. A [[headless porcelain doll->headless doll]] lies in its bed, her hands folded in her lap." CR>)>)
          (<VERB? PUSH>
           <COND (,CART-MOVED
                  <TELL "The cart is already out of the way." CR>)
                 (T
                  <TELL "The cart is far too heavy for Pip to push. It rumbles softly, almost like a growl -- but it does not move." CR>)>)
          (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,SCRAP-CART>>
           <COND (<EQUAL? ,PRSO ,DOLL-HEAD>
                  <V-GIVE-TO>)
                 (<EQUAL? ,PRSO ,TOY-HORSE>
                  <TELL "Pip lifts the three-legged horse toward the cart. A gentle mechanical arm takes it and settles it in the bed among the other rescued toys." CR>
                  <MOVE ,TOY-HORSE ,SCRAP-CART>
                  <FCLEAR ,TOY-HORSE ,TAKEBIT>)
                 (T
                  <TELL "The cart's mechanical arm hovers, then draws back. It gathers only broken toys that need mending." CR>)>
           <RTRUE>)
          (<VERB? ATTACK>
           <COND (,CART-MOVED
                  <TELL "The cart has done nothing to Pip. Leave it be." CR>)
                  (T
                   <TELL "The cart does not fight back. It simply continues its work, creaking along its track and ignoring Pip entirely." CR>)>)>>

<ROUTINE HEADLESS-DOLL-F ()
    <COND (<VERB? EXAMINE>
           <COND (<IN? ,DOLL-HEAD ,SCRAP-CART>
                  <TELL "The porcelain doll lies in the cart's bed in her torn dress, hands folded, her painted head resting beside her at last. She is ready to be mended." CR>)
                 (T
                  <TELL "A headless porcelain doll in a torn dress. Despite her state, someone has folded her hands neatly in her lap. She looks peaceful, somehow -- as if waiting to be made whole again." CR>)>)
          (<VERB? TAKE>
           <TELL "The cart has laid her down so carefully. Pip leaves her in its keeping." CR>)>>

<ROUTINE DOLL-HEAD-F ()
    <COND (<VERB? GIVE-TO> <V-GIVE-TO>)
          (<AND <VERB? TAKE> <IN? ,DOLL-HEAD ,SCRAP-CART>>
           <TELL "The head rests beside its doll in the cart now. Pip leaves them together." CR>)
          (<VERB? EXAMINE>
           <TELL "A porcelain doll head with painted blue eyes and rosebud lips. It matches the headless doll in the cart. They were clearly once part of the same toy." CR>)>>

<ROUTINE TOY-HORSE-F ()
    <COND (<AND <VERB? TAKE> <IN? ,TOY-HORSE ,SCRAP-CART>>
           <TELL "The horse is safe in the cart's bed, waiting to be mended. Pip leaves it there." CR>)
          (<VERB? EXAMINE>
           <TELL "A wooden toy horse, its paint chipped and one leg missing. It rocks gently at Pip's touch, as if dreaming of galloping." CR>)>>

<ROUTINE YARD-GATE-F ()
    <COND (<VERB? EXAMINE>
           <COND (,CART-MOVED
                  <TELL "Scraped paint on the gate shows how tightly the cart was wedged. Now Pip can walk through without turning sideways." CR>)
                  (T
                   <TELL "A [[wheel->cart wheels]] of the scrap cart is wedged against the gatepost. Pushing the gate itself would only push against the wheel." CR>)>)>>

; === FOX-DEN OBJECT HANDLERS ===

<ROUTINE NUTMEG-F ()
    <COND (<VERB? EXAMINE>
           <COND (<NOT <IN? ,NUTMEG ,FOX-DEN>>
                  <TELL "Nutmeg is not here. Her den feels empty -- just rags and a dying candle." CR>)
                 (<EQUAL? ,NUTMEG-TRUST -1>
                  <TELL "Nutmeg is curled in the furthest corner of her den, her back to Pip. Her shoulders tremble slightly.">
                  <COND (<NOT ,KEY-FOUND> <TELL " The key is still around her neck, but she will not let Pip near it.">)>
                  <TELL CR>)
                 (,KEY-FOUND
                  <TELL "Nutmeg, the fox toy. Her patchy orange fur and mismatched button eyes give her a lopsided, vulnerable look. She watches Pip with something close to trust now. The workshop key is no longer around her neck." CR>)
                 (<G? ,NUTMEG-TRUST 0>
                  <TELL "Nutmeg, the fox toy, with patchy orange fur and mismatched button eyes. She no longer shrinks from Pip. The workshop key -- the one from the empty hook -- still hangs from a string around her neck, ticking faintly." CR>)
                 (T
                  <TELL "A fox-shaped toy with patchy orange fur. Her button eyes watch Pip warily. The workshop key -- the one from the empty hook -- hangs from a string around her neck. It ticks faintly, its magic growing weaker." CR>)>)
          (<VERB? ATTACK>
           <COND (<EQUAL? ,NUTMEG-TRUST -1>
                  <TELL "Pip has already hurt her enough. She flinches at Pip's movement but does not fight back." CR>)
                 (T
                  <TELL "Nutmeg flinches. “I knew it,” she whispers. “You are just like the others.” She retreats to the deepest corner of the den">
                  <COND (<NOT ,KEY-FOUND> <TELL ", key clutched tight to her chest">)>
                  <TELL ". She will not look at Pip anymore." CR>
                  <SETG NUTMEG-TRUST -1>)>
           <RTRUE>)
          (<VERB? ASK TELL>
           <COND (<EQUAL? ,NUTMEG-TRUST -1>
                  ;"A frightened fox must not strand the story: saying sorry
                    gives back whatever trust Pip's gifts had earned."
                  <TELL "Pip kneels at the edge of the nest. “I am sorry, Nutmeg. I should never have frightened you.” For a long while she says nothing. Then one ear turns toward Pip. “Nobody ever said sorry to me before,” she whispers. She uncurls, just a little, and looks at Pip again." CR>
                  <SETG NUTMEG-TRUST ,NUTMEG-GIFTS>)
                 (<OR <EQUAL? ,PRSI ,WORKSHOP-KEY>
                      <EQUAL? ,PRSI ,TOPIC-KEY>>
                  <COND (,KEY-FOUND
                         <TELL "Nutmeg looks at the key in Pip's keeping. “It belongs with the others. I... I was wrong to take it.” She seems lighter now, having said it." CR>)
                        (<G? ,NUTMEG-TRUST 0>
                         <TELL "Nutmeg hugs the key closer. “I know it is not mine. But it is the only thing that has ever ticked for me. Do you know what that is like? Being a toy nobody wanted?”" CR>)
                        (T
                         <TELL "“Why should I give it back?” Her voice is sharp. “Nobody ever gave me anything. Why should I give up the only thing that has ever been mine?”" CR>)>)
                  (<TOLLIVER-TOPIC? ,PRSI>
                   <COND (<G? ,NUTMEG-TRUST 1>
                          <TELL "Nutmeg's ears droop. “The old man... he fixed me once. When my stitching came loose. He did not have to -- nobody asked him. He just did it. And then he stopped coming. I thought he had forgotten about me. Like everyone else.” A tear -- a tiny bead of condensation -- rolls down her fabric cheek." CR>)
                         (T
                          <TELL "“The toymaker?” She looks away. “He was kind. Too kind. He tried to fix everything. And look what happened.” She will not say more -- not yet." CR>)>)
                 (<AND ,KEY-FOUND <NOT ,STUDY-ACCESS>>
                  <TELL "Nutmeg touches Pip's sleeve. “The old clock in the loft -- wind him again. His bird can call me to the latch. I will meet you there.”" CR>)
                 (,KEY-FOUND
                  <TELL "“You kept your promise,” Nutmeg says. “I am coming with you. No more waiting alone.”" CR>)
                 (<G? ,NUTMEG-TRUST 0>
                  <TELL "Nutmeg uncurls a little. “You can ask me for the key now,” she says. “Or show me something of the toymaker's. I think I can talk about him.”" CR>)
                 (T
                  <TELL "“Nutmeg,” she says at last. “That is my name. Please do not take the ticking away. It is cold enough here already.”" CR>)>)>>

<ROUTINE WORKSHOP-KEY-F ()
    <COND (<VERB? SPIN>
           <COND (<EQUAL? ,HERE ,WORKSHOP-HEART> <PERFORM ,V?WIND ,HEART-MECH>)
                 (T <TELL "The key turns between Pip’s fingers. It needs the winding hole in the workshop heart." CR>)>)
          (<AND <VERB? TAKE> ,KEY-WOUND>
           <TELL "The winding teeth hold it fast. Pip leaves the key turning with the heart." CR>)
          (<VERB? EXAMINE>
           <COND (,KEY-WOUND <TELL "The little grooves in the brass key mesh with the heart’s teeth. Every tick turns the key one notch." CR>)
                 (,KEY-FOUND
                  <TELL "The workshop key. Brass, warm to the touch, with an intricate winding pattern on its head. It ticks faintly -- a tiny heartbeat. This is what keeps Wrenfold's toys alive." CR>)
                 (T
                  <TELL "The workshop key hangs from a string around the fox's neck. It is brass, intricately carved, and it ticks -- weakly, but steadily. It is the source of all the magic in Wrenfold." CR>)>)
           (<AND <VERB? TAKE>
                 <NOT ,KEY-FOUND>
                 <EQUAL? ,NUTMEG-TRUST -1>>
            <TELL "Nutmeg growls softly. The key is around her neck, and she will not let Pip near it. Not after what Pip did." CR>)
           (<AND <VERB? TAKE>
                 <NOT ,KEY-FOUND>
                 <L? ,NUTMEG-TRUST 1>>
           <TELL "Nutmeg snatches the key back. “No!” Her voice is sharp, but there is something else underneath -- fear, maybe. “I cannot... I cannot lose it too.”" CR>)
          (<AND <VERB? TAKE>
                <NOT ,KEY-FOUND>
                <G? ,NUTMEG-TRUST 0>>
           <TELL "Nutmeg is quiet for a long moment. Then, slowly, she paws the key off her neck and places it before Pip. “Take it,” she says. Her voice cracks. “I am sorry I took it. I just... I did not want to be alone when the ticking stopped. But you came all this way. You really care, do you not?” She looks up at Pip with her mismatched button eyes. “Promise you will come back. Please.”" CR>
           <SETG KEY-FOUND T>
           <SETG NUTMEG-KEY-METHOD 1>
           <MOVE ,WORKSHOP-KEY ,WINNER>
           <FCLEAR ,WORKSHOP-KEY ,NDESCBIT>
            <THIS-IS-IT ,WORKSHOP-KEY>
            <RTRUE>)>>

<ROUTINE RAG-BED-F ()
    <COND (<VERB? EXAMINE>
           <COND (<AND <IN? ,STRING-BALL ,FOX-DEN> <NOT <FSET? ,STRING-BALL ,TOUCHBIT>>> <TELL "A ball of red [[yarn]] nestles in the rags. ">)>
           <TELL "A cosy nest of rags and twigs. It smells faintly of cedar shavings -- the same scent as Tolliver's workshop. Someone has made this place into a home." CR>)>>

<ROUTINE TOY-CANDLE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A tiny toy candle, no bigger than Pip's finger. Its flame is steady and warm -- real fire, real light. It must have been burning for a long time." CR>)
          ;"Not LAMP-OFF: its TURN OFF grammar wants the candle in hand, so a
            reader's menu would offer an action that can only be refused."
          (<VERB? BLOW>
           <TELL "Pip considers blowing it out, but stops. It is the only warmth in this cold little den." CR>)>>

<ROUTINE STRING-BALL-F ()
    <COND (<VERB? GIVE-TO> <V-GIVE-TO>)
          (<VERB? EXAMINE>
           <TELL "A ball of red yarn. It is slightly frayed, as if someone has been playing with it. A fox, perhaps." CR>)>>

; === TOLLIVER-STUDY OBJECT HANDLERS ===

<ROUTINE TOLLIVER-COAT-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Grandfather Tolliver's worn tweed coat. It still smells like him -- wood shavings, lamp oil, and something faintly like peppermint. The pockets are empty." CR>)
          (<VERB? WEAR>
           <TELL "The coat is far too large for Pip; it would swallow him whole. Still, Pip wraps a corner around his shoulders. It is warm. It still feels like Tolliver." CR>)>>

<ROUTINE TEA-CUP-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A cup of tea, long gone cold. A skin of dust floats on the surface. Tolliver never got to finish it." CR>)
          (<VERB? DRINK>
           <TELL "Pip dips one finger in the cold tea. It is bitter with age, so he leaves the rest." CR>)>>

<ROUTINE STUDY-DESK-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE>
           <TELL "A half-finished sketch of the workshop heart covers the desk.">
           <COND (<AND <IN? ,TEA-CUP ,TOLLIVER-STUDY> <NOT <FSET? ,TEA-CUP ,TOUCHBIT>>> <TELL " A [[cup of tea->cup]] stands nearby.">)>
           <COND (<IN? ,STUDY-JOURNAL ,STUDY-DESK> <TELL " Tolliver's [[journal]] lies open.">)>
           <COND (<IN? ,DIAGRAM ,STUDY-DESK>
                  <TELL " Beside the sketch lies a hand-drawn winding [[diagram]].">)>
           <CRLF>)>>

<ROUTINE DIAGRAM-F ()
    <COND (<VERB? READ EXAMINE>
           <COND (<NOT ,DIAGRAM-READ>
                  <SETG DIAGRAM-READ T>
                  <SCORE-UPD 3>)>
           <TELL "A hand-drawn diagram of the workshop's inner workings. Tolliver mapped the heart chamber carefully. The instructions read: “Insert key. Turn clockwise. For full rewinding, surround the heart with companions -- the more love present, the stronger the magic. Each toy carries memories of the children who loved them. Those memories are power.”" CR>)>>

<ROUTINE STUDY-JOURNAL-F ()
    <COND (<VERB? READ EXAMINE>
           <COND (<NOT ,STUDY-JOURNAL-READ>
                  <SETG STUDY-JOURNAL-READ T>
                  <SCORE-UPD 3>)>
           <TELL "Tolliver's journal, open to the final entry. The handwriting is shaky but determined: “I cannot wind the heart alone. The magic has grown weak, and I am old. But Pip -- dear Pip -- is still small enough to reach the heart chamber. If the key is found, and if Pip has made friends along the way, then perhaps the heart can beat again. I have left the key in the workshop. I only hope it is enough. Pip, if you are reading this -- I am proud of you. You were always more than just an apprentice. -- G.T.”" CR>)>>

<ROUTINE STUDY-CHR-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The chair is pushed back as if Grandfather has only stepped away.">
           <COND (<AND <IN? ,TOLLIVER-COAT ,TOLLIVER-STUDY> <NOT <FSET? ,TOLLIVER-COAT ,TOUCHBIT>>> <TELL " His [[coat]] still hangs over its back.">)>
           <CRLF>)>>

; === WORKSHOP-HEART OBJECT HANDLERS ===

<ROUTINE HEART-DESC-F (RARG "AUX" TOY (COUNT 0))
    <COND (<EQUAL? .RARG ,M-OBJDESC>
           <COND (,KEY-WOUND <TELL "The brass [[heart]] beats with the [[workshop key]] in its [[keyhole]]">
                  <SET TOY <FIRST? ,WORKSHOP-HEART>>
                  <REPEAT ()
                      <COND (<NOT .TOY> <RETURN>)>
                      <COND (<AND <OR <EQUAL? .TOY ,TIN-SOLDIER ,MUSIC-BOX>
                                      <EQUAL? .TOY ,DOLL-ARM ,BUTTON>>
                                  <NOT <FSET? .TOY ,TAKEBIT>>>
                             <COND (<0? .COUNT> <TELL " while ">) (T <TELL " and ">)>
                             <TELL THE .TOY>
                             <COND (<EQUAL? .TOY ,MUSIC-BOX> <TELL " plays along">)
                                   (<EQUAL? .TOY ,TIN-SOLDIER> <TELL " stands guard">)
                                   (T <TELL " rests at its base">)>
                             <SET COUNT <+ .COUNT 1>>)>
                      <SET TOY <NEXT? .TOY>>>
                  <TELL "." CR>)
                 (T <TELL "At the centre of the brass [[heart]], a [[keyhole]] waits." CR>)>
           <RTRUE>)>>

<ROUTINE HEART-MECH-F ()
    <COND (<VERB? WIND SPIN> <V-WIND>)
          (<VERB? EXAMINE>
           <COND (,KEY-WOUND
                  <TELL "The workshop heart is turning now -- slowly, but steadily. Its brass gears catch the candlelight. A deep, resonant ticking fills the chamber. It sounds like hope.">
                  <COND (<G? ,COMPANION-COUNT 0>
           <TELL " The presence of Pip's companions has made the light brighter, the ticking stronger.">)>
                  <TELL " A brass keyhole gleams at its centre -- the workshop key is in place." CR>)
                 (T
                  <TELL "The workshop's heart -- a vast brass mechanism of interlocking gears -- stands silent and still. At its centre, a keyhole waits, dark and empty. Around the walls, dozens of toys stand frozen in the shadows, as if they came here hoping to be rewound." CR>)>)
          (<VERB? LISTEN>
           <COND (,KEY-WOUND
                  <TELL "Pip presses a hand to the mechanism. Tick, tick, tick -- a heartbeat, growing stronger." CR>)
                  (T
                   <TELL "Silence. The heart is completely still. Not even an echo." CR>)>)>>

<ROUTINE KEY-SLOT-F ()
    <COND (<VERB? EXAMINE>
           <COND (,KEY-WOUND
                  <TELL "The [[workshop key]] is in the keyhole, turning steadily. The brass gleams with renewed warmth." CR>)
                  (T
                   <TELL "An empty brass keyhole sits at the heart’s centre. Four square corners wait for a winding key." CR>)>)>>

<ROUTINE SILENT-TOYS-F ()
    <COND (<VERB? EXAMINE>
           <COND (,KEY-WOUND
                  <COND (,GAME-WON
                         <TELL "The toys around the heart are stirring. Paint is brightening. Joints are loosening. They are waking up." CR>)
                        (T
                         <TELL "The silent toys around the chamber walls. Their painted eyes seem to follow Pip. They are waiting -- hoping -- that the magic will return." CR>)>)
                  (T
                   <TELL "Dozens of toy figures stand around the heart chamber. Soldiers, dolls, wooden animals -- all of them motionless. Their paint is dull. Their joints are stiff. They are waiting for the heart to beat again." CR>)>)>>

; === LOCAL-GLOBALS ACTION HANDLERS ===

<ROUTINE WORKSHOP-BUILDING-F ()
    <COND (<VERB? EXAMINE>
           <COND (,GAME-WON
                  <TELL "The workshop looks different now. Warm light glows in every window. The magic has returned, a steady, gentle hum from deep within the building." CR>)
                  (T
                   <TELL "Grandfather Tolliver's workshop -- a cosy old building with frosted windows and a crooked chimney. From outside, nobody would guess the magic it holds within." CR>)>)>>

<ROUTINE MOON-F ()
    <COND (<VERB? EXAMINE>
           <COND (<L? ,TICK-COUNT 31>
                  <TELL "The winter moon is fading now, pale against the brightening sky. Dawn is near." CR>)
                  (T
                   <TELL "A bright winter moon hangs overhead, casting long blue shadows across the snow. It is a beautiful night -- but a cold one." CR>)>)>>

<ROUTINE BAKERY-F ()
    <COND (<VERB? EXAMINE>
           <TELL "An abandoned bakery storefront. Through the dusty window, a wooden baker toy stands frozen mid-knead. The glass is frosted with age, and the door hangs slightly ajar." CR>)>>

<ROUTINE COBBLER-F ()
    <COND (<VERB? EXAMINE>
           <TELL "An old cobbler's shop, its sign creaking in the wind. Through the dusty window, tiny shoes gather dust: doll-sized boots and toy-sized slippers. No one has worked here in a long time." CR>)>>

; === GIVE HANDLER OVERRIDES ===

<SYNTAX GIVE OBJECT TO OBJECT = V-GIVE-TO>

<ROUTINE V-GIVE-TO ()
    <COND (<AND <EQUAL? ,PRSO ,BUTTON>
                <EQUAL? ,PRSI ,MARZIPAN>>
           <COND (,MARZIPAN-BUTTON
                  <TELL "Marzipan already has her second eye. She touches it with a stitched finger and smiles." CR>)
                 (T
                  <TELL "Marzipan takes the button in her fabric hand. “For me?” She looks at it -- then at you. Her stitched smile somehow seems wider. She sews the button into place beside her other eye. Now both eyes watch you with warmth. “Thank you, little apprentice. Now I can see twice as much. Let me sing you a secret.” She leans close and whispers: “Behind the ticking, ticking clock, a door that needs no key or lock. But small paws only fit the crack -- the fox can push the hidden latch way back.”" CR>
                   <SETG MARZIPAN-BUTTON T>
                   <SCORE-UPD 3>
                   <MOVE ,BUTTON ,MARZIPAN>)>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,SCARF>
                <EQUAL? ,PRSI ,NUTMEG>>
           <COND (<NOT <IN? ,NUTMEG ,HERE>>
                  <TELL "Nutmeg is not here." CR>)
                 (<EQUAL? ,NUTMEG-TRUST -1>
                  <TELL "Nutmeg flinches away from your outstretched hand. She does not want anything from you now." CR>)
                 (T
                  <TELL "Nutmeg stares at the red scarf in your hand. “For... for me?” She reaches out with a trembling paw and touches the wool. “It is warm. Nobody ever gave me anything warm before.” Her voice cracks on the last word. She wraps the scarf around her neck">
                  <COND (<NOT ,KEY-FOUND> <TELL ", beside the little ticking key">)>
                  <TELL ". “Thank you,” she whispers." CR>
                  <COND (<EQUAL? ,NUTMEG-TRUST 0>
                         <SETG NUTMEG-TRUST 1>)
                        (T
                         <SETG NUTMEG-TRUST 2>)>
                  <SETG NUTMEG-GIFTS <+ ,NUTMEG-GIFTS 1>>
                  <MOVE ,SCARF ,NUTMEG>)>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,STRING-BALL>
                <EQUAL? ,PRSI ,NUTMEG>>
           <COND (<NOT <IN? ,NUTMEG ,HERE>>
                  <TELL "Nutmeg is not here." CR>)
                 (<EQUAL? ,NUTMEG-TRUST -1>
                  <TELL "Nutmeg ignores the ball. She does not want to play anymore." CR>)
                 (T
                  <TELL "Nutmeg looks at the ball of yarn. Despite herself, her paw twitches. She bats it once -- twice -- and then catches herself, embarrassed. “I used to do this,” she says quietly. “In the shop window. Before I knew nobody was coming for me.” She curls up with the yarn tucked under her chin." CR>
                  <SETG NUTMEG-TRUST 2>
                  <SETG NUTMEG-GIFTS <+ ,NUTMEG-GIFTS 1>>
                  <MOVE ,STRING-BALL ,NUTMEG>)>
           <RTRUE>)
          (<AND <EQUAL? ,PRSO ,DOLL-HEAD>
                <OR <EQUAL? ,PRSI ,SCRAP-CART>
                    <EQUAL? ,PRSI ,HEADLESS-DOLL>>>
           <COND (<NOT <EQUAL? ,HERE ,SCRAP-YARD>>
                  <TELL "The scrap cart is not here." CR>)
                 (,CART-MOVED
                  <TELL "The cart has already moved aside. Its work here is done." CR>)
                 (T
           <TELL "Pip holds up the porcelain doll head. The cart pauses. A mechanical arm -- surprisingly gentle -- extends and takes the head from Pip's hands. It places the head beside the headless doll in its bed. For a moment, the cart is perfectly still. Then it rumbles -- a low, soft sound, like a purr -- and rolls aside, revealing the iron gate to the [[east]]." CR>
                  <MOVE ,DOLL-HEAD ,SCRAP-CART>
                  <SETG CART-MOVED T>
                  <SETG CART-HELPED T>
                  <SCORE-UPD 5>)>
           <RTRUE>)
          (<AND <EQUAL? ,PRSI ,NUTMEG>
                <NOT <IN? ,NUTMEG ,HERE>>>
           <TELL "Nutmeg is not here." CR>)
          (T
           <TELL "Pip holds it out, but nothing comes of the offer." CR>)>>

; === PLACE HANDLER FOR FINAL REWIND ===

<SYNTAX POSITION OBJECT = V-PLACE-HEART>

<ROUTINE V-PLACE-HEART ()
    <COND (<NOT <EQUAL? ,HERE ,WORKSHOP-HEART>>
           <TELL "There is no reason to place that here." CR>)
          (,GAME-WON
           <TELL "The heart is already beating strongly. There is nothing more to do." CR>)
          (<NOT ,KEY-WOUND>
           <TELL "The heart is not yet wound. Pip must wind it with the key first." CR>)
          (<NOT <IN? ,PRSO ,WINNER>>
           <COND (<IN? ,PRSO ,WORKSHOP-HEART>
                  <TELL "That companion is already lending its strength to the heart." CR>)
                 (T
                  <TELL "Pip must carry that companion to the heart first." CR>)>)
          (<EQUAL? ,PRSO ,TIN-SOLDIER>
           <TELL "Pip places the tin soldier beside the heart mechanism. He snaps to attention -- and the heart ticks louder, stronger. His painted eyes seem to brighten. “Standing guard,” he seems to say, though his tin mouth never moves." CR>
           <SETG COMPANION-COUNT <+ ,COMPANION-COUNT 1>>
           <SCORE-UPD 10>
           <MOVE ,TIN-SOLDIER ,WORKSHOP-HEART>
           <FCLEAR ,TIN-SOLDIER ,TAKEBIT>
           <FSET ,TIN-SOLDIER ,NDESCBIT>
           <CHECK-ENDING>)
          (<EQUAL? ,PRSO ,MUSIC-BOX>
           <TELL "Pip places the silver music box near the heart. Its crank turns by itself, and the lullaby fills the chamber. The gears respond -- their rhythm shifts to match the melody." CR>
           <SETG COMPANION-COUNT <+ ,COMPANION-COUNT 1>>
           <SCORE-UPD 10>
           <MOVE ,MUSIC-BOX ,WORKSHOP-HEART>
           <MOVE ,MUSIC-TOOTH ,WORKSHOP-HEART>
           <FCLEAR ,MUSIC-BOX ,TAKEBIT>
           <FSET ,MUSIC-BOX ,NDESCBIT>
           <CHECK-ENDING>)
          (<EQUAL? ,PRSO ,DOLL-ARM>
           <TELL "Pip places the doll arm gently beside the heart. It is a small gesture, but the heart knows -- every mended toy, every kind act, feeds the magic." CR>
           <SETG COMPANION-COUNT <+ ,COMPANION-COUNT 1>>
           <SCORE-UPD 10>
           <MOVE ,DOLL-ARM ,WORKSHOP-HEART>
           <FCLEAR ,DOLL-ARM ,TAKEBIT>
           <FSET ,DOLL-ARM ,NDESCBIT>
           <CHECK-ENDING>)
          (<EQUAL? ,PRSO ,BUTTON>
           <TELL "Pip places the spare button at the heart's base. A tiny offering -- but the heart remembers everything." CR>
           <SETG COMPANION-COUNT <+ ,COMPANION-COUNT 1>>
           <SCORE-UPD 10>
           <MOVE ,BUTTON ,WORKSHOP-HEART>
           <FCLEAR ,BUTTON ,TAKEBIT>
           <FSET ,BUTTON ,NDESCBIT>
           <CHECK-ENDING>)
          (T
           <TELL "Placing that here would not help the heart." CR>)>>

<ROUTINE CHECK-ENDING ()
     <COND (<AND <G? ,NUTMEG-TRUST 0>
                <NOT ,NUTMEG-SAVED>
                <NOT <EQUAL? ,NUTMEG-TRUST -1>>>
           <TELL "Nutmeg pads forward from the shadows. “Let me help,” she says quietly. “I have been alone long enough. I would like to be part of something.” She curls up at the base of the heart mechanism, her patchy fur glowing faintly in its light." CR>
           <SETG NUTMEG-SAVED T>
           <SETG COMPANION-COUNT <+ ,COMPANION-COUNT 1>>
           <SCORE-UPD 10>)>
    <COND (<G? ,COMPANION-COUNT 2>
           <REWIND-ENDING>)>
    <RTRUE>>

<ROUTINE REWIND-ENDING ()
    <COND (,GAME-WON <RTRUE>)>
    <SETG GAME-WON T>
    <COND (<G? ,COMPANION-COUNT 2>
           <SETG ENDING-TIER 3>
           <TELL CR>
           <TELL "The workshop heart beats -- a deep, steady rhythm that echoes through every corner of Wrenfold. The clock tower chimes. Toys stir in shop windows all across the square. Streetlamps flicker to full brightness. The magic is back." CR CR>
           <TELL "Grandfather Tolliver's voice, somehow, whispers through the gears: “Well done, apprentice. Well done.”" CR CR>
           <COND (,NUTMEG-SAVED
                  <TELL "Nutmeg curls at Pip's feet, her patchy fur warm">
                  <COND (<IN? ,SCARF ,NUTMEG>
                         <TELL " and her new red scarf bright in the candlelight">)>
                  <TELL ". “You kept your promise,” she says. “Nobody ever kept their promise before.”" CR CR>)>
           <TELL "The sun rises over Wrenfold, and every toy in town is awake to see it." CR>
           <TELL "The last of the night's cold fades from Pip's bones. At last, Pip is home." CR CR>
           <TELL "*** Pip has restored the heart of Wrenfold ***" CR>)
          (T
           <SETG ENDING-TIER 1>
           <TELL CR>
           <TELL "The workshop heart shudders and begins to turn -- weakly, unsteadily, but it turns. A few toys in the nearest shop windows stir and blink. The streetlamps flicker but do not stay lit." CR CR>
           <TELL "Grandfather Tolliver's voice comes through the gears as a faint whisper, barely audible: “...well done, apprentice... keep trying...”" CR CR>
           <TELL "The heart beats, but softly -- too softly to wake every toy. Some are still asleep this morning. But the magic is not gone. It lingers, waiting for someone to bring more love into this world." CR CR>
           <TELL "The sun rises, pale and cold. Pip has done what he could. There is still work ahead." CR CR>
           <TELL "*** Pip has saved what he could of Wrenfold ***" CR>)>
    <FINISH>>

<ROUTINE LATCH-F ()
    <COND (<AND <VERB? EXAMINE> <FSET? ,DISPLAY-CASE ,OPENBIT>>
           <TELL "The brass tongue is clear of the glass. It will hook over the rim again when Pip shuts the case." CR>)
          (<VERB? MOVE RAISE> <PERFORM ,V?OPEN ,DISPLAY-CASE>)
          (<VERB? OPEN CLOSE> <PERFORM ,PRSA ,DISPLAY-CASE>)>>

<ROUTINE CART-WHEELS-F ()
    <COND (<VERB? PUSH> <PERFORM ,V?PUSH ,SCRAP-CART>)
          (<VERB? SPIN>
           <COND (,CART-MOVED <TELL "The front wheel rocks on its axle. The cart is clear of the gate." CR>)
                 (T <TELL "The front rim grinds against the gatepost. The whole cart needs a push." CR>)>)
          (<VERB? EXAMINE>
           <COND (,CART-MOVED <TELL "Four rusty lines end just past the gate. The rims stand clear of the post now." CR>) (T <TELL "The front rim has rubbed a bright stripe on the gatepost. The back wheels still sit squarely on the rails." CR>)>)>>

<ROUTINE DETAIL-SAILBOAT-F ()
    <COND (<VERB? PUSH> <TELL "The hull rocks twice and settles on its keel." CR>)>>

<ROUTINE DETAIL-WOODEN-TRAIN-F ()
    <COND (<VERB? PUSH> <TELL "The train rolls a finger’s length. Its last wheel drags a red streak across the bench." CR>)>>

<ROUTINE DETAIL-WOODEN-DUCK-F ()
    <COND (<VERB? PUSH> <TELL "The duck rolls round in a circle on its one good wheel and bumps Pip’s thumb." CR>)>>

<ROUTINE MUSIC-TOOTH-F ()
    <COND (<VERB? RUB> <TELL "A tiny buzz tickles Pip’s fingertip as the note dies away." CR>)>>

<ROUTINE DISTANT-TICK-F ()
    <COND (<VERB? LISTEN> <TELL "Tick … tick. It is loudest under the desk, where the boards lead [[down]]." CR>)>>

<ROUTINE DETAIL-PAINT-MARK-F ()
    <COND (<VERB? READ> <TELL "The red arrow points [[east]], toward the mailbox." CR>)
          (<VERB? FOLLOW> <DO-WALK ,P?EAST>)>>

<ROUTINE COUNTER-STEPS-F ()
    <COND (<VERB? CLIMB-FOO CLIMB-DOWN> <DO-WALK ,P?DOWN>)>>

<ROUTINE LOFT-RUNGS-F ()
    <COND (<VERB? CLIMB-FOO CLIMB-DOWN> <DO-WALK ,P?DOWN>)>>

<ROUTINE STUDY-STAIRS-F ()
    <COND (<VERB? CLIMB-FOO CLIMB-DOWN> <DO-WALK ,P?OUT>)>>

<ROUTINE RACK-TOOL-F ()
    <COND (<VERB? TAKE>
           <V-TAKE>
           <COND (<IN? ,PRSO ,WINNER> <FCLEAR ,PRSO ,NDESCBIT>)>
           <RTRUE>)>>
