<SYNTAX TURN OBJECT = V-SPIN>
<SYNTAX PLAY WITH OBJECT = V-PLAY>
<SYNTAX FIT OBJECT (HELD HAVE) ON OBJECT = V-PUT-ON PRE-PUT>

; === CUSTOM SYNTAX ===

<SYNTAX WIND OBJECT = V-WIND>
<SYNTAX WIND OBJECT WITH OBJECT (HELD CARRIED) = V-WIND>
<SYNTAX LUBRICATE OBJECT = V-OIL>
<SYNTAX LUBRICATE OBJECT WITH OBJECT (HELD CARRIED) = V-OIL>
<SYNTAX HINT = V-HINTS>
<SYNTAX EASY = V-EASY-TOGGLE>
<SYNONYM HINT HINTS>
<SYNONYM SQUEEZE HUG CUDDLE>

<ROUTINE STORAGE-LOFT-LOOK (RARG)
	<COND (<AND <EQUAL? .RARG ,M-LOOK> <FSET? ,TOY-BOX ,OPENBIT>>
		<TELL "This is the storage loft, a low, dusty room tucked under the roof beams. Grey [[cobwebs]] hang from the rafters like curtains. On the wall, an old cuckoo [[clock]] ">
		<COND (,OLD-TICK-HEARD <TELL "ticks steadily">) (T <TELL "sits silent">)>
		<TELL " above the open [[box]] of broken toy parts. Pip can climb the [[ladder]] back [[down]] to the workshop floor." CR>)>>

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

<ROUTINE V-VERSION ()
	<TELL "The Last Toymaker's Apprentice|Studio Null, 2024|Release " N ,RELEASEID CR>>

<ROUTINE GO ()
	<V-VERSION> <CRLF>
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
    ;"A book read with children has no countdown unless the reader asks
      for one: EASY switches the dawn clock on and off."
    <COND (,TIMER-ACTIVE
           <ENABLE <QUEUE I-TICK 1>>
           <ENABLE <QUEUE I-DAWN-WARNING 25>>)>
    <ENABLE <QUEUE I-NUTMEG-AUTONOMY 8>>
    <TELL "You are Pip, a workshop gnome no taller than a teacup, and the apprentice of Grandfather Tolliver, the last toymaker in Wrenfold. Every night the town's toys wake up and play, but tonight they are growing still. The magic key that keeps them ticking has vanished from its hook, and Grandfather has not come home. You must find the key and wind the workshop's heart before dawn." CR CR>
    <TELL D ,HERE CR>
    <V-LOOK>
    <MAIN-LOOP>
    <AGAIN>>

; === CLOCK DAEMONS ===

<ROUTINE I-TICK ()
    <QUEUE I-TICK 1>
    <COND (,GAME-WON <RTRUE>)>
    <COND (<L? ,TICK-COUNT 1>
           <TELL "The sun rises over Wrenfold before the heart is wound. All over town the toys give one great yawn and fall fast asleep, still smiling. They will sleep soundly until somebody winds the heart, and the night can begin again." CR>
           <SETG TICK-COUNT 0>
           <JIGS-UP "Morning has come, and the toys are sleeping.">)
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
           <TELL "This is the floor of Grandfather Tolliver's workshop. Soft golden [[sawdust]] smells of cedar and comes halfway up Pip’s boots. The brass key [[hook]] is empty, and ">
           <COND (,STUDY-ACCESS
                  <TELL "the old cuckoo [[clock]] has swung away from the wall above the folding [[loft ladder->loft ladder]].">)
                 (T <TELL "an old cuckoo [[clock]] ticks on the wall above the folding [[loft ladder->loft ladder]].">)>
           <TELL " The great [[workbench]] rises over Pip's head like a house">
           <COND (<AND <FSET? ,OIL-CAN ,INVISIBLE> <IN? ,OIL-CAN ,WORKSHOP-FLOOR>>
                  <TELL ". Something glints in the shadows underneath it.">)
                 (<AND <IN? ,OIL-CAN ,WORKSHOP-FLOOR> <NOT <FSET? ,OIL-CAN ,TOUCHBIT>>>
                  <TELL ", and a copper [[oil can->can]] sits in the shadows underneath it.">)
                 (T <TELL ".">)>
           <TELL " A [[pet door->door]] leads [[north]] to the snowy alley, and the tool bench is to the [[east]].">
           <COND (,LADDER-OILED <TELL " The oiled ladder reaches [[up]] to the storage loft.">)>
           <COND (,STUDY-ACCESS <TELL " Narrow [[stairs]] behind the open clock lead [[into the study->in]].">)>
           <CRLF>)>>

<ROUTINE WORKBENCH-TOP-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "This is the top of Grandfather's workbench, a wide wooden plain scattered with curls of cedar shavings. Under the work lamp, [[half-finished toys->toys]] cast long shadows. The unfinished duck’s shadow has both wheels.">
           <COND (,REPAIR-BOOK-OPEN
                  <TELL " Tolliver's [[repair book->book]] lies open, and a paper workshop rises from its pages.">)
                 (T
                  <TELL " Tolliver's big green [[repair book->book]] rests closed beside the work [[lamp]].">)>
           <TELL " The workshop floor is a long way [[down]]." CR>)>>

<ROUTINE WORKBENCH-DOWN-EXIT ()
    <COND (,REPAIR-BOOK-OPEN
           <TELL "The paper workshop trembles in the open book. Pip cannot leave it balanced like that; the heavy cover must be closed first." CR>
           <RFALSE>)
          (T
           <RETURN ,WORKSHOP-FLOOR>)>>

<ROUTINE SCRAP-YARD-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <COND (<AND <FSET? ,DOLL-HEAD ,INVISIBLE> <IN? ,DOLL-HEAD ,SCRAP-YARD>>
                  <TELL "This is the scrap-yard, where broken toys end up when nobody wants them any more. Snowy [[piles]] of tin, wood and ribbon rise on every side, and something pale shows through the nearest one.">)
                 (<AND <IN? ,DOLL-HEAD ,SCRAP-YARD> <FSET? ,DOLL-HEAD ,NDESCBIT>>
                  <TELL "This is the scrap-yard, where broken toys end up when nobody wants them any more. Snowy [[piles]] of tin, wood and ribbon rise on every side, and a porcelain [[doll head->head]] rests on top of the nearest one.">)
                 (T <TELL "This is the scrap-yard, where broken toys end up when nobody wants them any more. Snowy [[piles]] of tin, wood and ribbon rise on every side.">)>
           <TELL " Everything smells of rust and cold snow. Clock Square is back to the [[north]].">
           <COND (,CART-MOVED <TELL " An iron [[gate]] to the [[east]] stands open now." CR>)
                 (T <TELL " An iron [[gate]] leads east, but the way is blocked." CR>)>)>>

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
           <RTRUE>)
          (<VERB? KICK ATTACK>
           <TELL "Pip will not kick them. Every one of these broken things was somebody's favourite toy once." CR>)
          (<VERB? LISTEN>
           <TELL "When the wind blows, the piles tinkle and clink -- little bells, tin wheels, a music box with no tune left." CR>)
          (<VERB? SMELL>
           <TELL "The piles smell of rust, wet wood and old paint." CR>)>>

; === DYNAMIC OBJECT DESCRIPTIONS ===

<ROUTINE BERTRAND-DESC-F (RARG)
    <COND (<EQUAL? .RARG ,M-OBJDESC>
           <COND (,BERTRAND-WOUND
                  <TELL "Captain [[Bertrand]] salutes beside the clear way [[up]]." CR>)
                 (<NOT <IN? ,BERTRAND-KEY ,TOOL-BENCH>>
                  <TELL "A painted [[nutcracker]] stands frozen on the [[chair seat]], right in the middle of the steps." CR>)
                 (T
                  <TELL "A painted [[nutcracker]] stands frozen on the [[chair seat]], right in the middle of the steps, with a little [[key->winding key]] in his back." CR>)>
           <RTRUE>)>>

<ROUTINE MARZIPAN-DESC-F (RARG)
    <COND (<EQUAL? .RARG ,M-OBJDESC>
           <COND (,MARZIPAN-BUTTON
                  <TELL "[[Marzipan]] hums, her two mismatched button eyes shining." CR>)
                 (T
                  <TELL "A [[rag doll->ragdoll]] with only one [[button eye]] sits against the window, humming softly to herself." CR>)>
           <RTRUE>)>>

<ROUTINE OLD-TICK-DESC-F (RARG)
    <COND (<EQUAL? .RARG ,M-OBJDESC>
           <COND (<FSET? ,TOY-BOX ,OPENBIT> <RTRUE>)>
           <COND (,OLD-TICK-HEARD
                  <TELL "The old cuckoo [[clock]] on the wall ticks steadily." CR>)
                 (T
                  <TELL "An old cuckoo [[clock]] hangs on the wall, silent and grey with dust." CR>)>
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
                  <TELL "A patchy toy [[fox]] lies curled in the bed, watching Pip with button eyes. The missing workshop [[key->workshop key]] ticks faintly around her neck." CR>)>
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

