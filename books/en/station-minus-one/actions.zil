<SYNTAX TURN OBJECT = V-SPIN>
<SYNTAX LISTEN = V-STATION-LISTEN>
<SYNTAX SMELL = V-STATION-SMELL>
<GLOBAL LOOP-OBSERVED <>>

<ROUTINE V-STATION-LISTEN ()
 <COND (<EQUAL? ,HERE ,TICKET-HALL> <PERFORM ,V?LISTEN ,STATION-CLOCK>)
       (<EQUAL? ,HERE ,STAFF-ROOM> <PERFORM ,V?LISTEN ,STAFF-SINK>)
       (<EQUAL? ,HERE ,GAUGE-ROOM> <PERFORM ,V?LISTEN ,GAUGE-FROST>)
       (<EQUAL? ,HERE ,LOWER-PLATFORM> <PERFORM ,V?LISTEN ,PLATFORM-TRACK>)>
 <RTRUE>>

<ROUTINE V-STATION-SMELL ()
 <COND (<EQUAL? ,HERE ,TICKET-HALL> <TELL "The cold has a chalky smell here. When the clock skips, you catch the faintest trace of hot dust." CR>)
       (<EQUAL? ,HERE ,STAFF-ROOM> <PERFORM ,V?SMELL ,RINSED-CUPS>)
       (<EQUAL? ,HERE ,GAUGE-ROOM> <TELL "Cold metal and the clean, sharp smell of a machine that has just switched on." CR>)
       (<EQUAL? ,HERE ,LOWER-PLATFORM> <PERFORM ,V?SMELL ,PLATFORM-TRACK>)>
 <RTRUE>>
<GLOBAL STATION-END 0>
<GLOBAL STAFF-CHAIR-TUCKED <>>

<ROUTINE STATION-CLOCK-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "The second hand sweeps up toward twelve, and every time it crosses, the clock jerks back and comes out one second behind midnight again. It has been one second to midnight for an hour. Beneath it hangs the [[arrivals board->board]]." CR>)
       (<VERB? LISTEN>
  <TELL "It ticks steadily, and then, just at the top of the minute, there is a double tick, like a heel caught on a stair." CR>)
       (<VERB? RUB TAKE MOVE>
  <TELL "The clock is bolted high above the wickets, well out of reach." CR>)
       (<VERB? WIND>
  <TELL "There is no key and no winder. The clock takes its time from the rail signal, and the rail signal is the thing that has gone wrong." CR>)
       (<VERB? LOOK-BEHIND>
  <TELL "Only a fat grey cable, running from the clock along the ceiling toward the platform." CR>)
       (<VERB? SPIN>
  <TELL "The hands are behind glass, high above the wickets. The clock takes its time from the rail, not from anyone's fingers." CR>)>>

<ROUTINE ARRIVALS-BOARD-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "Every line of the arrivals board is blank except one: ARRIVAL MINUS ONE, due here yesterday. Beside it, where the board would say ON TIME or DELAYED, a small amber word keeps flickering: CALLING." CR>)
       (<VERB? RUB KNOCK>
  <TELL "The board is hung high under the clock. Even on tiptoe you can only reach its frame, which is faintly warm." CR>)
       (<VERB? LISTEN>
  <TELL "Each time CALLING flickers, the board gives a tiny click, the same rhythm as the platform bell." CR>)
       (<VERB? TAKE MOVE>
  <TELL "It is bolted under the clock, far out of reach." CR>)>>

<ROUTINE TICKET-WICKETS-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A row of waist-high steel ticket gates, locked open for the night. Each little screen shows a red dash where the next train's time should be." CR>)
       (<VERB? PUSH MOVE KICK>
  <TELL "The nearest gate swings, clacks against its stop, and settles. The sound runs all the way round the empty hall." CR>)
       (<VERB? RUB>
  <TELL "The steel is cold enough to sting. Someone has polished the top rail to a shine with years of passing hands." CR>)
       (<VERB? CLIMB-ON CLIMB-FOO OPEN CLOSE>
  <TELL "No need. They are locked open; you can walk straight through." CR>)>>

