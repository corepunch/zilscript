;"Opening, room and object descriptions, and companion choices."

<SYNTAX USE OBJECT = V-USE>
<SYNTAX STOP OBJECT = V-BW-STOP>
<ROUTINE V-BW-STOP () <MSG-THEME>>
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
 (SYNONYM WINCH CRANK REEL HANDLE) (ADJECTIVE HAND MANUAL)>
<OBJECT MARKET-TAGS (DESC "market tags") (SYNONYM TAG TAGS LABEL LABELS STALL) (ADJECTIVE MARKET)>
<OBJECT MIRROR (DESC "signal mirror")
 (SYNONYM MIRROR GLASS REFLECTOR) (ADJECTIVE SIGNAL TILTED)>
<OBJECT CACHE (DESC "supply chest")
 (SYNONYM CACHE CHEST BOX CRATE) (ADJECTIVE SUPPLY)>
<OBJECT CELL (DESC "power cell")
 (SYNONYM CELL BATTERY) (ADJECTIVE POWER)>
<OBJECT SOCKET (DESC "emergency socket")
 (SYNONYM SOCKET PORT) (ADJECTIVE EMERGENCY POWER)>
<OBJECT LOOM (DESC "Loom") (SYNONYM LOOM MACHINE) (ADJECTIVE STITCHING REALITY)>
<OBJECT BW-HOME-DOOR (DESC "last door") (SYNONYM DOOR DOORWAY) (ADJECTIVE LAST HOME)>
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
 <TELL "Pick your hero: Spider-Man, Storm or Iron Man. Type 'choose spider-man' or pick a name from the menu." CR>>

<ROUTINE MSG-CAMP ()
 <TELL "Ms. Marvel runs camp in half a schoolyard. A brass beacon crackles beside her. The bridge is north, and the sheltered ridge is south." CR>>

<ROUTINE MSG-SPAN ()
 <TELL "A small boat hangs below the broken bridge. Its passengers sit very still. A hand winch grips the rope. The boat blocks the way north to market. Camp is south." CR>>

<ROUTINE MSG-SPAN-BLOCK ()
 <TELL "The boat blocks the bridge. Try ">
 <COND (<NOT ,BW-RESCUE-TRIED> <TELL "'rescue boat' or ">)>
 <TELL "'pull winch'." CR>>

<ROUTINE MSG-SPAN-CLEAR ()
 <TELL "The empty boat taps against the bridge. A red mitten hangs from the rail. The market is now open to the north. Camp is south." CR>>

<ROUTINE MSG-MARKET ()
 <TELL "The market tilts downhill. Tags flap above a mirror and supply chest. The repair shop is east, Doom's tower north, and the bridge south." CR>
 <MSG-MARKET-SCALES>>

<ROUTINE MSG-MARKET-TAGS ()
 <TELL "One tag says LEFT SOCK. Another says ECHO, BARELY USED. The apples have all rolled into the same corner." CR>>

<ROUTINE MSG-WORKSHOP ()
 <TELL "Chalk outlines show where the tools hang. By the bench, a cable runs from an empty power socket up to the tower. The market is west." CR>>

<ROUTINE MSG-TOWER ()
 <TELL "The Loom tugs a bright thread from a half-open door. Doctor Doom flickers beside it. The stairs south lead to market. A bridge north leads to Galactus's ship." CR>>

<ROUTINE MSG-HOME-DOOR ()
 <TELL "Through the crack, you see a kitchen table back on Earth. The Loom's thread holds the door fast." CR>>

<ROUTINE MSG-HELPER ()
 <COND (,EVACUATED
        <TELL "Ms. Marvel pours soup for the passengers. 'Doom ran a cable from the repair shop to the tower. Try it if the Loom gives you trouble.'" CR>)
       (T <TELL "'The rope is holding for now,' says Ms. Marvel. 'Use your power to rescue the boat, or pull the winch. I'll get the soup ready.'" CR>
          <TELL "At the bridge, try 'rescue boat' or 'pull winch'." CR>)>>

<ROUTINE MSG-BEACON ()
 <TELL "Someone has penciled RESCUE ONLY on the brass. The speaker hisses. 'This is Doom. I offer one simple choice: agree now or agree later.' You turn the volume down to a much more useful crackle." CR>>