<ROUTINE V-HINTS ("AUX" STAGE)
    ;"Each stage starts again at its gentlest hint, so a reader who
      needed the full answer once is not handed every later answer."
    <SET STAGE
         <COND (<AND <EQUAL? ,HERE ,FOX-DEN> <NOT ,KEY-FOUND> <EQUAL? ,NUTMEG-TRUST -1>> 1)
               (<AND <EQUAL? ,HERE ,FOX-DEN> <NOT ,KEY-FOUND>> 2)
               (<AND <EQUAL? ,HERE ,SCRAP-YARD> <NOT ,CART-MOVED>> 3)
               (,KEY-WOUND 4)
               (<AND ,KEY-FOUND ,STUDY-ACCESS> 5)
               (<AND ,KEY-FOUND ,LADDER-OILED> 6)
               (<NOT ,BERTRAND-WOUND> 7)
               (<NOT ,LADDER-OILED> 8)
               (<NOT ,KEY-FOUND> 9)
               (T 10)>>
    <COND (<NOT <EQUAL? .STAGE ,HINT-KEY>>
           <SETG HINT-KEY .STAGE>
           <SETG HINT-LEVEL 0>)>
    <COND (<L? ,HINT-LEVEL 4>
           <SETG HINT-LEVEL <+ ,HINT-LEVEL 1>>)>
    <COND (<EQUAL? .STAGE 1>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "Nutmeg is frightened. Frightened friends need a gentle word." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "Pip can say sorry. Talking to her is the way to do it." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "Talk to Nutmeg. Saying sorry brings back the trust Pip's gifts had earned." CR>)
                 (T <TELL "TELL FOX ABOUT TOLLIVER. Then give her a gift if she still needs one." CR>)>)
          (<EQUAL? .STAGE 2>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "The fox has been alone a very long time. She needs kindness, not demands." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "Try giving her something -- the red scarf from the mailbox corner, or the ball of yarn in her den." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "Gifts and kind words build trust. She needs to know someone cares." CR>)
                 (T <TELL "GIVE SCARF TO FOX. TELL FOX ABOUT TOLLIVER. Then TAKE WORKSHOP KEY." CR>)>)
          (<EQUAL? .STAGE 3>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "The cart is not unfriendly. Look at it more carefully." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "The cart carries broken toys. One doll is missing its head. Search the piles." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "Give the doll head to the cart. Kindness moves it, not pushing." CR>)
                 (T <TELL "SEARCH PILES. TAKE DOLL HEAD. GIVE HEAD TO CART." CR>)>)
          (<EQUAL? .STAGE 4>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "The heart is turning, but it needs more than mechanical power." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "The toys you have helped can lend their strength." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "Place your companions around the heart. Each one adds their love to the magic. The tin soldier, the music box and the porcelain doll arm can all help." CR>)
                 (T <TELL "POSITION TIN SOLDIER. POSITION MUSIC BOX. POSITION ARM. Nutmeg will join in if you were kind to her." CR>)>)
          (<EQUAL? .STAGE 5>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "The study behind the open clock holds Grandfather's plans." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "Read the diagram in the study, then follow the ticking down to the heart." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "In the heart chamber, wind the heart with the workshop key." CR>)
                 (T <TELL "From the workshop floor go IN, then DOWN, then WIND HEART." CR>)>)
          (<EQUAL? .STAGE 6>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "Now that you have the key, the cuckoo clock seems different. The way to the heart is behind it." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "Old Tick, the clock in the storage loft, spoke of a latch behind him." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "Wind Old Tick in the storage loft. Nutmeg can reach the hidden latch, or the tin soldier can if she will not help." CR>)
                 (T <TELL "Climb UP to the storage loft and WIND CLOCK." CR>)>)
          (<EQUAL? .STAGE 7>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "The nutcracker on the tool bench is blocking the steps. He looks... stuck." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "Examine the nutcracker closely. He has something in his back." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "Turn the little key in his back to wind him up." CR>)
                 (T <TELL "Go EAST to the tool bench and WIND NUTCRACKER." CR>)>)
          (<EQUAL? .STAGE 8>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "The folding loft ladder will not rise. Something is rusted." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "The lifting mechanism needs oil. Look under the workbench." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "Take the oil can from under the workbench, then oil the mechanism." CR>)
                 (T <TELL "LOOK UNDER WORKBENCH. TAKE OIL CAN. LUBRICATE MECHANISM." CR>)>)
          (<EQUAL? .STAGE 9>
           <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "Someone small took the key. Look at the empty hook, then follow the trail outside." CR>)
                 (<EQUAL? ,HINT-LEVEL 2> <TELL "Tiny footprints in the snowy alley lead to Clock Square. The mailbox at the corner saw where they went." CR>)
                 (<EQUAL? ,HINT-LEVEL 3> <TELL "The fox is hiding past the scrap-yard, south of Clock Square. The scrap cart must be helped out of the way first." CR>)
                 (T <TELL "Go NORTH, EAST and SOUTH to the scrap-yard. SEARCH PILES, GIVE HEAD TO CART, then go EAST to the fox." CR>)>)
          (T
           <TELL "Grandfather's diagram is the best guide now. Every toy Pip has helped can stand by the heart." CR>)>
    <RTRUE>>

; === V-EASY-TOGGLE HANDLER ===

<ROUTINE V-EASY-TOGGLE ()
    <COND (,TIMER-ACTIVE
           <SETG TIMER-ACTIVE <>>
           <DISABLE <QUEUE I-TICK>>
           <DISABLE <QUEUE I-DAWN-WARNING>>
           <TELL "The dawn countdown is off. Explore Wrenfold at your own pace. Type EASY again to race the dawn." CR>)
          (T
           <SETG TIMER-ACTIVE T>
           <ENABLE <QUEUE I-TICK 1>>
           <ENABLE <QUEUE I-DAWN-WARNING 25>>
           <TELL "The dawn countdown is on. Every move brings the morning closer, so wind the heart before the sun comes up. Type EASY again to turn the countdown off." CR>)>>

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
            <CRLF>)
           (<VERB? RUB>
            <TELL "Pip touches the hook. It is as cold as a winter puddle. Last night it hummed warm under Pip's fingers, the way it always did when the key hung there." CR>)
           (<VERB? SMELL>
            <TELL "Pip sniffs the hook. Brass, old oil -- and, very faintly, something wild and furry, like a fox." CR>)
           (<VERB? KNOCK>
            <TELL "Pip taps the hook. It gives a thin, lonely ting that fades away into the quiet workshop." CR>)
           (<VERB? LISTEN>
            <TELL "Pip waits for the key’s familiar hum. The hook is so quiet that Pip can hear the workshop settling around him." CR>)>>

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
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "Knock, knock. Nobody answers, but a curl of cedar shaving drifts down from the top and lands on Pip's hat." CR>)
          (<VERB? SMELL>
           <TELL "The workbench smells of cedar, glue and Grandfather's peppermints. It smells like every good evening Pip can remember." CR>)
          (<VERB? RUB>
           <TELL "The carved legs are worn smooth, with little dents just right for Pip's hands and boots. Grandfather always said Pip climbed better than a squirrel." CR>)
          (<VERB? PUSH MOVE>
           <TELL "Pip pushes with all his might. The workbench is as big as a house to Pip, and it does not move one hair." CR>)>>

<ROUTINE OIL-CAN-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A tiny copper oil can, no bigger than Pip's thumb. It is about half full. The label reads: “Tolliver's Finest -- For Squeaks and Stiff Joints.”" CR>)
          (<VERB? SHAKE>
           <TELL "Pip shakes the can gently. Oil sloshes inside -- enough for a few uses." CR>)
          (<VERB? SMELL>
           <TELL "The oil smells warm and nutty, like toasted seeds. It is the smell of squeaky things being made quiet again." CR>)
          (<VERB? RUB>
           <TELL "Pip polishes the copper with a sleeve until it shines like a new penny. Pip can see a tiny, stretched reflection of his own face." CR>)
          (<VERB? OPEN>
           <TELL "Pip twists the little cap. One golden drop gleams at the spout. Pip screws the cap back on -- better save it for something stiff and rusty." CR>)>>

<ROUTINE SAWDUST-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Soft golden sawdust covers the floorboards. It smells of cedar and old wood. Pip would sweep it on any other night, but tonight there are more important things." CR>)
          (<VERB? TAKE>
           <TELL "The sawdust slips through Pip's fingers. There is not enough to carry." CR>)
          (<VERB? SMELL>
           <TELL "Pip breathes in. Cedar, sweet and sharp. Pip sneezes -- achoo! -- and a little golden cloud puffs up." CR>)
          (<VERB? KICK PLAY>
           <TELL "Pip kicks up the sawdust and it rains down glittering in the lamplight. For a moment it feels like an ordinary night." CR>)
          (<VERB? RUB SEARCH>
           <TELL "The sawdust is soft and warm under Pip's hands. Pip finds a bent tack and a pencil shaving, and nothing more." CR>)>>