<ROUTINE STAFF-TABLE-F ()
 <COND (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,STAFF-TABLE>>
  <COND (<HELD? ,PRSO>
         <MOVE ,PRSO ,STAFF-ROOM>
         <TELL "You set the " D ,PRSO " down on the table, beside the logbook." CR>)
        (T <TELL "You aren't holding that." CR>)>)
       (<EQUAL? ,PRSI ,STAFF-TABLE> <RFALSE>)
       (<VERB? EXAMINE>
  <TELL "A scuffed staff table with tea rings all over it. The [[logbook]] lies open in the middle, where whoever is on shift can't miss it." CR>)
       (<VERB? LOOK-UNDER>
  <COND (,STAFF-CHAIR-TUCKED <TELL "The [[chair]] is tucked under the table now. You can see a crescent in the dust where its feet dragged." CR>)
        (T <TELL "Only dust, and a [[chair]] pushed back as if someone got up in a hurry." CR>)>)
       (<VERB? KNOCK>
  <TELL "It sounds hollow and cheap. Nobody answers, which is a relief." CR>)
       (<VERB? TAKE MOVE PUSH>
  <TELL "The table is screwed to the floor, in case a train ever shakes the station." CR>)>>

<ROUTINE RINSED-CUPS-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Two plain station cups, rinsed and turned upside down to drain. Both are still damp inside. You only made tea for yourself tonight." CR>)
       (<VERB? SMELL>
  <TELL "Tea, and under it something sharper, like hot brakes." CR>)
       (<VERB? RUB>
  <TELL "Both are cool and wet. One has a chip in the rim that you don't remember." CR>)
       (<VERB? TAKE>
  <TELL "You leave them where they are. Whoever rinsed the second one may want it." CR>)
       (<VERB? DRINK DRINK-FROM>
  <TELL "Both cups are empty. Only the smell of stewed tea is left in the room." CR>)
       (<VERB? LOOK-UNDER>
  <TELL "Under each cup is a small ring of water on the drainer, nothing more." CR>)>>

<ROUTINE STAFF-CHAIR-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A plastic staff chair.">
  <COND (,STAFF-CHAIR-TUCKED <TELL " It is tucked neatly under the table.">)
        (T <TELL " It stands at an angle, as though someone stood up in a hurry.">)>
  <TELL " The seat is still faintly warm." CR>)
       (<VERB? CLIMB-ON CLIMB-FOO>
  <COND (,STAFF-CHAIR-TUCKED <TELL "You pull the chair out. "> <SETG STAFF-CHAIR-TUCKED <>>)>
  <TELL "You sit for a moment. From here the open logbook is right in front of you. Then the platform bell rings again, faintly, and you get up." CR>)
       (<VERB? PUSH>
  <COND (,STAFF-CHAIR-TUCKED <TELL "The chair is already under the table. Its back gives a hollow click against the edge." CR>)
        (T <SETG STAFF-CHAIR-TUCKED T>
           <TELL "You tuck the chair back under the table. It scrapes on the concrete, loud in the empty station." CR>)>)
       (<VERB? MOVE>
  <COND (,STAFF-CHAIR-TUCKED <SETG STAFF-CHAIR-TUCKED <>>
         <TELL "You pull the chair out. One foot drags through the dust and catches at just the angle you found it." CR>)
        (T <TELL "The chair is already pulled out far enough to sit down." CR>)>)>>

<ROUTINE SHIFT-LOG-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "The night operator's last entry is in pencil: “Yesterday's test train ran empty, and an empty run can leave a reflection on the rail, an echo that looks like a train arriving. To tell the difference, seat the ceramic puck in the gauge cradle and push the calibration stud. A reflection weighs nothing. I didn't build this station to wave at ghosts.”" CR>)
       (<VERB? TAKE>
  <TELL "The logbook is chained to the table leg. It belongs to the station, not to whoever is on shift." CR>)
       (<VERB? SMELL>
  <TELL "Pencil shavings and old tea. The pages are soft from damp." CR>)
       (<VERB? RUB>
  <TELL "The operator pressed hard enough to dent the paper. You can feel the last entry from the back of the page." CR>)
       (<VERB? CLOSE>
  <TELL "You start to close it, then leave it open. The next person on shift should see it." CR>)>>