<ROUTINE MSG-SKIFF ()
 <COND (,EVACUATED
        <TELL "The passengers are safe. Someone tied a red mitten to the empty boat's rail." CR>)
       (T <TELL "The boat tips when anyone moves. 'Boats can't be afraid of heights,' says a girl. 'They don't have knees.' Try 'rescue boat' or 'pull winch'." CR>)>>

<ROUTINE MSG-RESCUE-SUCCESS ()
 <COND (<==? ,RPG-PRESET-INDEX 1>
        <TELL "Two web lines catch the bow. You stretch a third into a handrail, and the passengers cross one by one. 'Please keep your arms inside the ride until it has come to a complete stop.' The girl steps off and asks if she can go again." CR>)
       (<==? ,RPG-PRESET-INDEX 2>
        <TELL "You lift a pocket of air under the hull. The skiff rises on it, steady as a leaf cupped in a hand, until the passengers step onto the stone. Only then do you let the wind out, one soft breath at a time." CR>)
       (T <TELL "You match the skiff's swing and take its weight on both gauntlets. A little sideways thrust sets it down at the edge of the road. 'Arrival at Platform One,' you tell the passengers. One of them claps the way people do when a plane lands." CR>)>>

<ROUTINE MSG-RESCUE-FAIL ()
 <TELL "The boat tips. The rope hits your shoulder. You lose 5 Health, but everyone stays aboard. Try 'pull winch'." CR>>

<ROUTINE MSG-RESCUE-WINCH ()
 <TELL "You lean into the handle. It gives an indignant squeak, then winds the skiff up to the road. The girl puts both boots on the stone. 'It didn't even scream.' Behind her the winch squeaks louder, as if it objects to the record." CR>>

<ROUTINE MSG-RESCUE-ALREADY ()
 <TELL "Everyone is already walking toward the soup pot. Let the boat rock." CR>>

<ROUTINE MSG-WINCH ()
 <COND (,EVACUATED
        <TELL "The winch holds the empty boat in place." CR>)
       (T <TELL "The winch reels in the boat's rope. Try 'pull winch' or 'pull handle'." CR>)>>

<ROUTINE MSG-MIRROR ()
 <TELL "A sun and a tower are painted on the frame. Turn the mirror to line them up and send daylight into the tower." CR>>

<ROUTINE MSG-MIRROR-CLUE ()
 <TELL "The swivel turns, but you have no idea where to aim it. Two painted marks are almost hidden under its lip. Examine the mirror first." CR>>

<ROUTINE MSG-MIRROR-SET ()
 <TELL "Sun meets tower with a little click. A bar of yellow light springs across the square and holds steady on the teeth at the top of the tower. Way up above, something gives a bright and very definite chime." CR>>

<ROUTINE MSG-CACHE ()
 <TELL "One corner of the chest is stenciled EMERGENCY POWER. ">
 <COND (<NOT <FSET? ,CACHE ,OPENBIT>>
        <TELL "Open its lid for a better look." CR>)
       (<IN? ,CELL ,CACHE>
        <TELL "A power cell about the size of a lunchbox fits snugly in its padding." CR>)
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
 <TELL "Your blow cuts across Doom's cape and hits nothing. Green light knits back together, button by button. 'If I intended to be punched, I would have attended in person.' The real work is still happening at the Loom." CR>>

<ROUTINE MSG-LOOM ()
 <TELL "Two drawings show how to free the door:" CR "• Turn the market mirror to send sunlight into the tower." CR "• Put a battery in the repair shop socket." CR>>

<ROUTINE MSG-LOOM-BLOCK ()
 <TELL "The thread is too tight. Try the mirror at the market or the power socket in the repair shop. The stairs south are clear." CR>>

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
        <CHOICE "bw.camp.span" "Go to the bridge" "north" ,CHOICE-PROGRESS 100>
        <CHOICE "bw.camp.helper" "Check in with Ms. Marvel" "examine marvel" ,CHOICE-INVESTIGATE 90>
        <CHOICE "bw.camp.beacon" "Listen to the brass beacon" "examine beacon" ,CHOICE-INVESTIGATE 80>)
       (<==? ,HERE ,SPAN>
        <COND (,EVACUATED
               <CHOICE "bw.span.market" "Cross to the tilted market" "north" ,CHOICE-PROGRESS 100>)
              (T <COND (<NOT ,BW-RESCUE-TRIED>
                          <CHOICE "bw.span.power" "Rescue the boat with your power" "rescue boat" ,CHOICE-PROGRESS 100>)>
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