<ROUTINE PET-DOOR-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A small pet door is cut into the bottom of the workshop's main door. It is just the right size for a workshop gnome -- or a fox toy. Moonlight and cold air seep through the flap." CR>)
          (<VERB? OPEN>
           <TELL "The pet door flap swings freely. It is just wide enough for Pip to slip into the snowy night." CR>)
          (<VERB? PUSH>
           <TELL "The flap swings out with a soft clack. A puff of icy air and three snowflakes blow in around Pip's boots." CR>)
          (<VERB? KNOCK>
           <TELL "Tock, tock. The flap rattles. Nobody knocks back -- only the wind." CR>)
          (<VERB? LISTEN>
           <TELL "Through the flap Pip hears the wind sighing down the alley and, far away, the slow tick of the clock tower." CR>)>>

<ROUTINE SWEEP-BROOM-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Pip's tiny broom has worn bristles and a handle smooth from use. It was one of the first things Tolliver ever made for his apprentice." CR>)
          (<VERB? SMELL>
           <TELL "The broom smells of sawdust and straw, and a little of Grandfather's pipe." CR>)
          (<VERB? RUB>
           <TELL "The handle is worn smooth in two places, exactly where Pip's hands always hold it." CR>)
          (<VERB? SHAKE>
           <TELL "Pip shakes the broom. A puff of golden sawdust falls from the bristles like snow." CR>)>>

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
           <TELL "Pip presses an ear to the clock. Tick, tick, tick -- steady as a heartbeat. Beneath it comes another rhythm, deeper and farther away, like a second heart below the workshop." CR>)
          (<VERB? KNOCK>
           <COND (,STUDY-ACCESS
                  <TELL "Pip knocks on the open clock case. The sound echoes up the narrow stairs behind it." CR>)
                 (T
                  <TELL "Tock, tock. The case sounds strangely hollow, as if there were empty space behind the wall. The little cuckoo door stays shut." CR>)>)
          (<VERB? PUSH MOVE OPEN>
           <COND (,STUDY-ACCESS
                  <TELL "The clock has already swung open. Narrow stairs lead [[into the study->in]]." CR>)
                 (T
                  <TELL "Pip pushes and pulls, but the clock is held fast against the wall. Something somewhere must be keeping it shut." CR>)>)
          (<VERB? RUB>
           <TELL "The wood is carved with tiny oak leaves. Pip's fingers find a little gear carved among them -- Grandfather's mark." CR>)
          (<VERB? WIND SPIN>
           <TELL "This clock ticks along by itself and has no winding hole Pip can find. Its twin up in the storage loft is the one with a winding hole." CR>)>>

<ROUTINE KEY-STRING-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A frayed piece of string, once used to hang the workshop key. The ends are chewed -- by small sharp teeth, from the look of it." CR>)
          (<VERB? SMELL>
           <TELL "Pip sniffs the string. It smells of snow and something wild and furry. A fox, surely." CR>)
          (<VERB? RUB>
           <TELL "Pip runs the string between two fingers. The chewed end is still a little damp." CR>)>>

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
                   <TELL "The ladder folds against the wall beneath the cuckoo [[clock]]. Its lifting [[mechanism]] is rusted solid. A drop of oil might free it." CR>)>)
          (<VERB? PUSH MOVE>
           <COND (,LADDER-OILED
                  <TELL "The ladder swings up and down as easily as a door. It is ready to climb." CR>)
                 (T
                  <TELL "The ladder shudders and creaks, but the rusty [[mechanism]] holds it tight against the wall." CR>)>)
          (<VERB? KNOCK RUB>
           <TELL "The broad rungs are made of good oak, warm and smooth. Grandfather built them wide enough for a gnome to stand on with both boots." CR>)>>

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
           <RTRUE>)
          (<VERB? RUB>
           <COND (,LADDER-OILED <TELL "The iron is slick and shiny with oil now. Pip wipes his fingers on his apron." CR>)
                 (T <TELL "Flakes of rust come away on Pip's fingers, orange as carrot peel." CR>)>)
          (<VERB? KICK KNOCK>
           <COND (,LADDER-OILED <TELL "Clang! The mechanism rings like a little bell and keeps working smoothly." CR>)
                 (T <TELL "Clang! A shower of rust falls, but the mechanism stays stuck. It needs oil, not kicks." CR>)>)>>

; === TOOL-BENCH OBJECT HANDLERS ===

"What Pip can show a toy to ask about Grandfather Tolliver: his name, his
coat, and the pages in his handwriting."

<ROUTINE TOLLIVER-TOPIC? (OBJ)
    <OR <EQUAL? .OBJ ,TOPIC-TOLLIVER ,TOLLIVER-COAT ,LETTER>
        <EQUAL? .OBJ ,TOLLIVER-JOURNAL ,STUDY-JOURNAL>>>

<ROUTINE BERTRAND-F ()
    <COND (<VERB? PLAY>
           <COND (,BERTRAND-WOUND
                  <TELL "“Play? A captain is on duty!” says Bertrand. Then he marches three smart steps up and down the bench anyway, just to show Pip how it is done." CR>)
                 (T <TELL "Pip tries a game of soldiers, but the frozen captain cannot even blink. He needs winding first." CR>)>)
          (<VERB? WIND> <V-WIND>)
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
                   <TELL "His painted mouth stays clamped shut. He looks like he has plenty to say, if only someone would wind him up." CR>)>)
          (<VERB? KNOCK>
           <COND (,BERTRAND-WOUND
                  <TELL "Pip knocks politely on Bertrand's wooden chest. “Enter!” he barks, then looks puzzled. “No, wait. That is not how chests work.”" CR>)
                 (T
                  <TELL "Pip knocks on the nutcracker's chest. Tock, tock -- solid wood. His painted eyes do not even blink." CR>)>)
          (<VERB? RUB>
           <COND (,BERTRAND-WOUND
                  <TELL "Pip straightens Bertrand's painted coat. “Thank you, apprentice,” he says stiffly. “A captain must look his best on duty.”" CR>)
                 (T
                  <TELL "Bertrand's paint is cool and glossy. His wooden arm is stuck fast in a salute that never quite finished." CR>)>)
          (<VERB? KISS>
           <COND (,BERTRAND-WOUND
                  <TELL "Pip kisses Bertrand's painted cheek. His face turns, if possible, even redder. “Most irregular,” he mutters, but his moustache twitches with pleasure." CR>)
                 (T
                  <TELL "Pip gives the frozen nutcracker a kiss on his painted cheek. Nothing happens. Kisses work in stories, but nutcrackers need winding." CR>)>)
          (<VERB? KICK ATTACK>
           <TELL "Pip would never kick a toy, even a pompous one. Grandfather always says toys are for loving, not bashing." CR>)>>

<ROUTINE BERTRAND-KEY-F ()
    <COND (<VERB? SPIN>
           <COND (<AND <EQUAL? ,HERE ,TOOL-BENCH> <IN? ,BERTRAND ,TOOL-BENCH>> <PERFORM ,V?WIND ,BERTRAND>)
                 (T <TELL "Pip rolls the key between two fingers. Its square tip fits the socket in Bertrand’s back." CR>)>)
          (<VERB? EXAMINE>
           <COND (<IN? ,BERTRAND-KEY ,TOOL-BENCH>
                  <TELL "A tiny brass winding key protrudes from the nutcracker's back. Its little wings are made for Pip's fingers; one good winding would wake the captain." CR>)
                  (T
                   <TELL "A tiny brass winding key. It is the exact size for winding a nutcracker -- or any other clockwork toy." CR>)>)
          (<VERB? RUB>
           <TELL "The little brass wings are smooth and warm, polished by years of Grandfather's fingers winding Bertrand every evening at six." CR>)>>

<ROUTINE VARNISH-POT-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE>
           <TELL "A pot of varnish, left open. The contents have gone thick and tacky -- useless for fine work now. The smell is faintly sweet and chemical." CR>)
          (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,VARNISH-POT>>
           <TELL "Anything dropped into that tacky varnish would never come out clean. Pip thinks better of it." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Pip sniffs, and his nose wrinkles all by itself. The varnish smells sweet and sharp at once, like burnt sugar and pine trees." CR>)
          (<VERB? RUB>
           <TELL "Pip dabs one finger on the surface. It comes away with a long, sticky string attached. Yuck! Pip wipes it on the bench." CR>)>>

<ROUTINE TOOL-RACK-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Grandfather cut a notch for each tool.">
           <COND (<AND <IN? ,TOY-CHISELS ,TOOL-BENCH> <FSET? ,TOY-CHISELS ,NDESCBIT>> <TELL " Tiny [[chisels]] hang in a row.">)>
           <COND (<AND <IN? ,TOY-FILES ,TOOL-BENCH> <FSET? ,TOY-FILES ,NDESCBIT>> <TELL " The [[needle-files]] share one notch.">)>
           <COND (<AND <IN? ,DETAIL-HAMMER ,TOOL-BENCH> <FSET? ,DETAIL-HAMMER ,NDESCBIT>> <TELL " A jeweller's [[hammer]] hangs by its head.">)>
           <TELL " An open [[varnish pot->pot]] stands beneath the rack." CR>)
          (<VERB? KNOCK MOVE>
           <TELL "Pip taps the rack. The tiny tools swing and jingle against each other like little silver bells." CR>)
          (<VERB? RUB>
           <TELL "Each notch is labelled in Grandfather's tiny pencil writing, so every tool always goes home to the same place." CR>)>>

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
           <RTRUE>)
          (<VERB? PUSH MOVE>
           <TELL "Pip leans on the crate. It does not wobble at all. Grandfather built these steps to last." CR>)
          (<VERB? SMELL>
           <TELL "The old repair books smell of leather and dust, and the crate smells of the apples it once held." CR>)>>
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
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "The book smells of old leather, cedar dust and pencil shavings, just like Grandfather's sleeves." CR>)
          (<VERB? RUB>
           <TELL "Pip traces the tiny gear and paintbrush stamped into the cover. The leather is soft and warm, like a well-loved boot." CR>)
          (<VERB? KNOCK>
           <TELL "Thump, thump. The heavy cover booms like a drum. It is a very serious sort of book." CR>)>>

