;"English edition of The Last Door of Battleworld. Story behavior lives in
  the shared book; this file supplies prose, vocabulary and companion cards."

<SYNTAX USE OBJECT = V-USE>
<SYNTAX USE OBJECT ON OBJECT = V-BW-FIT>
<SYNTAX FIT OBJECT IN OBJECT = V-BW-FIT>
<SYNONYM FIT INSERT>
<ROUTINE V-BW-FIT () <TELL "Those pieces don't fit together. Try examining them for a mark or a matching shape." CR>>
<SYNTAX ALIGN OBJECT = V-BW-TURN>
<SYNTAX TURN OBJECT = V-MOVE>

<ROOM SETUP-DESK (DESC "Signal Desk")>
<ROOM CAMP (DESC "The Makeshift Camp")>
<ROOM SPAN (DESC "The Hanging Span")>
<ROOM MARKET (DESC "The Tilted Market")>
<ROOM WORKSHOP (DESC "The Repair Shop")>
<ROOM TOWER (DESC "The Loom Tower")>

<OBJECT CARD-SPIDER (DESC "Spider-Man profile")
 (SYNONYM SPIDER-MAN SPIDER SPIDERMAN MAN) (ADJECTIVE SPIDER)>
<OBJECT CARD-STORM (DESC "Storm profile") (SYNONYM STORM)>
<OBJECT CARD-IRON (DESC "Iron Man profile") (SYNONYM IRON MAN IRONMAN) (ADJECTIVE IRON)>
<OBJECT HELPER (DESC "Ms. Marvel") (SYNONYM MARVEL HELPER HERO) (ADJECTIVE MS)>
<OBJECT BEACON (DESC "brass beacon")
 (SYNONYM BEACON RADIO RECEIVER) (ADJECTIVE BRASS)>
<OBJECT SKIFF (DESC "rescue skiff")
 (SYNONYM SKIFF BOAT PASSENGERS CIVILIANS) (ADJECTIVE RESCUE STRANDED)>
<OBJECT WINCH (DESC "hand winch")
 (SYNONYM WINCH CRANK REEL) (ADJECTIVE HAND MANUAL)>
<OBJECT MIRROR (DESC "signal mirror")
 (SYNONYM MIRROR GLASS REFLECTOR) (ADJECTIVE SIGNAL TILTED)>
<OBJECT CACHE (DESC "supply chest")
 (SYNONYM CACHE CHEST BOX CRATE) (ADJECTIVE SUPPLY)>
<OBJECT CELL (DESC "power cell")
 (SYNONYM CELL BATTERY) (ADJECTIVE POWER)>
<OBJECT SOCKET (DESC "emergency socket")
 (SYNONYM SOCKET PORT) (ADJECTIVE EMERGENCY)>
<OBJECT LOOM (DESC "Loom") (SYNONYM LOOM MACHINE) (ADJECTIVE STITCHING REALITY)>
<OBJECT DOOM (DESC "Doctor Doom")
 (SYNONYM DOOM PROJECTION) (ADJECTIVE DOCTOR DR)>

<ROUTINE RPG-PRESET-TITLE (INDEX)
 <COND (<==? .INDEX 1> <TELL "Spider-Man">)
       (<==? .INDEX 2> <TELL "Storm">)
       (T <TELL "Iron Man">)>>

<ROUTINE RPG-PRESET-SUMMARY (INDEX)
 <COND (<==? .INDEX 1> <TELL "Catch a falling skiff with web lines. Quick hands and quicker replies.">)
       (<==? .INDEX 2> <TELL "Carry people to safety on a current of air. Calm enough to hear the wind change.">)
       (T <TELL "Put armored flight and precision thrusters to work. There's a tool for almost everything.">)>>

<ROUTINE MSG-SETUP ()
 <TELL "Three rescue signals blink on the same scrap of sky. Choose [[Spider-Man->spider-man]], [[Storm->storm]], or [[Iron Man->iron]] to answer. You can examine each profile before you decide." CR>>

<ROUTINE MSG-CAMP ()
 <TELL "The camp occupies half a schoolyard and the wrong end of a railway platform. The soup pot is on the doubles court. [[Ms. Marvel->marvel]] has the court's chalkboard tipped up on a chair so she can count the people coming in. A [[beacon]] on the bench crackles. The path [[north]] leads down to the Hanging Span. The sheltered path goes [[south]] to the ridge." CR>>

<ROUTINE MSG-SPAN ()
 <TELL "Where the road runs out, the [[skiff]] hangs below you on a line that is unspooling one click at a time. The passengers are sitting very still. A [[hand winch->winch]] is bolted to the stone by your boot. The road to the market runs [[north]] beyond the span, and the camp is [[south]]." CR>>

