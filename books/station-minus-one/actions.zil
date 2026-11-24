<GLOBAL LOOP-OBSERVED <>>
<GLOBAL STATION-END 0>

<ROUTINE STATION-CLOCK-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "The second hand sweeps up toward twelve, and every time it crosses, the clock jerks back and comes out one second behind midnight again. It has been one second to midnight for an hour. Beneath it, the arrivals board shows a single train, marked ARRIVAL MINUS ONE: due here yesterday." CR>)
       (<VERB? LISTEN>
  <TELL "It ticks steadily, and then, just at the top of the minute, there is a double tick, like a heel caught on a stair." CR>)
       (<VERB? RUB TAKE MOVE>
  <TELL "The clock is bolted high above the wickets, well out of reach." CR>)
       (<VERB? WIND>
  <TELL "There is no key and no winder. The clock takes its time from the rail signal, and the rail signal is the thing that has gone wrong." CR>)
       (<VERB? LOOK-BEHIND>
  <TELL "Only a fat grey cable, running from the clock along the ceiling toward the platform." CR>)>>

<ROUTINE TICKET-WICKETS-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A row of waist-high steel ticket gates, locked open for the night. Each little screen shows a red dash where the next train's time should be." CR>)
       (<VERB? PUSH MOVE KICK>
  <TELL "The nearest gate swings, clacks against its stop, and settles. The sound runs all the way round the empty hall." CR>)
       (<VERB? RUB>
  <TELL "The steel is cold enough to sting. Someone has polished the top rail to a shine with years of passing hands." CR>)
       (<VERB? CLIMB-ON CLIMB-FOO>
  <TELL "No need. They are locked open; you can walk straight through." CR>)>>

<ROUTINE STAFF-TABLE-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A scuffed staff table with tea rings all over it. The [[logbook]] lies open in the middle, where whoever is on shift can't miss it." CR>)
       (<VERB? LOOK-UNDER>
  <TELL "Only dust, and a chair pushed back as if someone got up in a hurry." CR>)
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
       (<VERB? LOOK-UNDER>
  <TELL "Under each cup is a small ring of water on the drainer, nothing more." CR>)>>

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
       (<VERB? SHAKE>
  <TELL "Nothing rattles. It is solid all the way through." CR>)>>

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
  <TELL "A bundle of wires runs from underneath it into the floor, toward the track." CR>)>>

<ROUTINE CALIBRATION-STUD-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A low, square brass button, worn smooth by thumbs. Pressing it makes the gauge weigh whatever is on the track, measured against the weight in the [[cradle]]. With nothing in the cradle, it has nothing to measure against." CR>)
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
       (<VERB? CLIMB-FOO CLIMB-ON>
  <TELL "To use them, just go that way." CR>)>>

<ROUTINE STAFF-SINK-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A little steel sink with a dripping tap and a wire drainer. The two rinsed [[cups]] stand upside down on the drainer." CR>)
       (<VERB? LISTEN>
  <TELL "The tap drips, slowly, about once a second. Then twice, quickly, as though it has lost count." CR>)
       (<VERB? TURN OPEN CLOSE>
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
  <TELL "A squat steel post at the platform edge, bearing two controls: the red [[rescue switch->switch]] and the grey [[quarantine latch->latch]]. Only one of them can be used tonight." CR>)
       (<VERB? RUB>
  <TELL "The post trembles faintly under your hand, in time with the rails." CR>)
       (<VERB? KICK MOVE>
  <TELL "It is set deep in the concrete and doesn't budge." CR>)>>

<ROUTINE STATION-END-POSSIBLE ()
 <COND (,LOOP-OBSERVED <RTRUE>)
       (T <TELL "Your hand stops short. An empty reflection on the rail would look exactly like a train arriving. Run the comparison in the gauge room before you decide what to do with this train." CR> <RFALSE>)>>

<ROUTINE RESCUE-SWITCH-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A red push-switch marked EMERGENCY BERTH. Pressing it lets the train stop here, even though it belongs to yesterday. Then everyone in the colony will remember an extra stop that never happened, and no one can say what other changes to the past might come in with it." CR>)
       (<VERB? PUSH>
        <COND (<STATION-END-POSSIBLE>
          <SETG STATION-END 1>
          <TELL "You press the switch. The rail goes quiet, and then the train slides out of the dark: two lit carriages, frost on every window. A door opens, and a driver in her socks steps down and asks if this is still Tuesday. You hold the door while she counts the passengers off. By morning there will be two versions of every timetable, and one long queue for tea." CR CR "ENDING: THE EXTRA STOP" CR>
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
          <TELL "You press the latch, and the berth closes. A single note travels out along the rail under the frost; after a long pause, another comes back. The driver has heard you and is braking, safe in yesterday. The warmth fades from the rails. In the logbook you draw two small circles for the two signals, so whoever works here alone tomorrow will know there was an answer." CR CR "ENDING: OUTSIDE THE TIMETABLE" CR>
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
 <TELL "You are the night attendant at the colony's deepest railway station, far under the ice of a frozen moon. The last lift to the surface left an hour ago, and you are alone down here. Then the platform bell rang: a train is asking to stop, and by the timetable it was due yesterday. It is calling in from the wrong side of midnight, and somebody has to decide whether to let it in." CR CR>
 <TELL D ,HERE CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <COND (<NOT <EQUAL? ,STATION-END 0>> <TELL "The station register is closed." CR>)
       (,LOOP-OBSERVED <TELL "A real train is waiting. Its next stop is your decision." CR>)
       (T <TELL "The station register still shows one unverified arrival." CR>)>>