<ROUTINE HALF-FINISHED-TOYS-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE>
           <TELL "Pip walks between Grandfather's unfinished inventions: a [[sailboat]] waiting for its mast, a [[train->wooden train]] with careful red wheels, and a [[wooden duck]] whose missing wheel leaves it tilted as if listening. Nothing here is discarded. Everything is waiting for Tolliver to return." CR>
           <RTRUE>)
          (<VERB? PLAY>
           <TELL "Pip rolls the train in a little loop and makes the duck waddle after it. “Choo-choo! Quack!” The toys do not wake, but Pip feels a bit braver." CR>)
          (<VERB? RUB>
           <TELL "The unfinished wood is still rough in places, waiting for Grandfather's sandpaper." CR>)>>
; === COUNTERTOP OBJECT HANDLERS ===

<ROUTINE MARZIPAN-F ()
    <COND (<VERB? PLAY>
           <TELL "Marzipan claps her soft hands and plays pat-a-cake with Pip. She keeps the beat perfectly and giggles every time Pip misses." CR>)
          (<VERB? EXAMINE>
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
                   <TELL "Marzipan tilts her head and sings: “Fox feet, fox feet, left the shop / Through the door with a hop and a hop / Key round neck and heart so sore / Find her where the broken toys snore.”" CR>)>)
          (<VERB? LISTEN>
           <TELL "Pip leans close. Marzipan's humming has no words, but it goes up and down like snow falling past a window. Now and then she peeks at Pip to see if he is still listening." CR>)
          (<VERB? RUB SQUEEZE>
           <TELL "Pip gives Marzipan a hug. She is soft and floppy and smells of lavender. Her humming grows a little warmer." CR>)
          (<VERB? KISS>
           <TELL "Pip kisses Marzipan's patched cheek. She giggles -- a tiny sound like a thimble rolling -- and hides her stitched smile behind one hand." CR>)
          (<VERB? KICK ATTACK>
           <TELL "Pip would never hurt Marzipan. She is one of Grandfather's best-loved toys." CR>)>>

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
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "Tink, tink. The glass rings softly">
           <COND (<IN? ,TIN-SOLDIER ,DISPLAY-CASE> <TELL ", and the tin soldier inside seems to stand a little straighter">)>
           <TELL "." CR>)
          (<VERB? RUB>
           <TELL "Pip wipes a clean stripe through the dust with one sleeve. Now he is dusty, and the glass is shining." CR>)>>

<ROUTINE TIN-SOLDIER-F ()
    <COND (<VERB? PLACE-HEART> <V-PLACE-HEART>)
          (<VERB? EXAMINE>
           <TELL "A brave tin soldier, painted in bright red and blue. There is a spot of rust on his bayonet, but his painted eyes are steady. He stands at attention, as if waiting for orders." CR>)
          (<AND <VERB? PLAY RUB KNOCK> <IN? ,TIN-SOLDIER ,DISPLAY-CASE> <NOT <FSET? ,DISPLAY-CASE ,OPENBIT>>>
           <TELL "The tin soldier stands behind the glass. Pip's fingers only squeak on the front of the display case." CR>)
          (<VERB? PLAY>
           <TELL "“Left, right, left, right!” Pip marches the tin soldier across the countertop. He is heavier than he looks, and very steady on his feet." CR>)
          (<VERB? RUB>
           <TELL "Pip rubs the spot of rust on the bayonet. It does not come off, but the tin warms quickly in Pip's hands." CR>)
          (<VERB? KNOCK>
           <TELL "Pip taps the soldier's tin hat. Ting! It rings bright and brave, like a tiny bugle." CR>)>>

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
                   <TELL "A small silver music box with a tiny crank on its side. It looks like it would play a tune if wound." CR>)>)
          (<AND <VERB? LISTEN RUB> <IN? ,MUSIC-BOX ,DISPLAY-CASE> <NOT <FSET? ,DISPLAY-CASE ,OPENBIT>>>
           <TELL "The music box sits silent behind the glass. Pip presses his nose to the case, but cannot touch it." CR>)
          (<VERB? LISTEN>
           <COND (<AND <IN? ,MUSIC-BOX ,WORKSHOP-HEART> <NOT <FSET? ,MUSIC-BOX ,TAKEBIT>>>
                  <TELL "The lullaby plays on and on, keeping time with the great heart." CR>)
                 (,MUSIC-BOX-PLAYED
                  <TELL "The tune has stopped, but Pip can still hum it. Grandfather's lullaby is hard to forget." CR>)
                 (T
                  <TELL "Pip holds the box to one ear. Silence -- but somewhere inside, a tiny spring is waiting to sing." CR>)>)
          (<VERB? RUB>
           <TELL "Pip polishes the silver lid. Tiny engraved snowflakes appear under the dust." CR>)>>

<ROUTINE SHOP-WINDOW-F ()
    <COND (<VERB? EXAMINE LOOK-THROUGH>
           <TELL "Through the frosted shop window, Pip can see the snowy street outside. The clock tower's face is pale in the moonlight, and the snow is deeper than Pip is tall.">
           <COND (<L? ,TICK-COUNT 31>
                  <TELL " The sky is noticeably lighter now. Dawn is approaching.">)>
           <TELL CR>)
          (<VERB? RUB>
           <TELL "Pip rubs a round peephole in the frost with his sleeve. Outside, the snowflakes drift past the streetlamps as slowly as feathers." CR>)
          (<VERB? KNOCK>
           <TELL "Tap, tap, tap. The cold glass rattles a little in its frame. Out in the street, nobody looks up." CR>)
          (<VERB? OPEN>
           <TELL "The window is painted shut, and far too big for Pip besides. The way outside is the pet door on the workshop floor." CR>)>>

<ROUTINE TOY-BUTTON-F ()
    <COND (<VERB? GIVE-TO> <V-GIVE-TO>)
          (<VERB? PLACE-HEART> <V-PLACE-HEART>)
          (<VERB? EXAMINE>
           <TELL "A spare black button, just the right size for a doll's missing eye. It is smooth and slightly warm, as if someone has been holding it." CR>)
          (<VERB? RUB>
           <TELL "Pip rubs the button until it shines. In it Pip sees a tiny round reflection -- and behind him, the rag doll's one eye watching hopefully." CR>)
          (<VERB? SPIN>
           <TELL "Pip spins the button on the countertop. It twirls like a tiny top, wobbles, and falls flat with a click." CR>)>>

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
    <COND (<VERB? PLAY>
           <COND (,OLD-TICK-HEARD
                  <TELL "Pip plays peekaboo with the little wooden bird. It pops out, says “Cuckoo!”, and pops back in, very pleased with itself." CR>)
                 (T <TELL "Pip tickles the clock's carved leaves, but nothing happens. The old clock needs winding before it can play." CR>)>)
          (<VERB? OPEN PUSH>
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
                  <TELL "Pip presses an ear to the old clock. Silence. But then -- was that a faint tick? It is hard to tell. The clock seems to need winding before it will speak." CR>)>)
          (<VERB? KNOCK>
           <COND (,OLD-TICK-HEARD
                  <TELL "Pip knocks. The little door pops open and the wooden bird peers out. “Who is there?” it asks. “Oh, it is you. Come in -- or rather, do not. There is no room in here.”" CR>)
                 (T
                  <TELL "Tock, tock. The bird's little door rattles, but stays shut. The bird inside must be fast asleep." CR>)>)
          (<VERB? RUB>
           <TELL "Pip wipes the dust from the clock's face. Underneath, the numbers are painted gold, and a tiny fox is carved beside the twelve." CR>)>>

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
            <RTRUE>)
           (<VERB? SMELL>
            <TELL "The box smells of old cardboard and dust, with a little whiff of glue." CR>)
           (<VERB? RUB>
            <TELL "Pip blows the dust off the label. Grandfather's handwriting is round and careful, the way he writes on Pip's birthday cards." CR>)
           (<VERB? PUSH MOVE>
            <TELL "Pip pushes the box. It scrapes across the boards and something inside rattles -- springs, perhaps, or wheels." CR>)>>