<ROUTINE TEST-PUCK-F ()
 <COND (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,RECEIVER-CRADLE> <HELD? ,TEST-PUCK>>
  <MOVE ,TEST-PUCK ,RECEIVER-CRADLE>
  <TELL "The puck settles into the cradle with a ceramic click. Beside it, the [[calibration stud->stud]] glows once: the gauge has its reference weight." CR>)
       (<VERB? EXAMINE>
  <TELL "A white ceramic disc the size of your palm, heavier than it looks and faintly warm, even here. STANDARD LOAD is stamped around its rim, and one side is notched to fit the receiver cradle in the gauge room." CR>)
       (<VERB? SMELL>
  <TELL "It smells of nothing but clean clay and a little dust." CR>)
       (<VERB? RUB>
  <TELL "The glaze is smooth, and the warmth seems to come from inside it." CR>)
       (<VERB? LISTEN>
  <TELL "Held to your ear it hums very faintly, the same note as the gauge room floor." CR>)
       (<VERB? READ>
  <TELL "STANDARD LOAD. The letters are stamped around the rim, except for a gap where the notch lines up with the receiver cradle." CR>)
       (<VERB? SHAKE>
  <TELL "Nothing rattles. It is solid all the way through." CR>)
       (<VERB? TURN SPIN>
  <COND (<IN? ,TEST-PUCK ,RECEIVER-CRADLE> <TELL "The notch holds it exactly in place. You can lift it out, but it will not turn in the cradle." CR>)
        (T <TELL "You turn the disc over. The underside is polished in one spot, where the cradle has held it a few thousand times." CR>)>)>>

<ROUTINE RECEIVER-CRADLE-F ()
 <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE>
  <COND (<IN? ,TEST-PUCK ,RECEIVER-CRADLE>
         <TELL "The [[ceramic puck->puck]] sits flush in the cradle. Push the [[stud]] and the gauge will weigh whatever is on the track against it." CR>)
        (T <TELL "A round hollow in the console with one notch in its rim, sized for a standard ceramic weight. The [[stud]] beside it can't run a test until the cradle holds one." CR>)>)
       (<VERB? CLOSE> <TELL "The cradle has no lid. The puck sits in the open." CR>)
       (<VERB? RUB>
  <TELL "Unlike everything else in the room, the metal is warm, as if it has been used recently." CR>)
       (<VERB? TAKE MOVE>
  <TELL "The cradle is part of the console. It isn't going anywhere." CR>)
       (<VERB? LOOK-UNDER>
  <TELL "A bundle of wires runs from underneath it into the floor, toward the track." CR>)
       (<VERB? KNOCK>
  <TELL "You tap the rim. The little readout does not move; the instrument is listening to the rail, not to you." CR>)>>

<ROUTINE CALIBRATION-STUD-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A low, square brass button, worn smooth by thumbs. Pressing it makes the gauge weigh whatever is on the track, measured against the weight in the [[cradle]]. A needle and a little readout window sit just above it.">
  <COND (,LOOP-OBSERVED
         <TELL " The needle still rests at the full weight of a train.">
         <COND (<NOT <IN? ,TEST-PUCK ,RECEIVER-CRADLE>>
                <TELL " That is the last reading, not a new one; the [[cradle]] is empty now.">)>
         <CRLF>)
        (T <TELL " The needle rests at zero." CR>)>)
       (<VERB? PUSH>
        <COND (<NOT <IN? ,TEST-PUCK ,RECEIVER-CRADLE>>
               <TELL "EMPTY REFERENCE, says the little window over the stud. The gauge has nothing to measure against; you need to seat a ceramic puck in the [[cradle]] first." CR>)
              (,LOOP-OBSERVED
               <TELL "Again the needle climbs to a train's weight, and again it wavers as someone aboard shifts from one foot to the other." CR>)
              (T <SETG LOOP-OBSERVED T>
                 <TELL "The needle sweeps twice. First reading: nothing. Second reading: the full weight of a train, on a track where you can see no train. Then the last digits flicker by a few kilos, the way a scale does when a person shifts from one foot to the other. A reflection cannot do that. Someone is aboard." CR>)>)
       (<VERB? RUB>
  <TELL "The brass is warm, and very slightly sticky, as though someone pressed it with a cup of tea in the other hand." CR>)
       (<VERB? MOVE>
  <TELL "It doesn't pull or turn. It only pushes." CR>)
       (<VERB? KICK>
  <TELL "Not the one instrument in the station that might tell you the truth." CR>)>>