<ROUTINE MSG-SPAN-CLEAR ()
 <TELL "The empty [[skiff]] knocks gently against the stones. Someone left a red mitten hooked to its rail. The [[winch]] has stopped clicking. The way is clear [[north]] to the Tilted Market; the camp lies [[south]]." CR>>

<ROUTINE MSG-MARKET ()
 <MSG-MARKET-SCALES>
 <TELL "The market leans downhill just enough for every loose apple to end up at the same stall. A [[mirror]] on a swivel is catching the last sunlight. Someone has shoved a [[supply chest->cache]] under the stall. The repair shop is [[east]], the tower [[north]], and the span [[south]]." CR>>

<ROUTINE MSG-WORKSHOP ()
 <TELL "Every tool is outlined in chalk on the wall, including the ones someone has borrowed. An [[emergency socket->socket]] juts from a bench under a cable that runs up into the tower. The alley back to the market is [[west]]." CR>>

<ROUTINE MSG-TOWER ()
 <TELL "The open tower has no roof: just a ring of teeth where the sky goes through. The [[Loom->loom]] pulls a bright thread from a half-open doorway, one slow inch at a time. [[Doctor Doom->doom]] stands beside it. Moonlight goes straight through his cape. The stair leads [[south]] to the market; a docking bridge reaches [[north]] to the Worldship." CR>>

<ROUTINE MSG-HELPER ()
 <COND (,EVACUATED
        <TELL "Ms. Marvel puts three cups of soup on the edge of the bench. 'Everyone's off the span. Doom ran a line from the repair shop into the tower. If the Loom won't listen to you, see what it's connected to.'" CR>)
       (T <TELL "'No one on that deck can reach the road,' says Ms. Marvel. 'You can reach them with your powers. And if it gets messy, look for the winch where the road ends. The catch is holding for now. Take a moment to look before you move. I'll bring hot soup, which is very useful and doesn't look dramatic at all.'" CR>)>>

<ROUTINE MSG-BEACON ()
 <TELL "Someone has penciled RESCUE ONLY on the brass. The speaker hisses. 'This is Doom. I offer one simple choice: agree now or agree later.' You turn the volume down to a much more useful crackle." CR>>

<ROUTINE MSG-SKIFF ()
 <COND (,EVACUATED
        <TELL "A passenger has tied the red mitten to the rail by its thumb. The skiff is empty; nobody here needs rescuing again." CR>)
       (T <TELL "The skiff pitches when anyone moves. A little girl is explaining to the others that a boat can't be afraid of heights, because it doesn't have knees. The yellow winch line runs right through the skiff's bow ring." CR>)>>

<ROUTINE MSG-RESCUE-SUCCESS ()
 <COND (<==? ,RPG-PRESET-INDEX 1>
        <TELL "Two web lines catch the bow. You stretch a third into a handrail, and the passengers cross one by one. 'Please keep your arms inside the ride until it has come to a complete stop.' The girl steps off and asks if she can go again." CR>)
       (<==? ,RPG-PRESET-INDEX 2>
        <TELL "You lift a pocket of air under the hull. The skiff rises on it, steady as a leaf cupped in a hand, until the passengers step onto the stone. Only then do you let the wind out, one soft breath at a time." CR>)
       (T <TELL "You match the skiff's swing and take its weight on both gauntlets. A little sideways thrust sets it down at the edge of the road. 'Arrival at Platform One,' you tell the passengers. One of them claps the way people do when a plane lands." CR>)>>

<ROUTINE MSG-RESCUE-FAIL ()
 <TELL "The skiff rolls to one side before you can bring it in. A catch takes the line with a hard click. The line clips your shoulder. You lose 5 Health, but no one falls. The yellow line goes through the bow ring: pull the [[winch]] to bring the skiff in close." CR>>

<ROUTINE MSG-RESCUE-WINCH ()
 <TELL "You lean into the handle. It gives an indignant squeak, then winds the skiff up to the road. The girl puts both boots on the stone. 'It didn't even scream.' Behind her the winch squeaks louder, as if it objects to the record." CR>>

<ROUTINE MSG-RESCUE-ALREADY ()
 <TELL "Everyone is already walking toward the soup pot. Let the boat rock." CR>>

<ROUTINE MSG-WINCH ()
 <COND (,EVACUATED
        <TELL "The teeth of the winch are holding the yellow line fast. The rescue is over, but whoever gets this rig next will find it ready." CR>)
       (T <TELL "The yellow line is still threaded through the skiff. Hand-painted arrows show which way the drum draws it in. No power outlet, no lever puzzle. A firm pull on the handle ought to do it." CR>)>>

<ROUTINE MSG-MIRROR ()
 <TELL "There's a painted sun on the swivel collar and a tiny picture of the Loom tower on its rim. Line those marks up and the mirror will throw the last stripe of daylight into the tower's open top." CR>>