<ROUTINE DOLL-ARM-F ()
    <COND (<VERB? PLACE-HEART> <V-PLACE-HEART>)
          (<VERB? EXAMINE>
           <TELL "A delicate porcelain doll arm from Tolliver's repair box. The fingers are curled gently, as if reaching for something. He kept even this little broken piece; it was still worth saving." CR>)
          (<VERB? RUB>
           <TELL "The porcelain is cool and smooth as an eggshell. Pip holds it very carefully." CR>)
          (<VERB? SHAKE>
           <TELL "Pip gives the arm a tiny shake. The little hand seems to wave hello." CR>)>>

<ROUTINE TOLLIVER-JOURNAL-F ()
    <COND (<VERB? READ EXAMINE>
           <COND (<NOT ,JOURNAL-READ>
                  <SETG JOURNAL-READ T>
                  <SCORE-UPD 3>)>
           <TELL "Pip opens the leather journal. Tolliver's handwriting is neat but growing shakier with each entry. October 14th -- “The workshop key grows weaker. I must wind it more often now. The magic in this town depends on it.” October 20th -- “Old Tick tells me the heart needs attention. I will see to it tonight.” October 21st -- “I could not reach the heart alone. Something blocks the way. I must find another path. The toys need me. Pip needs me.” The rest of the pages are blank." CR>)>>

<ROUTINE COBWEBS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Dusty cobwebs drape the rafters like grey curtains. They have been here a long time -- nothing disturbs the dust up here. Or almost nothing." CR>)
          (<VERB? RUB MOVE>
           <TELL "Pip brushes the cobwebs aside. They stick to his fingers, tickly and grey, and a small spider glares at Pip from the rafter before tiptoeing away." CR>)
          (<VERB? SMELL>
           <TELL "Dust tickles Pip's nose. Ah -- ah -- achoo! The cobwebs sway." CR>)>>

; === SNOWY-ALLEY OBJECT HANDLERS ===

<ROUTINE FOOTPRINTS-F ()
    <COND (<VERB? FOLLOW>
           <COND (<EQUAL? ,HERE ,MAILBOX-CORNER> <DO-WALK ,P?WEST>)
                 (T <DO-WALK ,P?EAST>)>)
          (<VERB? EXAMINE>
           <COND (<EQUAL? ,HERE ,MAILBOX-CORNER>
                  <TELL "Two tracks overlap here. The little fox came to the post, turned, and put a paw almost exactly in her own print going back [[west]]. From there, they lead south toward the scrap-yard." CR>)
                 (T
                  <TELL "Tiny fox footprints in the snow -- unmistakably toy-sized. They lead [[east]] through the alley, toward the clock square. Someone small and fast came this way, and not long ago." CR>)>)
          (<VERB? RUB>
           <TELL "Pip kneels and fits a hand into one print. The paw that made it was hardly bigger than Pip's own palm, with four neat toes." CR>)
          (<VERB? SMELL>
           <TELL "Pip sniffs the snow. Cold, and underneath it, a faint smell of cedar shavings. Whoever made these tracks has been somewhere near a workshop." CR>)>>

<ROUTINE STREETLAMP-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A streetlamp -- really a toy lantern mounted on a pole. Its flame flickers weakly, but it still casts a warm circle of light on the snow. Someone cared enough to keep it lit." CR>)
          (<VERB? LAMP-ON>
           <TELL "The streetlamp is already lit. Its flame has been burning a long time." CR>)
          (<VERB? LISTEN>
           <TELL "The little flame hisses and pops, like someone whispering a secret too fast to understand." CR>)
          (<VERB? KNOCK KICK>
           <TELL "Pip taps the lamp post. Clink! The flame jumps, flickers, and settles again. Better not do that twice." CR>)
          (<VERB? RUB>
           <TELL "Pip warms his cold hands on the post. It is only a little warm, but it is better than nothing on a night like this." CR>)>>

<ROUTINE SNOW-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Fresh snow blankets the cobblestones. It sparkles around the fox footprints, and its cold reaches even through Pip's woollen clothes." CR>)
          (<VERB? TAKE>
           <TELL "The snow melts in Pip's tiny hands. There is no useful way to carry it." CR>)
          (<VERB? PLAY>
           <TELL "Pip rolls a snowball no bigger than a pea and sets it on top of a slightly bigger one. A very small snowman for a very small gnome." CR>)
          (<VERB? KICK>
           <TELL "Pip kicks the snow. It sprays up in a glittering fan -- and some of it goes down his collar. Brrr!" CR>)
          (<VERB? RUB>
           <TELL "The snow is soft on top and crunchy underneath. Pip's fingers turn pink with cold." CR>)>>

; === CLOCK-SQUARE OBJECT HANDLERS ===

<ROUTINE CLOCK-TOWER-F ()
    <COND (<VERB? EXAMINE>
           <COND (,TOWER-WOUND
                  <TELL "The clock tower stands over the square, its great face now ticking with a slow, steady beat. Time feels stretched -- Pip has bought precious extra hours." CR>)
                  (T
                   <TELL "The giant clock tower dominates the square. Its face shows the hours until dawn -- each tick of its great hand a reminder that time is running out. A brass winding mechanism sits at the base, too high for Pip to reach alone." CR>)>)
          (<VERB? LISTEN>
           <COND (,TOWER-WOUND
                  <TELL "TOCK ... ... TOCK. The tower ticks slowly now, deep and patient, as if time itself has decided to wait for Pip." CR>)
                 (T
                  <TELL "TOCK. TOCK. TOCK. The tower's tick is so deep that Pip feels it in his boots. It sounds as if it is in a hurry." CR>)>)
          (<VERB? WIND SPIN>
           <PERFORM ,V?WIND ,CLOCK-WINDING>
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "Pip knocks on the cold stone. The tower is far too big to notice." CR>)
          (<VERB? RUB>
           <TELL "The stones are rough and icy. Somebody long ago carved a tiny heart near the bottom, just at Pip's height." CR>)>>

<ROUTINE CLOCK-WINDING-DESC-F (RARG)
    <COND (<EQUAL? .RARG ,M-OBJDESC>
           <COND (,TOWER-WOUND
                  <TELL "The brass winding [[mechanism]] at the clock tower's base turns with a slow, deliberate rhythm." CR>)
                 (T
                  <TELL "At the foot of the tower, a brass winding [[mechanism]] is just out of reach." CR>)>
           <RTRUE>)>>

<ROUTINE CLOCK-WINDING-F ()
    <COND (<VERB? SPIN> <V-WIND>)
          (<VERB? WIND> <V-WIND>)
          (<VERB? EXAMINE>
           <COND (,TOWER-WOUND
                  <TELL "A small wheel catches a tooth, lifts it, and lets it drop. That little drop makes the tick Pip hears from the square." CR>)
                  (T
                   <TELL "A brass winding mechanism at the tower's base. It is just out of reach -- Pip needs something to stand on." CR>)>)
          (<VERB? LISTEN>
           <TELL "Inside the brass case, gears click and whir, as busy as bees in a hive." CR>)>>

<ROUTINE BAKER-TOY-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A wooden baker toy stands in the bakery window, frozen in the act of kneading dough. His painted smile is cheerful, but his eyes are still -- no magic left in him." CR>)
          (<VERB? KNOCK>
           <TELL "Pip knocks on the bakery window. Tap, tap. The baker does not look up. His hands stay sunk in the wooden dough." CR>)
          (<VERB? SMELL>
           <TELL "Pip presses his nose to the glass. Very faintly, the window still smells of cinnamon buns." CR>)
          (<VERB? RUB>
           <TELL "Pip can only touch the cold window in front of the baker. It leaves a small, foggy handprint." CR>)>>

<ROUTINE TOY-LAMPS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Tin toy lamps dot the cobblestones, their light weak and flickering. Like everything else in Wrenfold, they are running out of magic. Soon they will go dark too." CR>)
          (<VERB? RUB>
           <TELL "The nearest lamp is barely warm. Its tiny flame shivers as if it were cold too." CR>)
          (<VERB? LISTEN>
           <TELL "The lamps fizz quietly, like a kettle that has almost given up boiling." CR>)
          (<VERB? KICK ATTACK>
           <TELL "The poor lamps are struggling enough already. Pip leaves them be." CR>)>>

; === MAILBOX-CORNER OBJECT HANDLERS ===

<ROUTINE MAILBOX-F ()
    <COND (<VERB? PLAY>
           <TELL "Pip posts a pretend letter through the flap. The mailbox rattles happily and pretends to read it." CR>)
          (<VERB? EXAMINE>
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
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "Pip knocks on the red tin. “Ow!” says the mailbox. “Who is there? Oh. A gnome. Hello, gnome.”" CR>)
          (<VERB? RUB>
           <TELL "Pip pats the mailbox's cold red side. For a moment it stops shivering, and its flap gives a happy little flutter." CR>)
          (<VERB? KISS>
           <TELL "Pip kisses the mailbox on its tin cheek. The flap clatters bashfully. “Nobody has ever posted one of those to me before.”" CR>)>>