<ROUTINE GAUGE-FROST-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Thick white frost covers the walls, the pipes and the old dials, all except the cradle and the stud. Someone has kept those two clear." CR>)
       (<VERB? RUB>
  <TELL "You scrape a dial clear with your thumb. Its needle is pinned at zero, and the frost begins to close over it again at once." CR>)
       (<VERB? LISTEN>
  <TELL "It crackles softly as the floor hums, like paper being folded very slowly." CR>)
       (<VERB? TAKE EAT>
  <TELL "It melts on your fingers and tastes of metal." CR>)>>

<ROUTINE PLATFORM-TRACK-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Two steel rails run out of one tunnel and into the other. The frost on the sleepers has melted in a thin line along each rail, as if something warm has just gone by. There is no train to be seen." CR>)
       (<VERB? LISTEN>
  <COND (,LOOP-OBSERVED
         <TELL "Now that you know what to listen for, you hear it under the hum: the slow tick of wheels standing still, waiting for a signal." CR>)
        (T <TELL "The rails sing very faintly, like a wet finger on the rim of a glass. It could be a train far off. It could be an echo." CR>)>)
       (<VERB? RUB>
  <TELL "You kneel and lay your palm on the nearest rail. It is warm, and it trembles, very slightly." CR>)
       (<VERB? SMELL>
  <TELL "Hot brakes and wet stone, the smell of a train that has only just pulled in." CR>)
       (<VERB? THROUGH CLIMB-ON CLIMB-FOO>
  <TELL "You stay on the platform. Whatever is on that track, you don't want to be standing on it when it arrives." CR>)>>

<ROUTINE HALL-LIGHTS-F ()
 <COND (<VERB? EXAMINE>
  <TELL "The ceiling lamps are dark for the night. Pale green glow strips run along the floor instead, marking the way to the platform steps." CR>)
       (<VERB? RUB>
  <TELL "The strips are faintly warm, and they hum when you press them." CR>)
       (<VERB? KICK>
  <TELL "Your boot scuffs the plastic. The strip flickers, then steadies." CR>)>>

<ROUTINE STATION-STEPS-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Worn concrete steps between the ticket hall and the lower platform, with a steel rail down the middle." CR>)
       (<VERB? LISTEN>
  <TELL "Warm air breathes up and down them, as if the station itself were breathing." CR>)
       (<VERB? CLIMB-FOO CLIMB-ON CLIMB-UP CLIMB-DOWN>
  <COND (<EQUAL? ,HERE ,TICKET-HALL>
         <COND (<VERB? CLIMB-UP> <TELL "From the hall these steps go down, to the platform." CR>)
               (T <DO-WALK ,P?DOWN>)>)
        (<VERB? CLIMB-DOWN> <TELL "This is the bottom of the steps. They lead up to the ticket hall." CR>)
        (T <DO-WALK ,P?UP>)>
  <RTRUE>)>>

<ROUTINE STAFF-SINK-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A little steel sink with a dripping tap and a wire drainer. The two rinsed [[cups]] stand upside down on the drainer." CR>)
       (<VERB? LISTEN>
  <TELL "The tap drips, slowly, about once a second. Then twice, quickly, as though it has lost count." CR>)
       (<VERB? TURN SPIN OPEN CLOSE>
  <TELL "You turn the tap tight. A moment later it starts dripping again." CR>)>>