<ROUTINE MSG-MIRROR-CLUE ()
 <TELL "The swivel turns, but you have no idea where to aim it. Two painted marks are almost hidden under its lip. Examine the [[mirror]] first." CR>>

<ROUTINE MSG-MIRROR-SET ()
 <TELL "Sun meets tower with a little click. A bar of yellow light springs across the square and holds steady on the teeth at the top of the tower. Way up above, something gives a bright and very definite chime." CR>>

<ROUTINE MSG-CACHE ()
 <TELL "One corner of the chest is stenciled EMERGENCY POWER. ">
 <COND (<NOT <FSET? ,CACHE ,OPENBIT>>
        <TELL "Open its lid for a better look." CR>)
       (<IN? ,CELL ,CACHE>
        <TELL "A [[power cell->cell]] about the size of a lunchbox fits snugly in its padding." CR>)
       (T <TELL "The padding inside still has a lunchbox-sized dent." CR>)>>

<ROUTINE MSG-CELL ()
 <TELL "The power cell warms the palms. Three brass ribs fit only one way. A strip of tape says REPAIR SHOP, and underneath, in smaller and more emphatic letters: NOT FOR THE KETTLE." CR>>

<ROUTINE MSG-SOCKET ()
 <TELL "Three grooves run into the emergency socket under a crossed-out picture of a kettle. It needs a charged power cell; the matching connector will slot straight in." CR>>

<ROUTINE MSG-SOCKET-SET ()
 <TELL "All three ribs slide home. The cable jumps overhead and the bench's little service light glows green. Someone long ago painted a cheerful OK beside it. For once, it is right." CR>>

<ROUTINE MSG-SOCKET-ALREADY ()
 <TELL "The service light is still green. Unplugging the backup would only make you walk this alley twice." CR>>

<ROUTINE MSG-DOOM ()
 <TELL "'When every doorway leads to the same place, nobody gets lost,' says Doom. Behind him the last door offers you a glimpse of a kitchen table, somewhere with ordinary weather. Doom doesn't turn around. 'I fail to see why you object.'" CR>>

<ROUTINE MSG-DOOM-STRIKE ()
 <TELL "Your blow cuts across Doom's cape and hits nothing. Green light knits back together, button by button. 'If I intended to be punched, I would have attended in person.' The real work is still happening at the [[Loom->loom]]." CR>>

<ROUTINE MSG-LOOM ()
 <TELL "Two diagrams are etched on the Loom's plate. The first shows daylight striking the top of the tower: with a signal to follow, the Loom can unwind its last stitch. The second shows a cable from the repair shop: with emergency power, you can force the Loom to cut its thread. Neither diagram has Doom's face on it, which is how you know he didn't draw them." CR>>

<ROUTINE MSG-LOOM-BLOCK ()
 <TELL "The thread is too tight to touch. The Loom needs a signal or backup power. The stair is clear [[south]] to the market, where the mirror can catch daylight and the repair shop can supply a charge. The door hasn't closed yet." CR>>

<ROUTINE MSG-WIN-MIRROR ()
 <TELL "You feed the bar of daylight into the Loom's eye. Its needles start walking backward. The last stitch slips loose, then the next, and the doorway swings wide without tearing a single edge. On the far side, a kettle begins to whistle. Doom reaches to mute it, but his green fingers go straight through." CR CR
       "The Loom goes quiet with its thread still on the spool. Whoever eventually repairs these seams will have something to work with." CR>>

<ROUTINE MSG-WIN-CELL ()
 <TELL "You give the backup line one firm pulse. The Loom cuts its own stitch, and the trapped doorway flies open. A shower of loose thread drifts down like gold party streamers. Doom's image tries to finish a sentence and gets as far as 'I alw—' before a tiny spark puts it out." CR CR
       "The old thread burns out as the doorway settles. This time nobody will be able to close it by simply flipping a switch." CR>>

<ROUTINE MSG-END-DIRECT ()
 <TELL "At the doorway Ms. Marvel hands you the red mitten. 'A thank-you gift. Apparently she wants you to keep it in case you have to rescue a cold hand.' Beyond her the skiff passengers are already finding their way home." CR CR
       "THE END: THE LAST DOOR STAYS OPEN" CR>>

<ROUTINE MSG-END-ASSISTED ()
 <TELL "At the doorway Ms. Marvel shows you the chalkboard. Under HEROES, a child's hand has written your name and, underneath it, WINCH. 'I gave it a cup of soup,' says Ms. Marvel. 'It made no promises.'" CR CR
       "THE END: THE LAST DOOR STAYS OPEN" CR>>

<ROUTINE MSG-THEME ()
 <TELL "At a seam between worlds, a loose blue thread trembles as if someone on the other side has just drawn a breath." CR>>