<ROUTINE LETTER-F ()
    <COND (<VERB? READ EXAMINE>
           <COND (<NOT ,LETTER-READ>
                  <SETG LETTER-READ T>
                  <SCORE-UPD 3>)>
           <TELL "A crumpled envelope. Inside is a letter in Tolliver's handwriting: “My dear Pip -- The heart is failing. I must go and mend it myself. Do not worry. Take care of the toys while I am gone. Wind the key at midnight if I do not return. I am proud of you, little apprentice. -- Grandfather Tolliver.” The letter is dated three days ago." CR>)
          (<VERB? SMELL>
           <TELL "The paper smells of peppermint and lamp oil. It smells exactly like Grandfather." CR>)
          (<VERB? OPEN LOOK-INSIDE> <PERFORM ,V?READ ,LETTER> <RTRUE>)
          (<VERB? RUB> <TELL "Pip smooths the envelope. One corner stays bent where Grandfather pressed it flat with his thumb." CR>)>>

<ROUTINE SCARF-F ()
    <COND (<VERB? GIVE-TO> <V-GIVE-TO>)
          (<VERB? EXAMINE>
           <TELL "A red wool scarf, dropped in the snow. It is well-made and still warm -- whoever lost it cannot have gone far. It looks like it would fit a small toy perfectly." CR>)
          (<VERB? RUB SQUEEZE>
           <TELL "The wool is thick and soft, the kind that keeps out the very coldest wind." CR>)
          (<VERB? WEAR>
           <TELL "Pip winds the scarf round and round his neck. It is so long that he trips over the end. Somebody colder needs it more -- Pip unwinds it again." CR>)
          (<VERB? SMELL>
           <TELL "The scarf smells of snow and wool and, a little, of a warm fireside far away." CR>)>>

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
          (<VERB? OPEN CLOSE>
           <TELL "The cart has rails, but no lid. A broken toy can always see the sky on its way home." CR>)
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
                   <TELL "The cart does not fight back. It simply continues its work, creaking along its track and ignoring Pip entirely." CR>)>)
          (<VERB? LISTEN>
           <COND (,CART-MOVED <TELL "The cart rumbles softly to itself, a low, contented sound, like a cat by the fire." CR>)
                 (T <TELL "Creak ... clank ... creak. Under the noise, the cart seems to be humming a slow, sad tune to the broken toys in its bed." CR>)>)
          (<VERB? RUB>
           <TELL "Pip pats the cold iron rail. The cart's creaking softens for a moment, as if it likes being noticed." CR>)
          (<VERB? KNOCK KICK>
           <TELL "Bong! The cart's side rings like a bell. Its mechanical arm lifts, waves at Pip in a puzzled way, and goes back to work." CR>)>>

<ROUTINE HEADLESS-DOLL-F ()
    <COND (<VERB? EXAMINE>
           <COND (<IN? ,DOLL-HEAD ,SCRAP-CART>
                  <TELL "The porcelain doll lies in the cart's bed in her torn dress, hands folded, her painted head resting beside her at last. She is ready to be mended." CR>)
                 (T
                  <TELL "A headless porcelain doll in a torn dress. Despite her state, someone has folded her hands neatly in her lap. She looks peaceful, somehow -- as if waiting to be made whole again." CR>)>)
          (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSO ,DOLL-HEAD> <EQUAL? ,PRSI ,HEADLESS-DOLL>>
           <V-GIVE-TO>)
          (<VERB? LISTEN>
           <TELL "Pip hears no voice, only the steady clack of the cart under the doll’s folded hands." CR>)
          (<VERB? TAKE>
           <TELL "The cart has laid her down so carefully. Pip leaves her in its keeping." CR>)
          (<VERB? RUB>
           <TELL "Pip smooths the doll's torn dress and tucks the loose lace back into place. Her folded hands are cold as snow." CR>)>>

<ROUTINE DOLL-HEAD-F ()
    <COND (<VERB? GIVE-TO> <V-GIVE-TO>)
          (<AND <VERB? TAKE> <IN? ,DOLL-HEAD ,SCRAP-CART>>
           <TELL "The head rests beside its doll in the cart now. Pip leaves them together." CR>)
          (<VERB? EXAMINE>
           <TELL "A porcelain doll head with painted blue eyes and rosebud lips. It matches the headless doll in the cart. They were clearly once part of the same toy." CR>)
          (<VERB? RUB>
           <TELL "Pip gently wipes the snow from the doll's cheeks. Her painted eyes look a little less lonely." CR>)>>

<ROUTINE TOY-HORSE-F ()
    <COND (<AND <VERB? TAKE> <IN? ,TOY-HORSE ,SCRAP-CART>>
           <TELL "The horse is safe in the cart's bed, waiting to be mended. Pip leaves it there." CR>)
          (<VERB? EXAMINE>
           <TELL "A wooden toy horse, its paint chipped and one leg missing. It rocks gently at Pip's touch, as if dreaming of galloping." CR>)
          (<VERB? PLAY>
           <TELL "“Clip-clop, clip-clop!” Pip rocks the horse back and forth. It wobbles on its three legs, but it seems to enjoy it." CR>)
          (<VERB? RUB>
           <TELL "Pip strokes the horse's painted mane. Under the chips, the paint was once a bright cherry red." CR>)>>

<ROUTINE YARD-GATE-F ()
    <COND (<VERB? EXAMINE>
           <COND (,CART-MOVED
                  <TELL "Scraped paint on the gate shows how tightly the cart was wedged. Now Pip can walk through without turning sideways." CR>)
                  (T
                   <TELL "A [[wheel->cart wheels]] of the scrap cart is wedged against the gatepost. Pushing the gate itself would only push against the wheel." CR>)>)
          (<VERB? OPEN PUSH>
           <COND (,CART-MOVED <TELL "The gate already stands open. The way [[east]] is clear." CR>)
                 (T <TELL "Pip pushes the gate. It clanks against the cart's wheel and will not open while the cart is in the way." CR>)>)
          (<VERB? KNOCK>
           <TELL "Clang, clang. The iron gate rings in the cold air. Somewhere beyond it, something small goes very quiet." CR>)>>

; === FOX-DEN OBJECT HANDLERS ===

<ROUTINE NUTMEG-F ()
    <COND (<VERB? PLAY>
           <COND (<EQUAL? ,NUTMEG-TRUST -1>
                  <TELL "Nutmeg keeps her back to Pip. She is not ready to play. Saying sorry might help." CR>)
                 (<OR ,KEY-FOUND <G? ,NUTMEG-TRUST 0>>
                  <TELL "Pip and Nutmeg play chase round and round the little den. She lets Pip catch her tail, then steals Pip's hat and gives it back with a swish." CR>)
                 (T <TELL "Pip wiggles his fingers like a mouse. Nutmeg's ears flick toward them, but she stays curled up, watching. She does not trust Pip yet." CR>)>)
          (<VERB? EXAMINE>
           <COND (<NOT <IN? ,NUTMEG ,FOX-DEN>>
                  <TELL "Nutmeg is not here. Her den feels empty -- just rags and a little candle." CR>)
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
                  <SETG NUTMEG-TRUST ,NUTMEG-GIFTS>
                  <RTRUE>)
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
                  <TELL "“Nutmeg,” she says at last. “That is my name. Please do not take the ticking away. It is cold enough here already.”" CR>)>)
          (<VERB? RUB>
           <COND (<EQUAL? ,NUTMEG-TRUST -1>
                  <TELL "Pip reaches out, but Nutmeg shivers and turns further away. She needs to hear that Pip is sorry first." CR>)
                 (<OR ,KEY-FOUND <G? ,NUTMEG-TRUST 0>>
                  <TELL "Nutmeg leans into Pip's hand. Her patchy fur is soft as an old mitten, and she gives a small, surprised sigh." CR>)
                 (T
                  <TELL "Nutmeg flinches away from Pip's hand -- then, very slowly, she stretches her nose forward and sniffs his fingers." CR>)>)
          (<VERB? KISS>
           <COND (<EQUAL? ,NUTMEG-TRUST -1>
                  <TELL "Nutmeg hides her face in her paws. Not yet." CR>)
                 (T
                  <TELL "Pip kisses the top of Nutmeg's head. Her ears go flat with embarrassment, but her tail gives one small swish." CR>)>)
          (<VERB? LISTEN>
           <COND (,KEY-FOUND
                  <TELL "Nutmeg is humming. It is the first time Pip has heard her sound happy." CR>)
                 (T
                  <TELL "Under Nutmeg's quiet breathing, the workshop key ticks faintly against her chest -- tick ... tick ... slower than it should." CR>)>)
          (<VERB? KICK>
           <TELL "Pip would never kick Nutmeg. She has been hurt enough already." CR>)>>