<ROUTINE GAUGE-DIALS-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "Old dials and pressure pipes cover the walls, all furred white with frost. Nobody reads these any more. The cradle and the stud on the console do the real work now." CR>)
       (<VERB? RUB>
  <TELL "You scrape a dial clear with your thumb. Its needle is pinned at zero, and the frost begins to close over it again at once." CR>)
       (<VERB? KNOCK>
  <TELL "The pipe rings like a tuning fork, and the note runs off under the floor toward the track." CR>)>>

<ROUTINE GAUGE-CONSOLE-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A long steel console under the frosted dials. Set into it are the round [[receiver cradle->cradle]] and the square [[calibration stud->stud]], both clear of frost." CR>)
       (<VERB? RUB>
  <TELL "The metal is cold everywhere except around the cradle and the stud." CR>)
       (<VERB? LOOK-UNDER>
  <TELL "Bundles of wire run from underneath it into the floor, toward the track." CR>)>>

<ROUTINE PLATFORM-TUNNEL-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Two round black tunnel mouths, one at each end of the platform. You can see a few metres of rail into each, and then nothing." CR>)
       (<VERB? LISTEN>
  <TELL "From the left-hand tunnel comes a long, low note, like a train a very long way off, or the memory of one." CR>)
       (<VERB? SMELL>
  <TELL "Cold stone, and a breath of hot brakes." CR>)
       (<VERB? THROUGH WALK>
  <TELL "Not on foot. Whatever is in there is better met from the platform." CR>)>>

<ROUTINE PLATFORM-POST-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A squat steel post at the platform edge, with the platform bell bolted to its top. It bears two controls: the red [[rescue switch->switch]] and the grey [[quarantine latch->latch]]. Only one of them can be used tonight." CR>)
       (<VERB? RING>
  <TELL "You ring one dull note. The rails carry it off into the dark, but a bell from this end is only a test; neither control has moved." CR>)
       (<VERB? LISTEN>
  <TELL "The platform bell still trembles, too softly to ring. In the post below it, you hear the vibration the way you would hear a pulse." CR>)
       (<VERB? RUB>
  <TELL "The post trembles faintly under your hand, in time with the rails." CR>)
       (<VERB? KICK MOVE>
  <TELL "It is set deep in the concrete and doesn't budge." CR>)
       (<VERB? LOOK-BEHIND>
  <TELL "Two leads come out of the post and meet at the rail. Whatever you decide, there's only one way to get the message through." CR>)>>

<ROUTINE UNSEEN-TRAIN-F ()
 <COND (<VERB? EXAMINE LOOK-INSIDE FIND>
  <COND (,LOOP-OBSERVED
         <TELL "You still can't see it. But the gauge has weighed it: a whole train, with someone aboard, standing just beyond the edge of the platform, waiting for a signal." CR>)
        (T
         <TELL "There is no train in sight, only the warmth on the [[track]] and the bell's call. An echo on the rail would look just the same. The instruments in the gauge room could tell you whether anything is really there." CR>)>)
       (<VERB? LISTEN>
  <PERFORM ,V?LISTEN ,PLATFORM-TRACK>
  <RTRUE>)
       (<VERB? BOARD THROUGH WAVE TAKE PUSH>
  <TELL "There is nothing on the track your hands can reach. The only way to answer the train is with the controls on the [[post]]." CR>)
       (<VERB? TELL HELLO>
  <COND (,LOOP-OBSERVED <TELL "You call, and wait long enough for a reply. Whoever is aboard can hear the rail, not your voice. The controls on the [[post]] will carry an answer." CR>)
        (T <TELL "Your voice comes back from both tunnels. Neither echo is quite in time with the other." CR>)>)>>