<ROUTINE SUGGEST-ACTIONS ()
 <BW-EARLY-CHOICES>
 <BW-VILLAGE-CHOICES>
 <BW-LATE-CHOICES>
 <COND (<AND <NOT ,BW-CHARGED> <IN? ,CELL ,HERE>>
        <CHOICE "bw.cell.retake" "Pick the power cell back up" "take cell" ,CHOICE-PROGRESS 98>)>
 <COND (<==? ,HERE ,SETUP-DESK>
        <CHOICE "bw.profile.spider" "Start as Spider-Man" "choose spider-man" ,CHOICE-PROGRESS 100>
        <CHOICE "bw.profile.storm" "Start as Storm" "choose storm" ,CHOICE-PROGRESS 99>
        <CHOICE "bw.profile.iron" "Start as Iron Man" "choose iron man" ,CHOICE-PROGRESS 98>)
       (<==? ,HERE ,CAMP>
        <CHOICE "bw.camp.ridge" "Return to the sheltered ridge" "south" ,CHOICE-RETURN 60>
        <CHOICE "bw.camp.span" "Follow the rescue signal to the span" "north" ,CHOICE-PROGRESS 100>
        <CHOICE "bw.camp.helper" "Check in with Ms. Marvel" "examine marvel" ,CHOICE-INVESTIGATE 90>
        <CHOICE "bw.camp.beacon" "Listen to the brass beacon" "examine beacon" ,CHOICE-INVESTIGATE 80>)
       (<==? ,HERE ,SPAN>
        <COND (,EVACUATED
               <CHOICE "bw.span.market" "Cross to the tilted market" "north" ,CHOICE-PROGRESS 100>)
              (T <COND (<NOT ,BW-RESCUE-TRIED>
                          <CHOICE "bw.span.power" "Reach the skiff with your hero's power" "focus skiff" ,CHOICE-PROGRESS 100>)>
                 <CHOICE "bw.span.skiff" "Check the passengers and the rescue line" "examine skiff" ,CHOICE-INVESTIGATE 95>
                 <CHOICE "bw.span.winch" "Haul the skiff in with the winch" "pull winch" ,CHOICE-PROGRESS 90>)>
        <CHOICE "bw.span.camp" "Head back to the rescue camp" "south" ,CHOICE-RETURN 60>)
       (<==? ,HERE ,MARKET>
        <COND (<NOT ,BW-ALIGNED>
               <COND (,BW-MIRROR-SEEN
                      <CHOICE "bw.market.align" "Align the mirror with the tower mark" "turn mirror" ,CHOICE-PROGRESS 100>)
                     (T <CHOICE "bw.market.mirror" "Study the marks on the swiveling mirror" "examine mirror" ,CHOICE-INVESTIGATE 97>)>)>
        <COND (<NOT ,BW-CHARGED>
               <COND (<NOT <FSET? ,CACHE ,OPENBIT>>
                      <CHOICE "bw.market.cache" "Open the emergency supply chest" "open cache" ,CHOICE-INVESTIGATE 96>)
                     (<IN? ,CELL ,CACHE>
                      <CHOICE "bw.market.cell" "Take the power cell" "take cell" ,CHOICE-PROGRESS 98>)>)>
        <CHOICE "bw.market.shop" "Duck into the repair shop" "east" ,CHOICE-INVESTIGATE 90>
        <CHOICE "bw.market.tower" "Climb the stairs to Doom's Loom" "north" ,CHOICE-PROGRESS 92>
        <CHOICE "bw.market.span" "Return to the span" "south" ,CHOICE-RETURN 60>)
       (<==? ,HERE ,WORKSHOP>
        <COND (<AND <NOT ,BW-CHARGED> <IN? ,CELL ,WINNER>>
               <CHOICE "bw.shop.charge" "Power the cable to the tower" "use socket" ,CHOICE-PROGRESS 100>)
              (T <CHOICE "bw.shop.socket" "Check where the emergency cable goes" "examine socket" ,CHOICE-INVESTIGATE 90>)>
        <CHOICE "bw.shop.market" "Go back to the market square" "west" ,CHOICE-RETURN 95>)
       (<==? ,HERE ,TOWER>
        <COND (,BW-ALIGNED
               <CHOICE "bw.tower.light" "Use the daylight to unwind the last stitch" "use loom" ,CHOICE-PROGRESS 100>)>
        <COND (,BW-CHARGED
               <CHOICE "bw.tower.charge" "Send emergency power through the Loom" "focus loom" ,CHOICE-PROGRESS 99>)>
        <CHOICE "bw.tower.loom" "Read the diagrams on the Loom" "examine loom" ,CHOICE-INVESTIGATE 95>
        <CHOICE "bw.tower.doom" "Hear Doom's argument for closing the exits" "examine doom" ,CHOICE-INVESTIGATE 80>
        <CHOICE "bw.tower.market" "Take the stairs back to the market" "south" ,CHOICE-RETURN 90>)>>