<ROUTINE WORKSHOP-KEY-F ()
    <COND (<VERB? SPIN>
           <COND (<EQUAL? ,HERE ,WORKSHOP-HEART> <PERFORM ,V?WIND ,HEART-MECH>)
                 (T <TELL "The key turns between Pip’s fingers. It needs the winding hole in the workshop heart." CR>)>)
          (<AND <VERB? TAKE> ,KEY-WOUND>
           <TELL "The winding teeth hold it fast. Pip leaves the key turning with the heart." CR>)
          (<VERB? LISTEN>
           <COND (,KEY-WOUND <TELL "The key ticks in time with the great heart now, loud and sure." CR>)
                 (T <TELL "Tick ... tick ... tick. The key's ticking is faint and slow, like a sleepy heartbeat." CR>)>)
          (<VERB? RUB>
           <TELL "The brass is warm, warmer than metal should be. Under Pip's thumb the carved pattern feels like tiny gears." CR>)
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
    <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE>
           <COND (<AND <IN? ,STRING-BALL ,FOX-DEN> <NOT <FSET? ,STRING-BALL ,TOUCHBIT>>> <TELL "A ball of red [[yarn]] nestles in the rags. ">)>
           <TELL "A cosy nest of rags and twigs. It smells faintly of cedar shavings -- the same scent as Tolliver's workshop. Someone has made this place into a home." CR>)
          (<VERB? RUB>
           <TELL "The rags are soft and still a little warm. One of them is a scrap of Grandfather's old flannel shirt." CR>)
          (<VERB? SMELL>
           <TELL "Cedar shavings and warm fox. It smells like somebody trying very hard to feel at home." CR>)>>

<ROUTINE TOY-CANDLE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A tiny toy candle, no bigger than Pip's finger. Its flame is steady and warm -- real fire, real light. It must have been burning for a long time." CR>)
          ;"Not LAMP-OFF: its TURN OFF grammar wants the candle in hand, so a
            reader's menu would offer an action that can only be refused."
          (<VERB? BLOW>
           <TELL "Pip considers blowing it out, but stops. It is the only warmth in this cold little den." CR>)
          (<VERB? SMELL>
           <TELL "The candle smells of honey and beeswax, sweet as a summer afternoon." CR>)
          (<VERB? RUB>
           <TELL "Pip holds his cold hands near the little flame -- not too near. Warmth creeps back into his fingers." CR>)>>

<ROUTINE STRING-BALL-F ()
    <COND (<VERB? GIVE-TO> <V-GIVE-TO>)
          (<VERB? EXAMINE>
           <TELL "A ball of red yarn. It is slightly frayed, as if someone has been playing with it. A fox, perhaps." CR>)
          (<VERB? PLAY>
           <TELL "Pip rolls the yarn across the floor. It unwinds a little red trail, and Pip winds it back up again, round and round." CR>)
          (<VERB? RUB SQUEEZE>
           <TELL "The yarn is soft and squashy, with tooth marks here and there." CR>)>>

; === TOLLIVER-STUDY OBJECT HANDLERS ===

<ROUTINE TOLLIVER-COAT-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Grandfather Tolliver's worn tweed coat. It still smells like him -- wood shavings, lamp oil, and something faintly like peppermint. The pockets are empty." CR>)
          (<VERB? WEAR>
           <TELL "The coat is far too large for Pip; it would swallow him whole. Still, Pip wraps a corner around his shoulders. It is warm. It still feels like Tolliver." CR>)
          (<VERB? SMELL>
           <TELL "Pip buries his face in the tweed. Wood shavings, lamp oil, peppermint. For a moment Pip's eyes sting." CR>)
          (<VERB? SQUEEZE>
           <TELL "Pip hugs the big coat as hard as he can. It is almost like hugging Grandfather." CR>)
          (<VERB? SEARCH LOOK-INSIDE>
           <TELL "Pip climbs halfway into a pocket. It holds only a peppermint wrapper and a little curl of brass wire." CR>)>>

<ROUTINE TEA-CUP-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A cup of tea, long gone cold. A skin of dust floats on the surface. Tolliver never got to finish it." CR>)
          (<VERB? DRINK>
           <TELL "Pip dips one finger in the cold tea. It is bitter with age, so he leaves the rest." CR>)
          (<VERB? SMELL>
           <TELL "Cold peppermint tea. Grandfather always drank peppermint tea while he worked late." CR>)
          (<VERB? RUB>
           <TELL "The cup is stone cold. Nobody has touched it for a long while." CR>)>>

<ROUTINE STUDY-DESK-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE>
           <TELL "A half-finished sketch of the workshop heart covers the desk.">
           <COND (<AND <IN? ,TEA-CUP ,TOLLIVER-STUDY> <NOT <FSET? ,TEA-CUP ,TOUCHBIT>>> <TELL " A [[cup of tea->cup]] stands nearby.">)>
           <COND (<IN? ,STUDY-JOURNAL ,STUDY-DESK> <TELL " Tolliver's [[journal]] lies open.">)>
           <COND (<IN? ,DIAGRAM ,STUDY-DESK>
                  <TELL " Beside the sketch lies a hand-drawn winding [[diagram]].">)>
           <CRLF>)
          (<VERB? LOOK-UNDER>
           <TELL "Pip crawls under the desk. Here the ticking from [[down]] below is loudest, coming up through the boards." CR>)
          (<VERB? KNOCK>
           <TELL "Pip knocks on the desk. Something deep below the floor seems to tick back." CR>)
          (<VERB? RUB>
           <TELL "The wood is worn pale where Grandfather's elbows rested night after night." CR>)>>

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
           <CRLF>)
          (<VERB? RUB>
           <TELL "The seat is worn into a soft hollow. It is cold now -- nobody has sat here for days." CR>)
          (<VERB? PUSH MOVE>
           <TELL "Pip pushes the chair in neatly under the desk, the way Grandfather likes it. It will be ready when he comes home." CR>)>>

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
                   <TELL "Silence. The heart is completely still. Not even an echo." CR>)>)
          (<VERB? RUB>
           <COND (,KEY-WOUND <TELL "The brass is growing warm under Pip's hand, like a loaf fresh from the oven." CR>)
                 (T <TELL "The brass is cold as ice. Pip pulls his hand back and blows on his fingers." CR>)>)
          (<VERB? KNOCK>
           <TELL "Pip knocks on the great brass case. BONGGG. The sound rolls round and round the chamber, and the silent toys seem to listen." CR>)
          (<VERB? PUSH MOVE KICK>
           <TELL "Pip leans on the heart with all his weight. It is bigger than a house to Pip and does not budge. Only its key can make it turn." CR>)>>

<ROUTINE KEY-SLOT-F ()
    <COND (<VERB? EXAMINE>
           <COND (,KEY-WOUND
                  <TELL "The [[workshop key]] is in the keyhole, turning steadily. The brass gleams with renewed warmth." CR>)
                  (T
                   <TELL "An empty brass keyhole sits at the heart’s centre. Four square corners wait for a winding key." CR>)>)
          (<VERB? LOOK-INSIDE>
           <TELL "Pip peers into the keyhole. Deep inside, rows of brass teeth wait in the dark, ready to catch a key." CR>)
          (<VERB? RUB>
           <TELL "The edges of the keyhole are smooth and shiny, worn by years of Grandfather's careful winding." CR>)>>

<ROUTINE SILENT-TOYS-F ()
    <COND (<VERB? EXAMINE>
           <COND (,KEY-WOUND
                  <COND (,GAME-WON
                         <TELL "The toys around the heart are stirring. Paint is brightening. Joints are loosening. They are waking up." CR>)
                        (T
                         <TELL "The silent toys around the chamber walls. Their painted eyes seem to follow Pip. They are waiting -- hoping -- that the magic will return." CR>)>)
                  (T
                   <TELL "Dozens of toy figures stand around the heart chamber. Soldiers, dolls, wooden animals -- all of them motionless. Their paint is dull. Their joints are stiff. They are waiting for the heart to beat again." CR>)>)
          (<VERB? RUB>
           <TELL "Pip pats a wooden bear on the nose. Its paint is cold, but Pip is sure he saw one ear twitch." CR>)
          (<VERB? LISTEN>
           <COND (,KEY-WOUND <TELL "Here and there a spring creaks and a joint clicks. The toys are beginning to stir." CR>)
                 (T <TELL "The toys make no sound at all. It is the quietest crowd Pip has ever seen." CR>)>)>>

; === LOCAL-GLOBALS ACTION HANDLERS ===

<ROUTINE WORKSHOP-BUILDING-F ()
    <COND (<VERB? EXAMINE>
           <COND (,GAME-WON
                  <TELL "The workshop looks different now. Warm light glows in every window. The magic has returned, a steady, gentle hum from deep within the building." CR>)
                  (T
                   <TELL "Grandfather Tolliver's workshop -- a cosy old building with frosted windows and a crooked chimney. From outside, nobody would guess the magic it holds within." CR>)>)
          (<VERB? KNOCK>
           <TELL "Pip knocks on the workshop wall. Nobody answers. Grandfather would have called “Come in, little one!” by now." CR>)
          (<VERB? LISTEN>
           <TELL "From inside comes the soft tick of the cuckoo clock. It sounds lonely without Grandfather humming along." CR>)>>

<ROUTINE MOON-F ()
    <COND (<VERB? EXAMINE>
           <COND (<L? ,TICK-COUNT 31>
                  <TELL "The winter moon is fading now, pale against the brightening sky. Dawn is near." CR>)
                  (T
                   <TELL "A bright winter moon hangs overhead, casting long blue shadows across the snow. It is a beautiful night -- but a cold one." CR>)>)
          (<VERB? LISTEN>
           <TELL "The moon makes no sound at all, but the snow under it seems to hum very quietly." CR>)>>