<ROUTINE PLATFORM-EDGE-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A long concrete platform with a yellow line painted along its edge. The frost on it is unmarked except for your own footprints and a thin wet line along the very edge, where warmth has risen from the rails." CR>)
       (<VERB? THROUGH CLIMB-DOWN LEAP>
  <TELL "You stay behind the yellow line. Whatever is on that track, you don't want to be standing on it when it arrives." CR>)>>

<ROUTINE STATION-END-POSSIBLE ()
 <COND (,LOOP-OBSERVED <RTRUE>)
       (T <TELL "Your hand stops short. An empty reflection on the rail would look exactly like a train arriving. Run the comparison in the gauge room before you decide what to do with this train." CR> <RFALSE>)>>

<ROUTINE RESCUE-SWITCH-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A red push-switch marked EMERGENCY BERTH. Pressing it lets the train stop here, even though it belongs to yesterday. Then everyone in the colony will remember an extra stop that never happened, and no one can say what other changes to the past might come in with it." CR>)
       (<VERB? PUSH>
        <COND (<STATION-END-POSSIBLE>
          <SETG STATION-END 1>
          <TELL "You press the switch. The rail goes quiet, and then the train slides out of the dark: two lit carriages, frost on every window. A door opens, and a driver in her socks steps down and asks if this is still Tuesday. You hold the door while she counts the passengers off. By morning there will be two versions of every timetable, and one long queue for tea. You will have to explain the second cup, but first the passengers need somewhere warm to wait." CR CR "ENDING: THE EXTRA STOP" CR>
          <FINISH>)>
        <RTRUE>)
       (<VERB? RUB>
  <TELL "The red paint is worn through to the metal in the middle. Someone has rested a thumb here many times without ever pressing." CR>)
       (<VERB? MOVE>
  <TELL "It doesn't pull. It is a push-switch, made to be pressed once, on purpose." CR>)
       (<VERB? KICK ATTACK>
  <TELL "Whatever you decide, you want to decide it with your hand." CR>)>>

<ROUTINE QUARANTINE-LATCH-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A grey latch marked QUARANTINE. Pressing it closes the berth and rings one signal back down the rail, telling its driver to brake and stay in yesterday. The train would be safe there, but it would never arrive here, and you would never see who is aboard." CR>)
       (<VERB? PUSH>
        <COND (<STATION-END-POSSIBLE>
          <SETG STATION-END 2>
          <TELL "You press the latch, and the berth closes. A single note travels out along the rail under the frost; after a long pause, another comes back. The driver has heard you and is braking, safe in yesterday. The warmth fades from the rails. You keep your hand on the latch until the answering note has died, so the last thing you give the driver is not silence. Later, back in the staff room, you draw two small circles in the logbook for the two signals, so whoever works here alone tomorrow will know there was an answer." CR CR "ENDING: OUTSIDE THE TIMETABLE" CR>
          <FINISH>)>
        <RTRUE>)
       (<VERB? RUB>
  <TELL "It is ridged for a gloved hand and colder than the air around it." CR>)
       (<VERB? LISTEN>
  <TELL "Close to the latch you can hear the rail singing in the post behind it, waiting to carry a signal." CR>)
       (<VERB? MOVE>
  <TELL "The latch only presses in. Once pressed, it would lock." CR>)>>

<ROUTINE V-VERSION ()
 <TELL "The Station at Minus One|AdventureArena, 2026|Release " N ,RELEASEID CR>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG HERE ,TICKET-HALL> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "The last lift to the surface left an hour ago. You are alone on the night shift at the colony's deepest railway station, far under the ice of a frozen moon. You have locked the gates open and rinsed your cup. Then the platform bell rings. A train is asking to stop, and by the timetable it was due yesterday. It is calling in from the wrong side of midnight, and somebody has to decide whether to let it in." CR CR>
 <TELL D ,HERE CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <COND (<NOT <EQUAL? ,STATION-END 0>> <TELL "The station register is closed." CR>)
       (,LOOP-OBSERVED <TELL "A real train is waiting. Its next stop is your decision." CR>)
       (T <TELL "The station register still shows one unverified arrival." CR>)>>