<ROUTINE BAKERY-F ()
    <COND (<VERB? EXAMINE>
           <TELL "An abandoned bakery storefront. Through the dusty window, a wooden baker toy stands frozen mid-knead. The glass is frosted with age, and the door hangs slightly ajar." CR>)
          (<VERB? SMELL>
           <TELL "Even now, a ghost of cinnamon and warm bread drifts from the bakery door. Pip's tummy rumbles." CR>)
          (<VERB? KNOCK>
           <TELL "Pip knocks on the bakery door. It creaks a little wider, but nobody comes. Inside, everything is dark and still." CR>)
          (<VERB? ENTER THROUGH OPEN>
           <TELL "The bakery door is stuck with frost, open only a crack. Pip's business tonight is with the key, not the buns." CR>)>>

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
           <TELL "Far above, the shop door bangs open, and boots stamp off the snow. “Pip?” calls Grandfather Tolliver, out of breath from searching the whole town for another way to the heart. He hurries down the study stairs, sees the gears turning, and laughs. “You found the way yourself. Well done, apprentice. Well done.”" CR CR>
           <COND (,NUTMEG-SAVED
                  <TELL "Nutmeg curls at Pip's feet, her patchy fur warm">
                  <COND (<IN? ,SCARF ,NUTMEG>
                         <TELL " and her new red scarf bright in the candlelight">)>
                  <TELL ". “You kept your promise,” she says. “Nobody ever kept their promise before.”" CR CR>)
                 (T
                  ;"A reader who frightened Nutmeg still ends on a way back."
                  <TELL "Far away in her den behind the scrap-yard, Nutmeg lifts her head at the sound of the chimes. Tomorrow, Pip decides, he will visit her first thing and say sorry properly." CR CR>)>
           <TELL "The sun rises over Wrenfold, and every toy in town is awake to see it." CR>
           <TELL "The last of the night's cold fades from Pip's bones. At last, Pip is home." CR CR>
           <TELL "*** Pip has restored the heart of Wrenfold ***" CR>)
          (T
           <SETG ENDING-TIER 1>
           <TELL CR>
           <TELL "The workshop heart shudders and begins to turn -- weakly, unsteadily, but it turns. A few toys in the nearest shop windows stir and blink. The streetlamps flicker but do not stay lit." CR CR>
           <TELL "Far above, the shop door bangs open, and Grandfather Tolliver hurries down the study stairs, out of breath from searching the town. He listens to the heart and smiles. “Well done, apprentice. We will wake the others together.”" CR CR>
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
    <COND (<VERB? PUSH> <TELL "The hull rocks twice and settles on its keel." CR>)
          (<VERB? PLAY> <TELL "Pip blows into the little sail. “Whoosh!” The sailboat bobs on an imaginary sea of sawdust." CR>)
          (<VERB? RUB> <TELL "Pip slides a finger along the hull. At the pointed end, the wood is smooth enough not to catch a single wave." CR>)>>

<ROUTINE DETAIL-WOODEN-TRAIN-F ()
    <COND (<VERB? PUSH> <TELL "The train rolls a finger’s length. Its last wheel drags a red streak across the bench." CR>)
          (<VERB? PLAY MOVE> <TELL "“Choo-choo!” Pip pulls the train along a crack in the bench as if it were a railway line." CR>)
          (<VERB? LISTEN> <TELL "The little engine is silent. Pip makes a whistle small enough for its chimney." CR>)>>

<ROUTINE DETAIL-WOODEN-DUCK-F ()
    <COND (<VERB? PUSH> <TELL "The duck rolls round in a circle on its one good wheel and bumps Pip’s thumb." CR>)
          (<VERB? PLAY> <TELL "“Quack, quack,” says Pip for the duck, who cannot say it yet. The duck tilts as if it agrees." CR>)
          (<VERB? KNOCK> <TELL "Pip taps the duck’s hollow belly. It answers with a small wooden cluck, which is close enough." CR>)>>

<ROUTINE MUSIC-TOOTH-F ()
    <COND (<VERB? RUB> <TELL "A tiny buzz tickles Pip’s fingertip as the note dies away." CR>)>>

<ROUTINE DISTANT-TICK-F ()
    <COND (<VERB? LISTEN> <TELL "Tick … tick. It is loudest under the desk, where the boards lead [[down]]." CR>)>>

<ROUTINE DETAIL-PAINT-MARK-F ()
    <COND (<VERB? READ> <TELL "The red arrow points [[east]], toward the mailbox." CR>)
          (<VERB? FOLLOW> <DO-WALK ,P?EAST>)
          (<VERB? RUB> <TELL "The paint is dry and a little flaky. Whoever painted the arrow did it in a hurry." CR>)>>

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

<ROUTINE SQUARE-PATHS-F ()
    <COND (<VERB? RUB>
           <TELL "The wooden cobbles are worn smooth and round by years of little feet -- toy feet, gnome feet, children's boots." CR>)
          (<VERB? FOLLOW>
           <TELL "The paths wind every way at once. The red arrow on the cobbles points [[east]], toward the mailbox." CR>)
          (<VERB? KNOCK>
           <TELL "Pip stamps on the cobbles. Tock, tock -- they are hollow little wooden blocks, like a giant's xylophone." CR>)>>

<ROUTINE MAILBOX-SNOW-F ()
    <COND (<VERB? PLAY>
           <TELL "Pip scoops out a little cave in the drift, just big enough to sit in. It is surprisingly cosy out of the wind." CR>)
          (<VERB? KICK RUB>
           <TELL "The drift is crusted hard on top. Pip's boot crunches through into powdery snow below." CR>)>>

<ROUTINE TOWN-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Wrenfold is a little town of crooked roofs and snowy chimneys. Every window is dark tonight. In every house, Pip knows, toys are lying very still." CR>)
          (<VERB? LISTEN>
           <TELL "The whole town is hushed. No music boxes, no tin drums, no toy trains rattling under beds. Only the clock tower, ticking." CR>)>>

<ROUTINE DEN-ENTRANCE-F ()
    <COND (<VERB? RUB>
           <TELL "A few orange hairs are caught on the wire. Somebody comes and goes this way often." CR>)
          (<VERB? KNOCK>
           <TELL "Pip knocks on a crate beside the opening. From the bed comes a small, startled sniff." CR>)>>

<ROUTINE BENCH-SHAVINGS-F ()
    <COND (<VERB? SMELL>
           <TELL "The curls smell of fresh cedar, sweet and clean, like the inside of a new pencil." CR>)
          (<VERB? PLAY KICK>
           <TELL "Pip tosses a curl into the air and catches it on his head like a hat. It looks very fine." CR>)
          (<VERB? TAKE>
           <TELL "Pip picks up a curl, then puts it back. There are more important things to carry tonight." CR>)>>

<ROUTINE WORK-LAMP-F ()
    <COND (<VERB? RUB>
           <TELL "The brass shade is warm. Pip holds his hands close to it and feels the cold go out of his fingers." CR>)
          (<VERB? SMELL>
           <TELL "The lamp smells of warm brass and a little of lamp oil. It is the smell of Grandfather working late." CR>)
          (<VERB? MOVE PUSH>
           <TELL "The jointed arm swings a little, and the golden circle of light slides across the half-finished toys." CR>)>>

<ROUTINE HEART-CHAMBER-F ()
    <COND (<VERB? RUB>
           <TELL "Pip lays a hand on the nearest pipe. ">
           <COND (,KEY-WOUND <TELL "It throbs gently, warm as a cat, with every beat of the heart." CR>)
                 (T <TELL "It is cold and silent." CR>)>)
          (<VERB? KNOCK LISTEN>
           <TELL "Pip taps a pipe. Ting -- the sound runs up into the ceiling and comes back from far away, as if the whole workshop were listening." CR>)>>

<ROUTINE BENCH-SHELF-F ()
    <COND (<VERB? RUB>
           <TELL "Pip runs a hand along the wood. It is rough with little nicks, and one of them is shaped almost exactly like a star." CR>)
          (<VERB? KNOCK>
           <TELL "Tock, tock. The tools on the rack jingle in reply." CR>)>>

<ROUTINE COUNTER-TOP-F ()
    <COND (<VERB? RUB>
           <TELL "Pip slides a finger along the polished wood. It squeaks, and Pip's finger comes away a little dusty." CR>)
          (<VERB? KNOCK>
           <TELL "Pip knocks on the countertop. Behind the glass, the toys on display give a tiny rattle." CR>)>>

<ROUTINE WORKSHOP-HEART-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "This is the heart [[chamber]], deep beneath the workshop, where all of Wrenfold's magic begins.">
           <COND (,KEY-WOUND
                  <TELL " Brass [[pipes]] run along the walls, humming now, and the air is growing warm. Dozens of [[toys]] stand in a ring around the great brass [[machine]], and here and there one of them twitches.">)
                 (T
                  <TELL " Brass [[pipes]] run along the walls, and the air is cold and very still. Dozens of silent [[toys]] stand in a ring around a great brass [[machine]], as if they came here hoping to be wound.">)>
           <TELL " The narrow [[passage]] leads back [[up]] to the study." CR>)>>
